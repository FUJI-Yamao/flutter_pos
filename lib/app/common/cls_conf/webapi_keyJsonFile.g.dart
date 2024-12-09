// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webapi_keyJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Webapi_keyJsonFile _$Webapi_keyJsonFileFromJson(Map<String, dynamic> json) =>
    Webapi_keyJsonFile()
      ..APIKEY = _AAPIKEY.fromJson(json['APIKEY'] as Map<String, dynamic>)
      ..STRETOKEN =
          _SSTRETOKEN.fromJson(json['STRETOKEN'] as Map<String, dynamic>);

Map<String, dynamic> _$Webapi_keyJsonFileToJson(Webapi_keyJsonFile instance) =>
    <String, dynamic>{
      'APIKEY': instance.APIKEY.toJson(),
      'STRETOKEN': instance.STRETOKEN.toJson(),
    };

_AAPIKEY _$AAPIKEYFromJson(Map<String, dynamic> json) => _AAPIKEY(
      Value: json['Value'] as String? ?? 'web-api',
    );

Map<String, dynamic> _$AAPIKEYToJson(_AAPIKEY instance) => <String, dynamic>{
      'Value': instance.Value,
    };

_SSTRETOKEN _$SSTRETOKENFromJson(Map<String, dynamic> json) => _SSTRETOKEN(
      Value: json['Value'] as String? ?? 'stre-token',
    );

Map<String, dynamic> _$SSTRETOKENToJson(_SSTRETOKEN instance) =>
    <String, dynamic>{
      'Value': instance.Value,
    };
