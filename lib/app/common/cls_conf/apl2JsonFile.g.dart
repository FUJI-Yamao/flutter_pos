// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apl2JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apl2JsonFile _$Apl2JsonFileFromJson(Map<String, dynamic> json) => Apl2JsonFile()
  ..boot = _Boot.fromJson(json['boot'] as Map<String, dynamic>)
  ..boot_dual = _Boot_dual.fromJson(json['boot_dual'] as Map<String, dynamic>)
  ..apl1 = _Apl1.fromJson(json['apl1'] as Map<String, dynamic>)
  ..apl2 = _Apl2.fromJson(json['apl2'] as Map<String, dynamic>)
  ..apl3 = _Apl3.fromJson(json['apl3'] as Map<String, dynamic>)
  ..apl4 = _Apl4.fromJson(json['apl4'] as Map<String, dynamic>)
  ..apl5 = _Apl5.fromJson(json['apl5'] as Map<String, dynamic>);

Map<String, dynamic> _$Apl2JsonFileToJson(Apl2JsonFile instance) =>
    <String, dynamic>{
      'boot': instance.boot.toJson(),
      'boot_dual': instance.boot_dual.toJson(),
      'apl1': instance.apl1.toJson(),
      'apl2': instance.apl2.toJson(),
      'apl3': instance.apl3.toJson(),
      'apl4': instance.apl4.toJson(),
      'apl5': instance.apl5.toJson(),
    };

_Boot _$BootFromJson(Map<String, dynamic> json) => _Boot(
      tasks01: json['tasks01'] as String? ?? 'apl1',
      tasks02: json['tasks02'] as String? ?? 'apl2',
      tasks03: json['tasks03'] as String? ?? 'apl3',
      tasks04: json['tasks04'] as String? ?? 'apl4',
    );

Map<String, dynamic> _$BootToJson(_Boot instance) => <String, dynamic>{
      'tasks01': instance.tasks01,
      'tasks02': instance.tasks02,
      'tasks03': instance.tasks03,
      'tasks04': instance.tasks04,
    };

_Boot_dual _$Boot_dualFromJson(Map<String, dynamic> json) => _Boot_dual(
      tasks01: json['tasks01'] as String? ?? 'apl1',
      tasks02: json['tasks02'] as String? ?? 'apl2',
      tasks03: json['tasks03'] as String? ?? 'apl3',
      tasks04: json['tasks04'] as String? ?? 'apl4',
      tasks05: json['tasks05'] as String? ?? 'apl5',
    );

Map<String, dynamic> _$Boot_dualToJson(_Boot_dual instance) =>
    <String, dynamic>{
      'tasks01': instance.tasks01,
      'tasks02': instance.tasks02,
      'tasks03': instance.tasks03,
      'tasks04': instance.tasks04,
      'tasks05': instance.tasks05,
    };

_Apl1 _$Apl1FromJson(Map<String, dynamic> json) => _Apl1(
      entry: json['entry'] as String? ?? 'proc_con',
    );

Map<String, dynamic> _$Apl1ToJson(_Apl1 instance) => <String, dynamic>{
      'entry': instance.entry,
    };

_Apl2 _$Apl2FromJson(Map<String, dynamic> json) => _Apl2(
      entry: json['entry'] as String? ?? 'csvserver',
    );

Map<String, dynamic> _$Apl2ToJson(_Apl2 instance) => <String, dynamic>{
      'entry': instance.entry,
    };

_Apl3 _$Apl3FromJson(Map<String, dynamic> json) => _Apl3(
      entry: json['entry'] as String? ?? 'csvsend2',
    );

Map<String, dynamic> _$Apl3ToJson(_Apl3 instance) => <String, dynamic>{
      'entry': instance.entry,
    };

_Apl4 _$Apl4FromJson(Map<String, dynamic> json) => _Apl4(
      entry: json['entry'] as String? ?? 'checker',
    );

Map<String, dynamic> _$Apl4ToJson(_Apl4 instance) => <String, dynamic>{
      'entry': instance.entry,
    };

_Apl5 _$Apl5FromJson(Map<String, dynamic> json) => _Apl5(
      entry: json['entry'] as String? ?? 'cashier',
    );

Map<String, dynamic> _$Apl5ToJson(_Apl5 instance) => <String, dynamic>{
      'entry': instance.entry,
    };
