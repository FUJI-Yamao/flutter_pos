// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeat_toolJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repeat_toolJsonFile _$Repeat_toolJsonFileFromJson(Map<String, dynamic> json) =>
    Repeat_toolJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>)
      ..counter = _Counter.fromJson(json['counter'] as Map<String, dynamic>);

Map<String, dynamic> _$Repeat_toolJsonFileToJson(
        Repeat_toolJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
      'counter': instance.counter.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      tool_onoff: json['tool_onoff'] as int? ?? 0,
      rec_btn: json['rec_btn'] as int? ?? 16,
      play_btn: json['play_btn'] as int? ?? 30,
      turningtimes: json['turningtimes'] as int? ?? 0,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'tool_onoff': instance.tool_onoff,
      'rec_btn': instance.rec_btn,
      'play_btn': instance.play_btn,
      'turningtimes': instance.turningtimes,
    };

_Counter _$CounterFromJson(Map<String, dynamic> json) => _Counter(
      times: json['times'] as int? ?? 0,
    );

Map<String, dynamic> _$CounterToJson(_Counter instance) => <String, dynamic>{
      'times': instance.times,
    };
