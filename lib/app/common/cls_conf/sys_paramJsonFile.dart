/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'sys_paramJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Sys_paramJsonFile extends ConfigJsonFile {
  static final Sys_paramJsonFile _instance = Sys_paramJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "sys_param.json";

  Sys_paramJsonFile(){
    setPath(_confPath, _fileName);
  }
  Sys_paramJsonFile._internal();

  factory Sys_paramJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Sys_paramJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Sys_paramJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Sys_paramJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        db = _$DbFromJson(jsonD['db']);
      } catch(e) {
        db = _$DbFromJson({});
        ret = false;
      }
      try {
        server = _$ServerFromJson(jsonD['server']);
      } catch(e) {
        server = _$ServerFromJson({});
        ret = false;
      }
      try {
        master = _$MasterFromJson(jsonD['master']);
      } catch(e) {
        master = _$MasterFromJson({});
        ret = false;
      }
      try {
        subserver = _$SubserverFromJson(jsonD['subserver']);
      } catch(e) {
        subserver = _$SubserverFromJson({});
        ret = false;
      }
      try {
        mm_system = _$Mm_systemFromJson(jsonD['mm_system']);
      } catch(e) {
        mm_system = _$Mm_systemFromJson({});
        ret = false;
      }
      try {
        hq = _$HqFromJson(jsonD['hq']);
      } catch(e) {
        hq = _$HqFromJson({});
        ret = false;
      }
      try {
        netDoA = _$NetDoAFromJson(jsonD['netDoA']);
      } catch(e) {
        netDoA = _$NetDoAFromJson({});
        ret = false;
      }
      try {
        ht_server = _$Ht_serverFromJson(jsonD['ht_server']);
      } catch(e) {
        ht_server = _$Ht_serverFromJson({});
        ret = false;
      }
      try {
        ht_master = _$Ht_masterFromJson(jsonD['ht_master']);
      } catch(e) {
        ht_master = _$Ht_masterFromJson({});
        ret = false;
      }
      try {
        ip_addr = _$Ip_addrFromJson(jsonD['ip_addr']);
      } catch(e) {
        ip_addr = _$Ip_addrFromJson({});
        ret = false;
      }
      try {
        mobile = _$MobileFromJson(jsonD['mobile']);
      } catch(e) {
        mobile = _$MobileFromJson({});
        ret = false;
      }
      try {
        poppy = _$PoppyFromJson(jsonD['poppy']);
      } catch(e) {
        poppy = _$PoppyFromJson({});
        ret = false;
      }
      try {
        mclog = _$MclogFromJson(jsonD['mclog']);
      } catch(e) {
        mclog = _$MclogFromJson({});
        ret = false;
      }
      try {
        catalina = _$CatalinaFromJson(jsonD['catalina']);
      } catch(e) {
        catalina = _$CatalinaFromJson({});
        ret = false;
      }
      try {
        custrealsvr = _$CustrealsvrFromJson(jsonD['custrealsvr']);
      } catch(e) {
        custrealsvr = _$CustrealsvrFromJson({});
        ret = false;
      }
      try {
        testmode = _$TestmodeFromJson(jsonD['testmode']);
      } catch(e) {
        testmode = _$TestmodeFromJson({});
        ret = false;
      }
      try {
        landisk = _$LandiskFromJson(jsonD['landisk']);
      } catch(e) {
        landisk = _$LandiskFromJson({});
        ret = false;
      }
      try {
        hq2 = _$Hq2FromJson(jsonD['hq2']);
      } catch(e) {
        hq2 = _$Hq2FromJson({});
        ret = false;
      }
      try {
        hqimg = _$HqimgFromJson(jsonD['hqimg']);
      } catch(e) {
        hqimg = _$HqimgFromJson({});
        ret = false;
      }
      try {
        sims2100 = _$Sims2100FromJson(jsonD['sims2100']);
      } catch(e) {
        sims2100 = _$Sims2100FromJson({});
        ret = false;
      }
      try {
        https_host = _$Https_hostFromJson(jsonD['https_host']);
      } catch(e) {
        https_host = _$Https_hostFromJson({});
        ret = false;
      }
      try {
        nttb_host = _$Nttb_hostFromJson(jsonD['nttb_host']);
      } catch(e) {
        nttb_host = _$Nttb_hostFromJson({});
        ret = false;
      }
      try {
        custsvr2 = _$Custsvr2FromJson(jsonD['custsvr2']);
      } catch(e) {
        custsvr2 = _$Custsvr2FromJson({});
        ret = false;
      }
      try {
        proxy = _$ProxyFromJson(jsonD['proxy']);
      } catch(e) {
        proxy = _$ProxyFromJson({});
        ret = false;
      }
      try {
        hist_ftp = _$Hist_ftpFromJson(jsonD['hist_ftp']);
      } catch(e) {
        hist_ftp = _$Hist_ftpFromJson({});
        ret = false;
      }
      try {
        ftp_time = _$Ftp_timeFromJson(jsonD['ftp_time']);
      } catch(e) {
        ftp_time = _$Ftp_timeFromJson({});
        ret = false;
      }
      try {
        movie_server = _$Movie_serverFromJson(jsonD['movie_server']);
      } catch(e) {
        movie_server = _$Movie_serverFromJson({});
        ret = false;
      }
      try {
        hq_2nd = _$Hq_2ndFromJson(jsonD['hq_2nd']);
      } catch(e) {
        hq_2nd = _$Hq_2ndFromJson({});
        ret = false;
      }
      try {
        verup_cnct = _$Verup_cnctFromJson(jsonD['verup_cnct']);
      } catch(e) {
        verup_cnct = _$Verup_cnctFromJson({});
        ret = false;
      }
      try {
        caps_cardnet_store = _$Caps_cardnet_storeFromJson(jsonD['caps_cardnet_store']);
      } catch(e) {
        caps_cardnet_store = _$Caps_cardnet_storeFromJson({});
        ret = false;
      }
      try {
        custreal2_pa = _$Custreal2_paFromJson(jsonD['custreal2_pa']);
      } catch(e) {
        custreal2_pa = _$Custreal2_paFromJson({});
        ret = false;
      }
      try {
        tsweb_sh = _$Tsweb_shFromJson(jsonD['tsweb_sh']);
      } catch(e) {
        tsweb_sh = _$Tsweb_shFromJson({});
        ret = false;
      }
      try {
        bkup_save = _$Bkup_saveFromJson(jsonD['bkup_save']);
      } catch(e) {
        bkup_save = _$Bkup_saveFromJson({});
        ret = false;
      }
      try {
        histlog_server = _$Histlog_serverFromJson(jsonD['histlog_server']);
      } catch(e) {
        histlog_server = _$Histlog_serverFromJson({});
        ret = false;
      }
      try {
        cashrecycle = _$CashrecycleFromJson(jsonD['cashrecycle']);
      } catch(e) {
        cashrecycle = _$CashrecycleFromJson({});
        ret = false;
      }
      try {
        pack_on_time = _$Pack_on_timeFromJson(jsonD['pack_on_time']);
      } catch(e) {
        pack_on_time = _$Pack_on_timeFromJson({});
        ret = false;
      }
      try {
        ts_gyoumu = _$Ts_gyoumuFromJson(jsonD['ts_gyoumu']);
      } catch(e) {
        ts_gyoumu = _$Ts_gyoumuFromJson({});
        ret = false;
      }
      try {
        apl_curl_post_opt = _$Apl_curl_post_optFromJson(jsonD['apl_curl_post_opt']);
      } catch(e) {
        apl_curl_post_opt = _$Apl_curl_post_optFromJson({});
        ret = false;
      }
      try {
        apl_curl_ftp_opt = _$Apl_curl_ftp_optFromJson(jsonD['apl_curl_ftp_opt']);
      } catch(e) {
        apl_curl_ftp_opt = _$Apl_curl_ftp_optFromJson({});
        ret = false;
      }
      try {
        cust_reserve_db = _$Cust_reserve_dbFromJson(jsonD['cust_reserve_db']);
      } catch(e) {
        cust_reserve_db = _$Cust_reserve_dbFromJson({});
        ret = false;
      }
      try {
        dpoint = _$DpointFromJson(jsonD['dpoint']);
      } catch(e) {
        dpoint = _$DpointFromJson({});
        ret = false;
      }
      try {
        spec_bkup = _$Spec_bkupFromJson(jsonD['spec_bkup']);
      } catch(e) {
        spec_bkup = _$Spec_bkupFromJson({});
        ret = false;
      }
      try {
        custreal_hps = _$Custreal_hpsFromJson(jsonD['custreal_hps']);
      } catch(e) {
        custreal_hps = _$Custreal_hpsFromJson({});
        ret = false;
      }
      try {
        ws_hq = _$Ws_hqFromJson(jsonD['ws_hq']);
      } catch(e) {
        ws_hq = _$Ws_hqFromJson({});
        ret = false;
      }
      try {
        recovery_file = _$Recovery_fileFromJson(jsonD['recovery_file']);
      } catch(e) {
        recovery_file = _$Recovery_fileFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Db db = _Db(
    name                               : "",
    localdbname                        : "",
    localdbuser                        : "",
    localdbpass                        : "",
    hostdbname                         : "",
    hostdbuser                         : "",
    hostdbpass                         : "",
    masterdbname                       : "",
    masterdbuser                       : "",
    masterdbpass                       : "",
    db_connect_timeout                 : 0,
    tswebsvrname                       : "",
  );

  _Server server = _Server(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
    remoteverpath                      : "",
    remotebmppath                      : "",
    prggetpath                         : "",
    verupstsputpath                    : "",
    remotetranpath                     : "",
    remotepath_webapi                  : "",
    url                                : "",
  );

  _Master master = _Master(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
    remoteverpath                      : "",
    remotebmppath                      : "",
    prggetpath                         : "",
    verupstsputpath                    : "",
    remotetranpath                     : "",
  );

  _Subserver subserver = _Subserver(
    name                               : "",
  );

  _Mm_system mm_system = _Mm_system(
    max_connect                        : 0,
    maxBackends                        : 0,
    nBuffers                           : 0,
  );

  _Hq hq = _Hq(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
    remotepath_rcv                     : "",
    hostname                           : "",
    userid                             : "",
    userpass                           : "",
    compcd                             : 0,
    url                                : "",
    inq_retry_cnt                      : 0,
    inq_retry_time                     : 0,
    offsend_time                       : 0,
    offlimit_cnt                       : 0,
    ftp_port                           : 0,
    ftp_protocol                       : 0,
    ftp_pasv                           : 0,
    ftp_retrycnt                       : 0,
    daycls_time                        : 0,
  );

  _NetDoA netDoA = _NetDoA(
    histup_url                         : "",
    histdown_url                       : "",
    fileup_url                         : "",
    filedown_url                       : "",
    auth_user                          : "",
    auth_pass                          : "",
    fileup_retry_cnt                   : 0,
    filedown_retry_cnt                 : 0,
    verify_check                       : 0,
  );

  _Ht_server ht_server = _Ht_server(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Ht_master ht_master = _Ht_master(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Ip_addr ip_addr = _Ip_addr(
    manage_pc                          : "",
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
    remotebmppath                      : "",
  );

  _Mobile mobile = _Mobile(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Poppy poppy = _Poppy(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Mclog mclog = _Mclog(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Catalina catalina = _Catalina(
    ca_ipaddr                          : "",
    ca_port                            : "",
  );

  _Custrealsvr custrealsvr = _Custrealsvr(
    timeout                            : 0,
    retrywaittime                      : 0,
    retrycnt                           : 0,
    url                                : "",
  );

  _Testmode testmode = _Testmode(
    cnt_max                            : 0,
  );

  _Landisk landisk = _Landisk(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Hq2 hq2 = _Hq2(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
    remotepath_rcv                     : "",
    hostname                           : "",
  );

  _Hqimg hqimg = _Hqimg(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Sims2100 sims2100 = _Sims2100(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath_xpm                     : "",
    remotepath_ssps                    : "",
    remotepath_acx                     : "",
    remotepath_bmp                     : "",
    remotepath_cpy                     : "",
    remotepath_tmp                     : "",
    remotepath_webapi                  : "",
    res_cycle                          : 0,
    ftp_retry_cnt                      : 0,
    ftp_retry_time                     : 0,
  );

  _Https_host https_host = _Https_host(
    https                              : "",
    http                               : "",
    proxy                              : "",
    port                               : 0,
    timeout                            : 0,
  );

  _Nttb_host nttb_host = _Nttb_host(
    https                              : "",
    http                               : "",
  );

  _Custsvr2 custsvr2 = _Custsvr2(
    hbtime                             : 0,
    offlinetime                        : 0,
  );

  _Proxy proxy = _Proxy(
    address                            : "",
    port                               : "",
  );

  _Hist_ftp hist_ftp = _Hist_ftp(
    timeout                            : 0,
    retrycnt                           : 0,
  );

  _Ftp_time ftp_time = _Ftp_time(
    freq_timeout                       : 0,
    freq_retrycnt                      : 0,
  );

  _Movie_server movie_server = _Movie_server(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Hq_2nd hq_2nd = _Hq_2nd(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
    remotepath_rcv                     : "",
    ftp_port                           : 0,
    ftp_protocol                       : 0,
    ftp_pasv                           : 0,
    ftp_timeout                        : 0,
    ftp_retrycnt                       : 0,
    ftp_retrywait                      : 0,
  );

  _Verup_cnct verup_cnct = _Verup_cnct(
    name                               : "",
    loginname                          : "",
    password                           : "",
    prggetpath                         : "",
    remotepath                         : "",
    remoteverpath                      : "",
    verupstsputpath                    : "",
    imagepath                          : "",
  );

  _Caps_cardnet_store caps_cardnet_store = _Caps_cardnet_store(
    store_code                         : "",
    store_name                         : "",
    place                              : "",
  );

  _Custreal2_pa custreal2_pa = _Custreal2_pa(
    timeout                            : 0,
    retrywaittime                      : 0,
    retrycnt                           : 0,
    conect_typ                         : 0,
  );

  _Tsweb_sh tsweb_sh = _Tsweb_sh(
    wait_time                          : 0,
    retry_count                        : 0,
    wait_ftp_beforetime                : 0,
  );

  _Bkup_save bkup_save = _Bkup_save(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );

  _Histlog_server histlog_server = _Histlog_server(
    name                               : "",
  );

  _Cashrecycle cashrecycle = _Cashrecycle(
    soc_timeout                        : 0,
  );

  _Pack_on_time pack_on_time = _Pack_on_time(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
    remotepath_rcv                     : "",
    interval                           : 0,
  );

  _Ts_gyoumu ts_gyoumu = _Ts_gyoumu(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
    remotepath_rcv                     : "",
    ftp_port                           : 0,
    ftp_protocol                       : 0,
    ftp_pasv                           : 0,
    ftp_retrycnt                       : 0,
  );

  _Apl_curl_post_opt apl_curl_post_opt = _Apl_curl_post_opt(
    connect_timeout                    : 0,
    low_speed_time                     : 0,
    low_speed_limit                    : 0,
    retry_wait                         : 0,
  );

  _Apl_curl_ftp_opt apl_curl_ftp_opt = _Apl_curl_ftp_opt(
    connect_timeout                    : 0,
    low_speed_time                     : 0,
    low_speed_limit                    : 0,
    retry_wait                         : 0,
  );

  _Cust_reserve_db cust_reserve_db = _Cust_reserve_db(
    hostdbname                         : "",
    hostdbuser                         : "",
    hostdbpass                         : "",
  );

  _Dpoint dpoint = _Dpoint(
    name                               : "",
    timeout                            : 0,
    sub_name                           : "",
    username                           : "",
    password                           : "",
  );

  _Spec_bkup spec_bkup = _Spec_bkup(
    timeout2                           : 0,
    retrycnt                           : 0,
    sleep_time2                        : 0,
    sleep_cnt                          : 0,
    path                               : "",
    generation2                        : 0,
  );

  _Custreal_hps custreal_hps = _Custreal_hps(
    Username                           : "",
    Password                           : "",
    rtl_id                             : 0,
    version                            : 0,
    device_div                         : 0,
  );

  _Ws_hq ws_hq = _Ws_hq(
    hostdbname                         : "",
    hostdbuser                         : "",
    hostdbpass                         : "",
  );

  _Recovery_file recovery_file = _Recovery_file(
    name                               : "",
    loginname                          : "",
    password                           : "",
    remotepath                         : "",
  );
}

@JsonSerializable()
class _Db {
  factory _Db.fromJson(Map<String, dynamic> json) => _$DbFromJson(json);
  Map<String, dynamic> toJson() => _$DbToJson(this);

  _Db({
    required this.name,
    required this.localdbname,
    required this.localdbuser,
    required this.localdbpass,
    required this.hostdbname,
    required this.hostdbuser,
    required this.hostdbpass,
    required this.masterdbname,
    required this.masterdbuser,
    required this.masterdbpass,
    required this.db_connect_timeout,
    required this.tswebsvrname,
  });

  @JsonKey(defaultValue: "ts21db")
  String name;
  @JsonKey(defaultValue: "tpr_db")
  String localdbname;
  @JsonKey(defaultValue: "postgres")
  String localdbuser;
  @JsonKey(defaultValue: "postgres")
  String localdbpass;
  @JsonKey(defaultValue: "tsdb")
  String hostdbname;
  @JsonKey(defaultValue: "ts21ecr")
  String hostdbuser;
  @JsonKey(defaultValue: "0012st")
  String hostdbpass;
  @JsonKey(defaultValue: "tpr_db")
  String masterdbname;
  @JsonKey(defaultValue: "postgres")
  String masterdbuser;
  @JsonKey(defaultValue: "postgres")
  String masterdbpass;
  @JsonKey(defaultValue: 28)
  int    db_connect_timeout;
  @JsonKey(defaultValue: "tswebsvr")
  String tswebsvrname;
}

@JsonSerializable()
class _Server {
  factory _Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);
  Map<String, dynamic> toJson() => _$ServerToJson(this);

  _Server({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
    required this.remoteverpath,
    required this.remotebmppath,
    required this.prggetpath,
    required this.verupstsputpath,
    required this.remotetranpath,
    required this.remotepath_webapi,
    required this.url,
  });

  @JsonKey(defaultValue: "ts2100")
  String name;
  @JsonKey(defaultValue: "ts21ecr")
  String loginname;
  @JsonKey(defaultValue: "0012st")
  String password;
  @JsonKey(defaultValue: "~/tmp/")
  String remotepath;
  @JsonKey(defaultValue: "~/tmp/")
  String remoteverpath;
  @JsonKey(defaultValue: "~/bmp/")
  String remotebmppath;
  @JsonKey(defaultValue: "~/ftp/")
  String prggetpath;
  @JsonKey(defaultValue: "~/ftp/")
  String verupstsputpath;
  @JsonKey(defaultValue: "~/rcv/")
  String remotetranpath;
  @JsonKey(defaultValue: "~/sng/")
  String remotepath_webapi;
  @JsonKey(defaultValue: "https://ar.digi-tip-stg.com")
  String url;
}

@JsonSerializable()
class _Master {
  factory _Master.fromJson(Map<String, dynamic> json) => _$MasterFromJson(json);
  Map<String, dynamic> toJson() => _$MasterToJson(this);

  _Master({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
    required this.remoteverpath,
    required this.remotebmppath,
    required this.prggetpath,
    required this.verupstsputpath,
    required this.remotetranpath,
  });

  @JsonKey(defaultValue: "ts2100")
  String name;
  @JsonKey(defaultValue: "web2100")
  String loginname;
  @JsonKey(defaultValue: "web2100")
  String password;
  @JsonKey(defaultValue: "/web21ftp/tmp/")
  String remotepath;
  @JsonKey(defaultValue: "/web21ftp/tmp/")
  String remoteverpath;
  @JsonKey(defaultValue: "/web21ftp/bmp/")
  String remotebmppath;
  @JsonKey(defaultValue: "/web21ftp/vup/")
  String prggetpath;
  @JsonKey(defaultValue: "/web21ftp/vup/")
  String verupstsputpath;
  @JsonKey(defaultValue: "/web21ftp/tmp/")
  String remotetranpath;
}

@JsonSerializable()
class _Subserver {
  factory _Subserver.fromJson(Map<String, dynamic> json) => _$SubserverFromJson(json);
  Map<String, dynamic> toJson() => _$SubserverToJson(this);

  _Subserver({
    required this.name,
  });

  @JsonKey(defaultValue: "subsrx")
  String name;
}

@JsonSerializable()
class _Mm_system {
  factory _Mm_system.fromJson(Map<String, dynamic> json) => _$Mm_systemFromJson(json);
  Map<String, dynamic> toJson() => _$Mm_systemToJson(this);

  _Mm_system({
    required this.max_connect,
    required this.maxBackends,
    required this.nBuffers,
  });

  @JsonKey(defaultValue: 5)
  int    max_connect;
  @JsonKey(defaultValue: 64)
  int    maxBackends;
  @JsonKey(defaultValue: 1024)
  int    nBuffers;
}

@JsonSerializable()
class _Hq {
  factory _Hq.fromJson(Map<String, dynamic> json) => _$HqFromJson(json);
  Map<String, dynamic> toJson() => _$HqToJson(this);

  _Hq({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
    required this.remotepath_rcv,
    required this.hostname,
    required this.userid,
    required this.userpass,
    required this.compcd,
    required this.url,
    required this.inq_retry_cnt,
    required this.inq_retry_time,
    required this.offsend_time,
    required this.offlimit_cnt,
    required this.ftp_port,
    required this.ftp_protocol,
    required this.ftp_pasv,
    required this.ftp_retrycnt,
    required this.daycls_time,
  });

  @JsonKey(defaultValue: "hqserver")
  String name;
  @JsonKey(defaultValue: "anonymous")
  String loginname;
  @JsonKey(defaultValue: "anonymous")
  String password;
  @JsonKey(defaultValue: "./")
  String remotepath;
  @JsonKey(defaultValue: "./")
  String remotepath_rcv;
  @JsonKey(defaultValue: "hostname")
  String hostname;
  @JsonKey(defaultValue: "anonymous")
  String userid;
  @JsonKey(defaultValue: "anonymous")
  String userpass;
  @JsonKey(defaultValue: 0)
  int    compcd;
  @JsonKey(defaultValue: "https://www.netdoa-nx.jp:7070/DT/CUST/DTRC0010010.php")
  String url;
  @JsonKey(defaultValue: 2)
  int    inq_retry_cnt;
  @JsonKey(defaultValue: 1)
  int    inq_retry_time;
  @JsonKey(defaultValue: 60)
  int    offsend_time;
  @JsonKey(defaultValue: 100)
  int    offlimit_cnt;
  @JsonKey(defaultValue: 0)
  int    ftp_port;
  @JsonKey(defaultValue: 0)
  int    ftp_protocol;
  @JsonKey(defaultValue: 0)
  int    ftp_pasv;
  @JsonKey(defaultValue: 0)
  int    ftp_retrycnt;
  @JsonKey(defaultValue: 10)
  int    daycls_time;
}

@JsonSerializable()
class _NetDoA {
  factory _NetDoA.fromJson(Map<String, dynamic> json) => _$NetDoAFromJson(json);
  Map<String, dynamic> toJson() => _$NetDoAToJson(this);

  _NetDoA({
    required this.histup_url,
    required this.histdown_url,
    required this.fileup_url,
    required this.filedown_url,
    required this.auth_user,
    required this.auth_pass,
    required this.fileup_retry_cnt,
    required this.filedown_retry_cnt,
    required this.verify_check,
  });

  @JsonKey(defaultValue: "https://www.netdoa-nx.jp/api/histlog_up.php")
  String histup_url;
  @JsonKey(defaultValue: "https://www.netdoa-nx.jp/api/histlog_down.php")
  String histdown_url;
  @JsonKey(defaultValue: "https://www.netdoa-nx.jp/api/file_upload.php")
  String fileup_url;
  @JsonKey(defaultValue: "https://www.netdoa-nx.jp/api/file_download.php")
  String filedown_url;
  @JsonKey(defaultValue: "medi")
  String auth_user;
  @JsonKey(defaultValue: "teraoka")
  String auth_pass;
  @JsonKey(defaultValue: 1)
  int    fileup_retry_cnt;
  @JsonKey(defaultValue: 1)
  int    filedown_retry_cnt;
  @JsonKey(defaultValue: 1)
  int    verify_check;
}

@JsonSerializable()
class _Ht_server {
  factory _Ht_server.fromJson(Map<String, dynamic> json) => _$Ht_serverFromJson(json);
  Map<String, dynamic> toJson() => _$Ht_serverToJson(this);

  _Ht_server({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "ts2100")
  String name;
  @JsonKey(defaultValue: "ts21ecr")
  String loginname;
  @JsonKey(defaultValue: "0012st")
  String password;
  @JsonKey(defaultValue: "~/tmp/")
  String remotepath;
}

@JsonSerializable()
class _Ht_master {
  factory _Ht_master.fromJson(Map<String, dynamic> json) => _$Ht_masterFromJson(json);
  Map<String, dynamic> toJson() => _$Ht_masterToJson(this);

  _Ht_master({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "ts2100")
  String name;
  @JsonKey(defaultValue: "web2100")
  String loginname;
  @JsonKey(defaultValue: "web2100")
  String password;
  @JsonKey(defaultValue: "/web21ftp/mobile")
  String remotepath;
}

@JsonSerializable()
class _Ip_addr {
  factory _Ip_addr.fromJson(Map<String, dynamic> json) => _$Ip_addrFromJson(json);
  Map<String, dynamic> toJson() => _$Ip_addrToJson(this);

  _Ip_addr({
    required this.manage_pc,
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
    required this.remotebmppath,
  });

  @JsonKey(defaultValue: "0.0.0.0")
  String manage_pc;
  @JsonKey(defaultValue: "manage")
  String name;
  @JsonKey(defaultValue: "DIGI")
  String loginname;
  @JsonKey(defaultValue: "DIGI")
  String password;
  @JsonKey(defaultValue: "./tmp/QRSrv/Tran")
  String remotepath;
  @JsonKey(defaultValue: "./tmp/QRSrv/bmp")
  String remotebmppath;
}

@JsonSerializable()
class _Mobile {
  factory _Mobile.fromJson(Map<String, dynamic> json) => _$MobileFromJson(json);
  Map<String, dynamic> toJson() => _$MobileToJson(this);

  _Mobile({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "mblsvr")
  String name;
  @JsonKey(defaultValue: "web2100")
  String loginname;
  @JsonKey(defaultValue: "web2100")
  String password;
  @JsonKey(defaultValue: "/web21ftp/mobile")
  String remotepath;
}

@JsonSerializable()
class _Poppy {
  factory _Poppy.fromJson(Map<String, dynamic> json) => _$PoppyFromJson(json);
  Map<String, dynamic> toJson() => _$PoppyToJson(this);

  _Poppy({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "poppy")
  String name;
  @JsonKey(defaultValue: "web2100poppy")
  String loginname;
  @JsonKey(defaultValue: "web2100poppy")
  String password;
  @JsonKey(defaultValue: "./")
  String remotepath;
}

@JsonSerializable()
class _Mclog {
  factory _Mclog.fromJson(Map<String, dynamic> json) => _$MclogFromJson(json);
  Map<String, dynamic> toJson() => _$MclogToJson(this);

  _Mclog({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "compc")
  String name;
  @JsonKey(defaultValue: "ts21adm")
  String loginname;
  @JsonKey(defaultValue: "teraoka")
  String password;
  @JsonKey(defaultValue: "/ts2100/home/port/imp")
  String remotepath;
}

@JsonSerializable()
class _Catalina {
  factory _Catalina.fromJson(Map<String, dynamic> json) => _$CatalinaFromJson(json);
  Map<String, dynamic> toJson() => _$CatalinaToJson(this);

  _Catalina({
    required this.ca_ipaddr,
    required this.ca_port,
  });

  @JsonKey(defaultValue: "0.0.0.0")
  String ca_ipaddr;
  @JsonKey(defaultValue: "0000")
  String ca_port;
}

@JsonSerializable()
class _Custrealsvr {
  factory _Custrealsvr.fromJson(Map<String, dynamic> json) => _$CustrealsvrFromJson(json);
  Map<String, dynamic> toJson() => _$CustrealsvrToJson(this);

  _Custrealsvr({
    required this.timeout,
    required this.retrywaittime,
    required this.retrycnt,
    required this.url,
  });

  @JsonKey(defaultValue: 3)
  int    timeout;
  @JsonKey(defaultValue: 1)
  int    retrywaittime;
  @JsonKey(defaultValue: 1)
  int    retrycnt;
  @JsonKey(defaultValue: "anonymous")
  String url;
}

@JsonSerializable()
class _Testmode {
  factory _Testmode.fromJson(Map<String, dynamic> json) => _$TestmodeFromJson(json);
  Map<String, dynamic> toJson() => _$TestmodeToJson(this);

  _Testmode({
    required this.cnt_max,
  });

  @JsonKey(defaultValue: 100)
  int    cnt_max;
}

@JsonSerializable()
class _Landisk {
  factory _Landisk.fromJson(Map<String, dynamic> json) => _$LandiskFromJson(json);
  Map<String, dynamic> toJson() => _$LandiskToJson(this);

  _Landisk({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "landisk")
  String name;
  @JsonKey(defaultValue: "web2100")
  String loginname;
  @JsonKey(defaultValue: "web2100")
  String password;
  @JsonKey(defaultValue: "./")
  String remotepath;
}

@JsonSerializable()
class _Hq2 {
  factory _Hq2.fromJson(Map<String, dynamic> json) => _$Hq2FromJson(json);
  Map<String, dynamic> toJson() => _$Hq2ToJson(this);

  _Hq2({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
    required this.remotepath_rcv,
    required this.hostname,
  });

  @JsonKey(defaultValue: "hq2server")
  String name;
  @JsonKey(defaultValue: "anonymous")
  String loginname;
  @JsonKey(defaultValue: "anonymous")
  String password;
  @JsonKey(defaultValue: "./")
  String remotepath;
  @JsonKey(defaultValue: "./")
  String remotepath_rcv;
  @JsonKey(defaultValue: "hostname")
  String hostname;
}

@JsonSerializable()
class _Hqimg {
  factory _Hqimg.fromJson(Map<String, dynamic> json) => _$HqimgFromJson(json);
  Map<String, dynamic> toJson() => _$HqimgToJson(this);

  _Hqimg({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "hqimg_server")
  String name;
  @JsonKey(defaultValue: "anonymous")
  String loginname;
  @JsonKey(defaultValue: "anonymous")
  String password;
  @JsonKey(defaultValue: "./webimgrcv/")
  String remotepath;
}

@JsonSerializable()
class _Sims2100 {
  factory _Sims2100.fromJson(Map<String, dynamic> json) => _$Sims2100FromJson(json);
  Map<String, dynamic> toJson() => _$Sims2100ToJson(this);

  _Sims2100({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath_xpm,
    required this.remotepath_ssps,
    required this.remotepath_acx,
    required this.remotepath_bmp,
    required this.remotepath_cpy,
    required this.remotepath_tmp,
    required this.remotepath_webapi,
    required this.res_cycle,
    required this.ftp_retry_cnt,
    required this.ftp_retry_time,
  });

  @JsonKey(defaultValue: "sims2100")
  String name;
  @JsonKey(defaultValue: "web2100")
  String loginname;
  @JsonKey(defaultValue: "web2100")
  String password;
  @JsonKey(defaultValue: "/web21ftp/xpm/")
  String remotepath_xpm;
  @JsonKey(defaultValue: "/web21ftp/ssps/")
  String remotepath_ssps;
  @JsonKey(defaultValue: "/web21ftp/acx/")
  String remotepath_acx;
  @JsonKey(defaultValue: "/web21ftp/bmp/")
  String remotepath_bmp;
  @JsonKey(defaultValue: "/web21ftp/cpy/")
  String remotepath_cpy;
  @JsonKey(defaultValue: "/web21ftp/tmp/")
  String remotepath_tmp;
  @JsonKey(defaultValue: "/web21ftp/webapi/")
  String remotepath_webapi;
  @JsonKey(defaultValue: 20)
  int    res_cycle;
  @JsonKey(defaultValue: 1)
  int    ftp_retry_cnt;
  @JsonKey(defaultValue: 30)
  int    ftp_retry_time;
}

@JsonSerializable()
class _Https_host {
  factory _Https_host.fromJson(Map<String, dynamic> json) => _$Https_hostFromJson(json);
  Map<String, dynamic> toJson() => _$Https_hostToJson(this);

  _Https_host({
    required this.https,
    required this.http,
    required this.proxy,
    required this.port,
    required this.timeout,
  });

  @JsonKey(defaultValue: "sv1.tenpovisor.jp")
  String https;
  @JsonKey(defaultValue: "211.12.230.57")
  String http;
  @JsonKey(defaultValue: "default")
  String proxy;
  @JsonKey(defaultValue: 0)
  int    port;
  @JsonKey(defaultValue: 60)
  int    timeout;
}

@JsonSerializable()
class _Nttb_host {
  factory _Nttb_host.fromJson(Map<String, dynamic> json) => _$Nttb_hostFromJson(json);
  Map<String, dynamic> toJson() => _$Nttb_hostToJson(this);

  _Nttb_host({
    required this.https,
    required this.http,
  });

  @JsonKey(defaultValue: "sv1.tenpovisor.jp")
  String https;
  @JsonKey(defaultValue: "211.12.230.57")
  String http;
}

@JsonSerializable()
class _Custsvr2 {
  factory _Custsvr2.fromJson(Map<String, dynamic> json) => _$Custsvr2FromJson(json);
  Map<String, dynamic> toJson() => _$Custsvr2ToJson(this);

  _Custsvr2({
    required this.hbtime,
    required this.offlinetime,
  });

  @JsonKey(defaultValue: 5)
  int    hbtime;
  @JsonKey(defaultValue: 6)
  int    offlinetime;
}

@JsonSerializable()
class _Proxy {
  factory _Proxy.fromJson(Map<String, dynamic> json) => _$ProxyFromJson(json);
  Map<String, dynamic> toJson() => _$ProxyToJson(this);

  _Proxy({
    required this.address,
    required this.port,
  });

  @JsonKey(defaultValue: "default")
  String address;
  @JsonKey(defaultValue: "0000")
  String port;
}

@JsonSerializable()
class _Hist_ftp {
  factory _Hist_ftp.fromJson(Map<String, dynamic> json) => _$Hist_ftpFromJson(json);
  Map<String, dynamic> toJson() => _$Hist_ftpToJson(this);

  _Hist_ftp({
    required this.timeout,
    required this.retrycnt,
  });

  @JsonKey(defaultValue: 180)
  int    timeout;
  @JsonKey(defaultValue: 1)
  int    retrycnt;
}

@JsonSerializable()
class _Ftp_time {
  factory _Ftp_time.fromJson(Map<String, dynamic> json) => _$Ftp_timeFromJson(json);
  Map<String, dynamic> toJson() => _$Ftp_timeToJson(this);

  _Ftp_time({
    required this.freq_timeout,
    required this.freq_retrycnt,
  });

  @JsonKey(defaultValue: 180)
  int    freq_timeout;
  @JsonKey(defaultValue: 1)
  int    freq_retrycnt;
}

@JsonSerializable()
class _Movie_server {
  factory _Movie_server.fromJson(Map<String, dynamic> json) => _$Movie_serverFromJson(json);
  Map<String, dynamic> toJson() => _$Movie_serverToJson(this);

  _Movie_server({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "mvserver")
  String name;
  @JsonKey(defaultValue: "web2100")
  String loginname;
  @JsonKey(defaultValue: "web2100")
  String password;
  @JsonKey(defaultValue: "./Movie/")
  String remotepath;
}

@JsonSerializable()
class _Hq_2nd {
  factory _Hq_2nd.fromJson(Map<String, dynamic> json) => _$Hq_2ndFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_2ndToJson(this);

  _Hq_2nd({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
    required this.remotepath_rcv,
    required this.ftp_port,
    required this.ftp_protocol,
    required this.ftp_pasv,
    required this.ftp_timeout,
    required this.ftp_retrycnt,
    required this.ftp_retrywait,
  });

  @JsonKey(defaultValue: "hq_2nd_server")
  String name;
  @JsonKey(defaultValue: "anonymous")
  String loginname;
  @JsonKey(defaultValue: "anonymous")
  String password;
  @JsonKey(defaultValue: "./")
  String remotepath;
  @JsonKey(defaultValue: "./")
  String remotepath_rcv;
  @JsonKey(defaultValue: 0)
  int    ftp_port;
  @JsonKey(defaultValue: 0)
  int    ftp_protocol;
  @JsonKey(defaultValue: 0)
  int    ftp_pasv;
  @JsonKey(defaultValue: 30)
  int    ftp_timeout;
  @JsonKey(defaultValue: 0)
  int    ftp_retrycnt;
  @JsonKey(defaultValue: 10)
  int    ftp_retrywait;
}

@JsonSerializable()
class _Verup_cnct {
  factory _Verup_cnct.fromJson(Map<String, dynamic> json) => _$Verup_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Verup_cnctToJson(this);

  _Verup_cnct({
    required this.name,
    required this.loginname,
    required this.password,
    required this.prggetpath,
    required this.remotepath,
    required this.remoteverpath,
    required this.verupstsputpath,
    required this.imagepath,
  });

  @JsonKey(defaultValue: "verup_cnct")
  String name;
  @JsonKey(defaultValue: "web2100")
  String loginname;
  @JsonKey(defaultValue: "web2100")
  String password;
  @JsonKey(defaultValue: "/web21ftp/vup/")
  String prggetpath;
  @JsonKey(defaultValue: "/web21ftp/tmp/")
  String remotepath;
  @JsonKey(defaultValue: "/web21ftp/tmp/")
  String remoteverpath;
  @JsonKey(defaultValue: "/web21ftp/vup/")
  String verupstsputpath;
  @JsonKey(defaultValue: "/web21ftp/ssps/")
  String imagepath;
}

@JsonSerializable()
class _Caps_cardnet_store {
  factory _Caps_cardnet_store.fromJson(Map<String, dynamic> json) => _$Caps_cardnet_storeFromJson(json);
  Map<String, dynamic> toJson() => _$Caps_cardnet_storeToJson(this);

  _Caps_cardnet_store({
    required this.store_code,
    required this.store_name,
    required this.place,
  });

  @JsonKey(defaultValue: "9M999990000")
  String store_code;
  @JsonKey(defaultValue: "TERAOKA")
  String store_name;
  @JsonKey(defaultValue: "TOKYO")
  String place;
}

@JsonSerializable()
class _Custreal2_pa {
  factory _Custreal2_pa.fromJson(Map<String, dynamic> json) => _$Custreal2_paFromJson(json);
  Map<String, dynamic> toJson() => _$Custreal2_paToJson(this);

  _Custreal2_pa({
    required this.timeout,
    required this.retrywaittime,
    required this.retrycnt,
    required this.conect_typ,
  });

  @JsonKey(defaultValue: 3)
  int    timeout;
  @JsonKey(defaultValue: 1)
  int    retrywaittime;
  @JsonKey(defaultValue: 1)
  int    retrycnt;
  @JsonKey(defaultValue: 0)
  int    conect_typ;
}

@JsonSerializable()
class _Tsweb_sh {
  factory _Tsweb_sh.fromJson(Map<String, dynamic> json) => _$Tsweb_shFromJson(json);
  Map<String, dynamic> toJson() => _$Tsweb_shToJson(this);

  _Tsweb_sh({
    required this.wait_time,
    required this.retry_count,
    required this.wait_ftp_beforetime,
  });

  @JsonKey(defaultValue: 1)
  int    wait_time;
  @JsonKey(defaultValue: 50)
  int    retry_count;
  @JsonKey(defaultValue: 1)
  int    wait_ftp_beforetime;
}

@JsonSerializable()
class _Bkup_save {
  factory _Bkup_save.fromJson(Map<String, dynamic> json) => _$Bkup_saveFromJson(json);
  Map<String, dynamic> toJson() => _$Bkup_saveToJson(this);

  _Bkup_save({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "bkup_save")
  String name;
  @JsonKey(defaultValue: "web2100")
  String loginname;
  @JsonKey(defaultValue: "web2100")
  String password;
  @JsonKey(defaultValue: "/home/web2100/spec_bkup/")
  String remotepath;
}

@JsonSerializable()
class _Histlog_server {
  factory _Histlog_server.fromJson(Map<String, dynamic> json) => _$Histlog_serverFromJson(json);
  Map<String, dynamic> toJson() => _$Histlog_serverToJson(this);

  _Histlog_server({
    required this.name,
  });

  @JsonKey(defaultValue: "histlog_server")
  String name;
}

@JsonSerializable()
class _Cashrecycle {
  factory _Cashrecycle.fromJson(Map<String, dynamic> json) => _$CashrecycleFromJson(json);
  Map<String, dynamic> toJson() => _$CashrecycleToJson(this);

  _Cashrecycle({
    required this.soc_timeout,
  });

  @JsonKey(defaultValue: 5)
  int    soc_timeout;
}

@JsonSerializable()
class _Pack_on_time {
  factory _Pack_on_time.fromJson(Map<String, dynamic> json) => _$Pack_on_timeFromJson(json);
  Map<String, dynamic> toJson() => _$Pack_on_timeToJson(this);

  _Pack_on_time({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
    required this.remotepath_rcv,
    required this.interval,
  });

  @JsonKey(defaultValue: "pack_on_time_svr")
  String name;
  @JsonKey(defaultValue: "ftp")
  String loginname;
  @JsonKey(defaultValue: "ftp")
  String password;
  @JsonKey(defaultValue: "./RCV/POT/")
  String remotepath;
  @JsonKey(defaultValue: "./")
  String remotepath_rcv;
  @JsonKey(defaultValue: 5)
  int    interval;
}

@JsonSerializable()
class _Ts_gyoumu {
  factory _Ts_gyoumu.fromJson(Map<String, dynamic> json) => _$Ts_gyoumuFromJson(json);
  Map<String, dynamic> toJson() => _$Ts_gyoumuToJson(this);

  _Ts_gyoumu({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
    required this.remotepath_rcv,
    required this.ftp_port,
    required this.ftp_protocol,
    required this.ftp_pasv,
    required this.ftp_retrycnt,
  });

  @JsonKey(defaultValue: "ts2100")
  String name;
  @JsonKey(defaultValue: "ts21ecr")
  String loginname;
  @JsonKey(defaultValue: "0012st")
  String password;
  @JsonKey(defaultValue: "/ts2100/home/ts21ecr/tmp/")
  String remotepath;
  @JsonKey(defaultValue: "./")
  String remotepath_rcv;
  @JsonKey(defaultValue: 0)
  int    ftp_port;
  @JsonKey(defaultValue: 1)
  int    ftp_protocol;
  @JsonKey(defaultValue: 0)
  int    ftp_pasv;
  @JsonKey(defaultValue: 1)
  int    ftp_retrycnt;
}

@JsonSerializable()
class _Apl_curl_post_opt {
  factory _Apl_curl_post_opt.fromJson(Map<String, dynamic> json) => _$Apl_curl_post_optFromJson(json);
  Map<String, dynamic> toJson() => _$Apl_curl_post_optToJson(this);

  _Apl_curl_post_opt({
    required this.connect_timeout,
    required this.low_speed_time,
    required this.low_speed_limit,
    required this.retry_wait,
  });

  @JsonKey(defaultValue: 30)
  int    connect_timeout;
  @JsonKey(defaultValue: 10)
  int    low_speed_time;
  @JsonKey(defaultValue: 128)
  int    low_speed_limit;
  @JsonKey(defaultValue: 30)
  int    retry_wait;
}

@JsonSerializable()
class _Apl_curl_ftp_opt {
  factory _Apl_curl_ftp_opt.fromJson(Map<String, dynamic> json) => _$Apl_curl_ftp_optFromJson(json);
  Map<String, dynamic> toJson() => _$Apl_curl_ftp_optToJson(this);

  _Apl_curl_ftp_opt({
    required this.connect_timeout,
    required this.low_speed_time,
    required this.low_speed_limit,
    required this.retry_wait,
  });

  @JsonKey(defaultValue: 10)
  int    connect_timeout;
  @JsonKey(defaultValue: 10)
  int    low_speed_time;
  @JsonKey(defaultValue: 128)
  int    low_speed_limit;
  @JsonKey(defaultValue: 30)
  int    retry_wait;
}

@JsonSerializable()
class _Cust_reserve_db {
  factory _Cust_reserve_db.fromJson(Map<String, dynamic> json) => _$Cust_reserve_dbFromJson(json);
  Map<String, dynamic> toJson() => _$Cust_reserve_dbToJson(this);

  _Cust_reserve_db({
    required this.hostdbname,
    required this.hostdbuser,
    required this.hostdbpass,
  });

  @JsonKey(defaultValue: "tsdb")
  String hostdbname;
  @JsonKey(defaultValue: "ts21ecr")
  String hostdbuser;
  @JsonKey(defaultValue: "0012st")
  String hostdbpass;
}

@JsonSerializable()
class _Dpoint {
  factory _Dpoint.fromJson(Map<String, dynamic> json) => _$DpointFromJson(json);
  Map<String, dynamic> toJson() => _$DpointToJson(this);

  _Dpoint({
    required this.name,
    required this.timeout,
    required this.sub_name,
    required this.username,
    required this.password,
  });

  @JsonKey(defaultValue: "dpoint")
  String name;
  @JsonKey(defaultValue: 5)
  int    timeout;
  @JsonKey(defaultValue: "dpoint_rela_svr")
  String sub_name;
  @JsonKey(defaultValue: "anonymous")
  String username;
  @JsonKey(defaultValue: "anonymous")
  String password;
}

@JsonSerializable()
class _Spec_bkup {
  factory _Spec_bkup.fromJson(Map<String, dynamic> json) => _$Spec_bkupFromJson(json);
  Map<String, dynamic> toJson() => _$Spec_bkupToJson(this);

  _Spec_bkup({
    required this.timeout2,
    required this.retrycnt,
    required this.sleep_time2,
    required this.sleep_cnt,
    required this.path,
    required this.generation2,
  });

  @JsonKey(defaultValue: 180)
  int    timeout2;
  @JsonKey(defaultValue: 3)
  int    retrycnt;
  @JsonKey(defaultValue: 3)
  int    sleep_time2;
  @JsonKey(defaultValue: 10)
  int    sleep_cnt;
  @JsonKey(defaultValue: "/home/web2100")
  String path;
  @JsonKey(defaultValue: 3)
  int    generation2;
}

@JsonSerializable()
class _Custreal_hps {
  factory _Custreal_hps.fromJson(Map<String, dynamic> json) => _$Custreal_hpsFromJson(json);
  Map<String, dynamic> toJson() => _$Custreal_hpsToJson(this);

  _Custreal_hps({
    required this.Username,
    required this.Password,
    required this.rtl_id,
    required this.version,
    required this.device_div,
  });

  @JsonKey(defaultValue: "sa")
  String Username;
  @JsonKey(defaultValue: "hsv-pm7836")
  String Password;
  @JsonKey(defaultValue: 0)
  int    rtl_id;
  @JsonKey(defaultValue: 0)
  int    version;
  @JsonKey(defaultValue: 0)
  int    device_div;
}

@JsonSerializable()
class _Ws_hq {
  factory _Ws_hq.fromJson(Map<String, dynamic> json) => _$Ws_hqFromJson(json);
  Map<String, dynamic> toJson() => _$Ws_hqToJson(this);

  _Ws_hq({
    required this.hostdbname,
    required this.hostdbuser,
    required this.hostdbpass,
  });

  @JsonKey(defaultValue: "tsdb")
  String hostdbname;
  @JsonKey(defaultValue: "ts21ecr")
  String hostdbuser;
  @JsonKey(defaultValue: "0012st")
  String hostdbpass;
}

@JsonSerializable()
class _Recovery_file {
  factory _Recovery_file.fromJson(Map<String, dynamic> json) => _$Recovery_fileFromJson(json);
  Map<String, dynamic> toJson() => _$Recovery_fileToJson(this);

  _Recovery_file({
    required this.name,
    required this.loginname,
    required this.password,
    required this.remotepath,
  });

  @JsonKey(defaultValue: "recovery_file")
  String name;
  @JsonKey(defaultValue: "anonymous")
  String loginname;
  @JsonKey(defaultValue: "anonymous")
  String password;
  @JsonKey(defaultValue: "./")
  String remotepath;
}

