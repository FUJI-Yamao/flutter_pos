// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_updateJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auto_updateJsonFile _$Auto_updateJsonFileFromJson(Map<String, dynamic> json) =>
    Auto_updateJsonFile()
      ..comm = _Comm.fromJson(json['comm'] as Map<String, dynamic>)
      ..system = _System.fromJson(json['system'] as Map<String, dynamic>)
      ..ver01 = _Ver01.fromJson(json['ver01'] as Map<String, dynamic>)
      ..ver02 = _Ver02.fromJson(json['ver02'] as Map<String, dynamic>)
      ..ver03 = _Ver03.fromJson(json['ver03'] as Map<String, dynamic>)
      ..ver04 = _Ver04.fromJson(json['ver04'] as Map<String, dynamic>)
      ..ver05 = _Ver05.fromJson(json['ver05'] as Map<String, dynamic>)
      ..ver06 = _Ver06.fromJson(json['ver06'] as Map<String, dynamic>)
      ..ver07 = _Ver07.fromJson(json['ver07'] as Map<String, dynamic>)
      ..result = _Result.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$Auto_updateJsonFileToJson(
        Auto_updateJsonFile instance) =>
    <String, dynamic>{
      'comm': instance.comm.toJson(),
      'system': instance.system.toJson(),
      'ver01': instance.ver01.toJson(),
      'ver02': instance.ver02.toJson(),
      'ver03': instance.ver03.toJson(),
      'ver04': instance.ver04.toJson(),
      'ver05': instance.ver05.toJson(),
      'ver06': instance.ver06.toJson(),
      'ver07': instance.ver07.toJson(),
      'result': instance.result.toJson(),
    };

_Comm _$CommFromJson(Map<String, dynamic> json) => _Comm(
      rest_url:
          json['rest_url'] as String? ?? 'http://118.243.93.122/autoupdates?',
      get_result_url: json['get_result_url'] as String? ??
          'http://118.243.93.122/getfileresults?',
      vup_result_url: json['vup_result_url'] as String? ??
          'http://118.243.93.122/updateresults?',
      time_out: json['time_out'] as int? ?? 180,
      retry: json['retry'] as int? ?? 3,
      zhq_rest_url:
          json['zhq_rest_url'] as String? ?? 'http://10.147.1.102/autoupdates?',
      zhq_get_result_url: json['zhq_get_result_url'] as String? ??
          'http://10.147.1.102/getfileresults?',
      zhq_vup_result_url: json['zhq_vup_result_url'] as String? ??
          'http://10.147.1.102/updateresults?',
      nxt_rest_ctrl: json['nxt_rest_ctrl'] as int? ?? 1,
    );

Map<String, dynamic> _$CommToJson(_Comm instance) => <String, dynamic>{
      'rest_url': instance.rest_url,
      'get_result_url': instance.get_result_url,
      'vup_result_url': instance.vup_result_url,
      'time_out': instance.time_out,
      'retry': instance.retry,
      'zhq_rest_url': instance.zhq_rest_url,
      'zhq_get_result_url': instance.zhq_get_result_url,
      'zhq_vup_result_url': instance.zhq_vup_result_url,
      'nxt_rest_ctrl': instance.nxt_rest_ctrl,
    };

_System _$SystemFromJson(Map<String, dynamic> json) => _System(
      system: json['system'] as int? ?? 0,
    );

Map<String, dynamic> _$SystemToJson(_System instance) => <String, dynamic>{
      'system': instance.system,
    };

_Ver01 _$Ver01FromJson(Map<String, dynamic> json) => _Ver01(
      ver01_name: json['ver01_name'] as int? ?? 0,
      date01: json['date01'] as int? ?? 0,
      updateid01: json['updateid01'] as int? ?? 0,
      power01: json['power01'] as int? ?? 0,
    );

Map<String, dynamic> _$Ver01ToJson(_Ver01 instance) => <String, dynamic>{
      'ver01_name': instance.ver01_name,
      'date01': instance.date01,
      'updateid01': instance.updateid01,
      'power01': instance.power01,
    };

_Ver02 _$Ver02FromJson(Map<String, dynamic> json) => _Ver02(
      ver02_name: json['ver02_name'] as int? ?? 0,
      date02: json['date02'] as int? ?? 0,
      updateid02: json['updateid02'] as int? ?? 0,
      power02: json['power02'] as int? ?? 0,
    );

