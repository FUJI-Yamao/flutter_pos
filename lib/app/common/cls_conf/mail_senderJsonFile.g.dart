// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_senderJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mail_senderJsonFile _$Mail_senderJsonFileFromJson(Map<String, dynamic> json) =>
    Mail_senderJsonFile()
      ..network = _Network.fromJson(json['network'] as Map<String, dynamic>);

Map<String, dynamic> _$Mail_senderJsonFileToJson(
        Mail_senderJsonFile instance) =>
    <String, dynamic>{
      'network': instance.network.toJson(),
    };

_Network _$NetworkFromJson(Map<String, dynamic> json) => _Network(
      url: json['url'] as String? ?? 'http://',
      timeout: json['timeout'] as int? ?? 40,
      api_key: json['api_key'] as String? ?? 'none',
      ex_api_key: json['ex_api_key'] as String? ?? 'none',
    );

Map<String, dynamic> _$NetworkToJson(_Network instance) => <String, dynamic>{
      'url': instance.url,
      'timeout': instance.timeout,
      'api_key': instance.api_key,
      'ex_api_key': instance.ex_api_key,
    };
