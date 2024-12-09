// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_windowsJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Services_windowsJsonFile _$Services_windowsJsonFileFromJson(
        Map<String, dynamic> json) =>
    Services_windowsJsonFile()
      ..comport = _Comport.fromJson(json['comport'] as Map<String, dynamic>)
      ..comport2 = _Comport2.fromJson(json['comport2'] as Map<String, dynamic>)
      ..pbchg1port =
          _Pbchg1port.fromJson(json['pbchg1port'] as Map<String, dynamic>)
      ..pbchg2port =
          _Pbchg2port.fromJson(json['pbchg2port'] as Map<String, dynamic>);

Map<String, dynamic> _$Services_windowsJsonFileToJson(
        Services_windowsJsonFile instance) =>
    <String, dynamic>{
      'comport': instance.comport.toJson(),
      'comport2': instance.comport2.toJson(),
      'pbchg1port': instance.pbchg1port.toJson(),
      'pbchg2port': instance.pbchg2port.toJson(),
    };

_Comport _$ComportFromJson(Map<String, dynamic> json) => _Comport(
      PortNumber: json['PortNumber'] as String? ?? '6100',
      ProtocolName: json['ProtocolName'] as String? ?? 'tcp',
      Aliases: json['Aliases'] as String? ?? "# web credit comc socket'",
    );

Map<String, dynamic> _$ComportToJson(_Comport instance) => <String, dynamic>{
      'PortNumber': instance.PortNumber,
      'ProtocolName': instance.ProtocolName,
      'Aliases': instance.Aliases,
    };

_Comport2 _$Comport2FromJson(Map<String, dynamic> json) => _Comport2(
      PortNumber: json['PortNumber'] as String? ?? '0',
      ProtocolName: json['ProtocolName'] as String? ?? 'tcp',
      Aliases: json['Aliases'] as String? ?? '# web2100 credit compc socket',
    );

Map<String, dynamic> _$Comport2ToJson(_Comport2 instance) => <String, dynamic>{
      'PortNumber': instance.PortNumber,
      'ProtocolName': instance.ProtocolName,
      'Aliases': instance.Aliases,
    };

_Pbchg1port _$Pbchg1portFromJson(Map<String, dynamic> json) => _Pbchg1port(
      PortNumber: json['PortNumber'] as String? ?? '8201',
      ProtocolName: json['ProtocolName'] as String? ?? 'tcp',
      Aliases: json['Aliases'] as String? ?? '# web2100 PBCHG1 socket',
    );

Map<String, dynamic> _$Pbchg1portToJson(_Pbchg1port instance) =>
    <String, dynamic>{
      'PortNumber': instance.PortNumber,
      'ProtocolName': instance.ProtocolName,
      'Aliases': instance.Aliases,
    };

_Pbchg2port _$Pbchg2portFromJson(Map<String, dynamic> json) => _Pbchg2port(
      PortNumber: json['PortNumber'] as String? ?? '8201',
      ProtocolName: json['ProtocolName'] as String? ?? 'tcp',
      Aliases: json['Aliases'] as String? ?? '# web2100 PBCHG2 socket',
    );

Map<String, dynamic> _$Pbchg2portToJson(_Pbchg2port instance) =>
    <String, dynamic>{
      'PortNumber': instance.PortNumber,
      'ProtocolName': instance.ProtocolName,
      'Aliases': instance.Aliases,
    };
