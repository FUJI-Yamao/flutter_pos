/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'hostsJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class HostsJsonFile extends ConfigJsonFile {
  static final HostsJsonFile _instance = HostsJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "hosts.json";

  HostsJsonFile(){
    setPath(_confPath, _fileName);
  }
  HostsJsonFile._internal();

  factory HostsJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$HostsJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$HostsJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$HostsJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        hosts1 = _$Hosts1FromJson(jsonD['hosts1']);
      } catch(e) {
        hosts1 = _$Hosts1FromJson({});
        ret = false;
      }
      try {
        hosts2 = _$Hosts2FromJson(jsonD['hosts2']);
      } catch(e) {
        hosts2 = _$Hosts2FromJson({});
        ret = false;
      }
      try {
        hosts3 = _$Hosts3FromJson(jsonD['hosts3']);
      } catch(e) {
        hosts3 = _$Hosts3FromJson({});
        ret = false;
      }
      try {
        hosts4 = _$Hosts4FromJson(jsonD['hosts4']);
      } catch(e) {
        hosts4 = _$Hosts4FromJson({});
        ret = false;
      }
      try {
        hosts5 = _$Hosts5FromJson(jsonD['hosts5']);
      } catch(e) {
        hosts5 = _$Hosts5FromJson({});
        ret = false;
      }
      try {
        hosts6 = _$Hosts6FromJson(jsonD['hosts6']);
      } catch(e) {
        hosts6 = _$Hosts6FromJson({});
        ret = false;
      }
      try {
        hosts7 = _$Hosts7FromJson(jsonD['hosts7']);
      } catch(e) {
        hosts7 = _$Hosts7FromJson({});
        ret = false;
      }
      try {
        hosts8 = _$Hosts8FromJson(jsonD['hosts8']);
      } catch(e) {
        hosts8 = _$Hosts8FromJson({});
        ret = false;
      }
      try {
        hosts9 = _$Hosts9FromJson(jsonD['hosts9']);
      } catch(e) {
        hosts9 = _$Hosts9FromJson({});
        ret = false;
      }
      try {
        hosts10 = _$Hosts10FromJson(jsonD['hosts10']);
      } catch(e) {
        hosts10 = _$Hosts10FromJson({});
        ret = false;
      }
      try {
        hosts11 = _$Hosts11FromJson(jsonD['hosts11']);
      } catch(e) {
        hosts11 = _$Hosts11FromJson({});
        ret = false;
      }
      try {
        hosts12 = _$Hosts12FromJson(jsonD['hosts12']);
      } catch(e) {
        hosts12 = _$Hosts12FromJson({});
        ret = false;
      }
      try {
        hosts13 = _$Hosts13FromJson(jsonD['hosts13']);
      } catch(e) {
        hosts13 = _$Hosts13FromJson({});
        ret = false;
      }
      try {
        hosts14 = _$Hosts14FromJson(jsonD['hosts14']);
      } catch(e) {
        hosts14 = _$Hosts14FromJson({});
        ret = false;
      }
      try {
        hosts15 = _$Hosts15FromJson(jsonD['hosts15']);
      } catch(e) {
        hosts15 = _$Hosts15FromJson({});
        ret = false;
      }
      try {
        hosts16 = _$Hosts16FromJson(jsonD['hosts16']);
      } catch(e) {
        hosts16 = _$Hosts16FromJson({});
        ret = false;
      }
      try {
        hosts17 = _$Hosts17FromJson(jsonD['hosts17']);
      } catch(e) {
        hosts17 = _$Hosts17FromJson({});
        ret = false;
      }
      try {
        hosts18 = _$Hosts18FromJson(jsonD['hosts18']);
      } catch(e) {
        hosts18 = _$Hosts18FromJson({});
        ret = false;
      }
      try {
        hosts19 = _$Hosts19FromJson(jsonD['hosts19']);
      } catch(e) {
        hosts19 = _$Hosts19FromJson({});
        ret = false;
      }
      try {
        hosts20 = _$Hosts20FromJson(jsonD['hosts20']);
      } catch(e) {
        hosts20 = _$Hosts20FromJson({});
        ret = false;
      }
      try {
        hosts21 = _$Hosts21FromJson(jsonD['hosts21']);
      } catch(e) {
        hosts21 = _$Hosts21FromJson({});
        ret = false;
      }
      try {
        hosts22 = _$Hosts22FromJson(jsonD['hosts22']);
      } catch(e) {
        hosts22 = _$Hosts22FromJson({});
        ret = false;
      }
      try {
        hosts23 = _$Hosts23FromJson(jsonD['hosts23']);
      } catch(e) {
        hosts23 = _$Hosts23FromJson({});
        ret = false;
      }
      try {
        hosts24 = _$Hosts24FromJson(jsonD['hosts24']);
      } catch(e) {
        hosts24 = _$Hosts24FromJson({});
        ret = false;
      }
      try {
        hosts25 = _$Hosts25FromJson(jsonD['hosts25']);
      } catch(e) {
        hosts25 = _$Hosts25FromJson({});
        ret = false;
      }
      try {
        hosts26 = _$Hosts26FromJson(jsonD['hosts26']);
      } catch(e) {
        hosts26 = _$Hosts26FromJson({});
        ret = false;
      }
      try {
        hosts27 = _$Hosts27FromJson(jsonD['hosts27']);
      } catch(e) {
        hosts27 = _$Hosts27FromJson({});
        ret = false;
      }
      try {
        hosts28 = _$Hosts28FromJson(jsonD['hosts28']);
      } catch(e) {
        hosts28 = _$Hosts28FromJson({});
        ret = false;
      }
      try {
        hosts29 = _$Hosts29FromJson(jsonD['hosts29']);
      } catch(e) {
        hosts29 = _$Hosts29FromJson({});
        ret = false;
      }
      try {
        hosts30 = _$Hosts30FromJson(jsonD['hosts30']);
      } catch(e) {
        hosts30 = _$Hosts30FromJson({});
        ret = false;
      }
      try {
        hosts31 = _$Hosts31FromJson(jsonD['hosts31']);
      } catch(e) {
        hosts31 = _$Hosts31FromJson({});
        ret = false;
      }
      try {
        hosts32 = _$Hosts32FromJson(jsonD['hosts32']);
      } catch(e) {
        hosts32 = _$Hosts32FromJson({});
        ret = false;
      }
      try {
        hosts33 = _$Hosts33FromJson(jsonD['hosts33']);
      } catch(e) {
        hosts33 = _$Hosts33FromJson({});
        ret = false;
      }
      try {
        hosts34 = _$Hosts34FromJson(jsonD['hosts34']);
      } catch(e) {
        hosts34 = _$Hosts34FromJson({});
        ret = false;
      }
      try {
        hosts35 = _$Hosts35FromJson(jsonD['hosts35']);
      } catch(e) {
        hosts35 = _$Hosts35FromJson({});
        ret = false;
      }
      try {
        hosts36 = _$Hosts36FromJson(jsonD['hosts36']);
      } catch(e) {
        hosts36 = _$Hosts36FromJson({});
        ret = false;
      }
      try {
        hosts37 = _$Hosts37FromJson(jsonD['hosts37']);
      } catch(e) {
        hosts37 = _$Hosts37FromJson({});
        ret = false;
      }
      try {
        hosts38 = _$Hosts38FromJson(jsonD['hosts38']);
      } catch(e) {
        hosts38 = _$Hosts38FromJson({});
        ret = false;
      }
      try {
        hosts39 = _$Hosts39FromJson(jsonD['hosts39']);
      } catch(e) {
        hosts39 = _$Hosts39FromJson({});
        ret = false;
      }
      try {
        hosts40 = _$Hosts40FromJson(jsonD['hosts40']);
      } catch(e) {
        hosts40 = _$Hosts40FromJson({});
        ret = false;
      }
      try {
        hosts41 = _$Hosts41FromJson(jsonD['hosts41']);
      } catch(e) {
        hosts41 = _$Hosts41FromJson({});
        ret = false;
      }
      try {
        hosts42 = _$Hosts42FromJson(jsonD['hosts42']);
      } catch(e) {
        hosts42 = _$Hosts42FromJson({});
        ret = false;
      }
      try {
        hosts43 = _$Hosts43FromJson(jsonD['hosts43']);
      } catch(e) {
        hosts43 = _$Hosts43FromJson({});
        ret = false;
      }
      try {
        hosts44 = _$Hosts44FromJson(jsonD['hosts44']);
      } catch(e) {
        hosts44 = _$Hosts44FromJson({});
        ret = false;
      }
      try {
        hosts45 = _$Hosts45FromJson(jsonD['hosts45']);
      } catch(e) {
        hosts45 = _$Hosts45FromJson({});
        ret = false;
      }
      try {
        hosts46 = _$Hosts46FromJson(jsonD['hosts46']);
      } catch(e) {
        hosts46 = _$Hosts46FromJson({});
        ret = false;
      }
      try {
        hosts47 = _$Hosts47FromJson(jsonD['hosts47']);
      } catch(e) {
        hosts47 = _$Hosts47FromJson({});
        ret = false;
      }
      try {
        hosts48 = _$Hosts48FromJson(jsonD['hosts48']);
      } catch(e) {
        hosts48 = _$Hosts48FromJson({});
        ret = false;
      }
      try {
        hosts49 = _$Hosts49FromJson(jsonD['hosts49']);
      } catch(e) {
        hosts49 = _$Hosts49FromJson({});
        ret = false;
      }
      try {
        hosts50 = _$Hosts50FromJson(jsonD['hosts50']);
      } catch(e) {
        hosts50 = _$Hosts50FromJson({});
        ret = false;
      }
      try {
        hosts51 = _$Hosts51FromJson(jsonD['hosts51']);
      } catch(e) {
        hosts51 = _$Hosts51FromJson({});
        ret = false;
      }
      try {
        hosts52 = _$Hosts52FromJson(jsonD['hosts52']);
      } catch(e) {
        hosts52 = _$Hosts52FromJson({});
        ret = false;
      }
      try {
        hosts53 = _$Hosts53FromJson(jsonD['hosts53']);
      } catch(e) {
        hosts53 = _$Hosts53FromJson({});
        ret = false;
      }
      try {
        hosts54 = _$Hosts54FromJson(jsonD['hosts54']);
      } catch(e) {
        hosts54 = _$Hosts54FromJson({});
        ret = false;
      }
      try {
        hosts55 = _$Hosts55FromJson(jsonD['hosts55']);
      } catch(e) {
        hosts55 = _$Hosts55FromJson({});
        ret = false;
      }
      try {
        hosts56 = _$Hosts56FromJson(jsonD['hosts56']);
      } catch(e) {
        hosts56 = _$Hosts56FromJson({});
        ret = false;
      }
      try {
        hosts57 = _$Hosts57FromJson(jsonD['hosts57']);
      } catch(e) {
        hosts57 = _$Hosts57FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Hosts1 hosts1 = _Hosts1(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts2 hosts2 = _Hosts2(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts3 hosts3 = _Hosts3(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts4 hosts4 = _Hosts4(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts5 hosts5 = _Hosts5(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts6 hosts6 = _Hosts6(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts7 hosts7 = _Hosts7(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts8 hosts8 = _Hosts8(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts9 hosts9 = _Hosts9(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts10 hosts10 = _Hosts10(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts11 hosts11 = _Hosts11(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts12 hosts12 = _Hosts12(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts13 hosts13 = _Hosts13(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts14 hosts14 = _Hosts14(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts15 hosts15 = _Hosts15(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts16 hosts16 = _Hosts16(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts17 hosts17 = _Hosts17(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts18 hosts18 = _Hosts18(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts19 hosts19 = _Hosts19(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts20 hosts20 = _Hosts20(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts21 hosts21 = _Hosts21(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts22 hosts22 = _Hosts22(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts23 hosts23 = _Hosts23(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts24 hosts24 = _Hosts24(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts25 hosts25 = _Hosts25(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts26 hosts26 = _Hosts26(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts27 hosts27 = _Hosts27(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts28 hosts28 = _Hosts28(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts29 hosts29 = _Hosts29(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts30 hosts30 = _Hosts30(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts31 hosts31 = _Hosts31(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts32 hosts32 = _Hosts32(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts33 hosts33 = _Hosts33(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts34 hosts34 = _Hosts34(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts35 hosts35 = _Hosts35(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts36 hosts36 = _Hosts36(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts37 hosts37 = _Hosts37(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts38 hosts38 = _Hosts38(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts39 hosts39 = _Hosts39(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts40 hosts40 = _Hosts40(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts41 hosts41 = _Hosts41(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts42 hosts42 = _Hosts42(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts43 hosts43 = _Hosts43(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts44 hosts44 = _Hosts44(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts45 hosts45 = _Hosts45(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts46 hosts46 = _Hosts46(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts47 hosts47 = _Hosts47(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts48 hosts48 = _Hosts48(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts49 hosts49 = _Hosts49(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts50 hosts50 = _Hosts50(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts51 hosts51 = _Hosts51(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts52 hosts52 = _Hosts52(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts53 hosts53 = _Hosts53(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts54 hosts54 = _Hosts54(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts55 hosts55 = _Hosts55(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts56 hosts56 = _Hosts56(
    HostsName                          : "",
    IpAddress                          : "",
  );

  _Hosts57 hosts57 = _Hosts57(
    HostsName                          : "",
    IpAddress                          : "",
  );
}

@JsonSerializable()
class _Hosts1 {
  factory _Hosts1.fromJson(Map<String, dynamic> json) => _$Hosts1FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts1ToJson(this);

  _Hosts1({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "localhost")
  String HostsName;
  @JsonKey(defaultValue: "127.0.0.1")
  String IpAddress;
}

@JsonSerializable()
class _Hosts2 {
  factory _Hosts2.fromJson(Map<String, dynamic> json) => _$Hosts2FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts2ToJson(this);

  _Hosts2({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "ts2100")
  String HostsName;
  @JsonKey(defaultValue: "192.168.10.127")
  String IpAddress;
}

@JsonSerializable()
class _Hosts3 {
  factory _Hosts3.fromJson(Map<String, dynamic> json) => _$Hosts3FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts3ToJson(this);

  _Hosts3({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "ts21db")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts4 {
  factory _Hosts4.fromJson(Map<String, dynamic> json) => _$Hosts4FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts4ToJson(this);

  _Hosts4({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "web000001")
  String HostsName;
  @JsonKey(defaultValue: "192.168.10.1")
  String IpAddress;
}

@JsonSerializable()
class _Hosts5 {
  factory _Hosts5.fromJson(Map<String, dynamic> json) => _$Hosts5FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts5ToJson(this);

  _Hosts5({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "subsrx")
  String HostsName;
  @JsonKey(defaultValue: "192.168.10.1")
  String IpAddress;
}

@JsonSerializable()
class _Hosts6 {
  factory _Hosts6.fromJson(Map<String, dynamic> json) => _$Hosts6FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts6ToJson(this);

  _Hosts6({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "compc")
  String HostsName;
  @JsonKey(defaultValue: "192.168.10.126")
  String IpAddress;
}

@JsonSerializable()
class _Hosts7 {
  factory _Hosts7.fromJson(Map<String, dynamic> json) => _$Hosts7FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts7ToJson(this);

  _Hosts7({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "mblsvr")
  String HostsName;
  @JsonKey(defaultValue: "192.168.10.1")
  String IpAddress;
}

@JsonSerializable()
class _Hosts8 {
  factory _Hosts8.fromJson(Map<String, dynamic> json) => _$Hosts8FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts8ToJson(this);

  _Hosts8({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "Con_steps")
  String HostsName;
  @JsonKey(defaultValue: "200.1.1.104")
  String IpAddress;
}

@JsonSerializable()
class _Hosts9 {
  factory _Hosts9.fromJson(Map<String, dynamic> json) => _$Hosts9FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts9ToJson(this);

  _Hosts9({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "poppy")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts10 {
  factory _Hosts10.fromJson(Map<String, dynamic> json) => _$Hosts10FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts10ToJson(this);

  _Hosts10({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "manage")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts11 {
  factory _Hosts11.fromJson(Map<String, dynamic> json) => _$Hosts11FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts11ToJson(this);

  _Hosts11({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "sims2100")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts12 {
  factory _Hosts12.fromJson(Map<String, dynamic> json) => _$Hosts12FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts12ToJson(this);

  _Hosts12({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "custserver")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts13 {
  factory _Hosts13.fromJson(Map<String, dynamic> json) => _$Hosts13FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts13ToJson(this);

  _Hosts13({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "mp1")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts14 {
  factory _Hosts14.fromJson(Map<String, dynamic> json) => _$Hosts14FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts14ToJson(this);

  _Hosts14({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "gx_server")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts15 {
  factory _Hosts15.fromJson(Map<String, dynamic> json) => _$Hosts15FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts15ToJson(this);

  _Hosts15({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "gx_s_server")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts16 {
  factory _Hosts16.fromJson(Map<String, dynamic> json) => _$Hosts16FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts16ToJson(this);

  _Hosts16({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "hqserver")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts17 {
  factory _Hosts17.fromJson(Map<String, dynamic> json) => _$Hosts17FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts17ToJson(this);

  _Hosts17({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "landisk")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts18 {
  factory _Hosts18.fromJson(Map<String, dynamic> json) => _$Hosts18FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts18ToJson(this);

  _Hosts18({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "hq2server")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts19 {
  factory _Hosts19.fromJson(Map<String, dynamic> json) => _$Hosts19FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts19ToJson(this);

  _Hosts19({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "hqimg_server")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts20 {
  factory _Hosts20.fromJson(Map<String, dynamic> json) => _$Hosts20FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts20ToJson(this);

  _Hosts20({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "new_hq")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts21 {
  factory _Hosts21.fromJson(Map<String, dynamic> json) => _$Hosts21FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts21ToJson(this);

  _Hosts21({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "hq_second")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts22 {
  factory _Hosts22.fromJson(Map<String, dynamic> json) => _$Hosts22FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts22ToJson(this);

  _Hosts22({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "new_hq_second")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts23 {
  factory _Hosts23.fromJson(Map<String, dynamic> json) => _$Hosts23FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts23ToJson(this);

  _Hosts23({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "drugrev")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts24 {
  factory _Hosts24.fromJson(Map<String, dynamic> json) => _$Hosts24FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts24ToJson(this);

  _Hosts24({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "timeserver")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts25 {
  factory _Hosts25.fromJson(Map<String, dynamic> json) => _$Hosts25FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts25ToJson(this);

  _Hosts25({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "centerserver_mst")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts26 {
  factory _Hosts26.fromJson(Map<String, dynamic> json) => _$Hosts26FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts26ToJson(this);

  _Hosts26({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "centerserver_trn")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts27 {
  factory _Hosts27.fromJson(Map<String, dynamic> json) => _$Hosts27FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts27ToJson(this);

  _Hosts27({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "custserver2")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts28 {
  factory _Hosts28.fromJson(Map<String, dynamic> json) => _$Hosts28FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts28ToJson(this);

  _Hosts28({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "posinfo")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts29 {
  factory _Hosts29.fromJson(Map<String, dynamic> json) => _$Hosts29FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts29ToJson(this);

  _Hosts29({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "pbchg1")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts30 {
  factory _Hosts30.fromJson(Map<String, dynamic> json) => _$Hosts30FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts30ToJson(this);

  _Hosts30({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "pbchg2")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts31 {
  factory _Hosts31.fromJson(Map<String, dynamic> json) => _$Hosts31FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts31ToJson(this);

  _Hosts31({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "compc2")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts32 {
  factory _Hosts32.fromJson(Map<String, dynamic> json) => _$Hosts32FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts32ToJson(this);

  _Hosts32({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "spqc")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts33 {
  factory _Hosts33.fromJson(Map<String, dynamic> json) => _$Hosts33FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts33ToJson(this);

  _Hosts33({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "two_connect")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts34 {
  factory _Hosts34.fromJson(Map<String, dynamic> json) => _$Hosts34FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts34ToJson(this);

  _Hosts34({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "point-system")
  String HostsName;
  @JsonKey(defaultValue: "184.205.1.151")
  String IpAddress;
}

@JsonSerializable()
class _Hosts35 {
  factory _Hosts35.fromJson(Map<String, dynamic> json) => _$Hosts35FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts35ToJson(this);

  _Hosts35({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "real.ja-point.com")
  String HostsName;
  @JsonKey(defaultValue: "184.205.2.101")
  String IpAddress;
}

@JsonSerializable()
class _Hosts36 {
  factory _Hosts36.fromJson(Map<String, dynamic> json) => _$Hosts36FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts36ToJson(this);

  _Hosts36({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "spqc_subsvr")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts37 {
  factory _Hosts37.fromJson(Map<String, dynamic> json) => _$Hosts37FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts37ToJson(this);

  _Hosts37({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "MailExchanger")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts38 {
  factory _Hosts38.fromJson(Map<String, dynamic> json) => _$Hosts38FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts38ToJson(this);

  _Hosts38({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "mvserver")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts39 {
  factory _Hosts39.fromJson(Map<String, dynamic> json) => _$Hosts39FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts39ToJson(this);

  _Hosts39({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "brain")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts40 {
  factory _Hosts40.fromJson(Map<String, dynamic> json) => _$Hosts40FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts40ToJson(this);

  _Hosts40({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "hq_2nd_server")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts41 {
  factory _Hosts41.fromJson(Map<String, dynamic> json) => _$Hosts41FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts41ToJson(this);

  _Hosts41({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "verup_cnct")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts42 {
  factory _Hosts42.fromJson(Map<String, dynamic> json) => _$Hosts42FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts42ToJson(this);

  _Hosts42({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "sqrc_server")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts43 {
  factory _Hosts43.fromJson(Map<String, dynamic> json) => _$Hosts43FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts43ToJson(this);

  _Hosts43({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "kitchen_print1")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts44 {
  factory _Hosts44.fromJson(Map<String, dynamic> json) => _$Hosts44FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts44ToJson(this);

  _Hosts44({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "kitchen_print2")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts45 {
  factory _Hosts45.fromJson(Map<String, dynamic> json) => _$Hosts45FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts45ToJson(this);

  _Hosts45({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "bkup_save")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts46 {
  factory _Hosts46.fromJson(Map<String, dynamic> json) => _$Hosts46FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts46ToJson(this);

  _Hosts46({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "tswebsvr")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts47 {
  factory _Hosts47.fromJson(Map<String, dynamic> json) => _$Hosts47FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts47ToJson(this);

  _Hosts47({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "histlog_server")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts48 {
  factory _Hosts48.fromJson(Map<String, dynamic> json) => _$Hosts48FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts48ToJson(this);

  _Hosts48({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "pack_on_time_svr")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts49 {
  factory _Hosts49.fromJson(Map<String, dynamic> json) => _$Hosts49FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts49ToJson(this);

  _Hosts49({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "histlog_sub_server")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts50 {
  factory _Hosts50.fromJson(Map<String, dynamic> json) => _$Hosts50FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts50ToJson(this);

  _Hosts50({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "cust_reserve_svr")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts51 {
  factory _Hosts51.fromJson(Map<String, dynamic> json) => _$Hosts51FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts51ToJson(this);

  _Hosts51({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "dpoint")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts52 {
  factory _Hosts52.fromJson(Map<String, dynamic> json) => _$Hosts52FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts52ToJson(this);

  _Hosts52({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "dpoint_rela_svr")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts53 {
  factory _Hosts53.fromJson(Map<String, dynamic> json) => _$Hosts53FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts53ToJson(this);

  _Hosts53({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "tpoint")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts54 {
  factory _Hosts54.fromJson(Map<String, dynamic> json) => _$Hosts54FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts54ToJson(this);

  _Hosts54({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "iot.975194.jp")
  String HostsName;
  @JsonKey(defaultValue: "52.193.215.32")
  String IpAddress;
}

@JsonSerializable()
class _Hosts55 {
  factory _Hosts55.fromJson(Map<String, dynamic> json) => _$Hosts55FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts55ToJson(this);

  _Hosts55({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "ws_hq")
  String HostsName;
  @JsonKey(defaultValue: "192.168.11.150")
  String IpAddress;
}

@JsonSerializable()
class _Hosts56 {
  factory _Hosts56.fromJson(Map<String, dynamic> json) => _$Hosts56FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts56ToJson(this);

  _Hosts56({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "recovery_file")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

@JsonSerializable()
class _Hosts57 {
  factory _Hosts57.fromJson(Map<String, dynamic> json) => _$Hosts57FromJson(json);
  Map<String, dynamic> toJson() => _$Hosts57ToJson(this);

  _Hosts57({
    required this.HostsName,
    required this.IpAddress,
  });

  @JsonKey(defaultValue: "aibox")
  String HostsName;
  @JsonKey(defaultValue: "0.0.0.0")
  String IpAddress;
}

