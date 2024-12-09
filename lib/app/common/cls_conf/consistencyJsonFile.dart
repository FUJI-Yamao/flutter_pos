/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'consistencyJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class ConsistencyJsonFile extends ConfigJsonFile {
  static final ConsistencyJsonFile _instance = ConsistencyJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "consistency.json";

  ConsistencyJsonFile(){
    setPath(_confPath, _fileName);
  }
  ConsistencyJsonFile._internal();

  factory ConsistencyJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$ConsistencyJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$ConsistencyJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$ConsistencyJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        version = _$VersionFromJson(jsonD['version']);
      } catch(e) {
        version = _$VersionFromJson({});
        ret = false;
      }
      try {
        macno_check = _$Macno_checkFromJson(jsonD['macno_check']);
      } catch(e) {
        macno_check = _$Macno_checkFromJson({});
        ret = false;
      }
      try {
        stre_cd = _$Stre_cdFromJson(jsonD['stre_cd']);
      } catch(e) {
        stre_cd = _$Stre_cdFromJson({});
        ret = false;
      }
      try {
        ms_onoff = _$Ms_onoffFromJson(jsonD['ms_onoff']);
      } catch(e) {
        ms_onoff = _$Ms_onoffFromJson({});
        ret = false;
      }
      try {
        mac_info_timeserver = _$Mac_info_timeserverFromJson(jsonD['mac_info_timeserver']);
      } catch(e) {
        mac_info_timeserver = _$Mac_info_timeserverFromJson({});
        ret = false;
      }
      try {
        ts_ver_mrg = _$Ts_ver_mrgFromJson(jsonD['ts_ver_mrg']);
      } catch(e) {
        ts_ver_mrg = _$Ts_ver_mrgFromJson({});
        ret = false;
      }
      try {
        psc_scn_cmd_desktop = _$Psc_scn_cmd_desktopFromJson(jsonD['psc_scn_cmd_desktop']);
      } catch(e) {
        psc_scn_cmd_desktop = _$Psc_scn_cmd_desktopFromJson({});
        ret = false;
      }
      try {
        psc_scn_cmd_tower = _$Psc_scn_cmd_towerFromJson(jsonD['psc_scn_cmd_tower']);
      } catch(e) {
        psc_scn_cmd_tower = _$Psc_scn_cmd_towerFromJson({});
        ret = false;
      }
      try {
        scan_dp_snd_desktop = _$Scan_dp_snd_desktopFromJson(jsonD['scan_dp_snd_desktop']);
      } catch(e) {
        scan_dp_snd_desktop = _$Scan_dp_snd_desktopFromJson({});
        ret = false;
      }
      try {
        scan_dp_snd_tower = _$Scan_dp_snd_towerFromJson(jsonD['scan_dp_snd_tower']);
      } catch(e) {
        scan_dp_snd_tower = _$Scan_dp_snd_towerFromJson({});
        ret = false;
      }
      try {
        eat_in_start_end_check = _$Eat_in_start_end_checkFromJson(jsonD['eat_in_start_end_check']);
      } catch(e) {
        eat_in_start_end_check = _$Eat_in_start_end_checkFromJson({});
        ret = false;
      }
      try {
        catalinapr_cnct = _$Catalinapr_cnctFromJson(jsonD['catalinapr_cnct']);
      } catch(e) {
        catalinapr_cnct = _$Catalinapr_cnctFromJson({});
        ret = false;
      }
      try {
        custrealsvr_cnct = _$Custrealsvr_cnctFromJson(jsonD['custrealsvr_cnct']);
      } catch(e) {
        custrealsvr_cnct = _$Custrealsvr_cnctFromJson({});
        ret = false;
      }
      try {
        netmask = _$NetmaskFromJson(jsonD['netmask']);
      } catch(e) {
        netmask = _$NetmaskFromJson({});
        ret = false;
      }
      try {
        gateway = _$GatewayFromJson(jsonD['gateway']);
      } catch(e) {
        gateway = _$GatewayFromJson({});
        ret = false;
      }
      try {
        ts2100 = _$Ts2100FromJson(jsonD['ts2100']);
      } catch(e) {
        ts2100 = _$Ts2100FromJson({});
        ret = false;
      }
      try {
        ts21db = _$Ts21dbFromJson(jsonD['ts21db']);
      } catch(e) {
        ts21db = _$Ts21dbFromJson({});
        ret = false;
      }
      try {
        subsrx = _$SubsrxFromJson(jsonD['subsrx']);
      } catch(e) {
        subsrx = _$SubsrxFromJson({});
        ret = false;
      }
      try {
        compc = _$CompcFromJson(jsonD['compc']);
      } catch(e) {
        compc = _$CompcFromJson({});
        ret = false;
      }
      try {
        sims2100 = _$Sims2100FromJson(jsonD['sims2100']);
      } catch(e) {
        sims2100 = _$Sims2100FromJson({});
        ret = false;
      }
      try {
        sc_adr = _$Sc_adrFromJson(jsonD['sc_adr']);
      } catch(e) {
        sc_adr = _$Sc_adrFromJson({});
        ret = false;
      }
      try {
        sc_port = _$Sc_portFromJson(jsonD['sc_port']);
      } catch(e) {
        sc_port = _$Sc_portFromJson({});
        ret = false;
      }
      try {
        manage = _$ManageFromJson(jsonD['manage']);
      } catch(e) {
        manage = _$ManageFromJson({});
        ret = false;
      }
      try {
        comport = _$ComportFromJson(jsonD['comport']);
      } catch(e) {
        comport = _$ComportFromJson({});
        ret = false;
      }
      try {
        custserver = _$CustserverFromJson(jsonD['custserver']);
      } catch(e) {
        custserver = _$CustserverFromJson({});
        ret = false;
      }
      try {
        custsvrport = _$CustsvrportFromJson(jsonD['custsvrport']);
      } catch(e) {
        custsvrport = _$CustsvrportFromJson({});
        ret = false;
      }
      try {
        custrealsvr_timeout = _$Custrealsvr_timeoutFromJson(jsonD['custrealsvr_timeout']);
      } catch(e) {
        custrealsvr_timeout = _$Custrealsvr_timeoutFromJson({});
        ret = false;
      }
      try {
        mente_port = _$Mente_portFromJson(jsonD['mente_port']);
      } catch(e) {
        mente_port = _$Mente_portFromJson({});
        ret = false;
      }
      try {
        sc_mente_port = _$Sc_mente_portFromJson(jsonD['sc_mente_port']);
      } catch(e) {
        sc_mente_port = _$Sc_mente_portFromJson({});
        ret = false;
      }
      try {
        dns = _$DnsFromJson(jsonD['dns']);
      } catch(e) {
        dns = _$DnsFromJson({});
        ret = false;
      }
      try {
        timeserver = _$TimeserverFromJson(jsonD['timeserver']);
      } catch(e) {
        timeserver = _$TimeserverFromJson({});
        ret = false;
      }
      try {
        centerserver_mst = _$Centerserver_mstFromJson(jsonD['centerserver_mst']);
      } catch(e) {
        centerserver_mst = _$Centerserver_mstFromJson({});
        ret = false;
      }
      try {
        centerserver_trn = _$Centerserver_trnFromJson(jsonD['centerserver_trn']);
      } catch(e) {
        centerserver_trn = _$Centerserver_trnFromJson({});
        ret = false;
      }
      try {
        custserver2 = _$Custserver2FromJson(jsonD['custserver2']);
      } catch(e) {
        custserver2 = _$Custserver2FromJson({});
        ret = false;
      }
      try {
        hbtime = _$HbtimeFromJson(jsonD['hbtime']);
      } catch(e) {
        hbtime = _$HbtimeFromJson({});
        ret = false;
      }
      try {
        offlinetime = _$OfflinetimeFromJson(jsonD['offlinetime']);
      } catch(e) {
        offlinetime = _$OfflinetimeFromJson({});
        ret = false;
      }
      try {
        spqc = _$SpqcFromJson(jsonD['spqc']);
      } catch(e) {
        spqc = _$SpqcFromJson({});
        ret = false;
      }
      try {
        spqcport = _$SpqcportFromJson(jsonD['spqcport']);
      } catch(e) {
        spqcport = _$SpqcportFromJson({});
        ret = false;
      }
      try {
        wiz_port = _$Wiz_portFromJson(jsonD['wiz_port']);
      } catch(e) {
        wiz_port = _$Wiz_portFromJson({});
        ret = false;
      }
      try {
        spqc_subsvr = _$Spqc_subsvrFromJson(jsonD['spqc_subsvr']);
      } catch(e) {
        spqc_subsvr = _$Spqc_subsvrFromJson({});
        ret = false;
      }
      try {
        hq_userid = _$Hq_useridFromJson(jsonD['hq_userid']);
      } catch(e) {
        hq_userid = _$Hq_useridFromJson({});
        ret = false;
      }
      try {
        hq_userpass = _$Hq_userpassFromJson(jsonD['hq_userpass']);
      } catch(e) {
        hq_userpass = _$Hq_userpassFromJson({});
        ret = false;
      }
      try {
        hq_compcd = _$Hq_compcdFromJson(jsonD['hq_compcd']);
      } catch(e) {
        hq_compcd = _$Hq_compcdFromJson({});
        ret = false;
      }
      try {
        hq_url = _$Hq_urlFromJson(jsonD['hq_url']);
      } catch(e) {
        hq_url = _$Hq_urlFromJson({});
        ret = false;
      }
      try {
        qcselect_port = _$Qcselect_portFromJson(jsonD['qcselect_port']);
      } catch(e) {
        qcselect_port = _$Qcselect_portFromJson({});
        ret = false;
      }
      try {
        bult_send = _$Bult_sendFromJson(jsonD['bult_send']);
      } catch(e) {
        bult_send = _$Bult_sendFromJson({});
        ret = false;
      }
      try {
        tslnkweb_timeout = _$Tslnkweb_timeoutFromJson(jsonD['tslnkweb_timeout']);
      } catch(e) {
        tslnkweb_timeout = _$Tslnkweb_timeoutFromJson({});
        ret = false;
      }
      try {
        pbchg_groupcd = _$Pbchg_groupcdFromJson(jsonD['pbchg_groupcd']);
      } catch(e) {
        pbchg_groupcd = _$Pbchg_groupcdFromJson({});
        ret = false;
      }
      try {
        pbchg_officecd = _$Pbchg_officecdFromJson(jsonD['pbchg_officecd']);
      } catch(e) {
        pbchg_officecd = _$Pbchg_officecdFromJson({});
        ret = false;
      }
      try {
        pbchg_strecd = _$Pbchg_strecdFromJson(jsonD['pbchg_strecd']);
      } catch(e) {
        pbchg_strecd = _$Pbchg_strecdFromJson({});
        ret = false;
      }
      try {
        pbchg_interval = _$Pbchg_intervalFromJson(jsonD['pbchg_interval']);
      } catch(e) {
        pbchg_interval = _$Pbchg_intervalFromJson({});
        ret = false;
      }
      try {
        pbchg_cnt = _$Pbchg_cntFromJson(jsonD['pbchg_cnt']);
      } catch(e) {
        pbchg_cnt = _$Pbchg_cntFromJson({});
        ret = false;
      }
      try {
        pbchg_month = _$Pbchg_monthFromJson(jsonD['pbchg_month']);
      } catch(e) {
        pbchg_month = _$Pbchg_monthFromJson({});
        ret = false;
      }
      try {
        pbchg_steps = _$Pbchg_stepsFromJson(jsonD['pbchg_steps']);
      } catch(e) {
        pbchg_steps = _$Pbchg_stepsFromJson({});
        ret = false;
      }
      try {
        pbchg_res_sel = _$Pbchg_res_selFromJson(jsonD['pbchg_res_sel']);
      } catch(e) {
        pbchg_res_sel = _$Pbchg_res_selFromJson({});
        ret = false;
      }
      try {
        pbchg_fee1_sel = _$Pbchg_fee1_selFromJson(jsonD['pbchg_fee1_sel']);
      } catch(e) {
        pbchg_fee1_sel = _$Pbchg_fee1_selFromJson({});
        ret = false;
      }
      try {
        pbchg_fee2_sel = _$Pbchg_fee2_selFromJson(jsonD['pbchg_fee2_sel']);
      } catch(e) {
        pbchg_fee2_sel = _$Pbchg_fee2_selFromJson({});
        ret = false;
      }
      try {
        pbchg_cnct = _$Pbchg_cnctFromJson(jsonD['pbchg_cnct']);
      } catch(e) {
        pbchg_cnct = _$Pbchg_cnctFromJson({});
        ret = false;
      }
      try {
        pbchg_rd_timeout = _$Pbchg_rd_timeoutFromJson(jsonD['pbchg_rd_timeout']);
      } catch(e) {
        pbchg_rd_timeout = _$Pbchg_rd_timeoutFromJson({});
        ret = false;
      }
      try {
        pbchg_wt_timeout = _$Pbchg_wt_timeoutFromJson(jsonD['pbchg_wt_timeout']);
      } catch(e) {
        pbchg_wt_timeout = _$Pbchg_wt_timeoutFromJson({});
        ret = false;
      }
      try {
        add_total = _$Add_totalFromJson(jsonD['add_total']);
      } catch(e) {
        add_total = _$Add_totalFromJson({});
        ret = false;
      }
      try {
        add_cust = _$Add_custFromJson(jsonD['add_cust']);
      } catch(e) {
        add_cust = _$Add_custFromJson({});
        ret = false;
      }
      try {
        realitmsend_cnct = _$Realitmsend_cnctFromJson(jsonD['realitmsend_cnct']);
      } catch(e) {
        realitmsend_cnct = _$Realitmsend_cnctFromJson({});
        ret = false;
      }
      try {
        ca_ipaddr = _$Ca_ipaddrFromJson(jsonD['ca_ipaddr']);
      } catch(e) {
        ca_ipaddr = _$Ca_ipaddrFromJson({});
        ret = false;
      }
      try {
        ca_port = _$Ca_portFromJson(jsonD['ca_port']);
      } catch(e) {
        ca_port = _$Ca_portFromJson({});
        ret = false;
      }
      try {
        qcashier = _$QcashierFromJson(jsonD['qcashier']);
      } catch(e) {
        qcashier = _$QcashierFromJson({});
        ret = false;
      }
      try {
        tswebsvr = _$TswebsvrFromJson(jsonD['tswebsvr']);
      } catch(e) {
        tswebsvr = _$TswebsvrFromJson({});
        ret = false;
      }
      try {
        verup_cnct = _$Verup_cnctFromJson(jsonD['verup_cnct']);
      } catch(e) {
        verup_cnct = _$Verup_cnctFromJson({});
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
        histlog_server_sub = _$Histlog_server_subFromJson(jsonD['histlog_server_sub']);
      } catch(e) {
        histlog_server_sub = _$Histlog_server_subFromJson({});
        ret = false;
      }
      try {
        repica_url = _$Repica_urlFromJson(jsonD['repica_url']);
      } catch(e) {
        repica_url = _$Repica_urlFromJson({});
        ret = false;
      }
      try {
        repica_url_cancel = _$Repica_url_cancelFromJson(jsonD['repica_url_cancel']);
      } catch(e) {
        repica_url_cancel = _$Repica_url_cancelFromJson({});
        ret = false;
      }
      try {
        repica_timeout = _$Repica_timeoutFromJson(jsonD['repica_timeout']);
      } catch(e) {
        repica_timeout = _$Repica_timeoutFromJson({});
        ret = false;
      }
      try {
        repica_id = _$Repica_idFromJson(jsonD['repica_id']);
      } catch(e) {
        repica_id = _$Repica_idFromJson({});
        ret = false;
      }
      try {
        barcodepay_url = _$Barcodepay_urlFromJson(jsonD['barcodepay_url']);
      } catch(e) {
        barcodepay_url = _$Barcodepay_urlFromJson({});
        ret = false;
      }
      try {
        barcodepay_timeout = _$Barcodepay_timeoutFromJson(jsonD['barcodepay_timeout']);
      } catch(e) {
        barcodepay_timeout = _$Barcodepay_timeoutFromJson({});
        ret = false;
      }
      try {
        barcodepay_merchantCode = _$Barcodepay_merchantCodeFromJson(jsonD['barcodepay_merchantCode']);
      } catch(e) {
        barcodepay_merchantCode = _$Barcodepay_merchantCodeFromJson({});
        ret = false;
      }
      try {
        barcodepay_cliantId = _$Barcodepay_cliantIdFromJson(jsonD['barcodepay_cliantId']);
      } catch(e) {
        barcodepay_cliantId = _$Barcodepay_cliantIdFromJson({});
        ret = false;
      }
      try {
        DUMMY = _$DDUMMYFromJson(jsonD['DUMMY']);
      } catch(e) {
        DUMMY = _$DDUMMYFromJson({});
        ret = false;
      }
      try {
        linepay_url = _$Linepay_urlFromJson(jsonD['linepay_url']);
      } catch(e) {
        linepay_url = _$Linepay_urlFromJson({});
        ret = false;
      }
      try {
        linepay_timeout = _$Linepay_timeoutFromJson(jsonD['linepay_timeout']);
      } catch(e) {
        linepay_timeout = _$Linepay_timeoutFromJson({});
        ret = false;
      }
      try {
        linepay_channelId = _$Linepay_channelIdFromJson(jsonD['linepay_channelId']);
      } catch(e) {
        linepay_channelId = _$Linepay_channelIdFromJson({});
        ret = false;
      }
      try {
        linepay_channelSecretKey = _$Linepay_channelSecretKeyFromJson(jsonD['linepay_channelSecretKey']);
      } catch(e) {
        linepay_channelSecretKey = _$Linepay_channelSecretKeyFromJson({});
        ret = false;
      }
      try {
        linepay_line_at = _$Linepay_line_atFromJson(jsonD['linepay_line_at']);
      } catch(e) {
        linepay_line_at = _$Linepay_line_atFromJson({});
        ret = false;
      }
      try {
        onepay_url = _$Onepay_urlFromJson(jsonD['onepay_url']);
      } catch(e) {
        onepay_url = _$Onepay_urlFromJson({});
        ret = false;
      }
      try {
        onepay_timeout = _$Onepay_timeoutFromJson(jsonD['onepay_timeout']);
      } catch(e) {
        onepay_timeout = _$Onepay_timeoutFromJson({});
        ret = false;
      }
      try {
        canalpayment_url = _$Canalpayment_urlFromJson(jsonD['canalpayment_url']);
      } catch(e) {
        canalpayment_url = _$Canalpayment_urlFromJson({});
        ret = false;
      }
      try {
        canalpayment_timeout = _$Canalpayment_timeoutFromJson(jsonD['canalpayment_timeout']);
      } catch(e) {
        canalpayment_timeout = _$Canalpayment_timeoutFromJson({});
        ret = false;
      }
      try {
        canalpayment_company_code = _$Canalpayment_company_codeFromJson(jsonD['canalpayment_company_code']);
      } catch(e) {
        canalpayment_company_code = _$Canalpayment_company_codeFromJson({});
        ret = false;
      }
      try {
        canalpayment_branch_code = _$Canalpayment_branch_codeFromJson(jsonD['canalpayment_branch_code']);
      } catch(e) {
        canalpayment_branch_code = _$Canalpayment_branch_codeFromJson({});
        ret = false;
      }
      try {
        canalpayment_merchantId = _$Canalpayment_merchantIdFromJson(jsonD['canalpayment_merchantId']);
      } catch(e) {
        canalpayment_merchantId = _$Canalpayment_merchantIdFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Version version = _Version(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Macno_check macno_check = _Macno_check(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
  );

  _Stre_cd stre_cd = _Stre_cd(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ms_onoff ms_onoff = _Ms_onoff(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Mac_info_timeserver mac_info_timeserver = _Mac_info_timeserver(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ts_ver_mrg ts_ver_mrg = _Ts_ver_mrg(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Psc_scn_cmd_desktop psc_scn_cmd_desktop = _Psc_scn_cmd_desktop(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Psc_scn_cmd_tower psc_scn_cmd_tower = _Psc_scn_cmd_tower(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Scan_dp_snd_desktop scan_dp_snd_desktop = _Scan_dp_snd_desktop(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Scan_dp_snd_tower scan_dp_snd_tower = _Scan_dp_snd_tower(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Eat_in_start_end_check eat_in_start_end_check = _Eat_in_start_end_check(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    condi1_typ                         : 0,
    condi1_key                         : "",
    condi1_judge                       : 0,
    typ                                : 0,
    st_file                            : "",
    st_sect                            : "",
    st_key                             : "",
    end_file                           : "",
    end_sect                           : "",
    end_key                            : "",
  );

  _Catalinapr_cnct catalinapr_cnct = _Catalinapr_cnct(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    condi1_typ                         : 0,
    condi1_key                         : "",
    condi1_judge                       : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Custrealsvr_cnct custrealsvr_cnct = _Custrealsvr_cnct(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Netmask netmask = _Netmask(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Gateway gateway = _Gateway(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Ts2100 ts2100 = _Ts2100(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Ts21db ts21db = _Ts21db(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Subsrx subsrx = _Subsrx(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Compc compc = _Compc(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Sims2100 sims2100 = _Sims2100(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Sc_adr sc_adr = _Sc_adr(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Sc_port sc_port = _Sc_port(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Manage manage = _Manage(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Comport comport = _Comport(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Custserver custserver = _Custserver(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Custsvrport custsvrport = _Custsvrport(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Custrealsvr_timeout custrealsvr_timeout = _Custrealsvr_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Mente_port mente_port = _Mente_port(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Sc_mente_port sc_mente_port = _Sc_mente_port(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Dns dns = _Dns(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    condi1_typ                         : 0,
    condi1_key                         : "",
    condi1_judge                       : 0,
    typ                                : 0,
    file                               : "",
    keyword                            : "",
  );

  _Timeserver timeserver = _Timeserver(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Centerserver_mst centerserver_mst = _Centerserver_mst(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Centerserver_trn centerserver_trn = _Centerserver_trn(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Custserver2 custserver2 = _Custserver2(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Hbtime hbtime = _Hbtime(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Offlinetime offlinetime = _Offlinetime(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Spqc spqc = _Spqc(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Spqcport spqcport = _Spqcport(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Wiz_port wiz_port = _Wiz_port(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Spqc_subsvr spqc_subsvr = _Spqc_subsvr(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Hq_userid hq_userid = _Hq_userid(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Hq_userpass hq_userpass = _Hq_userpass(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Hq_compcd hq_compcd = _Hq_compcd(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Hq_url hq_url = _Hq_url(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Qcselect_port qcselect_port = _Qcselect_port(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Bult_send bult_send = _Bult_send(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Tslnkweb_timeout tslnkweb_timeout = _Tslnkweb_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_groupcd pbchg_groupcd = _Pbchg_groupcd(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_officecd pbchg_officecd = _Pbchg_officecd(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_strecd pbchg_strecd = _Pbchg_strecd(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_interval pbchg_interval = _Pbchg_interval(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_cnt pbchg_cnt = _Pbchg_cnt(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_month pbchg_month = _Pbchg_month(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_steps pbchg_steps = _Pbchg_steps(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_res_sel pbchg_res_sel = _Pbchg_res_sel(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_fee1_sel pbchg_fee1_sel = _Pbchg_fee1_sel(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_fee2_sel pbchg_fee2_sel = _Pbchg_fee2_sel(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_cnct pbchg_cnct = _Pbchg_cnct(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_rd_timeout pbchg_rd_timeout = _Pbchg_rd_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Pbchg_wt_timeout pbchg_wt_timeout = _Pbchg_wt_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Add_total add_total = _Add_total(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Add_cust add_cust = _Add_cust(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Realitmsend_cnct realitmsend_cnct = _Realitmsend_cnct(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ca_ipaddr ca_ipaddr = _Ca_ipaddr(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Ca_port ca_port = _Ca_port(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Qcashier qcashier = _Qcashier(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    condi1_typ                         : 0,
    condi1_key                         : "",
    condi1_judge                       : 0,
    typ                                : 0,
    file                               : "",
  );

  _Tswebsvr tswebsvr = _Tswebsvr(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Verup_cnct verup_cnct = _Verup_cnct(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Bkup_save bkup_save = _Bkup_save(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Histlog_server histlog_server = _Histlog_server(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Histlog_server_sub histlog_server_sub = _Histlog_server_sub(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    keyword_typ                        : 0,
    file                               : "",
    keyword                            : "",
  );

  _Repica_url repica_url = _Repica_url(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Repica_url_cancel repica_url_cancel = _Repica_url_cancel(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Repica_timeout repica_timeout = _Repica_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Repica_id repica_id = _Repica_id(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Barcodepay_url barcodepay_url = _Barcodepay_url(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Barcodepay_timeout barcodepay_timeout = _Barcodepay_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Barcodepay_merchantCode barcodepay_merchantCode = _Barcodepay_merchantCode(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Barcodepay_cliantId barcodepay_cliantId = _Barcodepay_cliantId(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _DDUMMY DUMMY = _DDUMMY(
    title                              : "",
    file                               : "",
    typ                                : 0,
    obj                                : 0,
  );

  _Linepay_url linepay_url = _Linepay_url(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Linepay_timeout linepay_timeout = _Linepay_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Linepay_channelId linepay_channelId = _Linepay_channelId(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Linepay_channelSecretKey linepay_channelSecretKey = _Linepay_channelSecretKey(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Linepay_line_at linepay_line_at = _Linepay_line_at(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Onepay_url onepay_url = _Onepay_url(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Onepay_timeout onepay_timeout = _Onepay_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Canalpayment_url canalpayment_url = _Canalpayment_url(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Canalpayment_timeout canalpayment_timeout = _Canalpayment_timeout(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Canalpayment_company_code canalpayment_company_code = _Canalpayment_company_code(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Canalpayment_branch_code canalpayment_branch_code = _Canalpayment_branch_code(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );

  _Canalpayment_merchantId canalpayment_merchantId = _Canalpayment_merchantId(
    title                              : "",
    obj                                : 0,
    condi                              : 0,
    typ                                : 0,
    ini_typ                            : 0,
    file                               : "",
    section                            : "",
    keyword                            : "",
  );
}

@JsonSerializable()
class _Version {
  factory _Version.fromJson(Map<String, dynamic> json) => _$VersionFromJson(json);
  Map<String, dynamic> toJson() => _$VersionToJson(this);

  _Version({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "バージョン")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/version.json")
  String file;
  @JsonKey(defaultValue: "apl")
  String section;
  @JsonKey(defaultValue: "ver")
  String keyword;
}

@JsonSerializable()
class _Macno_check {
  factory _Macno_check.fromJson(Map<String, dynamic> json) => _$Macno_checkFromJson(json);
  Map<String, dynamic> toJson() => _$Macno_checkToJson(this);

  _Macno_check({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
  });

  @JsonKey(defaultValue: "レジ番号関連")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 0)
  int    typ;
}

@JsonSerializable()
class _Stre_cd {
  factory _Stre_cd.fromJson(Map<String, dynamic> json) => _$Stre_cdFromJson(json);
  Map<String, dynamic> toJson() => _$Stre_cdToJson(this);

  _Stre_cd({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "店舗コード")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "shpno")
  String keyword;
}

@JsonSerializable()
class _Ms_onoff {
  factory _Ms_onoff.fromJson(Map<String, dynamic> json) => _$Ms_onoffFromJson(json);
  Map<String, dynamic> toJson() => _$Ms_onoffToJson(this);

  _Ms_onoff({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "M/S仕様")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "mm_onoff")
  String keyword;
}

@JsonSerializable()
class _Mac_info_timeserver {
  factory _Mac_info_timeserver.fromJson(Map<String, dynamic> json) => _$Mac_info_timeserverFromJson(json);
  Map<String, dynamic> toJson() => _$Mac_info_timeserverToJson(this);

  _Mac_info_timeserver({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "時刻問い合わせ先")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "timeserver")
  String section;
  @JsonKey(defaultValue: "timeserver")
  String keyword;
}

@JsonSerializable()
class _Ts_ver_mrg {
  factory _Ts_ver_mrg.fromJson(Map<String, dynamic> json) => _$Ts_ver_mrgFromJson(json);
  Map<String, dynamic> toJson() => _$Ts_ver_mrgToJson(this);

  _Ts_ver_mrg({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＴＳバージョン管理")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "ts_ver_mrg")
  String keyword;
}

@JsonSerializable()
class _Psc_scn_cmd_desktop {
  factory _Psc_scn_cmd_desktop.fromJson(Map<String, dynamic> json) => _$Psc_scn_cmd_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Psc_scn_cmd_desktopToJson(this);

  _Psc_scn_cmd_desktop({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＰＳＣスキャナコマンド制御（卓上）")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "scanner")
  String section;
  @JsonKey(defaultValue: "scn_cmd_desktop")
  String keyword;
}

@JsonSerializable()
class _Psc_scn_cmd_tower {
  factory _Psc_scn_cmd_tower.fromJson(Map<String, dynamic> json) => _$Psc_scn_cmd_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Psc_scn_cmd_towerToJson(this);

  _Psc_scn_cmd_tower({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＰＳＣスキャナコマンド制御（タワー）")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "scanner")
  String section;
  @JsonKey(defaultValue: "scn_cmd_tower")
  String keyword;
}

@JsonSerializable()
class _Scan_dp_snd_desktop {
  factory _Scan_dp_snd_desktop.fromJson(Map<String, dynamic> json) => _$Scan_dp_snd_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Scan_dp_snd_desktopToJson(this);

  _Scan_dp_snd_desktop({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "特定バーコード読取時スキャン音変更（卓上）")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "scanner")
  String section;
  @JsonKey(defaultValue: "scan_dp_snd_desktop")
  String keyword;
}

@JsonSerializable()
class _Scan_dp_snd_tower {
  factory _Scan_dp_snd_tower.fromJson(Map<String, dynamic> json) => _$Scan_dp_snd_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Scan_dp_snd_towerToJson(this);

  _Scan_dp_snd_tower({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "特定バーコード読取時スキャン音変更（タワー）")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "scanner")
  String section;
  @JsonKey(defaultValue: "scan_dp_snd_tower")
  String keyword;
}

@JsonSerializable()
class _Eat_in_start_end_check {
  factory _Eat_in_start_end_check.fromJson(Map<String, dynamic> json) => _$Eat_in_start_end_checkFromJson(json);
  Map<String, dynamic> toJson() => _$Eat_in_start_end_checkToJson(this);

  _Eat_in_start_end_check({
    required this.title,
    required this.obj,
    required this.condi,
    required this.condi1_typ,
    required this.condi1_key,
    required this.condi1_judge,
    required this.typ,
    required this.st_file,
    required this.st_sect,
    required this.st_key,
    required this.end_file,
    required this.end_sect,
    required this.end_key,
  });

  @JsonKey(defaultValue: "イートイン仕様整理番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 1)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    condi1_typ;
  @JsonKey(defaultValue: "eat_in")
  String condi1_key;
  @JsonKey(defaultValue: 1)
  int    condi1_judge;
  @JsonKey(defaultValue: 4)
  int    typ;
  @JsonKey(defaultValue: "conf/eat_in.json")
  String st_file;
  @JsonKey(defaultValue: "counter")
  String st_sect;
  @JsonKey(defaultValue: "start")
  String st_key;
  @JsonKey(defaultValue: "conf/eat_in.json")
  String end_file;
  @JsonKey(defaultValue: "counter")
  String end_sect;
  @JsonKey(defaultValue: "end")
  String end_key;
}

@JsonSerializable()
class _Catalinapr_cnct {
  factory _Catalinapr_cnct.fromJson(Map<String, dynamic> json) => _$Catalinapr_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Catalinapr_cnctToJson(this);

  _Catalinapr_cnct({
    required this.title,
    required this.obj,
    required this.condi,
    required this.condi1_typ,
    required this.condi1_key,
    required this.condi1_judge,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "カタリナプリンタ接続")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 1)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    condi1_typ;
  @JsonKey(defaultValue: "catalinasystem")
  String condi1_key;
  @JsonKey(defaultValue: 1)
  int    condi1_judge;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "internal_flg")
  String section;
  @JsonKey(defaultValue: "catalinapr_cnct")
  String keyword;
}

@JsonSerializable()
class _Custrealsvr_cnct {
  factory _Custrealsvr_cnct.fromJson(Map<String, dynamic> json) => _$Custrealsvr_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Custrealsvr_cnctToJson(this);

  _Custrealsvr_cnct({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "会員問い合わせサーバー接続")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "internal_flg")
  String section;
  @JsonKey(defaultValue: "custrealsvr_cnct")
  String keyword;
}

@JsonSerializable()
class _Netmask {
  factory _Netmask.fromJson(Map<String, dynamic> json) => _$NetmaskFromJson(json);
  Map<String, dynamic> toJson() => _$NetmaskToJson(this);

  _Netmask({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "サブネットマスク")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/sysconfig/network-scripts/ifcfg-eth0")
  String file;
  @JsonKey(defaultValue: "NETMASK")
  String keyword;
}

@JsonSerializable()
class _Gateway {
  factory _Gateway.fromJson(Map<String, dynamic> json) => _$GatewayFromJson(json);
  Map<String, dynamic> toJson() => _$GatewayToJson(this);

  _Gateway({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ゲートウェイアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/sysconfig/network-scripts/ifcfg-eth0")
  String file;
  @JsonKey(defaultValue: "GATEWAY")
  String keyword;
}

@JsonSerializable()
class _Ts2100 {
  factory _Ts2100.fromJson(Map<String, dynamic> json) => _$Ts2100FromJson(json);
  Map<String, dynamic> toJson() => _$Ts2100ToJson(this);

  _Ts2100({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "サーバーＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "ts2100")
  String keyword;
}

@JsonSerializable()
class _Ts21db {
  factory _Ts21db.fromJson(Map<String, dynamic> json) => _$Ts21dbFromJson(json);
  Map<String, dynamic> toJson() => _$Ts21dbToJson(this);

  _Ts21db({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＤＢサーバーＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "ts21db")
  String keyword;
}

@JsonSerializable()
class _Subsrx {
  factory _Subsrx.fromJson(Map<String, dynamic> json) => _$SubsrxFromJson(json);
  Map<String, dynamic> toJson() => _$SubsrxToJson(this);

  _Subsrx({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "サブサーバーＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "subsrx")
  String keyword;
}

@JsonSerializable()
class _Compc {
  factory _Compc.fromJson(Map<String, dynamic> json) => _$CompcFromJson(json);
  Map<String, dynamic> toJson() => _$CompcToJson(this);

  _Compc({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "通信ＰＣ　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "compc")
  String keyword;
}

@JsonSerializable()
class _Sims2100 {
  factory _Sims2100.fromJson(Map<String, dynamic> json) => _$Sims2100FromJson(json);
  Map<String, dynamic> toJson() => _$Sims2100ToJson(this);

  _Sims2100({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＳＩＭＳ２１００ＩＰアドレス＿１")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "sims2100")
  String keyword;
}

@JsonSerializable()
class _Sc_adr {
  factory _Sc_adr.fromJson(Map<String, dynamic> json) => _$Sc_adrFromJson(json);
  Map<String, dynamic> toJson() => _$Sc_adrToJson(this);

  _Sc_adr({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＳＩＭＳ２１００ＩＰアドレス＿２")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "sc_adr")
  String keyword;
}

@JsonSerializable()
class _Sc_port {
  factory _Sc_port.fromJson(Map<String, dynamic> json) => _$Sc_portFromJson(json);
  Map<String, dynamic> toJson() => _$Sc_portToJson(this);

  _Sc_port({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＳＩＭＳ２１００ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "sc_port")
  String keyword;
}

@JsonSerializable()
class _Manage {
  factory _Manage.fromJson(Map<String, dynamic> json) => _$ManageFromJson(json);
  Map<String, dynamic> toJson() => _$ManageToJson(this);

  _Manage({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "モニタＰＣ　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "manage")
  String keyword;
}

@JsonSerializable()
class _Comport {
  factory _Comport.fromJson(Map<String, dynamic> json) => _$ComportFromJson(json);
  Map<String, dynamic> toJson() => _$ComportToJson(this);

  _Comport({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "通信ＰＣ　ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/services")
  String file;
  @JsonKey(defaultValue: "comport")
  String keyword;
}

@JsonSerializable()
class _Custserver {
  factory _Custserver.fromJson(Map<String, dynamic> json) => _$CustserverFromJson(json);
  Map<String, dynamic> toJson() => _$CustserverToJson(this);

  _Custserver({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "会員サーバー　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "custserver")
  String keyword;
}

@JsonSerializable()
class _Custsvrport {
  factory _Custsvrport.fromJson(Map<String, dynamic> json) => _$CustsvrportFromJson(json);
  Map<String, dynamic> toJson() => _$CustsvrportToJson(this);

  _Custsvrport({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "会員サーバー　ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/services")
  String file;
  @JsonKey(defaultValue: "custsvrport")
  String keyword;
}

@JsonSerializable()
class _Custrealsvr_timeout {
  factory _Custrealsvr_timeout.fromJson(Map<String, dynamic> json) => _$Custrealsvr_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Custrealsvr_timeoutToJson(this);

  _Custrealsvr_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "リアル会員問い合わせ　受信タイムアウト秒")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "custrealsvr")
  String section;
  @JsonKey(defaultValue: "timeout")
  String keyword;
}

@JsonSerializable()
class _Mente_port {
  factory _Mente_port.fromJson(Map<String, dynamic> json) => _$Mente_portFromJson(json);
  Map<String, dynamic> toJson() => _$Mente_portToJson(this);

  _Mente_port({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "メンテナンス（セグメント、メモ）　ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "mente_port")
  String keyword;
}

@JsonSerializable()
class _Sc_mente_port {
  factory _Sc_mente_port.fromJson(Map<String, dynamic> json) => _$Sc_mente_portFromJson(json);
  Map<String, dynamic> toJson() => _$Sc_mente_portToJson(this);

  _Sc_mente_port({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "SIMS用メンテナンス（セグメント）　ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "sc_mente_port")
  String keyword;
}

@JsonSerializable()
class _Dns {
  factory _Dns.fromJson(Map<String, dynamic> json) => _$DnsFromJson(json);
  Map<String, dynamic> toJson() => _$DnsToJson(this);

  _Dns({
    required this.title,
    required this.obj,
    required this.condi,
    required this.condi1_typ,
    required this.condi1_key,
    required this.condi1_judge,
    required this.typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＤＮＳ（１）、ＤＮＳ（２）")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 1)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    condi1_typ;
  @JsonKey(defaultValue: "custreal_netdoa")
  String condi1_key;
  @JsonKey(defaultValue: 1)
  int    condi1_judge;
  @JsonKey(defaultValue: 5)
  int    typ;
  @JsonKey(defaultValue: "/etc/resolv.conf")
  String file;
  @JsonKey(defaultValue: "nameserver")
  String keyword;
}

@JsonSerializable()
class _Timeserver {
  factory _Timeserver.fromJson(Map<String, dynamic> json) => _$TimeserverFromJson(json);
  Map<String, dynamic> toJson() => _$TimeserverToJson(this);

  _Timeserver({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "タイムサーバー　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "timeserver")
  String keyword;
}

@JsonSerializable()
class _Centerserver_mst {
  factory _Centerserver_mst.fromJson(Map<String, dynamic> json) => _$Centerserver_mstFromJson(json);
  Map<String, dynamic> toJson() => _$Centerserver_mstToJson(this);

  _Centerserver_mst({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "センターサーバー（マスタ）　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "centerserver_mst")
  String keyword;
}

@JsonSerializable()
class _Centerserver_trn {
  factory _Centerserver_trn.fromJson(Map<String, dynamic> json) => _$Centerserver_trnFromJson(json);
  Map<String, dynamic> toJson() => _$Centerserver_trnToJson(this);

  _Centerserver_trn({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "センターサーバー（実績）　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "centerserver_trn")
  String keyword;
}

@JsonSerializable()
class _Custserver2 {
  factory _Custserver2.fromJson(Map<String, dynamic> json) => _$Custserver2FromJson(json);
  Map<String, dynamic> toJson() => _$Custserver2ToJson(this);

  _Custserver2({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "会員サーバー２　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "custserver2")
  String keyword;
}

@JsonSerializable()
class _Hbtime {
  factory _Hbtime.fromJson(Map<String, dynamic> json) => _$HbtimeFromJson(json);
  Map<String, dynamic> toJson() => _$HbtimeToJson(this);

  _Hbtime({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "会員サーバー２　ハートビート間隔")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "custsvr2")
  String section;
  @JsonKey(defaultValue: "hbtime")
  String keyword;
}

@JsonSerializable()
class _Offlinetime {
  factory _Offlinetime.fromJson(Map<String, dynamic> json) => _$OfflinetimeFromJson(json);
  Map<String, dynamic> toJson() => _$OfflinetimeToJson(this);

  _Offlinetime({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "会員サーバー２　オフライン時未接続間隔")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "custsvr2")
  String section;
  @JsonKey(defaultValue: "offlinetime")
  String keyword;
}

@JsonSerializable()
class _Spqc {
  factory _Spqc.fromJson(Map<String, dynamic> json) => _$SpqcFromJson(json);
  Map<String, dynamic> toJson() => _$SpqcToJson(this);

  _Spqc({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "お会計券管理　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "spqc")
  String keyword;
}

@JsonSerializable()
class _Spqcport {
  factory _Spqcport.fromJson(Map<String, dynamic> json) => _$SpqcportFromJson(json);
  Map<String, dynamic> toJson() => _$SpqcportToJson(this);

  _Spqcport({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "お会計券管理　ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/services")
  String file;
  @JsonKey(defaultValue: "spqcport")
  String keyword;
}

@JsonSerializable()
class _Wiz_port {
  factory _Wiz_port.fromJson(Map<String, dynamic> json) => _$Wiz_portFromJson(json);
  Map<String, dynamic> toJson() => _$Wiz_portToJson(this);

  _Wiz_port({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "Wiz接続　ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/services")
  String file;
  @JsonKey(defaultValue: "wiz_port")
  String keyword;
}

@JsonSerializable()
class _Spqc_subsvr {
  factory _Spqc_subsvr.fromJson(Map<String, dynamic> json) => _$Spqc_subsvrFromJson(json);
  Map<String, dynamic> toJson() => _$Spqc_subsvrToJson(this);

  _Spqc_subsvr({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "お会計券管理サブサーバーＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "spqc_subsvr")
  String keyword;
}

@JsonSerializable()
class _Hq_userid {
  factory _Hq_userid.fromJson(Map<String, dynamic> json) => _$Hq_useridFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_useridToJson(this);

  _Hq_userid({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様　ログインＩＤ")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "hq")
  String section;
  @JsonKey(defaultValue: "userid")
  String keyword;
}

@JsonSerializable()
class _Hq_userpass {
  factory _Hq_userpass.fromJson(Map<String, dynamic> json) => _$Hq_userpassFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_userpassToJson(this);

  _Hq_userpass({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様　ログインパスワード")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "hq")
  String section;
  @JsonKey(defaultValue: "userpass")
  String keyword;
}

@JsonSerializable()
class _Hq_compcd {
  factory _Hq_compcd.fromJson(Map<String, dynamic> json) => _$Hq_compcdFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_compcdToJson(this);

  _Hq_compcd({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様　企業コード")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "hq")
  String section;
  @JsonKey(defaultValue: "compcd")
  String keyword;
}

@JsonSerializable()
class _Hq_url {
  factory _Hq_url.fromJson(Map<String, dynamic> json) => _$Hq_urlFromJson(json);
  Map<String, dynamic> toJson() => _$Hq_urlToJson(this);

  _Hq_url({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様　接続先ＵＲＬ")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "hq")
  String section;
  @JsonKey(defaultValue: "url")
  String keyword;
}

@JsonSerializable()
class _Qcselect_port {
  factory _Qcselect_port.fromJson(Map<String, dynamic> json) => _$Qcselect_portFromJson(json);
  Map<String, dynamic> toJson() => _$Qcselect_portToJson(this);

  _Qcselect_port({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "QC指定接続　ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 2)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/services")
  String file;
  @JsonKey(defaultValue: "qcselect_port")
  String keyword;
}

@JsonSerializable()
class _Bult_send {
  factory _Bult_send.fromJson(Map<String, dynamic> json) => _$Bult_sendFromJson(json);
  Map<String, dynamic> toJson() => _$Bult_sendToJson(this);

  _Bult_send({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "センターサーバー　速報実績の送信")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "center_server")
  String section;
  @JsonKey(defaultValue: "bult_send")
  String keyword;
}

@JsonSerializable()
class _Tslnkweb_timeout {
  factory _Tslnkweb_timeout.fromJson(Map<String, dynamic> json) => _$Tslnkweb_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Tslnkweb_timeoutToJson(this);

  _Tslnkweb_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "センターサーバー　速報実績送信の間隔")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "center_server")
  String section;
  @JsonKey(defaultValue: "tslnkweb_timeout")
  String keyword;
}

@JsonSerializable()
class _Pbchg_groupcd {
  factory _Pbchg_groupcd.fromJson(Map<String, dynamic> json) => _$Pbchg_groupcdFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_groupcdToJson(this);

  _Pbchg_groupcd({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　会社グループコード")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "groupcd")
  String keyword;
}

@JsonSerializable()
class _Pbchg_officecd {
  factory _Pbchg_officecd.fromJson(Map<String, dynamic> json) => _$Pbchg_officecdFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_officecdToJson(this);

  _Pbchg_officecd({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　会社コード")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "officecd")
  String keyword;
}

@JsonSerializable()
class _Pbchg_strecd {
  factory _Pbchg_strecd.fromJson(Map<String, dynamic> json) => _$Pbchg_strecdFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_strecdToJson(this);

  _Pbchg_strecd({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　店舗コード")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "system")
  String section;
  @JsonKey(defaultValue: "strecd")
  String keyword;
}

@JsonSerializable()
class _Pbchg_interval {
  factory _Pbchg_interval.fromJson(Map<String, dynamic> json) => _$Pbchg_intervalFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_intervalToJson(this);

  _Pbchg_interval({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　収納代行速報リトライ間隔")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "retry")
  String section;
  @JsonKey(defaultValue: "interval")
  String keyword;
}

@JsonSerializable()
class _Pbchg_cnt {
  factory _Pbchg_cnt.fromJson(Map<String, dynamic> json) => _$Pbchg_cntFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_cntToJson(this);

  _Pbchg_cnt({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　収納代行速報リトライ回数")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "retry")
  String section;
  @JsonKey(defaultValue: "cnt")
  String keyword;
}

@JsonSerializable()
class _Pbchg_month {
  factory _Pbchg_month.fromJson(Map<String, dynamic> json) => _$Pbchg_monthFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_monthToJson(this);

  _Pbchg_month({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　収納代行過去実績保持月数")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "save")
  String section;
  @JsonKey(defaultValue: "month")
  String keyword;
}

@JsonSerializable()
class _Pbchg_steps {
  factory _Pbchg_steps.fromJson(Map<String, dynamic> json) => _$Pbchg_stepsFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_stepsToJson(this);

  _Pbchg_steps({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　１取引公共料金制限段数")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "tran")
  String section;
  @JsonKey(defaultValue: "steps")
  String keyword;
}

@JsonSerializable()
class _Pbchg_res_sel {
  factory _Pbchg_res_sel.fromJson(Map<String, dynamic> json) => _$Pbchg_res_selFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_res_selToJson(this);

  _Pbchg_res_sel({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　公共料金実績フラグ")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "tran")
  String section;
  @JsonKey(defaultValue: "res_sel")
  String keyword;
}

@JsonSerializable()
class _Pbchg_fee1_sel {
  factory _Pbchg_fee1_sel.fromJson(Map<String, dynamic> json) => _$Pbchg_fee1_selFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_fee1_selToJson(this);

  _Pbchg_fee1_sel({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　手数料1実績フラグ")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "tran")
  String section;
  @JsonKey(defaultValue: "fee1_sel")
  String keyword;
}

@JsonSerializable()
class _Pbchg_fee2_sel {
  factory _Pbchg_fee2_sel.fromJson(Map<String, dynamic> json) => _$Pbchg_fee2_selFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_fee2_selToJson(this);

  _Pbchg_fee2_sel({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　手数料2実績フラグ")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "tran")
  String section;
  @JsonKey(defaultValue: "fee2_sel")
  String keyword;
}

@JsonSerializable()
class _Pbchg_cnct {
  factory _Pbchg_cnct.fromJson(Map<String, dynamic> json) => _$Pbchg_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_cnctToJson(this);

  _Pbchg_cnct({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　接続タイムアウト")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "retry")
  String section;
  @JsonKey(defaultValue: "cnct")
  String keyword;
}

@JsonSerializable()
class _Pbchg_rd_timeout {
  factory _Pbchg_rd_timeout.fromJson(Map<String, dynamic> json) => _$Pbchg_rd_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_rd_timeoutToJson(this);

  _Pbchg_rd_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　受信タイムアウト")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "retry")
  String section;
  @JsonKey(defaultValue: "rd_timeout")
  String keyword;
}

@JsonSerializable()
class _Pbchg_wt_timeout {
  factory _Pbchg_wt_timeout.fromJson(Map<String, dynamic> json) => _$Pbchg_wt_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Pbchg_wt_timeoutToJson(this);

  _Pbchg_wt_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "公共料金　送信タイムアウト")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/pbchg.json")
  String file;
  @JsonKey(defaultValue: "retry")
  String section;
  @JsonKey(defaultValue: "wt_timeout")
  String keyword;
}

@JsonSerializable()
class _Add_total {
  factory _Add_total.fromJson(Map<String, dynamic> json) => _$Add_totalFromJson(json);
  Map<String, dynamic> toJson() => _$Add_totalToJson(this);

  _Add_total({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "日計データを累計に加算")
  String title;
  @JsonKey(defaultValue: 1)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "add_total")
  String keyword;
}

@JsonSerializable()
class _Add_cust {
  factory _Add_cust.fromJson(Map<String, dynamic> json) => _$Add_custFromJson(json);
  Map<String, dynamic> toJson() => _$Add_custToJson(this);

  _Add_cust({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "会員日計データを累計に加算")
  String title;
  @JsonKey(defaultValue: 1)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "mm_system")
  String section;
  @JsonKey(defaultValue: "add_cust")
  String keyword;
}

@JsonSerializable()
class _Realitmsend_cnct {
  factory _Realitmsend_cnct.fromJson(Map<String, dynamic> json) => _$Realitmsend_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Realitmsend_cnctToJson(this);

  _Realitmsend_cnct({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "リアル明細送信サーバー接続")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/mac_info.json")
  String file;
  @JsonKey(defaultValue: "internal_flg")
  String section;
  @JsonKey(defaultValue: "realitmsend_cnct")
  String keyword;
}

@JsonSerializable()
class _Ca_ipaddr {
  factory _Ca_ipaddr.fromJson(Map<String, dynamic> json) => _$Ca_ipaddrFromJson(json);
  Map<String, dynamic> toJson() => _$Ca_ipaddrToJson(this);

  _Ca_ipaddr({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "リアル明細送信サーバー　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "catalina")
  String section;
  @JsonKey(defaultValue: "ca_ipaddr")
  String keyword;
}

@JsonSerializable()
class _Ca_port {
  factory _Ca_port.fromJson(Map<String, dynamic> json) => _$Ca_portFromJson(json);
  Map<String, dynamic> toJson() => _$Ca_portToJson(this);

  _Ca_port({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "リアル明細送信サーバー　ポート番号")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/sys_param.json")
  String file;
  @JsonKey(defaultValue: "catalina")
  String section;
  @JsonKey(defaultValue: "ca_port")
  String keyword;
}

@JsonSerializable()
class _Qcashier {
  factory _Qcashier.fromJson(Map<String, dynamic> json) => _$QcashierFromJson(json);
  Map<String, dynamic> toJson() => _$QcashierToJson(this);

  _Qcashier({
    required this.title,
    required this.obj,
    required this.condi,
    required this.condi1_typ,
    required this.condi1_key,
    required this.condi1_judge,
    required this.typ,
    required this.file,
  });

  @JsonKey(defaultValue: "QCashier.iniファイル")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 1)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    condi1_typ;
  @JsonKey(defaultValue: "qcashier_system")
  String condi1_key;
  @JsonKey(defaultValue: 1)
  int    condi1_judge;
  @JsonKey(defaultValue: 3)
  int    typ;
  @JsonKey(defaultValue: "conf/qcashier.json")
  String file;
}

@JsonSerializable()
class _Tswebsvr {
  factory _Tswebsvr.fromJson(Map<String, dynamic> json) => _$TswebsvrFromJson(json);
  Map<String, dynamic> toJson() => _$TswebsvrToJson(this);

  _Tswebsvr({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "ＴＳ仕様 シェル実行サーバー ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "tswebsvr")
  String keyword;
}

@JsonSerializable()
class _Verup_cnct {
  factory _Verup_cnct.fromJson(Map<String, dynamic> json) => _$Verup_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Verup_cnctToJson(this);

  _Verup_cnct({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "バージョンアップファイル取得先 ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "verup_cnct")
  String keyword;
}

@JsonSerializable()
class _Bkup_save {
  factory _Bkup_save.fromJson(Map<String, dynamic> json) => _$Bkup_saveFromJson(json);
  Map<String, dynamic> toJson() => _$Bkup_saveToJson(this);

  _Bkup_save({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "spec_bkup保存先 ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "bkup_save")
  String keyword;
}

@JsonSerializable()
class _Histlog_server {
  factory _Histlog_server.fromJson(Map<String, dynamic> json) => _$Histlog_serverFromJson(json);
  Map<String, dynamic> toJson() => _$Histlog_serverToJson(this);

  _Histlog_server({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "履歴(COPY文)マスター取込み先　ＩＰアドレス")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "histlog_server")
  String keyword;
}

@JsonSerializable()
class _Histlog_server_sub {
  factory _Histlog_server_sub.fromJson(Map<String, dynamic> json) => _$Histlog_server_subFromJson(json);
  Map<String, dynamic> toJson() => _$Histlog_server_subToJson(this);

  _Histlog_server_sub({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.keyword_typ,
    required this.file,
    required this.keyword,
  });

  @JsonKey(defaultValue: "履歴(COPY文)マスター取込み先  ＩＰアドレス (サブ)")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 1)
  int    typ;
  @JsonKey(defaultValue: 1)
  int    keyword_typ;
  @JsonKey(defaultValue: "/etc/hosts")
  String file;
  @JsonKey(defaultValue: "histlog_sub_server")
  String keyword;
}

@JsonSerializable()
class _Repica_url {
  factory _Repica_url.fromJson(Map<String, dynamic> json) => _$Repica_urlFromJson(json);
  Map<String, dynamic> toJson() => _$Repica_urlToJson(this);

  _Repica_url({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "レピカ仕様 プリペイド接続アドレス(1)")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/repica.json")
  String file;
  @JsonKey(defaultValue: "normal")
  String section;
  @JsonKey(defaultValue: "url")
  String keyword;
}

@JsonSerializable()
class _Repica_url_cancel {
  factory _Repica_url_cancel.fromJson(Map<String, dynamic> json) => _$Repica_url_cancelFromJson(json);
  Map<String, dynamic> toJson() => _$Repica_url_cancelToJson(this);

  _Repica_url_cancel({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "レピカ仕様 プリペイド接続アドレス(2)")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/repica.json")
  String file;
  @JsonKey(defaultValue: "normal")
  String section;
  @JsonKey(defaultValue: "url_auto_cancel")
  String keyword;
}

@JsonSerializable()
class _Repica_timeout {
  factory _Repica_timeout.fromJson(Map<String, dynamic> json) => _$Repica_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Repica_timeoutToJson(this);

  _Repica_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "レピカ仕様 プリペイド接続 タイムアウト")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/repica.json")
  String file;
  @JsonKey(defaultValue: "normal")
  String section;
  @JsonKey(defaultValue: "timeout")
  String keyword;
}

@JsonSerializable()
class _Repica_id {
  factory _Repica_id.fromJson(Map<String, dynamic> json) => _$Repica_idFromJson(json);
  Map<String, dynamic> toJson() => _$Repica_idToJson(this);

  _Repica_id({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "レピカ仕様 プリペイド接続 ID")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/repica.json")
  String file;
  @JsonKey(defaultValue: "normal")
  String section;
  @JsonKey(defaultValue: "client_signature")
  String keyword;
}

@JsonSerializable()
class _Barcodepay_url {
  factory _Barcodepay_url.fromJson(Map<String, dynamic> json) => _$Barcodepay_urlFromJson(json);
  Map<String, dynamic> toJson() => _$Barcodepay_urlToJson(this);

  _Barcodepay_url({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "JPQR決済 問い合わせURL")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "barcodepay")
  String section;
  @JsonKey(defaultValue: "url")
  String keyword;
}

@JsonSerializable()
class _Barcodepay_timeout {
  factory _Barcodepay_timeout.fromJson(Map<String, dynamic> json) => _$Barcodepay_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Barcodepay_timeoutToJson(this);

  _Barcodepay_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "JPQR決済 タイムアウト")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "barcodepay")
  String section;
  @JsonKey(defaultValue: "timeout")
  String keyword;
}

@JsonSerializable()
class _Barcodepay_merchantCode {
  factory _Barcodepay_merchantCode.fromJson(Map<String, dynamic> json) => _$Barcodepay_merchantCodeFromJson(json);
  Map<String, dynamic> toJson() => _$Barcodepay_merchantCodeToJson(this);

  _Barcodepay_merchantCode({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "JPQR決済 merchantCode")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "barcodepay")
  String section;
  @JsonKey(defaultValue: "merchantCode")
  String keyword;
}

@JsonSerializable()
class _Barcodepay_cliantId {
  factory _Barcodepay_cliantId.fromJson(Map<String, dynamic> json) => _$Barcodepay_cliantIdFromJson(json);
  Map<String, dynamic> toJson() => _$Barcodepay_cliantIdToJson(this);

  _Barcodepay_cliantId({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "JPQR決済 cliantId")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "barcodepay")
  String section;
  @JsonKey(defaultValue: "cliantId")
  String keyword;
}

@JsonSerializable()
class _DDUMMY {
  factory _DDUMMY.fromJson(Map<String, dynamic> json) => _$DDUMMYFromJson(json);
  Map<String, dynamic> toJson() => _$DDUMMYToJson(this);

  _DDUMMY({
    required this.title,
    required this.file,
    required this.typ,
    required this.obj,
  });

  @JsonKey(defaultValue: "DUMMY")
  String title;
  @JsonKey(defaultValue: "/etc/sysconfig/network-scripts/ifcfg-enp1s0")
  String file;
  @JsonKey(defaultValue: 99)
  int    typ;
  @JsonKey(defaultValue: 99)
  int    obj;
}

@JsonSerializable()
class _Linepay_url {
  factory _Linepay_url.fromJson(Map<String, dynamic> json) => _$Linepay_urlFromJson(json);
  Map<String, dynamic> toJson() => _$Linepay_urlToJson(this);

  _Linepay_url({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "LINE Pay 問い合わせURL")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "linepay")
  String section;
  @JsonKey(defaultValue: "url")
  String keyword;
}

@JsonSerializable()
class _Linepay_timeout {
  factory _Linepay_timeout.fromJson(Map<String, dynamic> json) => _$Linepay_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Linepay_timeoutToJson(this);

  _Linepay_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "LINE Pay タイムアウト秒")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "linepay")
  String section;
  @JsonKey(defaultValue: "timeout")
  String keyword;
}

@JsonSerializable()
class _Linepay_channelId {
  factory _Linepay_channelId.fromJson(Map<String, dynamic> json) => _$Linepay_channelIdFromJson(json);
  Map<String, dynamic> toJson() => _$Linepay_channelIdToJson(this);

  _Linepay_channelId({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "LINE Pay channelId")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "linepay")
  String section;
  @JsonKey(defaultValue: "channelId")
  String keyword;
}

@JsonSerializable()
class _Linepay_channelSecretKey {
  factory _Linepay_channelSecretKey.fromJson(Map<String, dynamic> json) => _$Linepay_channelSecretKeyFromJson(json);
  Map<String, dynamic> toJson() => _$Linepay_channelSecretKeyToJson(this);

  _Linepay_channelSecretKey({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "LINE Pay channelSecretKey")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "linepay")
  String section;
  @JsonKey(defaultValue: "channelSecretKey")
  String keyword;
}

@JsonSerializable()
class _Linepay_line_at {
  factory _Linepay_line_at.fromJson(Map<String, dynamic> json) => _$Linepay_line_atFromJson(json);
  Map<String, dynamic> toJson() => _$Linepay_line_atToJson(this);

  _Linepay_line_at({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "LINE Pay LINE@")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "linepay")
  String section;
  @JsonKey(defaultValue: "line_at")
  String keyword;
}

@JsonSerializable()
class _Onepay_url {
  factory _Onepay_url.fromJson(Map<String, dynamic> json) => _$Onepay_urlFromJson(json);
  Map<String, dynamic> toJson() => _$Onepay_urlToJson(this);

  _Onepay_url({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "Onepay 問い合わせURL")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "onepay")
  String section;
  @JsonKey(defaultValue: "url")
  String keyword;
}

@JsonSerializable()
class _Onepay_timeout {
  factory _Onepay_timeout.fromJson(Map<String, dynamic> json) => _$Onepay_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Onepay_timeoutToJson(this);

  _Onepay_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "Onepay タイムアウト秒")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "onepay")
  String section;
  @JsonKey(defaultValue: "timeout")
  String keyword;
}

@JsonSerializable()
class _Canalpayment_url {
  factory _Canalpayment_url.fromJson(Map<String, dynamic> json) => _$Canalpayment_urlFromJson(json);
  Map<String, dynamic> toJson() => _$Canalpayment_urlToJson(this);

  _Canalpayment_url({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "CANALPayment 問い合わせURL")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "canalpayment")
  String section;
  @JsonKey(defaultValue: "url")
  String keyword;
}

@JsonSerializable()
class _Canalpayment_timeout {
  factory _Canalpayment_timeout.fromJson(Map<String, dynamic> json) => _$Canalpayment_timeoutFromJson(json);
  Map<String, dynamic> toJson() => _$Canalpayment_timeoutToJson(this);

  _Canalpayment_timeout({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "CANALPayment タイムアウト秒")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "canalpayment")
  String section;
  @JsonKey(defaultValue: "timeout")
  String keyword;
}

@JsonSerializable()
class _Canalpayment_company_code {
  factory _Canalpayment_company_code.fromJson(Map<String, dynamic> json) => _$Canalpayment_company_codeFromJson(json);
  Map<String, dynamic> toJson() => _$Canalpayment_company_codeToJson(this);

  _Canalpayment_company_code({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "CANALPayment 企業コード")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "canalpayment")
  String section;
  @JsonKey(defaultValue: "company_code")
  String keyword;
}

@JsonSerializable()
class _Canalpayment_branch_code {
  factory _Canalpayment_branch_code.fromJson(Map<String, dynamic> json) => _$Canalpayment_branch_codeFromJson(json);
  Map<String, dynamic> toJson() => _$Canalpayment_branch_codeToJson(this);

  _Canalpayment_branch_code({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "CANALPayment 店舗コード")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "canalpayment")
  String section;
  @JsonKey(defaultValue: "branch_code")
  String keyword;
}

@JsonSerializable()
class _Canalpayment_merchantId {
  factory _Canalpayment_merchantId.fromJson(Map<String, dynamic> json) => _$Canalpayment_merchantIdFromJson(json);
  Map<String, dynamic> toJson() => _$Canalpayment_merchantIdToJson(this);

  _Canalpayment_merchantId({
    required this.title,
    required this.obj,
    required this.condi,
    required this.typ,
    required this.ini_typ,
    required this.file,
    required this.section,
    required this.keyword,
  });

  @JsonKey(defaultValue: "CANALPayment マーチャントID")
  String title;
  @JsonKey(defaultValue: 0)
  int    obj;
  @JsonKey(defaultValue: 0)
  int    condi;
  @JsonKey(defaultValue: 2)
  int    typ;
  @JsonKey(defaultValue: 0)
  int    ini_typ;
  @JsonKey(defaultValue: "conf/barcode_pay.json")
  String file;
  @JsonKey(defaultValue: "canalpayment")
  String section;
  @JsonKey(defaultValue: "merchantId")
  String keyword;
}

