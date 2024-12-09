// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tpoint_dummyJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tpoint_dummyJsonFile _$Tpoint_dummyJsonFileFromJson(
        Map<String, dynamic> json) =>
    Tpoint_dummyJsonFile()
      ..tpoint = _Tpoint.fromJson(json['tpoint'] as Map<String, dynamic>)
      ..tpoint_use =
          _Tpoint_use.fromJson(json['tpoint_use'] as Map<String, dynamic>)
      ..tpoint_cancel =
          _Tpoint_cancel.fromJson(json['tpoint_cancel'] as Map<String, dynamic>)
      ..mobile = _Mobile.fromJson(json['mobile'] as Map<String, dynamic>)
      ..tmoney = _Tmoney.fromJson(json['tmoney'] as Map<String, dynamic>)
      ..tmoney_chrg =
          _Tmoney_chrg.fromJson(json['tmoney_chrg'] as Map<String, dynamic>)
      ..tmoney_chrg_rc = _Tmoney_chrg_rc.fromJson(
          json['tmoney_chrg_rc'] as Map<String, dynamic>)
      ..tmoney_chrg_vd = _Tmoney_chrg_vd.fromJson(
          json['tmoney_chrg_vd'] as Map<String, dynamic>)
      ..tmoney_tran =
          _Tmoney_tran.fromJson(json['tmoney_tran'] as Map<String, dynamic>)
      ..tmoney_tran_rc = _Tmoney_tran_rc.fromJson(
          json['tmoney_tran_rc'] as Map<String, dynamic>)
      ..tmoney_tran_vd = _Tmoney_tran_vd.fromJson(
          json['tmoney_tran_vd'] as Map<String, dynamic>)
      ..kikan = _Kikan.fromJson(json['kikan'] as Map<String, dynamic>)
      ..kikan_use =
          _Kikan_use.fromJson(json['kikan_use'] as Map<String, dynamic>)
      ..kikan_cancel =
          _Kikan_cancel.fromJson(json['kikan_cancel'] as Map<String, dynamic>)
      ..tcoupon = _Tcoupon.fromJson(json['tcoupon'] as Map<String, dynamic>)
      ..tcoupon1 = _Tcoupon1.fromJson(json['tcoupon1'] as Map<String, dynamic>)
      ..tcoupon2 = _Tcoupon2.fromJson(json['tcoupon2'] as Map<String, dynamic>)
      ..tcoupon3 = _Tcoupon3.fromJson(json['tcoupon3'] as Map<String, dynamic>);

Map<String, dynamic> _$Tpoint_dummyJsonFileToJson(
        Tpoint_dummyJsonFile instance) =>
    <String, dynamic>{
      'tpoint': instance.tpoint.toJson(),
      'tpoint_use': instance.tpoint_use.toJson(),
      'tpoint_cancel': instance.tpoint_cancel.toJson(),
      'mobile': instance.mobile.toJson(),
      'tmoney': instance.tmoney.toJson(),
      'tmoney_chrg': instance.tmoney_chrg.toJson(),
      'tmoney_chrg_rc': instance.tmoney_chrg_rc.toJson(),
      'tmoney_chrg_vd': instance.tmoney_chrg_vd.toJson(),
      'tmoney_tran': instance.tmoney_tran.toJson(),
      'tmoney_tran_rc': instance.tmoney_tran_rc.toJson(),
      'tmoney_tran_vd': instance.tmoney_tran_vd.toJson(),
      'kikan': instance.kikan.toJson(),
      'kikan_use': instance.kikan_use.toJson(),
      'kikan_cancel': instance.kikan_cancel.toJson(),
      'tcoupon': instance.tcoupon.toJson(),
      'tcoupon1': instance.tcoupon1.toJson(),
      'tcoupon2': instance.tcoupon2.toJson(),
      'tcoupon3': instance.tcoupon3.toJson(),
    };