Map<String, dynamic> _$Ver02ToJson(_Ver02 instance) => <String, dynamic>{
      'ver02_name': instance.ver02_name,
      'date02': instance.date02,
      'updateid02': instance.updateid02,
      'power02': instance.power02,
    };

_Ver03 _$Ver03FromJson(Map<String, dynamic> json) => _Ver03(
      ver03_name: json['ver03_name'] as int? ?? 0,
      date03: json['date03'] as int? ?? 0,
      updateid03: json['updateid03'] as int? ?? 0,
      power03: json['power03'] as int? ?? 0,
      stat03: json['stat03'] as int? ?? 0,
    );

Map<String, dynamic> _$Ver03ToJson(_Ver03 instance) => <String, dynamic>{
      'ver03_name': instance.ver03_name,
      'date03': instance.date03,
      'updateid03': instance.updateid03,
      'power03': instance.power03,
      'stat03': instance.stat03,
    };

_Ver04 _$Ver04FromJson(Map<String, dynamic> json) => _Ver04(
      ver04_name: json['ver04_name'] as int? ?? 0,
      date04: json['date04'] as int? ?? 0,
      updateid04: json['updateid04'] as int? ?? 0,
      power04: json['power04'] as int? ?? 0,
    );

Map<String, dynamic> _$Ver04ToJson(_Ver04 instance) => <String, dynamic>{
      'ver04_name': instance.ver04_name,
      'date04': instance.date04,
      'updateid04': instance.updateid04,
      'power04': instance.power04,
    };

_Ver05 _$Ver05FromJson(Map<String, dynamic> json) => _Ver05(
      ver05_name: json['ver05_name'] as int? ?? 0,
      date05: json['date05'] as int? ?? 0,
      updateid05: json['updateid05'] as int? ?? 0,
      power05: json['power05'] as int? ?? 0,
    );

Map<String, dynamic> _$Ver05ToJson(_Ver05 instance) => <String, dynamic>{
      'ver05_name': instance.ver05_name,
      'date05': instance.date05,
      'updateid05': instance.updateid05,
      'power05': instance.power05,
    };

_Ver06 _$Ver06FromJson(Map<String, dynamic> json) => _Ver06(
      ver06_name: json['ver06_name'] as int? ?? 0,
      date06: json['date06'] as int? ?? 0,
      updateid06: json['updateid06'] as int? ?? 0,
      power06: json['power06'] as int? ?? 0,
    );

Map<String, dynamic> _$Ver06ToJson(_Ver06 instance) => <String, dynamic>{
      'ver06_name': instance.ver06_name,
      'date06': instance.date06,
      'updateid06': instance.updateid06,
      'power06': instance.power06,
    };

_Ver07 _$Ver07FromJson(Map<String, dynamic> json) => _Ver07(
      ver07_name: json['ver07_name'] as int? ?? 0,
      date07: json['date07'] as int? ?? 0,
      updateid07: json['updateid07'] as int? ?? 0,
      power07: json['power07'] as int? ?? 0,
    );

Map<String, dynamic> _$Ver07ToJson(_Ver07 instance) => <String, dynamic>{
      'ver07_name': instance.ver07_name,
      'date07': instance.date07,
      'updateid07': instance.updateid07,
      'power07': instance.power07,
    };

_Result _$ResultFromJson(Map<String, dynamic> json) => _Result(
      get01: json['get01'] as int? ?? 0,
      get02: json['get02'] as int? ?? 0,
      get03: json['get03'] as int? ?? 0,
      get04: json['get04'] as int? ?? 0,
      get05: json['get05'] as int? ?? 0,
      get06: json['get06'] as int? ?? 0,
      get07: json['get07'] as int? ?? 0,
      file_name: json['file_name'] as int? ?? 0,
    );

Map<String, dynamic> _$ResultToJson(_Result instance) => <String, dynamic>{
      'get01': instance.get01,
      'get02': instance.get02,
      'get03': instance.get03,
      'get04': instance.get04,
      'get05': instance.get05,
      'get06': instance.get06,
      'get07': instance.get07,
      'file_name': instance.file_name,
    };
