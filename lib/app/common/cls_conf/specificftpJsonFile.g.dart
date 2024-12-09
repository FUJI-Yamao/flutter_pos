// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specificftpJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecificftpJsonFile _$SpecificftpJsonFileFromJson(Map<String, dynamic> json) =>
    SpecificftpJsonFile()
      ..ja_system =
          _Ja_system.fromJson(json['ja_system'] as Map<String, dynamic>)
      ..producer = _Producer.fromJson(json['producer'] as Map<String, dynamic>)
      ..items = _Items.fromJson(json['items'] as Map<String, dynamic>)
      ..csv_dly = _Csv_dly.fromJson(json['csv_dly'] as Map<String, dynamic>)
      ..max_item = _Max_item.fromJson(json['max_item'] as Map<String, dynamic>)
      ..page = _Page.fromJson(json['page'] as Map<String, dynamic>)
      ..item0 = _Item0.fromJson(json['item0'] as Map<String, dynamic>)
      ..item1 = _Item1.fromJson(json['item1'] as Map<String, dynamic>)
      ..item2 = _Item2.fromJson(json['item2'] as Map<String, dynamic>);

Map<String, dynamic> _$SpecificftpJsonFileToJson(
        SpecificftpJsonFile instance) =>
    <String, dynamic>{
      'ja_system': instance.ja_system.toJson(),
      'producer': instance.producer.toJson(),
      'items': instance.items.toJson(),
      'csv_dly': instance.csv_dly.toJson(),
      'max_item': instance.max_item.toJson(),
      'page': instance.page.toJson(),
      'item0': instance.item0.toJson(),
      'item1': instance.item1.toJson(),
      'item2': instance.item2.toJson(),
    };

_Ja_system _$Ja_systemFromJson(Map<String, dynamic> json) => _Ja_system(
      jano: json['jano'] as int? ?? 1,
      clientno: json['clientno'] as int? ?? 1,
      sendcnt: json['sendcnt'] as int? ?? 0,
      senditemcnt: json['senditemcnt'] as int? ?? 0,
    );

Map<String, dynamic> _$Ja_systemToJson(_Ja_system instance) =>
    <String, dynamic>{
      'jano': instance.jano,
      'clientno': instance.clientno,
      'sendcnt': instance.sendcnt,
      'senditemcnt': instance.senditemcnt,
    };

_Producer _$ProducerFromJson(Map<String, dynamic> json) => _Producer(
      cdlen: json['cdlen'] as int? ?? 0,
      startcd: json['startcd'] as int? ?? 1,
      endcd: json['endcd'] as int? ?? 999,
      endcd2: json['endcd2'] as int? ?? 99999,
    );

Map<String, dynamic> _$ProducerToJson(_Producer instance) => <String, dynamic>{
      'cdlen': instance.cdlen,
      'startcd': instance.startcd,
      'endcd': instance.endcd,
      'endcd2': instance.endcd2,
    };

_Items _$ItemsFromJson(Map<String, dynamic> json) => _Items(
      startcd: json['startcd'] as int? ?? 1,
      endcd: json['endcd'] as int? ?? 999,
      instre_flg: json['instre_flg'] as String? ?? '00',
      endcd2: json['endcd2'] as int? ?? 99999,
    );

Map<String, dynamic> _$ItemsToJson(_Items instance) => <String, dynamic>{
      'startcd': instance.startcd,
      'endcd': instance.endcd,
      'instre_flg': instance.instre_flg,
      'endcd2': instance.endcd2,
    };

_Csv_dly _$Csv_dlyFromJson(Map<String, dynamic> json) => _Csv_dly(
      dly_nouchoku: json['dly_nouchoku'] as int? ?? 0,
      dlynouchoku_week: json['dlynouchoku_week'] as int? ?? 0,
      dlynouchoku_day: json['dlynouchoku_day'] as int? ?? 1,
      dly_urihdr: json['dly_urihdr'] as int? ?? 0,
      dlyurihdr_week: json['dlyurihdr_week'] as int? ?? 0,
      dlyurihdr_day: json['dlyurihdr_day'] as int? ?? 1,
      dly_urimei: json['dly_urimei'] as int? ?? 0,
      dlyurimei_week: json['dlyurimei_week'] as int? ?? 0,
      dlyurimei_day: json['dlyurimei_day'] as int? ?? 1,
    );

Map<String, dynamic> _$Csv_dlyToJson(_Csv_dly instance) => <String, dynamic>{
      'dly_nouchoku': instance.dly_nouchoku,
      'dlynouchoku_week': instance.dlynouchoku_week,
      'dlynouchoku_day': instance.dlynouchoku_day,
      'dly_urihdr': instance.dly_urihdr,
      'dlyurihdr_week': instance.dlyurihdr_week,
      'dlyurihdr_day': instance.dlyurihdr_day,
      'dly_urimei': instance.dly_urimei,
      'dlyurimei_week': instance.dlyurimei_week,
      'dlyurimei_day': instance.dlyurimei_day,
    };

_Max_item _$Max_itemFromJson(Map<String, dynamic> json) => _Max_item(
      total_item: json['total_item'] as int? ?? 3,
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
      table1: json['table1'] as String? ?? '農直品',
      total: json['total'] as int? ?? 1,
      t_exe1: json['t_exe1'] as String? ?? 'NOUCHOKU',
      section: json['section'] as String? ?? 'csv_dly',
      keyword: json['keyword'] as String? ?? 'dly_nouchoku',
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
      position: json['position'] as int? ?? 2,
      table1: json['table1'] as String? ?? '売上伝票',
      total: json['total'] as int? ?? 1,
      t_exe1: json['t_exe1'] as String? ?? 'URIHDR',
      section: json['section'] as String? ?? 'csv_dly',
      keyword: json['keyword'] as String? ?? 'dly_urihdr',
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
      'backup_day': instance.backup_day,
      'select_dsp': instance.select_dsp,
    };

_Item2 _$Item2FromJson(Map<String, dynamic> json) => _Item2(
      onoff: json['onoff'] as int? ?? 0,
      page: json['page'] as int? ?? 1,
      position: json['position'] as int? ?? 3,
      table1: json['table1'] as String? ?? '売上明細',
      total: json['total'] as int? ?? 1,
      t_exe1: json['t_exe1'] as String? ?? 'URIMEI',
      section: json['section'] as String? ?? 'csv_dly',
      keyword: json['keyword'] as String? ?? 'dly_urimei',
      backup_day: json['backup_day'] as String? ?? '0000-00-00',
      select_dsp: json['select_dsp'] as int? ?? 0,
    );

Map<String, dynamic> _$Item2ToJson(_Item2 instance) => <String, dynamic>{
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