_Tpoint _$TpointFromJson(Map<String, dynamic> json) => _Tpoint(
      pts: json['pts'] as int? ?? 10000,
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$TpointToJson(_Tpoint instance) => <String, dynamic>{
      'pts': instance.pts,
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Tpoint_use _$Tpoint_useFromJson(Map<String, dynamic> json) => _Tpoint_use(
      pts: json['pts'] as int? ?? 1000,
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$Tpoint_useToJson(_Tpoint_use instance) =>
    <String, dynamic>{
      'pts': instance.pts,
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Tpoint_cancel _$Tpoint_cancelFromJson(Map<String, dynamic> json) =>
    _Tpoint_cancel(
      pts: json['pts'] as int? ?? 2000,
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$Tpoint_cancelToJson(_Tpoint_cancel instance) =>
    <String, dynamic>{
      'pts': instance.pts,
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Mobile _$MobileFromJson(Map<String, dynamic> json) => _Mobile(
      kaiin_id: json['kaiin_id'] as String? ?? '1234567890123456',
    );

Map<String, dynamic> _$MobileToJson(_Mobile instance) => <String, dynamic>{
      'kaiin_id': instance.kaiin_id,
    };

_Tmoney _$TmoneyFromJson(Map<String, dynamic> json) => _Tmoney(
      ret_cd: json['ret_cd'] as String? ?? '00',
      avbl: json['avbl'] as int? ?? 1,
      first: json['first'] as int? ?? 1,
      bal: json['bal'] as int? ?? 1000,
    );

Map<String, dynamic> _$TmoneyToJson(_Tmoney instance) => <String, dynamic>{
      'ret_cd': instance.ret_cd,
      'avbl': instance.avbl,
      'first': instance.first,
      'bal': instance.bal,
    };

_Tmoney_chrg _$Tmoney_chrgFromJson(Map<String, dynamic> json) => _Tmoney_chrg(
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$Tmoney_chrgToJson(_Tmoney_chrg instance) =>
    <String, dynamic>{
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Tmoney_chrg_rc _$Tmoney_chrg_rcFromJson(Map<String, dynamic> json) =>
    _Tmoney_chrg_rc(
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$Tmoney_chrg_rcToJson(_Tmoney_chrg_rc instance) =>
    <String, dynamic>{
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Tmoney_chrg_vd _$Tmoney_chrg_vdFromJson(Map<String, dynamic> json) =>
    _Tmoney_chrg_vd(
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$Tmoney_chrg_vdToJson(_Tmoney_chrg_vd instance) =>
    <String, dynamic>{
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Tmoney_tran _$Tmoney_tranFromJson(Map<String, dynamic> json) => _Tmoney_tran(
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$Tmoney_tranToJson(_Tmoney_tran instance) =>
    <String, dynamic>{
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Tmoney_tran_rc _$Tmoney_tran_rcFromJson(Map<String, dynamic> json) =>
    _Tmoney_tran_rc(
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$Tmoney_tran_rcToJson(_Tmoney_tran_rc instance) =>
    <String, dynamic>{
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Tmoney_tran_vd _$Tmoney_tran_vdFromJson(Map<String, dynamic> json) =>
    _Tmoney_tran_vd(
      ret_cd: json['ret_cd'] as String? ?? '00',
      err_flg: json['err_flg'] as int? ?? 0,
    );

Map<String, dynamic> _$Tmoney_tran_vdToJson(_Tmoney_tran_vd instance) =>
    <String, dynamic>{
      'ret_cd': instance.ret_cd,
      'err_flg': instance.err_flg,
    };

_Kikan _$KikanFromJson(Map<String, dynamic> json) => _Kikan(
      total: json['total'] as String? ?? '',
      minlim: json['minlim'] as String? ?? '',
      count: json['count'] as int? ?? 0,
      id1: json['id1'] as String? ?? '',
      pts1: json['pts1'] as String? ?? '',
      date1: json['date1'] as String? ?? '',
      id2: json['id2'] as String? ?? '',
      pts2: json['pts2'] as String? ?? '',
      date2: json['date2'] as String? ?? '',
      id3: json['id3'] as String? ?? '',
      pts3: json['pts3'] as String? ?? '',
      date3: json['date3'] as String? ?? '',
      id4: json['id4'] as String? ?? '',
      pts4: json['pts4'] as String? ?? '',
      date4: json['date4'] as String? ?? '',
      id5: json['id5'] as String? ?? '',
      pts5: json['pts5'] as String? ?? '',
      date5: json['date5'] as String? ?? '',
      id6: json['id6'] as String? ?? '',
      pts6: json['pts6'] as String? ?? '',
      date6: json['date6'] as String? ?? '',
      id7: json['id7'] as String? ?? '',
      pts7: json['pts7'] as String? ?? '',
      date7: json['date7'] as String? ?? '',
      id8: json['id8'] as String? ?? '',
      pts8: json['pts8'] as String? ?? '',
      date8: json['date8'] as String? ?? '',
      id9: json['id9'] as String? ?? '',
      pts9: json['pts9'] as String? ?? '',
      date9: json['date9'] as String? ?? '',
      id10: json['id10'] as String? ?? '',
      pts10: json['pts10'] as String? ?? '',
      date10: json['date10'] as String? ?? '',
    );

Map<String, dynamic> _$KikanToJson(_Kikan instance) => <String, dynamic>{
      'total': instance.total,
      'minlim': instance.minlim,
      'count': instance.count,
      'id1': instance.id1,
      'pts1': instance.pts1,
      'date1': instance.date1,
      'id2': instance.id2,
      'pts2': instance.pts2,
      'date2': instance.date2,
      'id3': instance.id3,
      'pts3': instance.pts3,
      'date3': instance.date3,
      'id4': instance.id4,
      'pts4': instance.pts4,
      'date4': instance.date4,
      'id5': instance.id5,
      'pts5': instance.pts5,
      'date5': instance.date5,
      'id6': instance.id6,
      'pts6': instance.pts6,
      'date6': instance.date6,
      'id7': instance.id7,
      'pts7': instance.pts7,
      'date7': instance.date7,
      'id8': instance.id8,
      'pts8': instance.pts8,
      'date8': instance.date8,
      'id9': instance.id9,
      'pts9': instance.pts9,
      'date9': instance.date9,
      'id10': instance.id10,
      'pts10': instance.pts10,
      'date10': instance.date10,
    };

_Kikan_use _$Kikan_useFromJson(Map<String, dynamic> json) => _Kikan_use(
      total: json['total'] as String? ?? '',
      minlim: json['minlim'] as String? ?? '',
      count: json['count'] as int? ?? 0,
      id1: json['id1'] as String? ?? '',
      pts1: json['pts1'] as String? ?? '',
      date1: json['date1'] as String? ?? '',
      id2: json['id2'] as String? ?? '',
      pts2: json['pts2'] as String? ?? '',
      date2: json['date2'] as String? ?? '',
      id3: json['id3'] as String? ?? '',
      pts3: json['pts3'] as String? ?? '',
      date3: json['date3'] as String? ?? '',
      id4: json['id4'] as String? ?? '',
      pts4: json['pts4'] as String? ?? '',
      date4: json['date4'] as String? ?? '',
      id5: json['id5'] as String? ?? '',
      pts5: json['pts5'] as String? ?? '',
      date5: json['date5'] as String? ?? '',
      id6: json['id6'] as String? ?? '',
      pts6: json['pts6'] as String? ?? '',
      date6: json['date6'] as String? ?? '',
      id7: json['id7'] as String? ?? '',
      pts7: json['pts7'] as String? ?? '',
      date7: json['date7'] as String? ?? '',
      id8: json['id8'] as String? ?? '',
      pts8: json['pts8'] as String? ?? '',
      date8: json['date8'] as String? ?? '',
      id9: json['id9'] as String? ?? '',
      pts9: json['pts9'] as String? ?? '',
      date9: json['date9'] as String? ?? '',
      id10: json['id10'] as String? ?? '',
      pts10: json['pts10'] as String? ?? '',
      date10: json['date10'] as String? ?? '',
    );

Map<String, dynamic> _$Kikan_useToJson(_Kikan_use instance) =>
    <String, dynamic>{
      'total': instance.total,
      'minlim': instance.minlim,
      'count': instance.count,
      'id1': instance.id1,
      'pts1': instance.pts1,
      'date1': instance.date1,
      'id2': instance.id2,
      'pts2': instance.pts2,
      'date2': instance.date2,
      'id3': instance.id3,
      'pts3': instance.pts3,
      'date3': instance.date3,
      'id4': instance.id4,
      'pts4': instance.pts4,
      'date4': instance.date4,
      'id5': instance.id5,
      'pts5': instance.pts5,
      'date5': instance.date5,
      'id6': instance.id6,
      'pts6': instance.pts6,
      'date6': instance.date6,
      'id7': instance.id7,
      'pts7': instance.pts7,
      'date7': instance.date7,
      'id8': instance.id8,
      'pts8': instance.pts8,
      'date8': instance.date8,
      'id9': instance.id9,
      'pts9': instance.pts9,
      'date9': instance.date9,
      'id10': instance.id10,
      'pts10': instance.pts10,
      'date10': instance.date10,
    };

_Kikan_cancel _$Kikan_cancelFromJson(Map<String, dynamic> json) =>
    _Kikan_cancel(
      total: json['total'] as String? ?? '',
      minlim: json['minlim'] as String? ?? '',
      count: json['count'] as int? ?? 0,
      id1: json['id1'] as String? ?? '',
      pts1: json['pts1'] as String? ?? '',
      date1: json['date1'] as String? ?? '',
      id2: json['id2'] as String? ?? '',
      pts2: json['pts2'] as String? ?? '',
      date2: json['date2'] as String? ?? '',
      id3: json['id3'] as String? ?? '',
      pts3: json['pts3'] as String? ?? '',
      date3: json['date3'] as String? ?? '',
      id4: json['id4'] as String? ?? '',
      pts4: json['pts4'] as String? ?? '',
      date4: json['date4'] as String? ?? '',
      id5: json['id5'] as String? ?? '',
      pts5: json['pts5'] as String? ?? '',
      date5: json['date5'] as String? ?? '',
      id6: json['id6'] as String? ?? '',
      pts6: json['pts6'] as String? ?? '',
      date6: json['date6'] as String? ?? '',
      id7: json['id7'] as String? ?? '',
      pts7: json['pts7'] as String? ?? '',
      date7: json['date7'] as String? ?? '',
      id8: json['id8'] as String? ?? '',
      pts8: json['pts8'] as String? ?? '',
      date8: json['date8'] as String? ?? '',
      id9: json['id9'] as String? ?? '',
      pts9: json['pts9'] as String? ?? '',
      date9: json['date9'] as String? ?? '',
      id10: json['id10'] as String? ?? '',
      pts10: json['pts10'] as String? ?? '',
      date10: json['date10'] as String? ?? '',
    );

Map<String, dynamic> _$Kikan_cancelToJson(_Kikan_cancel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'minlim': instance.minlim,
      'count': instance.count,
      'id1': instance.id1,
      'pts1': instance.pts1,
      'date1': instance.date1,
      'id2': instance.id2,
      'pts2': instance.pts2,
      'date2': instance.date2,
      'id3': instance.id3,
      'pts3': instance.pts3,
      'date3': instance.date3,
      'id4': instance.id4,
      'pts4': instance.pts4,
      'date4': instance.date4,
      'id5': instance.id5,
      'pts5': instance.pts5,
      'date5': instance.date5,
      'id6': instance.id6,
      'pts6': instance.pts6,
      'date6': instance.date6,
      'id7': instance.id7,
      'pts7': instance.pts7,
      'date7': instance.date7,
      'id8': instance.id8,
      'pts8': instance.pts8,
      'date8': instance.date8,
      'id9': instance.id9,
      'pts9': instance.pts9,
      'date9': instance.date9,
      'id10': instance.id10,
      'pts10': instance.pts10,
      'date10': instance.date10,
    };

_Tcoupon _$TcouponFromJson(Map<String, dynamic> json) => _Tcoupon(
      count: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$TcouponToJson(_Tcoupon instance) => <String, dynamic>{
      'count': instance.count,
    };

_Tcoupon1 _$Tcoupon1FromJson(Map<String, dynamic> json) => _Tcoupon1(
      no: json['no'] as String? ?? '',
      prom: json['prom'] as String? ?? '',
      jan: json['jan'] as String? ?? '',
      kanri: json['kanri'] as String? ?? '',
      keihyo: json['keihyo'] as String? ?? '',
      mbr: json['mbr'] as String? ?? '',
      shop: json['shop'] as String? ?? '',
      txt1: json['txt1'] as String? ?? '',
      txt2: json['txt2'] as String? ?? '',
      txt3: json['txt3'] as String? ?? '',
      txt4: json['txt4'] as String? ?? '',
      kenmen: json['kenmen'] as String? ?? '',
      kikaku: json['kikaku'] as String? ?? '',
      limit: json['limit'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subt: json['subt'] as String? ?? '',
      note1: json['note1'] as String? ?? '',
      note2: json['note2'] as String? ?? '',
      info1: json['info1'] as String? ?? '',
      info2: json['info2'] as String? ?? '',
      info3: json['info3'] as String? ?? '',
      info4: json['info4'] as String? ?? '',
      urltxt: json['urltxt'] as String? ?? '',
      url_1: json['url_1'] as String? ?? '',
      url_2: json['url_2'] as String? ?? '',
      url_3: json['url_3'] as String? ?? '',
    );

Map<String, dynamic> _$Tcoupon1ToJson(_Tcoupon1 instance) => <String, dynamic>{
      'no': instance.no,
      'prom': instance.prom,
      'jan': instance.jan,
      'kanri': instance.kanri,
      'keihyo': instance.keihyo,
      'mbr': instance.mbr,
      'shop': instance.shop,
      'txt1': instance.txt1,
      'txt2': instance.txt2,
      'txt3': instance.txt3,
      'txt4': instance.txt4,
      'kenmen': instance.kenmen,
      'kikaku': instance.kikaku,
      'limit': instance.limit,
      'title': instance.title,
      'subt': instance.subt,
      'note1': instance.note1,
      'note2': instance.note2,
      'info1': instance.info1,
      'info2': instance.info2,
      'info3': instance.info3,
      'info4': instance.info4,
      'urltxt': instance.urltxt,
      'url_1': instance.url_1,
      'url_2': instance.url_2,
      'url_3': instance.url_3,
    };

_Tcoupon2 _$Tcoupon2FromJson(Map<String, dynamic> json) => _Tcoupon2(
      no: json['no'] as String? ?? '',
      prom: json['prom'] as String? ?? '',
      jan: json['jan'] as String? ?? '',
      kanri: json['kanri'] as String? ?? '',
      keihyo: json['keihyo'] as String? ?? '',
      mbr: json['mbr'] as String? ?? '',
      shop: json['shop'] as String? ?? '',
      txt1: json['txt1'] as String? ?? '',
      txt2: json['txt2'] as String? ?? '',
      txt3: json['txt3'] as String? ?? '',
      txt4: json['txt4'] as String? ?? '',
      kenmen: json['kenmen'] as String? ?? '',
      kikaku: json['kikaku'] as String? ?? '',
      limit: json['limit'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subt: json['subt'] as String? ?? '',
      note1: json['note1'] as String? ?? '',
      note2: json['note2'] as String? ?? '',
      info1: json['info1'] as String? ?? '',
      info2: json['info2'] as String? ?? '',
      info3: json['info3'] as String? ?? '',
      info4: json['info4'] as String? ?? '',
      urltxt: json['urltxt'] as String? ?? '',
      url_1: json['url_1'] as String? ?? '',
      url_2: json['url_2'] as String? ?? '',
      url_3: json['url_3'] as String? ?? '',
    );

Map<String, dynamic> _$Tcoupon2ToJson(_Tcoupon2 instance) => <String, dynamic>{
      'no': instance.no,
      'prom': instance.prom,
      'jan': instance.jan,
      'kanri': instance.kanri,
      'keihyo': instance.keihyo,
      'mbr': instance.mbr,
      'shop': instance.shop,
      'txt1': instance.txt1,
      'txt2': instance.txt2,
      'txt3': instance.txt3,
      'txt4': instance.txt4,
      'kenmen': instance.kenmen,
      'kikaku': instance.kikaku,
      'limit': instance.limit,
      'title': instance.title,
      'subt': instance.subt,
      'note1': instance.note1,
      'note2': instance.note2,
      'info1': instance.info1,
      'info2': instance.info2,
      'info3': instance.info3,
      'info4': instance.info4,
      'urltxt': instance.urltxt,
      'url_1': instance.url_1,
      'url_2': instance.url_2,
      'url_3': instance.url_3,
    };

_Tcoupon3 _$Tcoupon3FromJson(Map<String, dynamic> json) => _Tcoupon3(
      no: json['no'] as String? ?? '',
      prom: json['prom'] as String? ?? '',
      jan: json['jan'] as String? ?? '',
      kanri: json['kanri'] as String? ?? '',
      keihyo: json['keihyo'] as String? ?? '',
      mbr: json['mbr'] as String? ?? '',
      shop: json['shop'] as String? ?? '',
      txt1: json['txt1'] as String? ?? '',
      txt2: json['txt2'] as String? ?? '',
      txt3: json['txt3'] as String? ?? '',
      txt4: json['txt4'] as String? ?? '',
      kenmen: json['kenmen'] as String? ?? '',
      kikaku: json['kikaku'] as String? ?? '',
      limit: json['limit'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subt: json['subt'] as String? ?? '',
      note1: json['note1'] as String? ?? '',
      note2: json['note2'] as String? ?? '',
      info1: json['info1'] as String? ?? '',
      info2: json['info2'] as String? ?? '',
      info3: json['info3'] as String? ?? '',
      info4: json['info4'] as String? ?? '',
      urltxt: json['urltxt'] as String? ?? '',
      url_1: json['url_1'] as String? ?? '',
      url_2: json['url_2'] as String? ?? '',
      url_3: json['url_3'] as String? ?? '',
    );

Map<String, dynamic> _$Tcoupon3ToJson(_Tcoupon3 instance) => <String, dynamic>{
      'no': instance.no,
      'prom': instance.prom,
      'jan': instance.jan,
      'kanri': instance.kanri,
      'keihyo': instance.keihyo,
      'mbr': instance.mbr,
      'shop': instance.shop,
      'txt1': instance.txt1,
      'txt2': instance.txt2,
      'txt3': instance.txt3,
      'txt4': instance.txt4,
      'kenmen': instance.kenmen,
      'kikaku': instance.kikaku,
      'limit': instance.limit,
      'title': instance.title,
      'subt': instance.subt,
      'note1': instance.note1,
      'note2': instance.note2,
      'info1': instance.info1,
      'info2': instance.info2,
      'info3': instance.info3,
      'info4': instance.info4,
      'urltxt': instance.urltxt,
      'url_1': instance.url_1,
      'url_2': instance.url_2,
      'url_3': instance.url_3,
    };
