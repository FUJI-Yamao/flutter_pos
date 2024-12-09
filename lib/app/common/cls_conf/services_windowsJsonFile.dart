/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'services_windowsJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Services_windowsJsonFile extends ConfigJsonFile {
  static final Services_windowsJsonFile _instance = Services_windowsJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "services_windows.json";

  Services_windowsJsonFile(){
    setPath(_confPath, _fileName);
  }
  Services_windowsJsonFile._internal();

  factory Services_windowsJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Services_windowsJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Services_windowsJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Services_windowsJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        comport = _$ComportFromJson(jsonD['comport']);
      } catch(e) {
        comport = _$ComportFromJson({});
        ret = false;
      }
      try {
        comport2 = _$Comport2FromJson(jsonD['comport2']);
      } catch(e) {
        comport2 = _$Comport2FromJson({});
        ret = false;
      }
      try {
        pbchg1port = _$Pbchg1portFromJson(jsonD['pbchg1port']);
      } catch(e) {
        pbchg1port = _$Pbchg1portFromJson({});
        ret = false;
      }
      try {
        pbchg2port = _$Pbchg2portFromJson(jsonD['pbchg2port']);
      } catch(e) {
        pbchg2port = _$Pbchg2portFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Comport comport = _Comport(
    PortNumber                         : "",
    ProtocolName                       : "",
    Aliases                            : "",
  );

  _Comport2 comport2 = _Comport2(
    PortNumber                         : "",
    ProtocolName                       : "",
    Aliases                            : "",
  );

  _Pbchg1port pbchg1port = _Pbchg1port(
    PortNumber                         : "",
    ProtocolName                       : "",
    Aliases                            : "",
  );

  _Pbchg2port pbchg2port = _Pbchg2port(
    PortNumber                         : "",
    ProtocolName                       : "",
    Aliases                            : "",
  );
}

@JsonSerializable()
class _Comport {
  factory _Comport.fromJson(Map<String, dynamic> json) => _$ComportFromJson(json);
  Map<String, dynamic> toJson() => _$ComportToJson(this);

  _Comport({
    required this.PortNumber,
    required this.ProtocolName,
    required this.Aliases,
  });

  @JsonKey(defaultValue: "6100")
  String PortNumber;
  @JsonKey(defaultValue: "tcp")
  String ProtocolName;
  @JsonKey(defaultValue: "# web credit comc socket'")
  String Aliases;
}

@JsonSerializable()
class _Comport2 {
  factory _Comport2.fromJson(Map<String, dynamic> json) => _$Comport2FromJson(json);
  Map<String, dynamic> toJson() => _$Comport2ToJson(this);

  _Comport2({
    required this.PortNumber,
    required this.ProtocolName,
    required this.Aliases,
  });

  @JsonKey(defaultValue: "0")
  String PortNumber;
  @JsonKey(defaultValue: "tcp")
  String ProtocolName;
  @JsonKey(defaultValue: "# web2100 credit compc socket")
  String Aliases;
}

@JsonSerializable()
class _Pbchg1port {
  factory _Pbchg1port.fromJson(Map<String, dynamic> json) => _$Pbchg1portFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg1portToJson(this);

  _Pbchg1port({
    required this.PortNumber,
    required this.ProtocolName,
    required this.Aliases,
  });

  @JsonKey(defaultValue: "8201")
  String PortNumber;
  @JsonKey(defaultValue: "tcp")
  String ProtocolName;
  @JsonKey(defaultValue: "# web2100 PBCHG1 socket")
  String Aliases;
}

@JsonSerializable()
class _Pbchg2port {
  factory _Pbchg2port.fromJson(Map<String, dynamic> json) => _$Pbchg2portFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg2portToJson(this);

  _Pbchg2port({
    required this.PortNumber,
    required this.ProtocolName,
    required this.Aliases,
  });

  @JsonKey(defaultValue: "8201")
  String PortNumber;
  @JsonKey(defaultValue: "tcp")
  String ProtocolName;
  @JsonKey(defaultValue: "# web2100 PBCHG2 socket")
  String Aliases;
}

