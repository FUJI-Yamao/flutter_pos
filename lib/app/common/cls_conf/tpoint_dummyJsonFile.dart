/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'tpoint_dummyJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Tpoint_dummyJsonFile extends ConfigJsonFile {
  static final Tpoint_dummyJsonFile _instance = Tpoint_dummyJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "tpoint_dummy.json";

  Tpoint_dummyJsonFile(){
    setPath(_confPath, _fileName);
  }
  Tpoint_dummyJsonFile._internal();

  factory Tpoint_dummyJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Tpoint_dummyJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Tpoint_dummyJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Tpoint_dummyJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        tpoint = _$TpointFromJson(jsonD['tpoint']);
      } catch(e) {
        tpoint = _$TpointFromJson({});
        ret = false;
      }
      try {
        tpoint_use = _$Tpoint_useFromJson(jsonD['tpoint_use']);
      } catch(e) {
        tpoint_use = _$Tpoint_useFromJson({});
        ret = false;
      }
      try {
        tpoint_cancel = _$Tpoint_cancelFromJson(jsonD['tpoint_cancel']);
      } catch(e) {
        tpoint_cancel = _$Tpoint_cancelFromJson({});
        ret = false;
      }
      try {
        mobile = _$MobileFromJson(jsonD['mobile']);
      } catch(e) {
        mobile = _$MobileFromJson({});
        ret = false;
      }
      try {
        tmoney = _$TmoneyFromJson(jsonD['tmoney']);
      } catch(e) {
        tmoney = _$TmoneyFromJson({});
        ret = false;
      }
      try {
        tmoney_chrg = _$Tmoney_chrgFromJson(jsonD['tmoney_chrg']);
      } catch(e) {
        tmoney_chrg = _$Tmoney_chrgFromJson({});
        ret = false;
      }
      try {
        tmoney_chrg_rc = _$Tmoney_chrg_rcFromJson(jsonD['tmoney_chrg_rc']);
      } catch(e) {
        tmoney_chrg_rc = _$Tmoney_chrg_rcFromJson({});
        ret = false;
      }
      try {
        tmoney_chrg_vd = _$Tmoney_chrg_vdFromJson(jsonD['tmoney_chrg_vd']);
      } catch(e) {
        tmoney_chrg_vd = _$Tmoney_chrg_vdFromJson({});
        ret = false;
      }
      try {
        tmoney_tran = _$Tmoney_tranFromJson(jsonD['tmoney_tran']);
      } catch(e) {
        tmoney_tran = _$Tmoney_tranFromJson({});
        ret = false;
      }
      try {
        tmoney_tran_rc = _$Tmoney_tran_rcFromJson(jsonD['tmoney_tran_rc']);
      } catch(e) {
        tmoney_tran_rc = _$Tmoney_tran_rcFromJson({});
        ret = false;
      }
      try {
        tmoney_tran_vd = _$Tmoney_tran_vdFromJson(jsonD['tmoney_tran_vd']);
      } catch(e) {
        tmoney_tran_vd = _$Tmoney_tran_vdFromJson({});
        ret = false;
      }
      try {
        kikan = _$KikanFromJson(jsonD['kikan']);
      } catch(e) {
        kikan = _$KikanFromJson({});
        ret = false;
      }
      try {
        kikan_use = _$Kikan_useFromJson(jsonD['kikan_use']);
      } catch(e) {
        kikan_use = _$Kikan_useFromJson({});
        ret = false;
      }
      try {
        kikan_cancel = _$Kikan_cancelFromJson(jsonD['kikan_cancel']);
      } catch(e) {
        kikan_cancel = _$Kikan_cancelFromJson({});
        ret = false;
      }
      try {
        tcoupon = _$TcouponFromJson(jsonD['tcoupon']);
      } catch(e) {
        tcoupon = _$TcouponFromJson({});
        ret = false;
      }
      try {
        tcoupon1 = _$Tcoupon1FromJson(jsonD['tcoupon1']);
      } catch(e) {
        tcoupon1 = _$Tcoupon1FromJson({});
        ret = false;
      }
      try {
        tcoupon2 = _$Tcoupon2FromJson(jsonD['tcoupon2']);
      } catch(e) {
        tcoupon2 = _$Tcoupon2FromJson({});
        ret = false;
      }
      try {
        tcoupon3 = _$Tcoupon3FromJson(jsonD['tcoupon3']);
      } catch(e) {
        tcoupon3 = _$Tcoupon3FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Tpoint tpoint = _Tpoint(
    pts                                : 0,
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Tpoint_use tpoint_use = _Tpoint_use(
    pts                                : 0,
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Tpoint_cancel tpoint_cancel = _Tpoint_cancel(
    pts                                : 0,
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Mobile mobile = _Mobile(
    kaiin_id                           : "",
  );

  _Tmoney tmoney = _Tmoney(
    ret_cd                             : "",
    avbl                               : 0,
    first                              : 0,
    bal                                : 0,
  );

  _Tmoney_chrg tmoney_chrg = _Tmoney_chrg(
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Tmoney_chrg_rc tmoney_chrg_rc = _Tmoney_chrg_rc(
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Tmoney_chrg_vd tmoney_chrg_vd = _Tmoney_chrg_vd(
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Tmoney_tran tmoney_tran = _Tmoney_tran(
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Tmoney_tran_rc tmoney_tran_rc = _Tmoney_tran_rc(
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Tmoney_tran_vd tmoney_tran_vd = _Tmoney_tran_vd(
    ret_cd                             : "",
    err_flg                            : 0,
  );

  _Kikan kikan = _Kikan(
    total                              : "",
    minlim                             : "",
    count                              : 0,
    id1                                : "",
    pts1                               : "",
    date1                              : "",
    id2                                : "",
    pts2                               : "",
    date2                              : "",
    id3                                : "",
    pts3                               : "",
    date3                              : "",
    id4                                : "",
    pts4                               : "",
    date4                              : "",
    id5                                : "",
    pts5                               : "",
    date5                              : "",
    id6                                : "",
    pts6                               : "",
    date6                              : "",
    id7                                : "",
    pts7                               : "",
    date7                              : "",
    id8                                : "",
    pts8                               : "",
    date8                              : "",
    id9                                : "",
    pts9                               : "",
    date9                              : "",
    id10                               : "",
    pts10                              : "",
    date10                             : "",
  );

  _Kikan_use kikan_use = _Kikan_use(
    total                              : "",
    minlim                             : "",
    count                              : 0,
    id1                                : "",
    pts1                               : "",
    date1                              : "",
    id2                                : "",
    pts2                               : "",
    date2                              : "",
    id3                                : "",
    pts3                               : "",
    date3                              : "",
    id4                                : "",
    pts4                               : "",
    date4                              : "",
    id5                                : "",
    pts5                               : "",
    date5                              : "",
    id6                                : "",
    pts6                               : "",
    date6                              : "",
    id7                                : "",
    pts7                               : "",
    date7                              : "",
    id8                                : "",
    pts8                               : "",
    date8                              : "",
    id9                                : "",
    pts9                               : "",
    date9                              : "",
    id10                               : "",
    pts10                              : "",
    date10                             : "",
  );

  _Kikan_cancel kikan_cancel = _Kikan_cancel(
    total                              : "",
    minlim                             : "",
    count                              : 0,
    id1                                : "",
    pts1                               : "",
    date1                              : "",
    id2                                : "",
    pts2                               : "",
    date2                              : "",
    id3                                : "",
    pts3                               : "",
    date3                              : "",
    id4                                : "",
    pts4                               : "",
    date4                              : "",
    id5                                : "",
    pts5                               : "",
    date5                              : "",
    id6                                : "",
    pts6                               : "",
    date6                              : "",
    id7                                : "",
    pts7                               : "",
    date7                              : "",
    id8                                : "",
    pts8                               : "",
    date8                              : "",
    id9                                : "",
    pts9                               : "",
    date9                              : "",
    id10                               : "",
    pts10                              : "",
    date10                             : "",
  );

  _Tcoupon tcoupon = _Tcoupon(
    count                              : 0,
  );

  _Tcoupon1 tcoupon1 = _Tcoupon1(
    no                                 : "",
    prom                               : "",
    jan                                : "",
    kanri                              : "",
    keihyo                             : "",
    mbr                                : "",
    shop                               : "",
    txt1                               : "",
    txt2                               : "",
    txt3                               : "",
    txt4                               : "",
    kenmen                             : "",
    kikaku                             : "",
    limit                              : "",
    title                              : "",
    subt                               : "",
    note1                              : "",
    note2                              : "",
    info1                              : "",
    info2                              : "",
    info3                              : "",
    info4                              : "",
    urltxt                             : "",
    url_1                              : "",
    url_2                              : "",
    url_3                              : "",
  );

  _Tcoupon2 tcoupon2 = _Tcoupon2(
    no                                 : "",
    prom                               : "",
    jan                                : "",
    kanri                              : "",
    keihyo                             : "",
    mbr                                : "",
    shop                               : "",
    txt1                               : "",
    txt2                               : "",
    txt3                               : "",
    txt4                               : "",
    kenmen                             : "",
    kikaku                             : "",
    limit                              : "",
    title                              : "",
    subt                               : "",
    note1                              : "",
    note2                              : "",
    info1                              : "",
    info2                              : "",
    info3                              : "",
    info4                              : "",
    urltxt                             : "",
    url_1                              : "",
    url_2                              : "",
    url_3                              : "",
  );

  _Tcoupon3 tcoupon3 = _Tcoupon3(
    no                                 : "",
    prom                               : "",
    jan                                : "",
    kanri                              : "",
    keihyo                             : "",
    mbr                                : "",
    shop                               : "",
    txt1                               : "",
    txt2                               : "",
    txt3                               : "",
    txt4                               : "",
    kenmen                             : "",
    kikaku                             : "",
    limit                              : "",
    title                              : "",
    subt                               : "",
    note1                              : "",
    note2                              : "",
    info1                              : "",
    info2                              : "",
    info3                              : "",
    info4                              : "",
    urltxt                             : "",
    url_1                              : "",
    url_2                              : "",
    url_3                              : "",
  );
}

@JsonSerializable()
class _Tpoint {
  factory _Tpoint.fromJson(Map<String, dynamic> json) => _$TpointFromJson(json);
  Map<String, dynamic> toJson() => _$TpointToJson(this);

  _Tpoint({
    required this.pts,
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: 10000)
  int    pts;
  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Tpoint_use {
  factory _Tpoint_use.fromJson(Map<String, dynamic> json) => _$Tpoint_useFromJson(json);
  Map<String, dynamic> toJson() => _$Tpoint_useToJson(this);

  _Tpoint_use({
    required this.pts,
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: 1000)
  int    pts;
  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Tpoint_cancel {
  factory _Tpoint_cancel.fromJson(Map<String, dynamic> json) => _$Tpoint_cancelFromJson(json);
  Map<String, dynamic> toJson() => _$Tpoint_cancelToJson(this);

  _Tpoint_cancel({
    required this.pts,
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: 2000)
  int    pts;
  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Mobile {
  factory _Mobile.fromJson(Map<String, dynamic> json) => _$MobileFromJson(json);
  Map<String, dynamic> toJson() => _$MobileToJson(this);

  _Mobile({
    required this.kaiin_id,
  });

  @JsonKey(defaultValue: "1234567890123456")
  String kaiin_id;
}

@JsonSerializable()
class _Tmoney {
  factory _Tmoney.fromJson(Map<String, dynamic> json) => _$TmoneyFromJson(json);
  Map<String, dynamic> toJson() => _$TmoneyToJson(this);

  _Tmoney({
    required this.ret_cd,
    required this.avbl,
    required this.first,
    required this.bal,
  });

  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 1)
  int    avbl;
  @JsonKey(defaultValue: 1)
  int    first;
  @JsonKey(defaultValue: 1000)
  int    bal;
}

@JsonSerializable()
class _Tmoney_chrg {
  factory _Tmoney_chrg.fromJson(Map<String, dynamic> json) => _$Tmoney_chrgFromJson(json);
  Map<String, dynamic> toJson() => _$Tmoney_chrgToJson(this);

  _Tmoney_chrg({
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Tmoney_chrg_rc {
  factory _Tmoney_chrg_rc.fromJson(Map<String, dynamic> json) => _$Tmoney_chrg_rcFromJson(json);
  Map<String, dynamic> toJson() => _$Tmoney_chrg_rcToJson(this);

  _Tmoney_chrg_rc({
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Tmoney_chrg_vd {
  factory _Tmoney_chrg_vd.fromJson(Map<String, dynamic> json) => _$Tmoney_chrg_vdFromJson(json);
  Map<String, dynamic> toJson() => _$Tmoney_chrg_vdToJson(this);

  _Tmoney_chrg_vd({
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Tmoney_tran {
  factory _Tmoney_tran.fromJson(Map<String, dynamic> json) => _$Tmoney_tranFromJson(json);
  Map<String, dynamic> toJson() => _$Tmoney_tranToJson(this);

  _Tmoney_tran({
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Tmoney_tran_rc {
  factory _Tmoney_tran_rc.fromJson(Map<String, dynamic> json) => _$Tmoney_tran_rcFromJson(json);
  Map<String, dynamic> toJson() => _$Tmoney_tran_rcToJson(this);

  _Tmoney_tran_rc({
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Tmoney_tran_vd {
  factory _Tmoney_tran_vd.fromJson(Map<String, dynamic> json) => _$Tmoney_tran_vdFromJson(json);
  Map<String, dynamic> toJson() => _$Tmoney_tran_vdToJson(this);

  _Tmoney_tran_vd({
    required this.ret_cd,
    required this.err_flg,
  });

  @JsonKey(defaultValue: "00")
  String ret_cd;
  @JsonKey(defaultValue: 0)
  int    err_flg;
}

@JsonSerializable()
class _Kikan {
  factory _Kikan.fromJson(Map<String, dynamic> json) => _$KikanFromJson(json);
  Map<String, dynamic> toJson() => _$KikanToJson(this);

  _Kikan({
    required this.total,
    required this.minlim,
    required this.count,
    required this.id1,
    required this.pts1,
    required this.date1,
    required this.id2,
    required this.pts2,
    required this.date2,
    required this.id3,
    required this.pts3,
    required this.date3,
    required this.id4,
    required this.pts4,
    required this.date4,
    required this.id5,
    required this.pts5,
    required this.date5,
    required this.id6,
    required this.pts6,
    required this.date6,
    required this.id7,
    required this.pts7,
    required this.date7,
    required this.id8,
    required this.pts8,
    required this.date8,
    required this.id9,
    required this.pts9,
    required this.date9,
    required this.id10,
    required this.pts10,
    required this.date10,
  });

  @JsonKey(defaultValue: "")
  String total;
  @JsonKey(defaultValue: "")
  String minlim;
  @JsonKey(defaultValue: 0)
  int    count;
  @JsonKey(defaultValue: "")
  String id1;
  @JsonKey(defaultValue: "")
  String pts1;
  @JsonKey(defaultValue: "")
  String date1;
  @JsonKey(defaultValue: "")
  String id2;
  @JsonKey(defaultValue: "")
  String pts2;
  @JsonKey(defaultValue: "")
  String date2;
  @JsonKey(defaultValue: "")
  String id3;
  @JsonKey(defaultValue: "")
  String pts3;
  @JsonKey(defaultValue: "")
  String date3;
  @JsonKey(defaultValue: "")
  String id4;
  @JsonKey(defaultValue: "")
  String pts4;
  @JsonKey(defaultValue: "")
  String date4;
  @JsonKey(defaultValue: "")
  String id5;
  @JsonKey(defaultValue: "")
  String pts5;
  @JsonKey(defaultValue: "")
  String date5;
  @JsonKey(defaultValue: "")
  String id6;
  @JsonKey(defaultValue: "")
  String pts6;
  @JsonKey(defaultValue: "")
  String date6;
  @JsonKey(defaultValue: "")
  String id7;
  @JsonKey(defaultValue: "")
  String pts7;
  @JsonKey(defaultValue: "")
  String date7;
  @JsonKey(defaultValue: "")
  String id8;
  @JsonKey(defaultValue: "")
  String pts8;
  @JsonKey(defaultValue: "")
  String date8;
  @JsonKey(defaultValue: "")
  String id9;
  @JsonKey(defaultValue: "")
  String pts9;
  @JsonKey(defaultValue: "")
  String date9;
  @JsonKey(defaultValue: "")
  String id10;
  @JsonKey(defaultValue: "")
  String pts10;
  @JsonKey(defaultValue: "")
  String date10;
}

@JsonSerializable()
class _Kikan_use {
  factory _Kikan_use.fromJson(Map<String, dynamic> json) => _$Kikan_useFromJson(json);
  Map<String, dynamic> toJson() => _$Kikan_useToJson(this);

  _Kikan_use({
    required this.total,
    required this.minlim,
    required this.count,
    required this.id1,
    required this.pts1,
    required this.date1,
    required this.id2,
    required this.pts2,
    required this.date2,
    required this.id3,
    required this.pts3,
    required this.date3,
    required this.id4,
    required this.pts4,
    required this.date4,
    required this.id5,
    required this.pts5,
    required this.date5,
    required this.id6,
    required this.pts6,
    required this.date6,
    required this.id7,
    required this.pts7,
    required this.date7,
    required this.id8,
    required this.pts8,
    required this.date8,
    required this.id9,
    required this.pts9,
    required this.date9,
    required this.id10,
    required this.pts10,
    required this.date10,
  });

  @JsonKey(defaultValue: "")
  String total;
  @JsonKey(defaultValue: "")
  String minlim;
  @JsonKey(defaultValue: 0)
  int    count;
  @JsonKey(defaultValue: "")
  String id1;
  @JsonKey(defaultValue: "")
  String pts1;
  @JsonKey(defaultValue: "")
  String date1;
  @JsonKey(defaultValue: "")
  String id2;
  @JsonKey(defaultValue: "")
  String pts2;
  @JsonKey(defaultValue: "")
  String date2;
  @JsonKey(defaultValue: "")
  String id3;
  @JsonKey(defaultValue: "")
  String pts3;
  @JsonKey(defaultValue: "")
  String date3;
  @JsonKey(defaultValue: "")
  String id4;
  @JsonKey(defaultValue: "")
  String pts4;
  @JsonKey(defaultValue: "")
  String date4;
  @JsonKey(defaultValue: "")
  String id5;
  @JsonKey(defaultValue: "")
  String pts5;
  @JsonKey(defaultValue: "")
  String date5;
  @JsonKey(defaultValue: "")
  String id6;
  @JsonKey(defaultValue: "")
  String pts6;
  @JsonKey(defaultValue: "")
  String date6;
  @JsonKey(defaultValue: "")
  String id7;
  @JsonKey(defaultValue: "")
  String pts7;
  @JsonKey(defaultValue: "")
  String date7;
  @JsonKey(defaultValue: "")
  String id8;
  @JsonKey(defaultValue: "")
  String pts8;
  @JsonKey(defaultValue: "")
  String date8;
  @JsonKey(defaultValue: "")
  String id9;
  @JsonKey(defaultValue: "")
  String pts9;
  @JsonKey(defaultValue: "")
  String date9;
  @JsonKey(defaultValue: "")
  String id10;
  @JsonKey(defaultValue: "")
  String pts10;
  @JsonKey(defaultValue: "")
  String date10;
}

@JsonSerializable()
class _Kikan_cancel {
  factory _Kikan_cancel.fromJson(Map<String, dynamic> json) => _$Kikan_cancelFromJson(json);
  Map<String, dynamic> toJson() => _$Kikan_cancelToJson(this);

  _Kikan_cancel({
    required this.total,
    required this.minlim,
    required this.count,
    required this.id1,
    required this.pts1,
    required this.date1,
    required this.id2,
    required this.pts2,
    required this.date2,
    required this.id3,
    required this.pts3,
    required this.date3,
    required this.id4,
    required this.pts4,
    required this.date4,
    required this.id5,
    required this.pts5,
    required this.date5,
    required this.id6,
    required this.pts6,
    required this.date6,
    required this.id7,
    required this.pts7,
    required this.date7,
    required this.id8,
    required this.pts8,
    required this.date8,
    required this.id9,
    required this.pts9,
    required this.date9,
    required this.id10,
    required this.pts10,
    required this.date10,
  });

  @JsonKey(defaultValue: "")
  String total;
  @JsonKey(defaultValue: "")
  String minlim;
  @JsonKey(defaultValue: 0)
  int    count;
  @JsonKey(defaultValue: "")
  String id1;
  @JsonKey(defaultValue: "")
  String pts1;
  @JsonKey(defaultValue: "")
  String date1;
  @JsonKey(defaultValue: "")
  String id2;
  @JsonKey(defaultValue: "")
  String pts2;
  @JsonKey(defaultValue: "")
  String date2;
  @JsonKey(defaultValue: "")
  String id3;
  @JsonKey(defaultValue: "")
  String pts3;
  @JsonKey(defaultValue: "")
  String date3;
  @JsonKey(defaultValue: "")
  String id4;
  @JsonKey(defaultValue: "")
  String pts4;
  @JsonKey(defaultValue: "")
  String date4;
  @JsonKey(defaultValue: "")
  String id5;
  @JsonKey(defaultValue: "")
  String pts5;
  @JsonKey(defaultValue: "")
  String date5;
  @JsonKey(defaultValue: "")
  String id6;
  @JsonKey(defaultValue: "")
  String pts6;
  @JsonKey(defaultValue: "")
  String date6;
  @JsonKey(defaultValue: "")
  String id7;
  @JsonKey(defaultValue: "")
  String pts7;
  @JsonKey(defaultValue: "")
  String date7;
  @JsonKey(defaultValue: "")
  String id8;
  @JsonKey(defaultValue: "")
  String pts8;
  @JsonKey(defaultValue: "")
  String date8;
  @JsonKey(defaultValue: "")
  String id9;
  @JsonKey(defaultValue: "")
  String pts9;
  @JsonKey(defaultValue: "")
  String date9;
  @JsonKey(defaultValue: "")
  String id10;
  @JsonKey(defaultValue: "")
  String pts10;
  @JsonKey(defaultValue: "")
  String date10;
}

@JsonSerializable()
class _Tcoupon {
  factory _Tcoupon.fromJson(Map<String, dynamic> json) => _$TcouponFromJson(json);
  Map<String, dynamic> toJson() => _$TcouponToJson(this);

  _Tcoupon({
    required this.count,
  });

  @JsonKey(defaultValue: 0)
  int    count;
}

@JsonSerializable()
class _Tcoupon1 {
  factory _Tcoupon1.fromJson(Map<String, dynamic> json) => _$Tcoupon1FromJson(json);
  Map<String, dynamic> toJson() => _$Tcoupon1ToJson(this);

  _Tcoupon1({
    required this.no,
    required this.prom,
    required this.jan,
    required this.kanri,
    required this.keihyo,
    required this.mbr,
    required this.shop,
    required this.txt1,
    required this.txt2,
    required this.txt3,
    required this.txt4,
    required this.kenmen,
    required this.kikaku,
    required this.limit,
    required this.title,
    required this.subt,
    required this.note1,
    required this.note2,
    required this.info1,
    required this.info2,
    required this.info3,
    required this.info4,
    required this.urltxt,
    required this.url_1,
    required this.url_2,
    required this.url_3,
  });

  @JsonKey(defaultValue: "")
  String no;
  @JsonKey(defaultValue: "")
  String prom;
  @JsonKey(defaultValue: "")
  String jan;
  @JsonKey(defaultValue: "")
  String kanri;
  @JsonKey(defaultValue: "")
  String keihyo;
  @JsonKey(defaultValue: "")
  String mbr;
  @JsonKey(defaultValue: "")
  String shop;
  @JsonKey(defaultValue: "")
  String txt1;
  @JsonKey(defaultValue: "")
  String txt2;
  @JsonKey(defaultValue: "")
  String txt3;
  @JsonKey(defaultValue: "")
  String txt4;
  @JsonKey(defaultValue: "")
  String kenmen;
  @JsonKey(defaultValue: "")
  String kikaku;
  @JsonKey(defaultValue: "")
  String limit;
  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String subt;
  @JsonKey(defaultValue: "")
  String note1;
  @JsonKey(defaultValue: "")
  String note2;
  @JsonKey(defaultValue: "")
  String info1;
  @JsonKey(defaultValue: "")
  String info2;
  @JsonKey(defaultValue: "")
  String info3;
  @JsonKey(defaultValue: "")
  String info4;
  @JsonKey(defaultValue: "")
  String urltxt;
  @JsonKey(defaultValue: "")
  String url_1;
  @JsonKey(defaultValue: "")
  String url_2;
  @JsonKey(defaultValue: "")
  String url_3;
}

@JsonSerializable()
class _Tcoupon2 {
  factory _Tcoupon2.fromJson(Map<String, dynamic> json) => _$Tcoupon2FromJson(json);
  Map<String, dynamic> toJson() => _$Tcoupon2ToJson(this);

  _Tcoupon2({
    required this.no,
    required this.prom,
    required this.jan,
    required this.kanri,
    required this.keihyo,
    required this.mbr,
    required this.shop,
    required this.txt1,
    required this.txt2,
    required this.txt3,
    required this.txt4,
    required this.kenmen,
    required this.kikaku,
    required this.limit,
    required this.title,
    required this.subt,
    required this.note1,
    required this.note2,
    required this.info1,
    required this.info2,
    required this.info3,
    required this.info4,
    required this.urltxt,
    required this.url_1,
    required this.url_2,
    required this.url_3,
  });

  @JsonKey(defaultValue: "")
  String no;
  @JsonKey(defaultValue: "")
  String prom;
  @JsonKey(defaultValue: "")
  String jan;
  @JsonKey(defaultValue: "")
  String kanri;
  @JsonKey(defaultValue: "")
  String keihyo;
  @JsonKey(defaultValue: "")
  String mbr;
  @JsonKey(defaultValue: "")
  String shop;
  @JsonKey(defaultValue: "")
  String txt1;
  @JsonKey(defaultValue: "")
  String txt2;
  @JsonKey(defaultValue: "")
  String txt3;
  @JsonKey(defaultValue: "")
  String txt4;
  @JsonKey(defaultValue: "")
  String kenmen;
  @JsonKey(defaultValue: "")
  String kikaku;
  @JsonKey(defaultValue: "")
  String limit;
  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String subt;
  @JsonKey(defaultValue: "")
  String note1;
  @JsonKey(defaultValue: "")
  String note2;
  @JsonKey(defaultValue: "")
  String info1;
  @JsonKey(defaultValue: "")
  String info2;
  @JsonKey(defaultValue: "")
  String info3;
  @JsonKey(defaultValue: "")
  String info4;
  @JsonKey(defaultValue: "")
  String urltxt;
  @JsonKey(defaultValue: "")
  String url_1;
  @JsonKey(defaultValue: "")
  String url_2;
  @JsonKey(defaultValue: "")
  String url_3;
}

@JsonSerializable()
class _Tcoupon3 {
  factory _Tcoupon3.fromJson(Map<String, dynamic> json) => _$Tcoupon3FromJson(json);
  Map<String, dynamic> toJson() => _$Tcoupon3ToJson(this);

  _Tcoupon3({
    required this.no,
    required this.prom,
    required this.jan,
    required this.kanri,
    required this.keihyo,
    required this.mbr,
    required this.shop,
    required this.txt1,
    required this.txt2,
    required this.txt3,
    required this.txt4,
    required this.kenmen,
    required this.kikaku,
    required this.limit,
    required this.title,
    required this.subt,
    required this.note1,
    required this.note2,
    required this.info1,
    required this.info2,
    required this.info3,
    required this.info4,
    required this.urltxt,
    required this.url_1,
    required this.url_2,
    required this.url_3,
  });

  @JsonKey(defaultValue: "")
  String no;
  @JsonKey(defaultValue: "")
  String prom;
  @JsonKey(defaultValue: "")
  String jan;
  @JsonKey(defaultValue: "")
  String kanri;
  @JsonKey(defaultValue: "")
  String keihyo;
  @JsonKey(defaultValue: "")
  String mbr;
  @JsonKey(defaultValue: "")
  String shop;
  @JsonKey(defaultValue: "")
  String txt1;
  @JsonKey(defaultValue: "")
  String txt2;
  @JsonKey(defaultValue: "")
  String txt3;
  @JsonKey(defaultValue: "")
  String txt4;
  @JsonKey(defaultValue: "")
  String kenmen;
  @JsonKey(defaultValue: "")
  String kikaku;
  @JsonKey(defaultValue: "")
  String limit;
  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(defaultValue: "")
  String subt;
  @JsonKey(defaultValue: "")
  String note1;
  @JsonKey(defaultValue: "")
  String note2;
  @JsonKey(defaultValue: "")
  String info1;
  @JsonKey(defaultValue: "")
  String info2;
  @JsonKey(defaultValue: "")
  String info3;
  @JsonKey(defaultValue: "")
  String info4;
  @JsonKey(defaultValue: "")
  String urltxt;
  @JsonKey(defaultValue: "")
  String url_1;
  @JsonKey(defaultValue: "")
  String url_2;
  @JsonKey(defaultValue: "")
  String url_3;
}

