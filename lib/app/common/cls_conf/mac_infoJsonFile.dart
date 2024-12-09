/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'mac_infoJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Mac_infoJsonFile extends ConfigJsonFile {
  static final Mac_infoJsonFile _instance = Mac_infoJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "mac_info.json";

  Mac_infoJsonFile(){
    setPath(_confPath, _fileName);
  }
  Mac_infoJsonFile._internal();

  factory Mac_infoJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Mac_infoJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Mac_infoJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Mac_infoJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        system = _$SystemFromJson(jsonD['system']);
      } catch(e) {
        system = _$SystemFromJson({});
        ret = false;
      }
      try {
        mm_system = _$Mm_systemFromJson(jsonD['mm_system']);
      } catch(e) {
        mm_system = _$Mm_systemFromJson({});
        ret = false;
      }
      try {
        logging = _$LoggingFromJson(jsonD['logging']);
      } catch(e) {
        logging = _$LoggingFromJson({});
        ret = false;
      }
      try {
        mac_addr = _$Mac_addrFromJson(jsonD['mac_addr']);
      } catch(e) {
        mac_addr = _$Mac_addrFromJson({});
        ret = false;
      }
      try {
        ip_addr = _$Ip_addrFromJson(jsonD['ip_addr']);
      } catch(e) {
        ip_addr = _$Ip_addrFromJson({});
        ret = false;
      }
      try {
        mac_no = _$Mac_noFromJson(jsonD['mac_no']);
      } catch(e) {
        mac_no = _$Mac_noFromJson({});
        ret = false;
      }
      try {
        jnl_bkup = _$Jnl_bkupFromJson(jsonD['jnl_bkup']);
      } catch(e) {
        jnl_bkup = _$Jnl_bkupFromJson({});
        ret = false;
      }
      try {
        data_bkup = _$Data_bkupFromJson(jsonD['data_bkup']);
      } catch(e) {
        data_bkup = _$Data_bkupFromJson({});
        ret = false;
      }
      try {
        csv_bkup = _$Csv_bkupFromJson(jsonD['csv_bkup']);
      } catch(e) {
        csv_bkup = _$Csv_bkupFromJson({});
        ret = false;
      }
      try {
        csv_term = _$Csv_termFromJson(jsonD['csv_term']);
      } catch(e) {
        csv_term = _$Csv_termFromJson({});
        ret = false;
      }
      try {
        csv_prg = _$Csv_prgFromJson(jsonD['csv_prg']);
      } catch(e) {
        csv_prg = _$Csv_prgFromJson({});
        ret = false;
      }
      try {
        csv_dly = _$Csv_dlyFromJson(jsonD['csv_dly']);
      } catch(e) {
        csv_dly = _$Csv_dlyFromJson({});
        ret = false;
      }
      try {
        csv_tpr8100 = _$Csv_tpr8100FromJson(jsonD['csv_tpr8100']);
      } catch(e) {
        csv_tpr8100 = _$Csv_tpr8100FromJson({});
        ret = false;
      }
      try {
        sch_delete = _$Sch_deleteFromJson(jsonD['sch_delete']);
      } catch(e) {
        sch_delete = _$Sch_deleteFromJson({});
        ret = false;
      }
      try {
        internal_flg = _$Internal_flgFromJson(jsonD['internal_flg']);
      } catch(e) {
        internal_flg = _$Internal_flgFromJson({});
        ret = false;
      }
      try {
        cat_timer = _$Cat_timerFromJson(jsonD['cat_timer']);
      } catch(e) {
        cat_timer = _$Cat_timerFromJson({});
        ret = false;
      }
      try {
        printer = _$PrinterFromJson(jsonD['printer']);
      } catch(e) {
        printer = _$PrinterFromJson({});
        ret = false;
      }
      try {
        printer_cntl = _$Printer_cntlFromJson(jsonD['printer_cntl']);
      } catch(e) {
        printer_cntl = _$Printer_cntlFromJson({});
        ret = false;
      }
      try {
        printer_def = _$Printer_defFromJson(jsonD['printer_def']);
      } catch(e) {
        printer_def = _$Printer_defFromJson({});
        ret = false;
      }
      try {
        clerksave = _$ClerksaveFromJson(jsonD['clerksave']);
      } catch(e) {
        clerksave = _$ClerksaveFromJson({});
        ret = false;
      }
      try {
        printer_font = _$Printer_fontFromJson(jsonD['printer_font']);
      } catch(e) {
        printer_font = _$Printer_fontFromJson({});
        ret = false;
      }
      try {
        ups = _$UpsFromJson(jsonD['ups']);
      } catch(e) {
        ups = _$UpsFromJson({});
        ret = false;
      }
      try {
        doc = _$DocFromJson(jsonD['doc']);
      } catch(e) {
        doc = _$DocFromJson({});
        ret = false;
      }
      try {
        mem_size_db5_M = _$Mem_size_db5_MFromJson(jsonD['mem_size_db5_M']);
      } catch(e) {
        mem_size_db5_M = _$Mem_size_db5_MFromJson({});
        ret = false;
      }
      try {
        mem_size_db5_S = _$Mem_size_db5_SFromJson(jsonD['mem_size_db5_S']);
      } catch(e) {
        mem_size_db5_S = _$Mem_size_db5_SFromJson({});
        ret = false;
      }
      try {
        mem_size_db6_M = _$Mem_size_db6_MFromJson(jsonD['mem_size_db6_M']);
      } catch(e) {
        mem_size_db6_M = _$Mem_size_db6_MFromJson({});
        ret = false;
      }
      try {
        mem_size_db6_S = _$Mem_size_db6_SFromJson(jsonD['mem_size_db6_S']);
      } catch(e) {
        mem_size_db6_S = _$Mem_size_db6_SFromJson({});
        ret = false;
      }
      try {
        tag_poppy = _$Tag_poppyFromJson(jsonD['tag_poppy']);
      } catch(e) {
        tag_poppy = _$Tag_poppyFromJson({});
        ret = false;
      }
      try {
        FJ_FTP = _$FFJ_FTPFromJson(jsonD['FJ_FTP']);
      } catch(e) {
        FJ_FTP = _$FFJ_FTPFromJson({});
        ret = false;
      }
      try {
        select_self = _$Select_selfFromJson(jsonD['select_self']);
      } catch(e) {
        select_self = _$Select_selfFromJson({});
        ret = false;
      }
      try {
        prime_fip = _$Prime_fipFromJson(jsonD['prime_fip']);
      } catch(e) {
        prime_fip = _$Prime_fipFromJson({});
        ret = false;
      }
      try {
        Edy_Connection = _$EEdy_ConnectionFromJson(jsonD['Edy_Connection']);
      } catch(e) {
        Edy_Connection = _$EEdy_ConnectionFromJson({});
        ret = false;
      }
      try {
        timeserver = _$TimeserverFromJson(jsonD['timeserver']);
      } catch(e) {
        timeserver = _$TimeserverFromJson({});
        ret = false;
      }
      try {
        fcon_version = _$Fcon_versionFromJson(jsonD['fcon_version']);
      } catch(e) {
        fcon_version = _$Fcon_versionFromJson({});
        ret = false;
      }
      try {
        MC_Connection = _$MMC_ConnectionFromJson(jsonD['MC_Connection']);
      } catch(e) {
        MC_Connection = _$MMC_ConnectionFromJson({});
        ret = false;
      }
      try {
        deccin_bkup = _$Deccin_bkupFromJson(jsonD['deccin_bkup']);
      } catch(e) {
        deccin_bkup = _$Deccin_bkupFromJson({});
        ret = false;
      }
      try {
        identifies = _$IdentifiesFromJson(jsonD['identifies']);
      } catch(e) {
        identifies = _$IdentifiesFromJson({});
        ret = false;
      }
      try {
        acx_flg = _$Acx_flgFromJson(jsonD['acx_flg']);
      } catch(e) {
        acx_flg = _$Acx_flgFromJson({});
        ret = false;
      }
      try {
        acx_timer = _$Acx_timerFromJson(jsonD['acx_timer']);
      } catch(e) {
        acx_timer = _$Acx_timerFromJson({});
        ret = false;
      }
      try {
        eventinput = _$EventinputFromJson(jsonD['eventinput']);
      } catch(e) {
        eventinput = _$EventinputFromJson({});
        ret = false;
      }
      try {
        acx_stop_info = _$Acx_stop_infoFromJson(jsonD['acx_stop_info']);
      } catch(e) {
        acx_stop_info = _$Acx_stop_infoFromJson({});
        ret = false;
      }
      try {
        scanner = _$ScannerFromJson(jsonD['scanner']);
      } catch(e) {
        scanner = _$ScannerFromJson({});
        ret = false;
      }
      try {
        CT3100_Connection = _$CCT3100_ConnectionFromJson(jsonD['CT3100_Connection']);
      } catch(e) {
        CT3100_Connection = _$CCT3100_ConnectionFromJson({});
        ret = false;
      }
      try {
        upd_chk = _$Upd_chkFromJson(jsonD['upd_chk']);
      } catch(e) {
        upd_chk = _$Upd_chkFromJson({});
        ret = false;
      }
      try {
        drugrev = _$DrugrevFromJson(jsonD['drugrev']);
      } catch(e) {
        drugrev = _$DrugrevFromJson({});
        ret = false;
      }
      try {
        center_server = _$Center_serverFromJson(jsonD['center_server']);
      } catch(e) {
        center_server = _$Center_serverFromJson({});
        ret = false;
      }
      try {
        print = _$PrintFromJson(jsonD['print']);
      } catch(e) {
        print = _$PrintFromJson({});
        ret = false;
      }
      try {
        stopn_retry = _$Stopn_retryFromJson(jsonD['stopn_retry']);
      } catch(e) {
        stopn_retry = _$Stopn_retryFromJson({});
        ret = false;
      }
      try {
        select_batrepo = _$Select_batrepoFromJson(jsonD['select_batrepo']);
      } catch(e) {
        select_batrepo = _$Select_batrepoFromJson({});
        ret = false;
      }
      try {
        ftp = _$FtpFromJson(jsonD['ftp']);
      } catch(e) {
        ftp = _$FtpFromJson({});
        ret = false;
      }
      try {
        movsend = _$MovsendFromJson(jsonD['movsend']);
      } catch(e) {
        movsend = _$MovsendFromJson({});
        ret = false;
      }
      try {
        disk_free = _$Disk_freeFromJson(jsonD['disk_free']);
      } catch(e) {
        disk_free = _$Disk_freeFromJson({});
        ret = false;
      }
      try {
        other = _$OtherFromJson(jsonD['other']);
      } catch(e) {
        other = _$OtherFromJson({});
        ret = false;
      }
      try {
        sqrc_sys = _$Sqrc_sysFromJson(jsonD['sqrc_sys']);
      } catch(e) {
        sqrc_sys = _$Sqrc_sysFromJson({});
        ret = false;
      }
      try {
        histlog_get = _$Histlog_getFromJson(jsonD['histlog_get']);
      } catch(e) {
        histlog_get = _$Histlog_getFromJson({});
        ret = false;
      }
      try {
        sims_cnct = _$Sims_cnctFromJson(jsonD['sims_cnct']);
      } catch(e) {
        sims_cnct = _$Sims_cnctFromJson({});
        ret = false;
      }
      try {
        step2_bar = _$Step2_barFromJson(jsonD['step2_bar']);
      } catch(e) {
        step2_bar = _$Step2_barFromJson({});
        ret = false;
      }
      try {
        tax_free = _$Tax_freeFromJson(jsonD['tax_free']);
      } catch(e) {
        tax_free = _$Tax_freeFromJson({});
        ret = false;
      }
      try {
        stcls = _$StclsFromJson(jsonD['stcls']);
      } catch(e) {
        stcls = _$StclsFromJson({});
        ret = false;
      }
      try {
        ticket = _$TicketFromJson(jsonD['ticket']);
      } catch(e) {
        ticket = _$TicketFromJson({});
        ret = false;
      }
      try {
        z_system = _$Z_systemFromJson(jsonD['z_system']);
      } catch(e) {
        z_system = _$Z_systemFromJson({});
        ret = false;
      }
      try {
        dpoint = _$DpointFromJson(jsonD['dpoint']);
      } catch(e) {
        dpoint = _$DpointFromJson({});
        ret = false;
      }
      try {
        tslnkweb_sys = _$Tslnkweb_sysFromJson(jsonD['tslnkweb_sys']);
      } catch(e) {
        tslnkweb_sys = _$Tslnkweb_sysFromJson({});
        ret = false;
      }
      try {
        coupon_off = _$Coupon_offFromJson(jsonD['coupon_off']);
      } catch(e) {
        coupon_off = _$Coupon_offFromJson({});
        ret = false;
      }
      try {
        scalerm = _$ScalermFromJson(jsonD['scalerm']);
      } catch(e) {
        scalerm = _$ScalermFromJson({});
        ret = false;
      }
      try {
        tax = _$TaxFromJson(jsonD['tax']);
      } catch(e) {
        tax = _$TaxFromJson({});
        ret = false;
      }
      try {
        leavegate = _$LeavegateFromJson(jsonD['leavegate']);
      } catch(e) {
        leavegate = _$LeavegateFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _System system = _System(
    macno                              : 0,
    crpno                              : 0,
    shpno                              : 0,
    wakeup_delay                       : 0,
    tenant                             : 0,
    serialno                           : 0,
    join_area_cd                       : 0,
    join_sub_area_cd                   : 0,
    comp_cd                            : 0,
    soc_timeout                        : 0,
    soc_timback                        : 0,
    kill_port                          : 0,
    vpn                                : 0,
    smart                              : 0,
    drugrev_timeout                    : 0,
    set_spec_no                        : 0,
    reg_cruising                       : 0,
    fip_connect                        : 0,
    fip_display                        : 0,
    ts_ver_mrg                         : 0,
    print_screen                       : 0,
    twoconnect                         : 0,
    custsw_cnct                        : 0,
    keytype_desk                       : 0,
    keytype_tower                      : 0,
    front_self_type                    : 0,
    font                               : 0,
    stcls_mode                         : 0,
    verifone_center_cnct               : 0,
    verifone_one_receipt               : 0,
    device_connect                     : 0,
  );

  _Mm_system mm_system = _Mm_system(
    mm_onoff                           : 0,
    mm_type                            : 0,
    add_total                          : 0,
    sc_cnct                            : 0,
    sc_adr                             : "",
    sc_port                            : 0,
    add_cust                           : 0,
    mente_port                         : 0,
    ej_txt_format                      : 0,
    ej_txt_make                        : 0,
    csvsend_cycle                      : 0,
    srvlog_save_date                   : 0,
    mupd_port                          : 0,
    mupd_cycle                         : 0,
    sgt_cf_wt                          : 0,
    sc_mente_port                      : 0,
    sc_port2                           : 0,
    sinq_timeout                       : 0,
    doc_fsck                           : 0,
    duty_dis                           : 0,
    clr_total                          : 0,
    clr_total_date                     : 0,
    reg_lrg_sum                        : 0,
  );

  _Logging logging = _Logging(
    UnlimitSize                        : "",
    LogSaveDate                        : 0,
    TranSaveDate                       : 0,
  );

  _Mac_addr mac_addr = _Mac_addr(
    m1                                 : "",
    m2                                 : "",
    s1                                 : "",
    s2                                 : "",
    s3                                 : "",
    fshare                             : "",
  );

  _Ip_addr ip_addr = _Ip_addr(
    m1                                 : "",
    m2                                 : "",
    s1                                 : "",
    s2                                 : "",
    s3                                 : "",
  );

  _Mac_no mac_no = _Mac_no(
    m1                                 : 0,
    m2                                 : 0,
    s1                                 : 0,
    s2                                 : 0,
    s3                                 : 0,
  );

  _Jnl_bkup jnl_bkup = _Jnl_bkup(
    jnl_bkup_knd                       : 0,
    jnl_bkup_week                      : 0,
    jnl_bkup_date                      : 0,
  );

  _Data_bkup data_bkup = _Data_bkup(
    data_bkup_knd                      : 0,
    data_bkup_week                     : 0,
    data_bkup_date                     : 0,
    data_bkup_generation               : 0,
    data_bkup_generation2              : 0,
  );

  _Csv_bkup csv_bkup = _Csv_bkup(
    Bakup                              : 0,
    data_knd                           : 0,
    timeout                            : 0,
    css_filename                       : 0,
    css_retry_count                    : 0,
    css_retry_time                     : 0,
    time_zone                          : 0,
    name_add                           : 0,
    lgyoumu                            : 0,
    ext_digit                          : 0,
    pasv                               : 0,
    lgyoumu_full                       : 0,
    netdoa_mbr                         : 0,
    css_fixed_length                   : 0,
    css_date_file                      : 0,
    netdoa_comp_ej                     : 0,
    css_usb_bkup                       : 0,
    css_ment_tran                      : 0,
    css_proxy_type_add                 : 0,
    ping_check                         : 0,
    text_resend                        : 0,
    css_igyoumu_make                   : 0,
    netdoa_opetime_send                : 0,
    nttb_item_cd_typ                   : 0,
  );

  _Csv_term csv_term = _Csv_term(
    reg_mly_deal                       : 0,
    regmlydeal_week                    : 0,
    regmlydeal_day                     : 0,
    reg_mly_mdl                        : 0,
    regmlymdl_week                     : 0,
    regmlymdl_day                      : 0,
    reg_mly_sml                        : 0,
    regmlysml_week                     : 0,
    regmlysml_day                      : 0,
    reg_mly_plu                        : 0,
    regmlyplu_week                     : 0,
    regmlyplu_day                      : 0,
    reg_mly_cat                        : 0,
    regmlycat_week                     : 0,
    regmlycat_day                      : 0,
    reg_sch_brgn                       : 0,
    regschbrgn_week                    : 0,
    regschbrgn_day                     : 0,
    reg_sch_mach                       : 0,
    regschmach_week                    : 0,
    regschmach_day                     : 0,
    reg_mly_cust                       : 0,
    regmlycust_week                    : 0,
    regmlycust_day                     : 0,
    reg_mly_zone                       : 0,
    regmlyzone_week                    : 0,
    regmlyzone_day                     : 0,
    reg_mly_svs                        : 0,
    regmlysvs_week                     : 0,
    regmlysvs_day                      : 0,
    reg_mly_fspplu                     : 0,
    regmlyfspplu_week                  : 0,
    regmlyfspplu_day                   : 0,
    reg_mly_fspsml                     : 0,
    regmlyfspsml_week                  : 0,
    regmlyfspsml_day                   : 0,
    reg_mly_fspmdl                     : 0,
    regmlyfspmdl_week                  : 0,
    regmlyfspmdl_day                   : 0,
    reg_mly_fspttl                     : 0,
    regmlyfspttl_week                  : 0,
    regmlyfspttl_day                   : 0,
    reg_mly_lrg                        : 0,
    regmlylrg_week                     : 0,
    regmlylrg_day                      : 0,
  );

  _Csv_prg csv_prg = _Csv_prg(
    mdl_cls_mst                        : 0,
    mdlcls_week                        : 0,
    mdlcls_day                         : 0,
    sml_cls_mst                        : 0,
    smlcls_week                        : 0,
    smlcls_day                         : 0,
    plu_mst                            : 0,
    plumst_week                        : 0,
    plumst_day                         : 0,
    cat_dsc_mst                        : 0,
    catdsc_week                        : 0,
    catdsc_day                         : 0,
    brgn_mst                           : 0,
    brgnmst_week                       : 0,
    brgnmst_day                        : 0,
    bdl_mst                            : 0,
    bdlmst_week                        : 0,
    bdlmst_day                         : 0,
    stm_mst                            : 0,
    stmmst_week                        : 0,
    stmmst_day                         : 0,
    staff_mst                          : 0,
    staffmst_week                      : 0,
    staffmst_day                       : 0,
    cust_mst                           : 0,
    custmst_week                       : 0,
    custmst_day                        : 0,
    zone_mst                           : 0,
    zonemst_week                       : 0,
    zonemst_day                        : 0,
    svs_mst                            : 0,
    svsmst_week                        : 0,
    svsmst_day                         : 0,
    fspsch_mst                         : 0,
    fspschmst_week                     : 0,
    fspschmst_day                      : 0,
    fspplan_plu                        : 0,
    fspplanplu_week                    : 0,
    fspplanplu_day                     : 0,
    fspplan_mdl                        : 0,
    fspplanmdl_week                    : 0,
    fspplanmdl_day                     : 0,
    fspplan_sml                        : 0,
    fspplansml_week                    : 0,
    fspplansml_day                     : 0,
    dly_trm                            : 0,
    dlytrm_week                        : 0,
    dlytrm_day                         : 0,
    dly_kopt                           : 0,
    dlykopt_week                       : 0,
    dlykopt_day                        : 0,
    dly_recmsg                         : 0,
    dlyrecmsg_week                     : 0,
    dlyrecmsg_day                      : 0,
    dly_preset                         : 0,
    dlypreset_week                     : 0,
    dlypreset_day                      : 0,
    dly_batrepo                        : 0,
    dlybatrepo_week                    : 0,
    dlybatrepo_day                     : 0,
    dly_img                            : 0,
    dlyimg_week                        : 0,
    dlyimg_day                         : 0,
    tax_mst                            : 0,
    tax_week                           : 0,
    tax_day                            : 0,
    ctrl_mst                           : 0,
    ctrl_week                          : 0,
    ctrl_day                           : 0,
    instre_mst                         : 0,
    instre_week                        : 0,
    instre_day                         : 0,
    mdlsch_mst                         : 0,
    mdlsch_week                        : 0,
    mdlsch_day                         : 0,
    smlsch_mst                         : 0,
    smlsch_week                        : 0,
    smlsch_day                         : 0,
    plusch_mst                         : 0,
    plusch_week                        : 0,
    plusch_day                         : 0,
    batprcchg_mst                      : 0,
    batprcchg_week                     : 0,
    batprcchg_day                      : 0,
    fipsch_mst                         : 0,
    fipsch_week                        : 0,
    fipsch_day                         : 0,
    anvkind_mst                        : 0,
    anvkind_week                       : 0,
    anvkind_day                        : 0,
    decrbt_mst                         : 0,
    decrbt_week                        : 0,
    decrbt_day                         : 0,
    zipcode_mst                        : 0,
    zipcode_week                       : 0,
    zipcode_day                        : 0,
    maker_mst                          : 0,
    maker_week                         : 0,
    maker_day                          : 0,
    mcard_mst                          : 0,
    mcard_week                         : 0,
    mcard_day                          : 0,
    reason_mst                         : 0,
    reason_week                        : 0,
    reason_day                         : 0,
  );

  _Csv_dly csv_dly = _Csv_dly(
    dly_deal                           : 0,
    dlydeal_week                       : 0,
    dlydeal_day                        : 0,
    dly_mdl                            : 0,
    dlymdl_week                        : 0,
    dlymdl_day                         : 0,
    dly_sml                            : 0,
    dlysml_week                        : 0,
    dlysml_day                         : 0,
    dly_plu                            : 0,
    dlyplu_week                        : 0,
    dlyplu_day                         : 0,
    dly_cat                            : 0,
    dlycat_week                        : 0,
    dlycatl_day                        : 0,
    dly_brgn                           : 0,
    dlybrgn_week                       : 0,
    dlybrgn_day                        : 0,
    dly_mach                           : 0,
    dlymach_week                       : 0,
    dlymach_day                        : 0,
    dly_crdt                           : 0,
    dlycrdt_week                       : 0,
    dlycrdt_day                        : 0,
    dly_tmp                            : 0,
    dlytmp_week                        : 0,
    dlytmp_day                         : 0,
    dly_prcchg                         : 0,
    dlyprcchgl_week                    : 0,
    dlyprcchg_day                      : 0,
    dly_itemlog                        : 0,
    dlyitemlog_week                    : 0,
    dlyitmlog_day                      : 0,
    dly_bdllog                         : 0,
    dlybdllog_week                     : 0,
    dlybdllog_day                      : 0,
    dly_stmlog                         : 0,
    dlystmlog_week                     : 0,
    dlystmlog_day                      : 0,
    dly_ttllog                         : 0,
    dlyttllog_week                     : 0,
    dlyttllog_day                      : 0,
    dly_ejlog                          : 0,
    dlyejlog_week                      : 0,
    dlyejlog_day                       : 0,
    dly_cust                           : 0,
    dlycust_week                       : 0,
    dlycust_day                        : 0,
    dly_zone                           : 0,
    dlyzone_week                       : 0,
    dlyzone_day                        : 0,
    dly_svs                            : 0,
    dlysvs_week                        : 0,
    dlysvs_day                         : 0,
    dly_fspplu                         : 0,
    dlyfspplu_week                     : 0,
    dlyfspplu_day                      : 0,
    dly_fspsml                         : 0,
    dlyfspsml_week                     : 0,
    dlyfspsml_day                      : 0,
    dly_fspmdl                         : 0,
    dlyfspmdl_week                     : 0,
    dlyfspmdl_day                      : 0,
    dly_fspttl                         : 0,
    dlyfspttl_week                     : 0,
    dlyfspttl_day                      : 0,
    histlog                            : 0,
    histlog_week                       : 0,
    histlog_day                        : 0,
    duty_log                           : 0,
    dutylog_week                       : 0,
    dutylog_day                        : 0,
    sims_log                           : 0,
    simslog_week                       : 0,
    simslog_day                        : 0,
    reserv_log                         : 0,
    reservlog_week                     : 0,
    reservlog_day                      : 0,
    z_receipt                          : 0,
    zreceipt_week                      : 0,
    zreceipt_day                       : 0,
    dly_lrg                            : 0,
    dlylrg_week                        : 0,
    dlylrg_day                         : 0,
    drawchk_cash_log                   : 0,
    drawchk_cash_log_week              : 0,
    drawchk_cash_log_day               : 0,
  );

  _Csv_tpr8100 csv_tpr8100 = _Csv_tpr8100(
    dly_plu_tpr8100                    : 0,
    dly_deal_tpr8100                   : 0,
    reg_dly_mly_mdl_tpr8100            : 0,
    ibaraki_tpr8100                    : 0,
  );

  _Sch_delete sch_delete = _Sch_delete(
    bgnsch_del_date                    : 0,
    mmsch_del_date                     : 0,
    smsch_del_date                     : 0,
    clssch_del_date                    : 0,
    plusch_del_date                    : 0,
    ej_txt_del_date                    : 0,
    csv_txt_del_date                   : 0,
    schmsg_del_date                    : 0,
    fipsch_del_date                    : 0,
    reserv_del_date                    : 0,
    custbkup_del_date                  : 0,
  );

  _Internal_flg internal_flg = _Internal_flg(
    mode                               : 0,
    auto_mode                          : 0,
    rct_onoff                          : 0,
    acr_onoff                          : 0,
    acr_cnct                           : 0,
    acr_errprn                         : 0,
    card_cnct                          : 0,
    acb_deccin                         : 0,
    rwt_cnct                           : 0,
    scale_cnct                         : 0,
    acb_select                         : 0,
    iis21_cnct                         : 0,
    mobile_cnct                        : 0,
    stpr_cnct                          : 0,
    netwlpr_cnct                       : 0,
    poppy_cnct                         : 0,
    tag_cnct                           : 0,
    auto_deccin                        : 0,
    s2pr_cnct                          : 0,
    pwrctrl_cnct                       : 0,
    catalinapr_cnct                    : 0,
    dish_cnct                          : 0,
    custrealsvr_cnct                   : 0,
    aivoice_cnct                       : 0,
    gcat_cnct                          : 0,
    suica_cnct                         : 0,
    mp1_cnct                           : 0,
    realitmsend_cnct                   : 0,
    gramx_cnct                         : 0,
    rfid_cnct                          : 0,
    soft_keyb                          : 0,
    keyb                               : 0,
    msg_flg                            : 0,
    multi_cnct                         : 0,
    jrem_cnct                          : 0,
    colordsp_cnct                      : 0,
    usbcam_cnct                        : 0,
    masr_cnct                          : 0,
    brainfl_cnct                       : 0,
    cat_jmups_twin_cnct                : 0,
    sqrc_ticket_cnct                   : 0,
    custrealsvr_pqs_new_send           : 0,
    sqrc_drlabel_no                    : 0,
    iccard_cnct                        : 0,
    ecs_mode                           : 0,
    colordsp_size                      : 0,
    usbcam_direction                   : 0,
    usbcam_disp                        : 0,
    apbf_cnct                          : 0,
    usbcam_disp_size                   : 0,
    exc_cnct                           : 0,
    hitouch_cnct                       : 0,
    snresult                           : 0,
    ami_cnct                           : 0,
    hs_scale_cnct                      : 0,
  );

  _Cat_timer cat_timer = _Cat_timer(
    cat_stat_timer                     : 0,
    cat_recv_timer                     : 0,
  );

  _Printer printer = _Printer(
    rct_spd                            : 0,
    rct_dns                            : 0,
    s2pr_topfeed                       : 0,
    s2pr_lineno                        : 0,
    rct_lf_plus                        : 0,
    rct_tb_cut                         : 0,
    rct_sp_width                       : 0,
    rct_cut_type                       : 0,
    rct_cut_type2                      : 0,
    err_rpr_timer                      : 0,
    nearend_check                      : 0,
    kitchen_prt_power                  : 0,
    zhq_cpn_rct_share                  : 0,
    nearend_note                       : 0,
    nearend_count                      : 0,
    hprt_fwver                         : 0,
  );

  _Printer_cntl printer_cntl = _Printer_cntl(
    recipt_wid                         : 0,
    prnt_length                        : 0,
    start_speed                        : 0,
    top_speed                          : 0,
    top_sp_step                        : 0,
    start_density                      : 0,
    top_density                        : 0,
    top_den_step                       : 0,
    prt_position                       : 0,
    head_wid                           : 0,
    prt_start_size                     : 0,
    err_mask                           : 0,
    x_offset                           : 0,
    recipt_wid80                       : 0,
  );

  _Printer_def printer_def = _Printer_def(
    rct_tspd_0                         : 0,
    rct_tspd_1                         : 0,
    rct_tspd_2                         : 0,
    rct_tspd_3                         : 0,
    rct_lspeed_dens0                   : 0,
    rct_lspeed_dens1                   : 0,
    rct_lspeed_dens2                   : 0,
    rct_lspeed_dens3                   : 0,
    rct_mspeed_dens0                   : 0,
    rct_mspeed_dens1                   : 0,
    rct_mspeed_dens2                   : 0,
    rct_mspeed_dens3                   : 0,
    rct_hmspeed_dens0                  : 0,
    rct_hmspeed_dens1                  : 0,
    rct_hmspeed_dens2                  : 0,
    rct_hmspeed_dens3                  : 0,
    rct_hspeed_dens0                   : 0,
    rct_hspeed_dens1                   : 0,
    rct_hspeed_dens2                   : 0,
    rct_hspeed_dens3                   : 0,
  );

  _Clerksave clerksave = _Clerksave(
    spoolend                           : 0,
  );

  _Printer_font printer_font = _Printer_font(
    fontname_j                         : "",
    fontname_e                         : "",
  );

  _Ups ups = _Ups(
    pfcheck                            : 0,
    pftime                             : 0,
    pfretry                            : 0,
    pftime2                            : 0,
    pfretry2                           : 0,
    pfmaxwait                          : 0,
    port                               : "",
    entry                              : "",
    entry2                             : "",
    port2                              : "",
  );

  _Doc doc = _Doc(
    update                             : 0,
  );

  _Mem_size_db5_M mem_size_db5_M = _Mem_size_db5_M(
    M1                                 : 0,
    M5                                 : 0,
    M10                                : 0,
  );

  _Mem_size_db5_S mem_size_db5_S = _Mem_size_db5_S(
    S1                                 : 0,
    S5                                 : 0,
    S10                                : 0,
  );

  _Mem_size_db6_M mem_size_db6_M = _Mem_size_db6_M(
    M1                                 : 0,
    M5                                 : 0,
    M10                                : 0,
    M15                                : 0,
  );

  _Mem_size_db6_S mem_size_db6_S = _Mem_size_db6_S(
    S1                                 : 0,
    S5                                 : 0,
    S10                                : 0,
    S15                                : 0,
  );

  _Tag_poppy tag_poppy = _Tag_poppy(
    poppy_print                        : 0,
    tag_print                          : 0,
  );

  _FFJ_FTP FJ_FTP = _FFJ_FTP(
    store_chd                          : 0,
  );

  _Select_self select_self = _Select_self(
    self_mode                          : 0,
    self_mac_mode                      : 0,
    assist_port                        : 0,
    reg_cruising_drct                  : 0,
    self_chart_output                  : 0,
    select_dspmode                     : 0,
    qs_auto_reboot                     : 0,
    self_regbag1_plucd                 : 0,
    self_regbag2_plucd                 : 0,
    self_regbag3_plucd                 : 0,
    self_separate_in_scl               : 0,
    qc_mode                            : 0,
    selfmactyp                         : 0,
    self_scan_typ                      : 0,
    self_stre_typ                      : 0,
    hs_start_mode                      : 0,
    psensor_scan_swing                 : 0,
    psensor_swing_notice               : 0,
    psensor_scan_slow                  : 0,
    psensor_slow_notice                : 0,
    psensor_scan_slowtime              : 0,
    psensor_scan_away                  : 0,
    psensor_away_notice                : 0,
    psensor_scan_awaytime              : 0,
    psensor_disptime                   : 0,
    psensor_notice                     : 0,
    kpi_hs_mode                        : 0,
    psensor_swing_cnt                  : 0,
    psensor_scan_slow_sound            : 0,
    psensor_away_sound                 : 0,
    leave_qr_mode                      : 0,
    aibox_select_mode                  : 0,
    psensor_position                   : 0,
    leave_qr_prn_ptn                   : 0,
  );

  _Prime_fip prime_fip = _Prime_fip(
    prime_fip                          : 0,
  );

  _EEdy_Connection Edy_Connection = _EEdy_Connection(
    edy_retry_timeout                  : 0,
    edy_connect_timeout                : 0,
  );

  _Timeserver timeserver = _Timeserver(
    timeserver                         : 0,
  );

  _Fcon_version fcon_version = _Fcon_version(
    scpu1                              : "",
    scpu2                              : "",
    printer                            : "",
    printer2                           : "",
  );

  _MMC_Connection MC_Connection = _MMC_Connection(
    mc_tenant_cd                       : 0,
  );

  _Deccin_bkup deccin_bkup = _Deccin_bkup(
    bkup_auto_deccin                   : 0,
    bkup_acb_deccin                    : 0,
    bkup_acr_onoff                     : 0,
    bkup_acb_onoff                     : 0,
  );

  _Identifies identifies = _Identifies(
    identifies_cd                      : "",
    identifies_cd1                     : "",
    identifies_cd2                     : "",
    identifies_cd3                     : "",
    identifies_cd4                     : "",
    identifies_cd5                     : "",
    identifies_cd6                     : "",
    identifies_cd7                     : "",
    identifies_cd8                     : "",
  );

  _Acx_flg acx_flg = _Acx_flg(
    acr50_ssw14_0                      : 0,
    acr50_ssw14_1_2                    : 0,
    acr50_ssw14_3_4                    : 0,
    acr50_ssw14_5                      : 0,
    acr50_ssw14_7                      : 0,
    pick_end                           : 0,
    acxreal_system                     : 0,
    ecs_pick_positn10000               : 0,
    ecs_pick_positn5000                : 0,
    ecs_pick_positn2000                : 0,
    ecs_pick_positn1000                : 0,
    acx_pick_data10000                 : 0,
    acx_pick_data5000                  : 0,
    acx_pick_data2000                  : 0,
    acx_pick_data1000                  : 0,
    acx_pick_data500                   : 0,
    acx_pick_data100                   : 0,
    acx_pick_data50                    : 0,
    acx_pick_data10                    : 0,
    acx_pick_data5                     : 0,
    acx_pick_data1                     : 0,
    ecs_recalc_reject                  : 0,
    sst1_error_disp                    : 0,
    sst1_cin_retry                     : 0,
    acx_resv_min5000                   : 0,
    acx_resv_min2000                   : 0,
    acx_resv_min1000                   : 0,
    acx_resv_min500                    : 0,
    acx_resv_min100                    : 0,
    acx_resv_min50                     : 0,
    acx_resv_min10                     : 0,
    acx_resv_min5                      : 0,
    acx_resv_min1                      : 0,
    acb50_ssw13_0                      : 0,
    acb50_ssw13_1_2                    : 0,
    acb50_ssw13_3_4                    : 0,
    acb50_ssw13_5                      : 0,
    acb50_ssw13_6                      : 0,
    chgdrw_inout_tran                  : 0,
    chgdrw_loan_tran                   : 0,
    acb50_ssw15_0                      : 0,
    acb50_ssw15_1                      : 0,
    acb50_ssw15_2                      : 0,
    acb50_ssw15_3                      : 0,
    acb50_ssw24_0                      : 0,
    ecs_gpd_1_1                        : 0,
    ecs_gpd_1_2                        : 0,
    ecs_gpd_2_1                        : 0,
    ecs_gpd_2_2                        : 0,
    ecs_gpd_3_1                        : 0,
    ecs_gpd_3_2                        : 0,
    ecs_gpd_4_1                        : 0,
    ecs_gpd_5_1                        : 0,
    ecs_gpd_5_2                        : 0,
    ecs_gpd_5_3                        : 0,
    chgdrw_in_tran_cd                  : 0,
    chgdrw_out_tran_cd                 : 0,
    acx_nearfull_diff                  : 0,
    ecs_pick_flg                       : "",
    acx_pick_cbillkind                 : "",
    acb50_ssw50_0_1                    : 0,
    acb50_ssw50_2                      : 0,
    acb50_ssw50_3                      : 0,
    acb50_ssw50_4_5                    : 0,
    acb50_ssw50_6_7                    : 0,
    acb_control_mode                   : 0,
    acx_resv_drw                       : 0,
    acx_resv_drw500                    : 0,
    acx_resv_drw100                    : 0,
    acx_resv_drw50                     : 0,
    acx_resv_drw10                     : 0,
    acx_resv_drw5                      : 0,
    acx_resv_drw1                      : 0,
    acx_auto_stop_sec                  : 0,
    ecs_gp2_3_2                        : 0,
    ecs_gp2_4_1                        : 0,
    ecs_gp2_4_2                        : 0,
    ecs_gp2_5_1                        : 0,
    ecs_gp7_1_1                        : 0,
    ecs_gp7_1_2                        : 0,
    ecs_gp7_1_3                        : 0,
    ecs_gp7_2_1                        : 0,
    ecs_gp7_2_2                        : 0,
    ecs_gp7_3_1                        : 0,
    ecs_gp7_4_1                        : 0,
    ecs_gp7_5_1                        : 0,
    ecs_gp7_5_2                        : 0,
    ecs_gpb_1_1                        : 0,
    ecs_gpb_2_1                        : 0,
    ecs_gpb_2_2                        : 0,
    ecs_gpb_2_3                        : 0,
    ecs_gpb_3_1                        : 0,
    ecs_gpb_3_2                        : 0,
    ecs_gpb_4_2                        : 0,
    ecs_gpb_4_3                        : 0,
    ecs_gpb_5_1                        : 0,
    ecs_gpb_5_2                        : 0,
    ecs_gpc_3_1_fwdl                   : 0,
    ecs_overflowpick_use               : 0,
  );

  _Acx_timer acx_timer = _Acx_timer(
    acx_enq_interval                   : 0,
    acx_enq_timeout                    : 0,
    acxreal_interval                   : 0,
  );

  _Eventinput eventinput = _Eventinput(
    event_cd                           : "",
    logo_cd                            : "",
    event_hall                         : 0,
  );

  _Acx_stop_info acx_stop_info = _Acx_stop_info(
    acx_stop_5000                      : 0,
    acx_stop_2000                      : 0,
    acx_stop_1000                      : 0,
    acx_stop_500                       : 0,
    acx_stop_100                       : 0,
    acx_stop_50                        : 0,
    acx_stop_10                        : 0,
    acx_stop_5                         : 0,
    acx_stop_1                         : 0,
  );

  _Scanner scanner = _Scanner(
    scn_cmd_desktop                    : 0,
    scn_cmd_tower                      : 0,
    scn_cmd_add                        : 0,
    scan_dp_snd_desktop                : 0,
    scan_dp_snd_tower                  : 0,
    scan_dp_snd_add                    : 0,
    scan_happyself_2nd                 : 0,
    scan_display_mode                  : 0,
    scan_barcode_payment               : 0,
    beep_times                         : 0,
    beep_interval                      : 0,
  );

  _CCT3100_Connection CT3100_Connection = _CCT3100_Connection(
    ct3100_waite_time                  : 0,
    ct3100_point_type                  : 0,
  );

  _Upd_chk upd_chk = _Upd_chk(
    upd_err_rbt                        : 0,
    timeout                            : 0,
  );

  _Drugrev drugrev = _Drugrev(
    name                               : "",
  );

  _Center_server center_server = _Center_server(
    hist_cycle                         : 0,
    stcls_send                         : 0,
    bult_send                          : 0,
    tslnkweb_timeout                   : 0,
    pmod_dspmode                       : 0,
  );

  _Print print = _Print(
  );

  _Stopn_retry stopn_retry = _Stopn_retry(
    retry_cnt                          : 0,
    retry_inter                        : 0,
    cls_downset                        : 0,
    cls_downtime                       : "",
  );

  _Select_batrepo select_batrepo = _Select_batrepo(
    batch_no1                          : 0,
    batch_no2                          : 0,
    batch_no3                          : 0,
    batch_no4                          : 0,
    batch_no5                          : 0,
    batch_no6                          : 0,
    batch_no7                          : 0,
    batch_no8                          : 0,
    batch_no9                          : 0,
  );

  _Ftp ftp = _Ftp(
    rpm_timeout                        : 0,
    rpm_retry                          : 0,
    landisk_timeout                    : 0,
    landisk_retry                      : 0,
    mcput_timeout                      : 0,
    mcput_retry                        : 0,
    mcget_timeout                      : 0,
    mcget_retry                        : 0,
    void_timeout                       : 0,
    void_retry                         : 0,
    hqput_timeout                      : 0,
    hqput_retry                        : 0,
    offset_speed                       : 0,
    error_timeout                      : 0,
    offset_timeout                     : 0,
    default_timeout                    : 0,
  );

  _Movsend movsend = _Movsend(
    avispace                           : 0,
    send_speed2                        : 0,
    extend_time                        : 0,
    taking_start                       : 0,
    usbcam_send                        : 0,
  );

  _Disk_free disk_free = _Disk_free(
    limit_size                         : 0,
    stat                               : 0,
  );

  _Other other = _Other(
    ut1_wait                           : 0,
    multi_vega_env                     : 0,
    quo_useup_flg                      : 0,
    jpqr_err_nonprint                  : 0,
  );

  _Sqrc_sys sqrc_sys = _Sqrc_sys(
    sqrc_back_timer                    : 0,
  );

  _Histlog_get histlog_get = _Histlog_get(
    histlog_get_change                 : 0,
  );

  _Sims_cnct sims_cnct = _Sims_cnct(
    cls_wait_time                      : 0,
  );

  _Step2_bar step2_bar = _Step2_bar(
    step2_bar_order                    : 0,
  );

  _Tax_free tax_free = _Tax_free(
    tax_free_add                       : 0,
  );

  _Stcls stcls = _Stcls(
    tran_interval                      : 0,
  );

  _Ticket ticket = _Ticket(
    ticket_cnt                         : 0,
  );

  _Z_system z_system = _Z_system(
    z_demo_mode                        : 0,
  );

  _Dpoint dpoint = _Dpoint(
    client                             : "",
    branch                             : 0,
    store                              : 0,
    srvdate                            : "",
    backup_macno                       : 0,
  );

  _Tslnkweb_sys tslnkweb_sys = _Tslnkweb_sys(
    mkttl_timeout                      : 0,
  );

  _Coupon_off coupon_off = _Coupon_off(
    coupon_off_flg                     : 0,
  );

  _Scalerm scalerm = _Scalerm(
    over_plu_tare                      : 0,
    tare_auto_clear                    : 0,
    ad_res_watch                       : 0,
  );

  _Tax tax = _Tax(
    realitmsend_add                    : 0,
  );

  _Leavegate leavegate = _Leavegate(
    leave_ip01                         : "",
    leave_port01                       : 0,
  );
}

@JsonSerializable()
class _System {
  factory _System.fromJson(Map<String, dynamic> json) => _$SystemFromJson(json);
  Map<String, dynamic> toJson() => _$SystemToJson(this);

  _System({
    required this.macno,
    required this.crpno,
    required this.shpno,
    required this.wakeup_delay,
    required this.tenant,
    required this.serialno,
    required this.join_area_cd,
    required this.join_sub_area_cd,
    required this.comp_cd,
    required this.soc_timeout,
    required this.soc_timback,
    required this.kill_port,
    required this.vpn,
    required this.smart,
    required this.drugrev_timeout,
    required this.set_spec_no,
    required this.reg_cruising,
    required this.fip_connect,
    required this.fip_display,
    required this.ts_ver_mrg,
    required this.print_screen,
    required this.twoconnect,
    required this.custsw_cnct,
    required this.keytype_desk,
    required this.keytype_tower,
    required this.front_self_type,
    required this.font,
    required this.stcls_mode,
    required this.verifone_center_cnct,
    required this.verifone_one_receipt,
    required this.device_connect,
  });

  @JsonKey(defaultValue: 1)
  int    macno;
  @JsonKey(defaultValue: 1)
  int    crpno;
  @JsonKey(defaultValue: 1)
  int    shpno;
  @JsonKey(defaultValue: 2)
  int    wakeup_delay;
  @JsonKey(defaultValue: 0)
  int    tenant;
  @JsonKey(defaultValue: 1)
  int    serialno;
  @JsonKey(defaultValue: 0)
  int    join_area_cd;
  @JsonKey(defaultValue: 0)
  int    join_sub_area_cd;
  @JsonKey(defaultValue: 1)
  int    comp_cd;
  @JsonKey(defaultValue: 5)
  int    soc_timeout;
  @JsonKey(defaultValue: 5)
  int    soc_timback;
  @JsonKey(defaultValue: 9734)
  int    kill_port;
  @JsonKey(defaultValue: 0)
  int    vpn;
  @JsonKey(defaultValue: 0)
  int    smart;
  @JsonKey(defaultValue: 300)
  int    drugrev_timeout;
  @JsonKey(defaultValue: 0)
  int    set_spec_no;
  @JsonKey(defaultValue: 0)
  int    reg_cruising;
  @JsonKey(defaultValue: 0)
  int    fip_connect;
  @JsonKey(defaultValue: 0)
  int    fip_display;
  @JsonKey(defaultValue: 0)
  int    ts_ver_mrg;
  @JsonKey(defaultValue: 0)
  int    print_screen;
  @JsonKey(defaultValue: 0)
  int    twoconnect;
  @JsonKey(defaultValue: 0)
  int    custsw_cnct;
  @JsonKey(defaultValue: 0)
  int    keytype_desk;
  @JsonKey(defaultValue: 0)
  int    keytype_tower;
  @JsonKey(defaultValue: 0)
  int    front_self_type;
  @JsonKey(defaultValue: 0)
  int    font;
  @JsonKey(defaultValue: 0)
  int    stcls_mode;
  @JsonKey(defaultValue: 0)
  int    verifone_center_cnct;
  @JsonKey(defaultValue: 0)
  int    verifone_one_receipt;
  @JsonKey(defaultValue: 0)
  int    device_connect;
}

@JsonSerializable()
class _Mm_system {
  factory _Mm_system.fromJson(Map<String, dynamic> json) => _$Mm_systemFromJson(json);
  Map<String, dynamic> toJson() => _$Mm_systemToJson(this);

  _Mm_system({
    required this.mm_onoff,
    required this.mm_type,
    required this.add_total,
    required this.sc_cnct,
    required this.sc_adr,
    required this.sc_port,
    required this.add_cust,
    required this.mente_port,
    required this.ej_txt_format,
    required this.ej_txt_make,
    required this.csvsend_cycle,
    required this.srvlog_save_date,
    required this.mupd_port,
    required this.mupd_cycle,
    required this.sgt_cf_wt,
    required this.sc_mente_port,
    required this.sc_port2,
    required this.sinq_timeout,
    required this.doc_fsck,
    required this.duty_dis,
    required this.clr_total,
    required this.clr_total_date,
    required this.reg_lrg_sum,
  });

  @JsonKey(defaultValue: 0)
  int    mm_onoff;
  @JsonKey(defaultValue: 0)
  int    mm_type;
  @JsonKey(defaultValue: 0)
  int    add_total;
  @JsonKey(defaultValue: 0)
  int    sc_cnct;
  @JsonKey(defaultValue: "0.0.0.0")
  String sc_adr;
  @JsonKey(defaultValue: 9736)
  int    sc_port;
  @JsonKey(defaultValue: 0)
  int    add_cust;
  @JsonKey(defaultValue: 9738)
  int    mente_port;
  @JsonKey(defaultValue: 0)
  int    ej_txt_format;
  @JsonKey(defaultValue: 0)
  int    ej_txt_make;
  @JsonKey(defaultValue: 60)
  int    csvsend_cycle;
  @JsonKey(defaultValue: 7)
  int    srvlog_save_date;
  @JsonKey(defaultValue: 9750)
  int    mupd_port;
  @JsonKey(defaultValue: 10)
  int    mupd_cycle;
  @JsonKey(defaultValue: 0)
  int    sgt_cf_wt;
  @JsonKey(defaultValue: 9740)
  int    sc_mente_port;
  @JsonKey(defaultValue: 9737)
  int    sc_port2;
  @JsonKey(defaultValue: 5)
  int    sinq_timeout;
  @JsonKey(defaultValue: 0)
  int    doc_fsck;
  @JsonKey(defaultValue: 0)
  int    duty_dis;
  @JsonKey(defaultValue: 0)
  int    clr_total;
  @JsonKey(defaultValue: 1)
  int    clr_total_date;
  @JsonKey(defaultValue: 0)
  int    reg_lrg_sum;
}

@JsonSerializable()
class _Logging {
  factory _Logging.fromJson(Map<String, dynamic> json) => _$LoggingFromJson(json);
  Map<String, dynamic> toJson() => _$LoggingToJson(this);

  _Logging({
    required this.UnlimitSize,
    required this.LogSaveDate,
    required this.TranSaveDate,
  });

  @JsonKey(defaultValue: "yes")
  String UnlimitSize;
  @JsonKey(defaultValue: 30)
  int    LogSaveDate;
  @JsonKey(defaultValue: 30)
  int    TranSaveDate;
}

@JsonSerializable()
class _Mac_addr {
  factory _Mac_addr.fromJson(Map<String, dynamic> json) => _$Mac_addrFromJson(json);
  Map<String, dynamic> toJson() => _$Mac_addrToJson(this);

  _Mac_addr({
    required this.m1,
    required this.m2,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.fshare,
  });

  @JsonKey(defaultValue: "00:00:00:00:00:00")
  String m1;
  @JsonKey(defaultValue: "00:00:00:00:00:00")
  String m2;
  @JsonKey(defaultValue: "00:00:00:00:00:00")
  String s1;
  @JsonKey(defaultValue: "00:00:00:00:00:00")
  String s2;
  @JsonKey(defaultValue: "00:00:00:00:00:00")
  String s3;
  @JsonKey(defaultValue: "00:00:00:00:00:00")
  String fshare;
}

@JsonSerializable()
class _Ip_addr {
  factory _Ip_addr.fromJson(Map<String, dynamic> json) => _$Ip_addrFromJson(json);
  Map<String, dynamic> toJson() => _$Ip_addrToJson(this);

  _Ip_addr({
    required this.m1,
    required this.m2,
    required this.s1,
    required this.s2,
    required this.s3,
  });

  @JsonKey(defaultValue: "0.0.0.0")
  String m1;
  @JsonKey(defaultValue: "0.0.0.0")
  String m2;
  @JsonKey(defaultValue: "0.0.0.0")
  String s1;
  @JsonKey(defaultValue: "0.0.0.0")
  String s2;
  @JsonKey(defaultValue: "0.0.0.0")
  String s3;
}

@JsonSerializable()
class _Mac_no {
  factory _Mac_no.fromJson(Map<String, dynamic> json) => _$Mac_noFromJson(json);
  Map<String, dynamic> toJson() => _$Mac_noToJson(this);

  _Mac_no({
    required this.m1,
    required this.m2,
    required this.s1,
    required this.s2,
    required this.s3,
  });

  @JsonKey(defaultValue: 1)
  int    m1;
  @JsonKey(defaultValue: 2)
  int    m2;
  @JsonKey(defaultValue: 1)
  int    s1;
  @JsonKey(defaultValue: 2)
  int    s2;
  @JsonKey(defaultValue: 3)
  int    s3;
}

@JsonSerializable()
class _Jnl_bkup {
  factory _Jnl_bkup.fromJson(Map<String, dynamic> json) => _$Jnl_bkupFromJson(json);
  Map<String, dynamic> toJson() => _$Jnl_bkupToJson(this);

  _Jnl_bkup({
    required this.jnl_bkup_knd,
    required this.jnl_bkup_week,
    required this.jnl_bkup_date,
  });

  @JsonKey(defaultValue: 0)
  int    jnl_bkup_knd;
  @JsonKey(defaultValue: 0)
  int    jnl_bkup_week;
  @JsonKey(defaultValue: 1)
  int    jnl_bkup_date;
}

@JsonSerializable()
class _Data_bkup {
  factory _Data_bkup.fromJson(Map<String, dynamic> json) => _$Data_bkupFromJson(json);
  Map<String, dynamic> toJson() => _$Data_bkupToJson(this);

  _Data_bkup({
    required this.data_bkup_knd,
    required this.data_bkup_week,
    required this.data_bkup_date,
    required this.data_bkup_generation,
    required this.data_bkup_generation2,
  });

  @JsonKey(defaultValue: 0)
  int    data_bkup_knd;
  @JsonKey(defaultValue: 0)
  int    data_bkup_week;
  @JsonKey(defaultValue: 1)
  int    data_bkup_date;
  @JsonKey(defaultValue: 7)
  int    data_bkup_generation;
  @JsonKey(defaultValue: 3)
  int    data_bkup_generation2;
}

@JsonSerializable()
class _Csv_bkup {
  factory _Csv_bkup.fromJson(Map<String, dynamic> json) => _$Csv_bkupFromJson(json);
  Map<String, dynamic> toJson() => _$Csv_bkupToJson(this);

  _Csv_bkup({
    required this.Bakup,
    required this.data_knd,
    required this.timeout,
    required this.css_filename,
    required this.css_retry_count,
    required this.css_retry_time,
    required this.time_zone,
    required this.name_add,
    required this.lgyoumu,
    required this.ext_digit,
    required this.pasv,
    required this.lgyoumu_full,
    required this.netdoa_mbr,
    required this.css_fixed_length,
    required this.css_date_file,
    required this.netdoa_comp_ej,
    required this.css_usb_bkup,
    required this.css_ment_tran,
    required this.css_proxy_type_add,
    required this.ping_check,
    required this.text_resend,
    required this.css_igyoumu_make,
    required this.netdoa_opetime_send,
    required this.nttb_item_cd_typ,
  });

  @JsonKey(defaultValue: 0)
  int    Bakup;
  @JsonKey(defaultValue: 2)
  int    data_knd;
  @JsonKey(defaultValue: 10)
  int    timeout;
  @JsonKey(defaultValue: 0)
  int    css_filename;
  @JsonKey(defaultValue: 0)
  int    css_retry_count;
  @JsonKey(defaultValue: 5)
  int    css_retry_time;
  @JsonKey(defaultValue: 0)
  int    time_zone;
  @JsonKey(defaultValue: 1)
  int    name_add;
  @JsonKey(defaultValue: 0)
  int    lgyoumu;
  @JsonKey(defaultValue: 0)
  int    ext_digit;
  @JsonKey(defaultValue: 0)
  int    pasv;
  @JsonKey(defaultValue: 0)
  int    lgyoumu_full;
  @JsonKey(defaultValue: 0)
  int    netdoa_mbr;
  @JsonKey(defaultValue: 0)
  int    css_fixed_length;
  @JsonKey(defaultValue: 0)
  int    css_date_file;
  @JsonKey(defaultValue: 0)
  int    netdoa_comp_ej;
  @JsonKey(defaultValue: 0)
  int    css_usb_bkup;
  @JsonKey(defaultValue: 0)
  int    css_ment_tran;
  @JsonKey(defaultValue: 1)
  int    css_proxy_type_add;
  @JsonKey(defaultValue: 1)
  int    ping_check;
  @JsonKey(defaultValue: 0)
  int    text_resend;
  @JsonKey(defaultValue: 0)
  int    css_igyoumu_make;
  @JsonKey(defaultValue: 0)
  int    netdoa_opetime_send;
  @JsonKey(defaultValue: 0)
  int    nttb_item_cd_typ;
}

@JsonSerializable()
class _Csv_term {
  factory _Csv_term.fromJson(Map<String, dynamic> json) => _$Csv_termFromJson(json);
  Map<String, dynamic> toJson() => _$Csv_termToJson(this);

  _Csv_term({
    required this.reg_mly_deal,
    required this.regmlydeal_week,
    required this.regmlydeal_day,
    required this.reg_mly_mdl,
    required this.regmlymdl_week,
    required this.regmlymdl_day,
    required this.reg_mly_sml,
    required this.regmlysml_week,
    required this.regmlysml_day,
    required this.reg_mly_plu,
    required this.regmlyplu_week,
    required this.regmlyplu_day,
    required this.reg_mly_cat,
    required this.regmlycat_week,
    required this.regmlycat_day,
    required this.reg_sch_brgn,
    required this.regschbrgn_week,
    required this.regschbrgn_day,
    required this.reg_sch_mach,
    required this.regschmach_week,
    required this.regschmach_day,
    required this.reg_mly_cust,
    required this.regmlycust_week,
    required this.regmlycust_day,
    required this.reg_mly_zone,
    required this.regmlyzone_week,
    required this.regmlyzone_day,
    required this.reg_mly_svs,
    required this.regmlysvs_week,
    required this.regmlysvs_day,
    required this.reg_mly_fspplu,
    required this.regmlyfspplu_week,
    required this.regmlyfspplu_day,
    required this.reg_mly_fspsml,
    required this.regmlyfspsml_week,
    required this.regmlyfspsml_day,
    required this.reg_mly_fspmdl,
    required this.regmlyfspmdl_week,
    required this.regmlyfspmdl_day,
    required this.reg_mly_fspttl,
    required this.regmlyfspttl_week,
    required this.regmlyfspttl_day,
    required this.reg_mly_lrg,
    required this.regmlylrg_week,
    required this.regmlylrg_day,
  });

  @JsonKey(defaultValue: 0)
  int    reg_mly_deal;
  @JsonKey(defaultValue: 0)
  int    regmlydeal_week;
  @JsonKey(defaultValue: 1)
  int    regmlydeal_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_mdl;
  @JsonKey(defaultValue: 0)
  int    regmlymdl_week;
  @JsonKey(defaultValue: 1)
  int    regmlymdl_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_sml;
  @JsonKey(defaultValue: 0)
  int    regmlysml_week;
  @JsonKey(defaultValue: 1)
  int    regmlysml_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_plu;
  @JsonKey(defaultValue: 0)
  int    regmlyplu_week;
  @JsonKey(defaultValue: 1)
  int    regmlyplu_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_cat;
  @JsonKey(defaultValue: 0)
  int    regmlycat_week;
  @JsonKey(defaultValue: 1)
  int    regmlycat_day;
  @JsonKey(defaultValue: 0)
  int    reg_sch_brgn;
  @JsonKey(defaultValue: 0)
  int    regschbrgn_week;
  @JsonKey(defaultValue: 1)
  int    regschbrgn_day;
  @JsonKey(defaultValue: 0)
  int    reg_sch_mach;
  @JsonKey(defaultValue: 0)
  int    regschmach_week;
  @JsonKey(defaultValue: 1)
  int    regschmach_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_cust;
  @JsonKey(defaultValue: 0)
  int    regmlycust_week;
  @JsonKey(defaultValue: 1)
  int    regmlycust_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_zone;
  @JsonKey(defaultValue: 0)
  int    regmlyzone_week;
  @JsonKey(defaultValue: 1)
  int    regmlyzone_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_svs;
  @JsonKey(defaultValue: 0)
  int    regmlysvs_week;
  @JsonKey(defaultValue: 1)
  int    regmlysvs_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_fspplu;
  @JsonKey(defaultValue: 0)
  int    regmlyfspplu_week;
  @JsonKey(defaultValue: 1)
  int    regmlyfspplu_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_fspsml;
  @JsonKey(defaultValue: 0)
  int    regmlyfspsml_week;
  @JsonKey(defaultValue: 1)
  int    regmlyfspsml_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_fspmdl;
  @JsonKey(defaultValue: 0)
  int    regmlyfspmdl_week;
  @JsonKey(defaultValue: 1)
  int    regmlyfspmdl_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_fspttl;
  @JsonKey(defaultValue: 0)
  int    regmlyfspttl_week;
  @JsonKey(defaultValue: 1)
  int    regmlyfspttl_day;
  @JsonKey(defaultValue: 0)
  int    reg_mly_lrg;
  @JsonKey(defaultValue: 0)
  int    regmlylrg_week;
  @JsonKey(defaultValue: 1)
  int    regmlylrg_day;
}

@JsonSerializable()
class _Csv_prg {
  factory _Csv_prg.fromJson(Map<String, dynamic> json) => _$Csv_prgFromJson(json);
  Map<String, dynamic> toJson() => _$Csv_prgToJson(this);

  _Csv_prg({
    required this.mdl_cls_mst,
    required this.mdlcls_week,
    required this.mdlcls_day,
    required this.sml_cls_mst,
    required this.smlcls_week,
    required this.smlcls_day,
    required this.plu_mst,
    required this.plumst_week,
    required this.plumst_day,
    required this.cat_dsc_mst,
    required this.catdsc_week,
    required this.catdsc_day,
    required this.brgn_mst,
    required this.brgnmst_week,
    required this.brgnmst_day,
    required this.bdl_mst,
    required this.bdlmst_week,
    required this.bdlmst_day,
    required this.stm_mst,
    required this.stmmst_week,
    required this.stmmst_day,
    required this.staff_mst,
    required this.staffmst_week,
    required this.staffmst_day,
    required this.cust_mst,
    required this.custmst_week,
    required this.custmst_day,
    required this.zone_mst,
    required this.zonemst_week,
    required this.zonemst_day,
    required this.svs_mst,
    required this.svsmst_week,
    required this.svsmst_day,
    required this.fspsch_mst,
    required this.fspschmst_week,
    required this.fspschmst_day,
    required this.fspplan_plu,
    required this.fspplanplu_week,
    required this.fspplanplu_day,
    required this.fspplan_mdl,
    required this.fspplanmdl_week,
    required this.fspplanmdl_day,
    required this.fspplan_sml,
    required this.fspplansml_week,
    required this.fspplansml_day,
    required this.dly_trm,
    required this.dlytrm_week,
    required this.dlytrm_day,
    required this.dly_kopt,
    required this.dlykopt_week,
    required this.dlykopt_day,
    required this.dly_recmsg,
    required this.dlyrecmsg_week,
    required this.dlyrecmsg_day,
    required this.dly_preset,
    required this.dlypreset_week,
    required this.dlypreset_day,
    required this.dly_batrepo,
    required this.dlybatrepo_week,
    required this.dlybatrepo_day,
    required this.dly_img,
    required this.dlyimg_week,
    required this.dlyimg_day,
    required this.tax_mst,
    required this.tax_week,
    required this.tax_day,
    required this.ctrl_mst,
    required this.ctrl_week,
    required this.ctrl_day,
    required this.instre_mst,
    required this.instre_week,
    required this.instre_day,
    required this.mdlsch_mst,
    required this.mdlsch_week,
    required this.mdlsch_day,
    required this.smlsch_mst,
    required this.smlsch_week,
    required this.smlsch_day,
    required this.plusch_mst,
    required this.plusch_week,
    required this.plusch_day,
    required this.batprcchg_mst,
    required this.batprcchg_week,
    required this.batprcchg_day,
    required this.fipsch_mst,
    required this.fipsch_week,
    required this.fipsch_day,
    required this.anvkind_mst,
    required this.anvkind_week,
    required this.anvkind_day,
    required this.decrbt_mst,
    required this.decrbt_week,
    required this.decrbt_day,
    required this.zipcode_mst,
    required this.zipcode_week,
    required this.zipcode_day,
    required this.maker_mst,
    required this.maker_week,
    required this.maker_day,
    required this.mcard_mst,
    required this.mcard_week,
    required this.mcard_day,
    required this.reason_mst,
    required this.reason_week,
    required this.reason_day,
  });

  @JsonKey(defaultValue: 0)
  int    mdl_cls_mst;
  @JsonKey(defaultValue: 0)
  int    mdlcls_week;
  @JsonKey(defaultValue: 1)
  int    mdlcls_day;
  @JsonKey(defaultValue: 0)
  int    sml_cls_mst;
  @JsonKey(defaultValue: 0)
  int    smlcls_week;
  @JsonKey(defaultValue: 1)
  int    smlcls_day;
  @JsonKey(defaultValue: 0)
  int    plu_mst;
  @JsonKey(defaultValue: 0)
  int    plumst_week;
  @JsonKey(defaultValue: 1)
  int    plumst_day;
  @JsonKey(defaultValue: 0)
  int    cat_dsc_mst;
  @JsonKey(defaultValue: 0)
  int    catdsc_week;
  @JsonKey(defaultValue: 1)
  int    catdsc_day;
  @JsonKey(defaultValue: 0)
  int    brgn_mst;
  @JsonKey(defaultValue: 0)
  int    brgnmst_week;
  @JsonKey(defaultValue: 1)
  int    brgnmst_day;
  @JsonKey(defaultValue: 0)
  int    bdl_mst;
  @JsonKey(defaultValue: 0)
  int    bdlmst_week;
  @JsonKey(defaultValue: 1)
  int    bdlmst_day;
  @JsonKey(defaultValue: 0)
  int    stm_mst;
  @JsonKey(defaultValue: 0)
  int    stmmst_week;
  @JsonKey(defaultValue: 1)
  int    stmmst_day;
  @JsonKey(defaultValue: 0)
  int    staff_mst;
  @JsonKey(defaultValue: 0)
  int    staffmst_week;
  @JsonKey(defaultValue: 1)
  int    staffmst_day;
  @JsonKey(defaultValue: 0)
  int    cust_mst;
  @JsonKey(defaultValue: 0)
  int    custmst_week;
  @JsonKey(defaultValue: 1)
  int    custmst_day;
  @JsonKey(defaultValue: 0)
  int    zone_mst;
  @JsonKey(defaultValue: 0)
  int    zonemst_week;
  @JsonKey(defaultValue: 1)
  int    zonemst_day;
  @JsonKey(defaultValue: 0)
  int    svs_mst;
  @JsonKey(defaultValue: 0)
  int    svsmst_week;
  @JsonKey(defaultValue: 1)
  int    svsmst_day;
  @JsonKey(defaultValue: 0)
  int    fspsch_mst;
  @JsonKey(defaultValue: 0)
  int    fspschmst_week;
  @JsonKey(defaultValue: 1)
  int    fspschmst_day;
  @JsonKey(defaultValue: 0)
  int    fspplan_plu;
  @JsonKey(defaultValue: 0)
  int    fspplanplu_week;
  @JsonKey(defaultValue: 1)
  int    fspplanplu_day;
  @JsonKey(defaultValue: 0)
  int    fspplan_mdl;
  @JsonKey(defaultValue: 0)
  int    fspplanmdl_week;
  @JsonKey(defaultValue: 1)
  int    fspplanmdl_day;
  @JsonKey(defaultValue: 0)
  int    fspplan_sml;
  @JsonKey(defaultValue: 0)
  int    fspplansml_week;
  @JsonKey(defaultValue: 1)
  int    fspplansml_day;
  @JsonKey(defaultValue: 0)
  int    dly_trm;
  @JsonKey(defaultValue: 0)
  int    dlytrm_week;
  @JsonKey(defaultValue: 1)
  int    dlytrm_day;
  @JsonKey(defaultValue: 0)
  int    dly_kopt;
  @JsonKey(defaultValue: 0)
  int    dlykopt_week;
  @JsonKey(defaultValue: 1)
  int    dlykopt_day;
  @JsonKey(defaultValue: 0)
  int    dly_recmsg;
  @JsonKey(defaultValue: 0)
  int    dlyrecmsg_week;
  @JsonKey(defaultValue: 1)
  int    dlyrecmsg_day;
  @JsonKey(defaultValue: 0)
  int    dly_preset;
  @JsonKey(defaultValue: 0)
  int    dlypreset_week;
  @JsonKey(defaultValue: 1)
  int    dlypreset_day;
  @JsonKey(defaultValue: 0)
  int    dly_batrepo;
  @JsonKey(defaultValue: 0)
  int    dlybatrepo_week;
  @JsonKey(defaultValue: 1)
  int    dlybatrepo_day;
  @JsonKey(defaultValue: 0)
  int    dly_img;
  @JsonKey(defaultValue: 0)
  int    dlyimg_week;
  @JsonKey(defaultValue: 1)
  int    dlyimg_day;
  @JsonKey(defaultValue: 0)
  int    tax_mst;
  @JsonKey(defaultValue: 0)
  int    tax_week;
  @JsonKey(defaultValue: 1)
  int    tax_day;
  @JsonKey(defaultValue: 0)
  int    ctrl_mst;
  @JsonKey(defaultValue: 0)
  int    ctrl_week;
  @JsonKey(defaultValue: 1)
  int    ctrl_day;
  @JsonKey(defaultValue: 0)
  int    instre_mst;
  @JsonKey(defaultValue: 0)
  int    instre_week;
  @JsonKey(defaultValue: 1)
  int    instre_day;
  @JsonKey(defaultValue: 0)
  int    mdlsch_mst;
  @JsonKey(defaultValue: 0)
  int    mdlsch_week;
  @JsonKey(defaultValue: 1)
  int    mdlsch_day;
  @JsonKey(defaultValue: 0)
  int    smlsch_mst;
  @JsonKey(defaultValue: 0)
  int    smlsch_week;
  @JsonKey(defaultValue: 1)
  int    smlsch_day;
  @JsonKey(defaultValue: 0)
  int    plusch_mst;
  @JsonKey(defaultValue: 0)
  int    plusch_week;
  @JsonKey(defaultValue: 1)
  int    plusch_day;
  @JsonKey(defaultValue: 0)
  int    batprcchg_mst;
  @JsonKey(defaultValue: 0)
  int    batprcchg_week;
  @JsonKey(defaultValue: 1)
  int    batprcchg_day;
  @JsonKey(defaultValue: 0)
  int    fipsch_mst;
  @JsonKey(defaultValue: 0)
  int    fipsch_week;
  @JsonKey(defaultValue: 1)
  int    fipsch_day;
  @JsonKey(defaultValue: 0)
  int    anvkind_mst;
  @JsonKey(defaultValue: 0)
  int    anvkind_week;
  @JsonKey(defaultValue: 1)
  int    anvkind_day;
  @JsonKey(defaultValue: 0)
  int    decrbt_mst;
  @JsonKey(defaultValue: 0)
  int    decrbt_week;
  @JsonKey(defaultValue: 1)
  int    decrbt_day;
  @JsonKey(defaultValue: 0)
  int    zipcode_mst;
  @JsonKey(defaultValue: 0)
  int    zipcode_week;
  @JsonKey(defaultValue: 1)
  int    zipcode_day;
  @JsonKey(defaultValue: 0)
  int    maker_mst;
  @JsonKey(defaultValue: 0)
  int    maker_week;
  @JsonKey(defaultValue: 1)
  int    maker_day;
  @JsonKey(defaultValue: 0)
  int    mcard_mst;
  @JsonKey(defaultValue: 0)
  int    mcard_week;
  @JsonKey(defaultValue: 1)
  int    mcard_day;
  @JsonKey(defaultValue: 0)
  int    reason_mst;
  @JsonKey(defaultValue: 0)
  int    reason_week;
  @JsonKey(defaultValue: 1)
  int    reason_day;
}

@JsonSerializable()
class _Csv_dly {
  factory _Csv_dly.fromJson(Map<String, dynamic> json) => _$Csv_dlyFromJson(json);
  Map<String, dynamic> toJson() => _$Csv_dlyToJson(this);

  _Csv_dly({
    required this.dly_deal,
    required this.dlydeal_week,
    required this.dlydeal_day,
    required this.dly_mdl,
    required this.dlymdl_week,
    required this.dlymdl_day,
    required this.dly_sml,
    required this.dlysml_week,
    required this.dlysml_day,
    required this.dly_plu,
    required this.dlyplu_week,
    required this.dlyplu_day,
    required this.dly_cat,
    required this.dlycat_week,
    required this.dlycatl_day,
    required this.dly_brgn,
    required this.dlybrgn_week,
    required this.dlybrgn_day,
    required this.dly_mach,
    required this.dlymach_week,
    required this.dlymach_day,
    required this.dly_crdt,
    required this.dlycrdt_week,
    required this.dlycrdt_day,
    required this.dly_tmp,
    required this.dlytmp_week,
    required this.dlytmp_day,
    required this.dly_prcchg,
    required this.dlyprcchgl_week,
    required this.dlyprcchg_day,
    required this.dly_itemlog,
    required this.dlyitemlog_week,
    required this.dlyitmlog_day,
    required this.dly_bdllog,
    required this.dlybdllog_week,
    required this.dlybdllog_day,
    required this.dly_stmlog,
    required this.dlystmlog_week,
    required this.dlystmlog_day,
    required this.dly_ttllog,
    required this.dlyttllog_week,
    required this.dlyttllog_day,
    required this.dly_ejlog,
    required this.dlyejlog_week,
    required this.dlyejlog_day,
    required this.dly_cust,
    required this.dlycust_week,
    required this.dlycust_day,
    required this.dly_zone,
    required this.dlyzone_week,
    required this.dlyzone_day,
    required this.dly_svs,
    required this.dlysvs_week,
    required this.dlysvs_day,
    required this.dly_fspplu,
    required this.dlyfspplu_week,
    required this.dlyfspplu_day,
    required this.dly_fspsml,
    required this.dlyfspsml_week,
    required this.dlyfspsml_day,
    required this.dly_fspmdl,
    required this.dlyfspmdl_week,
    required this.dlyfspmdl_day,
    required this.dly_fspttl,
    required this.dlyfspttl_week,
    required this.dlyfspttl_day,
    required this.histlog,
    required this.histlog_week,
    required this.histlog_day,
    required this.duty_log,
    required this.dutylog_week,
    required this.dutylog_day,
    required this.sims_log,
    required this.simslog_week,
    required this.simslog_day,
    required this.reserv_log,
    required this.reservlog_week,
    required this.reservlog_day,
    required this.z_receipt,
    required this.zreceipt_week,
    required this.zreceipt_day,
    required this.dly_lrg,
    required this.dlylrg_week,
    required this.dlylrg_day,
    required this.drawchk_cash_log,
    required this.drawchk_cash_log_week,
    required this.drawchk_cash_log_day,
  });

  @JsonKey(defaultValue: 0)
  int    dly_deal;
  @JsonKey(defaultValue: 0)
  int    dlydeal_week;
  @JsonKey(defaultValue: 1)
  int    dlydeal_day;
  @JsonKey(defaultValue: 0)
  int    dly_mdl;
  @JsonKey(defaultValue: 0)
  int    dlymdl_week;
  @JsonKey(defaultValue: 1)
  int    dlymdl_day;
  @JsonKey(defaultValue: 0)
  int    dly_sml;
  @JsonKey(defaultValue: 0)
  int    dlysml_week;
  @JsonKey(defaultValue: 1)
  int    dlysml_day;
  @JsonKey(defaultValue: 0)
  int    dly_plu;
  @JsonKey(defaultValue: 0)
  int    dlyplu_week;
  @JsonKey(defaultValue: 1)
  int    dlyplu_day;
  @JsonKey(defaultValue: 0)
  int    dly_cat;
  @JsonKey(defaultValue: 0)
  int    dlycat_week;
  @JsonKey(defaultValue: 1)
  int    dlycatl_day;
  @JsonKey(defaultValue: 0)
  int    dly_brgn;
  @JsonKey(defaultValue: 0)
  int    dlybrgn_week;
  @JsonKey(defaultValue: 1)
  int    dlybrgn_day;
  @JsonKey(defaultValue: 0)
  int    dly_mach;
  @JsonKey(defaultValue: 0)
  int    dlymach_week;
  @JsonKey(defaultValue: 1)
  int    dlymach_day;
  @JsonKey(defaultValue: 0)
  int    dly_crdt;
  @JsonKey(defaultValue: 0)
  int    dlycrdt_week;
  @JsonKey(defaultValue: 1)
  int    dlycrdt_day;
  @JsonKey(defaultValue: 0)
  int    dly_tmp;
  @JsonKey(defaultValue: 0)
  int    dlytmp_week;
  @JsonKey(defaultValue: 1)
  int    dlytmp_day;
  @JsonKey(defaultValue: 0)
  int    dly_prcchg;
  @JsonKey(defaultValue: 0)
  int    dlyprcchgl_week;
  @JsonKey(defaultValue: 1)
  int    dlyprcchg_day;
  @JsonKey(defaultValue: 0)
  int    dly_itemlog;
  @JsonKey(defaultValue: 0)
  int    dlyitemlog_week;
  @JsonKey(defaultValue: 1)
  int    dlyitmlog_day;
  @JsonKey(defaultValue: 0)
  int    dly_bdllog;
  @JsonKey(defaultValue: 0)
  int    dlybdllog_week;
  @JsonKey(defaultValue: 1)
  int    dlybdllog_day;
  @JsonKey(defaultValue: 0)
  int    dly_stmlog;
  @JsonKey(defaultValue: 0)
  int    dlystmlog_week;
  @JsonKey(defaultValue: 1)
  int    dlystmlog_day;
  @JsonKey(defaultValue: 0)
  int    dly_ttllog;
  @JsonKey(defaultValue: 0)
  int    dlyttllog_week;
  @JsonKey(defaultValue: 1)
  int    dlyttllog_day;
  @JsonKey(defaultValue: 0)
  int    dly_ejlog;
  @JsonKey(defaultValue: 0)
  int    dlyejlog_week;
  @JsonKey(defaultValue: 1)
  int    dlyejlog_day;
  @JsonKey(defaultValue: 0)
  int    dly_cust;
  @JsonKey(defaultValue: 0)
  int    dlycust_week;
  @JsonKey(defaultValue: 1)
  int    dlycust_day;
  @JsonKey(defaultValue: 0)
  int    dly_zone;
  @JsonKey(defaultValue: 0)
  int    dlyzone_week;
  @JsonKey(defaultValue: 1)
  int    dlyzone_day;
  @JsonKey(defaultValue: 0)
  int    dly_svs;
  @JsonKey(defaultValue: 0)
  int    dlysvs_week;
  @JsonKey(defaultValue: 1)
  int    dlysvs_day;
  @JsonKey(defaultValue: 0)
  int    dly_fspplu;
  @JsonKey(defaultValue: 0)
  int    dlyfspplu_week;
  @JsonKey(defaultValue: 1)
  int    dlyfspplu_day;
  @JsonKey(defaultValue: 0)
  int    dly_fspsml;
  @JsonKey(defaultValue: 0)
  int    dlyfspsml_week;
  @JsonKey(defaultValue: 1)
  int    dlyfspsml_day;
  @JsonKey(defaultValue: 0)
  int    dly_fspmdl;
  @JsonKey(defaultValue: 0)
  int    dlyfspmdl_week;
  @JsonKey(defaultValue: 1)
  int    dlyfspmdl_day;
  @JsonKey(defaultValue: 0)
  int    dly_fspttl;
  @JsonKey(defaultValue: 0)
  int    dlyfspttl_week;
  @JsonKey(defaultValue: 1)
  int    dlyfspttl_day;
  @JsonKey(defaultValue: 0)
  int    histlog;
  @JsonKey(defaultValue: 0)
  int    histlog_week;
  @JsonKey(defaultValue: 1)
  int    histlog_day;
  @JsonKey(defaultValue: 1)
  int    duty_log;
  @JsonKey(defaultValue: 0)
  int    dutylog_week;
  @JsonKey(defaultValue: 1)
  int    dutylog_day;
  @JsonKey(defaultValue: 0)
  int    sims_log;
  @JsonKey(defaultValue: 0)
  int    simslog_week;
  @JsonKey(defaultValue: 1)
  int    simslog_day;
  @JsonKey(defaultValue: 0)
  int    reserv_log;
  @JsonKey(defaultValue: 0)
  int    reservlog_week;
  @JsonKey(defaultValue: 1)
  int    reservlog_day;
  @JsonKey(defaultValue: 0)
  int    z_receipt;
  @JsonKey(defaultValue: 0)
  int    zreceipt_week;
  @JsonKey(defaultValue: 1)
  int    zreceipt_day;
  @JsonKey(defaultValue: 0)
  int    dly_lrg;
  @JsonKey(defaultValue: 0)
  int    dlylrg_week;
  @JsonKey(defaultValue: 1)
  int    dlylrg_day;
  @JsonKey(defaultValue: 0)
  int    drawchk_cash_log;
  @JsonKey(defaultValue: 0)
  int    drawchk_cash_log_week;
  @JsonKey(defaultValue: 1)
  int    drawchk_cash_log_day;
}

@JsonSerializable()
class _Csv_tpr8100 {
  factory _Csv_tpr8100.fromJson(Map<String, dynamic> json) => _$Csv_tpr8100FromJson(json);
  Map<String, dynamic> toJson() => _$Csv_tpr8100ToJson(this);

  _Csv_tpr8100({
    required this.dly_plu_tpr8100,
    required this.dly_deal_tpr8100,
    required this.reg_dly_mly_mdl_tpr8100,
    required this.ibaraki_tpr8100,
  });

  @JsonKey(defaultValue: 0)
  int    dly_plu_tpr8100;
  @JsonKey(defaultValue: 0)
  int    dly_deal_tpr8100;
  @JsonKey(defaultValue: 0)
  int    reg_dly_mly_mdl_tpr8100;
  @JsonKey(defaultValue: 0)
  int    ibaraki_tpr8100;
}

@JsonSerializable()
class _Sch_delete {
  factory _Sch_delete.fromJson(Map<String, dynamic> json) => _$Sch_deleteFromJson(json);
  Map<String, dynamic> toJson() => _$Sch_deleteToJson(this);

  _Sch_delete({
    required this.bgnsch_del_date,
    required this.mmsch_del_date,
    required this.smsch_del_date,
    required this.clssch_del_date,
    required this.plusch_del_date,
    required this.ej_txt_del_date,
    required this.csv_txt_del_date,
    required this.schmsg_del_date,
    required this.fipsch_del_date,
    required this.reserv_del_date,
    required this.custbkup_del_date,
  });

  @JsonKey(defaultValue: 7)
  int    bgnsch_del_date;
  @JsonKey(defaultValue: 7)
  int    mmsch_del_date;
  @JsonKey(defaultValue: 7)
  int    smsch_del_date;
  @JsonKey(defaultValue: 7)
  int    clssch_del_date;
  @JsonKey(defaultValue: 7)
  int    plusch_del_date;
  @JsonKey(defaultValue: 3)
  int    ej_txt_del_date;
  @JsonKey(defaultValue: 1)
  int    csv_txt_del_date;
  @JsonKey(defaultValue: 7)
  int    schmsg_del_date;
  @JsonKey(defaultValue: 7)
  int    fipsch_del_date;
  @JsonKey(defaultValue: 7)
  int    reserv_del_date;
  @JsonKey(defaultValue: 7)
  int    custbkup_del_date;
}

@JsonSerializable()
class _Internal_flg {
  factory _Internal_flg.fromJson(Map<String, dynamic> json) => _$Internal_flgFromJson(json);
  Map<String, dynamic> toJson() => _$Internal_flgToJson(this);

  _Internal_flg({
    required this.mode,
    required this.auto_mode,
    required this.rct_onoff,
    required this.acr_onoff,
    required this.acr_cnct,
    required this.acr_errprn,
    required this.card_cnct,
    required this.acb_deccin,
    required this.rwt_cnct,
    required this.scale_cnct,
    required this.acb_select,
    required this.iis21_cnct,
    required this.mobile_cnct,
    required this.stpr_cnct,
    required this.netwlpr_cnct,
    required this.poppy_cnct,
    required this.tag_cnct,
    required this.auto_deccin,
    required this.s2pr_cnct,
    required this.pwrctrl_cnct,
    required this.catalinapr_cnct,
    required this.dish_cnct,
    required this.custrealsvr_cnct,
    required this.aivoice_cnct,
    required this.gcat_cnct,
    required this.suica_cnct,
    required this.mp1_cnct,
    required this.realitmsend_cnct,
    required this.gramx_cnct,
    required this.rfid_cnct,
    required this.soft_keyb,
    required this.keyb,
    required this.msg_flg,
    required this.multi_cnct,
    required this.jrem_cnct,
    required this.colordsp_cnct,
    required this.usbcam_cnct,
    required this.masr_cnct,
    required this.brainfl_cnct,
    required this.cat_jmups_twin_cnct,
    required this.sqrc_ticket_cnct,
    required this.custrealsvr_pqs_new_send,
    required this.sqrc_drlabel_no,
    required this.iccard_cnct,
    required this.ecs_mode,
    required this.colordsp_size,
    required this.usbcam_direction,
    required this.usbcam_disp,
    required this.apbf_cnct,
    required this.usbcam_disp_size,
    required this.exc_cnct,
    required this.hitouch_cnct,
    required this.snresult,
    required this.ami_cnct,
    required this.hs_scale_cnct,
  });

  @JsonKey(defaultValue: 0)
  int    mode;
  @JsonKey(defaultValue: 0)
  int    auto_mode;
  @JsonKey(defaultValue: 0)
  int    rct_onoff;
  @JsonKey(defaultValue: 0)
  int    acr_onoff;
  @JsonKey(defaultValue: 0)
  int    acr_cnct;
  @JsonKey(defaultValue: 0)
  int    acr_errprn;
  @JsonKey(defaultValue: 0)
  int    card_cnct;
  @JsonKey(defaultValue: 0)
  int    acb_deccin;
  @JsonKey(defaultValue: 0)
  int    rwt_cnct;
  @JsonKey(defaultValue: 0)
  int    scale_cnct;
  @JsonKey(defaultValue: 0)
  int    acb_select;
  @JsonKey(defaultValue: 0)
  int    iis21_cnct;
  @JsonKey(defaultValue: 0)
  int    mobile_cnct;
  @JsonKey(defaultValue: 0)
  int    stpr_cnct;
  @JsonKey(defaultValue: 0)
  int    netwlpr_cnct;
  @JsonKey(defaultValue: 0)
  int    poppy_cnct;
  @JsonKey(defaultValue: 0)
  int    tag_cnct;
  @JsonKey(defaultValue: 0)
  int    auto_deccin;
  @JsonKey(defaultValue: 0)
  int    s2pr_cnct;
  @JsonKey(defaultValue: 0)
  int    pwrctrl_cnct;
  @JsonKey(defaultValue: 0)
  int    catalinapr_cnct;
  @JsonKey(defaultValue: 0)
  int    dish_cnct;
  @JsonKey(defaultValue: 0)
  int    custrealsvr_cnct;
  @JsonKey(defaultValue: 0)
  int    aivoice_cnct;
  @JsonKey(defaultValue: 0)
  int    gcat_cnct;
  @JsonKey(defaultValue: 0)
  int    suica_cnct;
  @JsonKey(defaultValue: 0)
  int    mp1_cnct;
  @JsonKey(defaultValue: 0)
  int    realitmsend_cnct;
  @JsonKey(defaultValue: 0)
  int    gramx_cnct;
  @JsonKey(defaultValue: 0)
  int    rfid_cnct;
  @JsonKey(defaultValue: 0)
  int    soft_keyb;
  @JsonKey(defaultValue: 0)
  int    keyb;
  @JsonKey(defaultValue: 0)
  int    msg_flg;
  @JsonKey(defaultValue: 0)
  int    multi_cnct;
  @JsonKey(defaultValue: 0)
  int    jrem_cnct;
  @JsonKey(defaultValue: 0)
  int    colordsp_cnct;
  @JsonKey(defaultValue: 0)
  int    usbcam_cnct;
  @JsonKey(defaultValue: 0)
  int    masr_cnct;
  @JsonKey(defaultValue: 0)
  int    brainfl_cnct;
  @JsonKey(defaultValue: 0)
  int    cat_jmups_twin_cnct;
  @JsonKey(defaultValue: 0)
  int    sqrc_ticket_cnct;
  @JsonKey(defaultValue: 0)
  int    custrealsvr_pqs_new_send;
  @JsonKey(defaultValue: 1)
  int    sqrc_drlabel_no;
  @JsonKey(defaultValue: 0)
  int    iccard_cnct;
  @JsonKey(defaultValue: 1)
  int    ecs_mode;
  @JsonKey(defaultValue: 0)
  int    colordsp_size;
  @JsonKey(defaultValue: 0)
  int    usbcam_direction;
  @JsonKey(defaultValue: 0)
  int    usbcam_disp;
  @JsonKey(defaultValue: 0)
  int    apbf_cnct;
  @JsonKey(defaultValue: 0)
  int    usbcam_disp_size;
  @JsonKey(defaultValue: 0)
  int    exc_cnct;
  @JsonKey(defaultValue: 0)
  int    hitouch_cnct;
  @JsonKey(defaultValue: 0)
  int    snresult;
  @JsonKey(defaultValue: 0)
  int    ami_cnct;
  @JsonKey(defaultValue: 0)
  int    hs_scale_cnct;
}

@JsonSerializable()
class _Cat_timer {
  factory _Cat_timer.fromJson(Map<String, dynamic> json) => _$Cat_timerFromJson(json);
  Map<String, dynamic> toJson() => _$Cat_timerToJson(this);

  _Cat_timer({
    required this.cat_stat_timer,
    required this.cat_recv_timer,
  });

  @JsonKey(defaultValue: 300)
  int    cat_stat_timer;
  @JsonKey(defaultValue: 3000)
  int    cat_recv_timer;
}

@JsonSerializable()
class _Printer {
  factory _Printer.fromJson(Map<String, dynamic> json) => _$PrinterFromJson(json);
  Map<String, dynamic> toJson() => _$PrinterToJson(this);

  _Printer({
    required this.rct_spd,
    required this.rct_dns,
    required this.s2pr_topfeed,
    required this.s2pr_lineno,
    required this.rct_lf_plus,
    required this.rct_tb_cut,
    required this.rct_sp_width,
    required this.rct_cut_type,
    required this.rct_cut_type2,
    required this.err_rpr_timer,
    required this.nearend_check,
    required this.kitchen_prt_power,
    required this.zhq_cpn_rct_share,
    required this.nearend_note,
    required this.nearend_count,
    required this.hprt_fwver,
  });

  @JsonKey(defaultValue: 3)
  int    rct_spd;
  @JsonKey(defaultValue: 1)
  int    rct_dns;
  @JsonKey(defaultValue: 6)
  int    s2pr_topfeed;
  @JsonKey(defaultValue: 18)
  int    s2pr_lineno;
  @JsonKey(defaultValue: 6)
  int    rct_lf_plus;
  @JsonKey(defaultValue: 0)
  int    rct_tb_cut;
  @JsonKey(defaultValue: 0)
  int    rct_sp_width;
  @JsonKey(defaultValue: 0)
  int    rct_cut_type;
  @JsonKey(defaultValue: 0)
  int    rct_cut_type2;
  @JsonKey(defaultValue: 10)
  int    err_rpr_timer;
  @JsonKey(defaultValue: 0)
  int    nearend_check;
  @JsonKey(defaultValue: 0)
  int    kitchen_prt_power;
  @JsonKey(defaultValue: 0)
  int    zhq_cpn_rct_share;
  @JsonKey(defaultValue: 0)
  int    nearend_note;
  @JsonKey(defaultValue: 3)
  int    nearend_count;
  @JsonKey(defaultValue: 0)
  int    hprt_fwver;
}

@JsonSerializable()
class _Printer_cntl {
  factory _Printer_cntl.fromJson(Map<String, dynamic> json) => _$Printer_cntlFromJson(json);
  Map<String, dynamic> toJson() => _$Printer_cntlToJson(this);

  _Printer_cntl({
    required this.recipt_wid,
    required this.prnt_length,
    required this.start_speed,
    required this.top_speed,
    required this.top_sp_step,
    required this.start_density,
    required this.top_density,
    required this.top_den_step,
    required this.prt_position,
    required this.head_wid,
    required this.prt_start_size,
    required this.err_mask,
    required this.x_offset,
    required this.recipt_wid80,
  });

  @JsonKey(defaultValue: 464)
  int    recipt_wid;
  @JsonKey(defaultValue: 0)
  int    prnt_length;
  @JsonKey(defaultValue: 300)
  int    start_speed;
  @JsonKey(defaultValue: 1200)
  int    top_speed;
  @JsonKey(defaultValue: 100)
  int    top_sp_step;
  @JsonKey(defaultValue: 1020)
  int    start_density;
  @JsonKey(defaultValue: 1020)
  int    top_density;
  @JsonKey(defaultValue: 100)
  int    top_den_step;
  @JsonKey(defaultValue: 0)
  int    prt_position;
  @JsonKey(defaultValue: 640)
  int    head_wid;
  @JsonKey(defaultValue: 3200)
  int    prt_start_size;
  @JsonKey(defaultValue: 48)
  int    err_mask;
  @JsonKey(defaultValue: 40)
  int    x_offset;
  @JsonKey(defaultValue: 576)
  int    recipt_wid80;
}

@JsonSerializable()
class _Printer_def {
  factory _Printer_def.fromJson(Map<String, dynamic> json) => _$Printer_defFromJson(json);
  Map<String, dynamic> toJson() => _$Printer_defToJson(this);

  _Printer_def({
    required this.rct_tspd_0,
    required this.rct_tspd_1,
    required this.rct_tspd_2,
    required this.rct_tspd_3,
    required this.rct_lspeed_dens0,
    required this.rct_lspeed_dens1,
    required this.rct_lspeed_dens2,
    required this.rct_lspeed_dens3,
    required this.rct_mspeed_dens0,
    required this.rct_mspeed_dens1,
    required this.rct_mspeed_dens2,
    required this.rct_mspeed_dens3,
    required this.rct_hmspeed_dens0,
    required this.rct_hmspeed_dens1,
    required this.rct_hmspeed_dens2,
    required this.rct_hmspeed_dens3,
    required this.rct_hspeed_dens0,
    required this.rct_hspeed_dens1,
    required this.rct_hspeed_dens2,
    required this.rct_hspeed_dens3,
  });

  @JsonKey(defaultValue: 800)
  int    rct_tspd_0;
  @JsonKey(defaultValue: 800)
  int    rct_tspd_1;
  @JsonKey(defaultValue: 1000)
  int    rct_tspd_2;
  @JsonKey(defaultValue: 1200)
  int    rct_tspd_3;
  @JsonKey(defaultValue: 900)
  int    rct_lspeed_dens0;
  @JsonKey(defaultValue: 1000)
  int    rct_lspeed_dens1;
  @JsonKey(defaultValue: 1100)
  int    rct_lspeed_dens2;
  @JsonKey(defaultValue: 1200)
  int    rct_lspeed_dens3;
  @JsonKey(defaultValue: 900)
  int    rct_mspeed_dens0;
  @JsonKey(defaultValue: 1000)
  int    rct_mspeed_dens1;
  @JsonKey(defaultValue: 1100)
  int    rct_mspeed_dens2;
  @JsonKey(defaultValue: 1200)
  int    rct_mspeed_dens3;
  @JsonKey(defaultValue: 810)
  int    rct_hmspeed_dens0;
  @JsonKey(defaultValue: 900)
  int    rct_hmspeed_dens1;
  @JsonKey(defaultValue: 990)
  int    rct_hmspeed_dens2;
  @JsonKey(defaultValue: 1080)
  int    rct_hmspeed_dens3;
  @JsonKey(defaultValue: 918)
  int    rct_hspeed_dens0;
  @JsonKey(defaultValue: 1020)
  int    rct_hspeed_dens1;
  @JsonKey(defaultValue: 1122)
  int    rct_hspeed_dens2;
  @JsonKey(defaultValue: 1224)
  int    rct_hspeed_dens3;
}

@JsonSerializable()
class _Clerksave {
  factory _Clerksave.fromJson(Map<String, dynamic> json) => _$ClerksaveFromJson(json);
  Map<String, dynamic> toJson() => _$ClerksaveToJson(this);

  _Clerksave({
    required this.spoolend,
  });

  @JsonKey(defaultValue: 5)
  int    spoolend;
}

@JsonSerializable()
class _Printer_font {
  factory _Printer_font.fromJson(Map<String, dynamic> json) => _$Printer_fontFromJson(json);
  Map<String, dynamic> toJson() => _$Printer_fontToJson(this);

  _Printer_font({
    required this.fontname_j,
    required this.fontname_e,
  });

  @JsonKey(defaultValue: "rgmj0124.bdf")
  String fontname_j;
  @JsonKey(defaultValue: "rgmhhc24.bdf")
  String fontname_e;
}

@JsonSerializable()
class _Ups {
  factory _Ups.fromJson(Map<String, dynamic> json) => _$UpsFromJson(json);
  Map<String, dynamic> toJson() => _$UpsToJson(this);

  _Ups({
    required this.pfcheck,
    required this.pftime,
    required this.pfretry,
    required this.pftime2,
    required this.pfretry2,
    required this.pfmaxwait,
    required this.port,
    required this.entry,
    required this.entry2,
    required this.port2,
  });

  @JsonKey(defaultValue: 10)
  int    pfcheck;
  @JsonKey(defaultValue: 3)
  int    pftime;
  @JsonKey(defaultValue: 4)
  int    pfretry;
  @JsonKey(defaultValue: 1)
  int    pftime2;
  @JsonKey(defaultValue: 3)
  int    pfretry2;
  @JsonKey(defaultValue: 45)
  int    pfmaxwait;
  @JsonKey(defaultValue: "/dev/ttyS0")
  String port;
  @JsonKey(defaultValue: "tprdrv_ups")
  String entry;
  @JsonKey(defaultValue: "tprdrv_ups_plus")
  String entry2;
  @JsonKey(defaultValue: "/dev/ttyS5")
  String port2;
}

@JsonSerializable()
class _Doc {
  factory _Doc.fromJson(Map<String, dynamic> json) => _$DocFromJson(json);
  Map<String, dynamic> toJson() => _$DocToJson(this);

  _Doc({
    required this.update,
  });

  @JsonKey(defaultValue: 0)
  int    update;
}

@JsonSerializable()
class _Mem_size_db5_M {
  factory _Mem_size_db5_M.fromJson(Map<String, dynamic> json) => _$Mem_size_db5_MFromJson(json);
  Map<String, dynamic> toJson() => _$Mem_size_db5_MToJson(this);

  _Mem_size_db5_M({
    required this.M1,
    required this.M5,
    required this.M10,
  });

  @JsonKey(defaultValue: 64)
  int    M1;
  @JsonKey(defaultValue: 64)
  int    M5;
  @JsonKey(defaultValue: 128)
  int    M10;
}

@JsonSerializable()
class _Mem_size_db5_S {
  factory _Mem_size_db5_S.fromJson(Map<String, dynamic> json) => _$Mem_size_db5_SFromJson(json);
  Map<String, dynamic> toJson() => _$Mem_size_db5_SToJson(this);

  _Mem_size_db5_S({
    required this.S1,
    required this.S5,
    required this.S10,
  });

  @JsonKey(defaultValue: 64)
  int    S1;
  @JsonKey(defaultValue: 64)
  int    S5;
  @JsonKey(defaultValue: 64)
  int    S10;
}

@JsonSerializable()
class _Mem_size_db6_M {
  factory _Mem_size_db6_M.fromJson(Map<String, dynamic> json) => _$Mem_size_db6_MFromJson(json);
  Map<String, dynamic> toJson() => _$Mem_size_db6_MToJson(this);

  _Mem_size_db6_M({
    required this.M1,
    required this.M5,
    required this.M10,
    required this.M15,
  });

  @JsonKey(defaultValue: 64)
  int    M1;
  @JsonKey(defaultValue: 128)
  int    M5;
  @JsonKey(defaultValue: 128)
  int    M10;
  @JsonKey(defaultValue: 256)
  int    M15;
}

@JsonSerializable()
class _Mem_size_db6_S {
  factory _Mem_size_db6_S.fromJson(Map<String, dynamic> json) => _$Mem_size_db6_SFromJson(json);
  Map<String, dynamic> toJson() => _$Mem_size_db6_SToJson(this);

  _Mem_size_db6_S({
    required this.S1,
    required this.S5,
    required this.S10,
    required this.S15,
  });

  @JsonKey(defaultValue: 64)
  int    S1;
  @JsonKey(defaultValue: 64)
  int    S5;
  @JsonKey(defaultValue: 64)
  int    S10;
  @JsonKey(defaultValue: 64)
  int    S15;
}

@JsonSerializable()
class _Tag_poppy {
  factory _Tag_poppy.fromJson(Map<String, dynamic> json) => _$Tag_poppyFromJson(json);
  Map<String, dynamic> toJson() => _$Tag_poppyToJson(this);

  _Tag_poppy({
    required this.poppy_print,
    required this.tag_print,
  });

  @JsonKey(defaultValue: 0)
  int    poppy_print;
  @JsonKey(defaultValue: 0)
  int    tag_print;
}

@JsonSerializable()
class _FFJ_FTP {
  factory _FFJ_FTP.fromJson(Map<String, dynamic> json) => _$FFJ_FTPFromJson(json);
  Map<String, dynamic> toJson() => _$FFJ_FTPToJson(this);

  _FFJ_FTP({
    required this.store_chd,
  });

  @JsonKey(defaultValue: 0)
  int    store_chd;
}

@JsonSerializable()
class _Select_self {
  factory _Select_self.fromJson(Map<String, dynamic> json) => _$Select_selfFromJson(json);
  Map<String, dynamic> toJson() => _$Select_selfToJson(this);

  _Select_self({
    required this.self_mode,
    required this.self_mac_mode,
    required this.assist_port,
    required this.reg_cruising_drct,
    required this.self_chart_output,
    required this.select_dspmode,
    required this.qs_auto_reboot,
    required this.self_regbag1_plucd,
    required this.self_regbag2_plucd,
    required this.self_regbag3_plucd,
    required this.self_separate_in_scl,
    required this.qc_mode,
    required this.selfmactyp,
    required this.self_scan_typ,
    required this.self_stre_typ,
    required this.hs_start_mode,
    required this.psensor_scan_swing,
    required this.psensor_swing_notice,
    required this.psensor_scan_slow,
    required this.psensor_slow_notice,
    required this.psensor_scan_slowtime,
    required this.psensor_scan_away,
    required this.psensor_away_notice,
    required this.psensor_scan_awaytime,
    required this.psensor_disptime,
    required this.psensor_notice,
    required this.kpi_hs_mode,
    required this.psensor_swing_cnt,
    required this.psensor_scan_slow_sound,
    required this.psensor_away_sound,
    required this.leave_qr_mode,
    required this.aibox_select_mode,
    required this.psensor_position,
    required this.leave_qr_prn_ptn,
  });

  @JsonKey(defaultValue: 0)
  int    self_mode;
  @JsonKey(defaultValue: 0)
  int    self_mac_mode;
  @JsonKey(defaultValue: 9760)
  int    assist_port;
  @JsonKey(defaultValue: 0)
  int    reg_cruising_drct;
  @JsonKey(defaultValue: 0)
  int    self_chart_output;
  @JsonKey(defaultValue: 0)
  int    select_dspmode;
  @JsonKey(defaultValue: 0)
  int    qs_auto_reboot;
  @JsonKey(defaultValue: 0)
  int    self_regbag1_plucd;
  @JsonKey(defaultValue: 0)
  int    self_regbag2_plucd;
  @JsonKey(defaultValue: 0)
  int    self_regbag3_plucd;
  @JsonKey(defaultValue: 0)
  int    self_separate_in_scl;
  @JsonKey(defaultValue: 1)
  int    qc_mode;
  @JsonKey(defaultValue: 0)
  int    selfmactyp;
  @JsonKey(defaultValue: 1)
  int    self_scan_typ;
  @JsonKey(defaultValue: 0)
  int    self_stre_typ;
  @JsonKey(defaultValue: 0)
  int    hs_start_mode;
  @JsonKey(defaultValue: 1)
  int    psensor_scan_swing;
  @JsonKey(defaultValue: 0)
  int    psensor_swing_notice;
  @JsonKey(defaultValue: 1)
  int    psensor_scan_slow;
  @JsonKey(defaultValue: 0)
  int    psensor_slow_notice;
  @JsonKey(defaultValue: 2)
  int    psensor_scan_slowtime;
  @JsonKey(defaultValue: 1)
  int    psensor_scan_away;
  @JsonKey(defaultValue: 1)
  int    psensor_away_notice;
  @JsonKey(defaultValue: 2)
  int    psensor_scan_awaytime;
  @JsonKey(defaultValue: 1000)
  int    psensor_disptime;
  @JsonKey(defaultValue: 1)
  int    psensor_notice;
  @JsonKey(defaultValue: 0)
  int    kpi_hs_mode;
  @JsonKey(defaultValue: 1)
  int    psensor_swing_cnt;
  @JsonKey(defaultValue: 0)
  int    psensor_scan_slow_sound;
  @JsonKey(defaultValue: 0)
  int    psensor_away_sound;
  @JsonKey(defaultValue: 0)
  int    leave_qr_mode;
  @JsonKey(defaultValue: 0)
  int    aibox_select_mode;
  @JsonKey(defaultValue: 0)
  int    psensor_position;
  @JsonKey(defaultValue: 0)
  int    leave_qr_prn_ptn;
}

@JsonSerializable()
class _Prime_fip {
  factory _Prime_fip.fromJson(Map<String, dynamic> json) => _$Prime_fipFromJson(json);
  Map<String, dynamic> toJson() => _$Prime_fipToJson(this);

  _Prime_fip({
    required this.prime_fip,
  });

  @JsonKey(defaultValue: 0)
  int    prime_fip;
}

@JsonSerializable()
class _EEdy_Connection {
  factory _EEdy_Connection.fromJson(Map<String, dynamic> json) => _$EEdy_ConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$EEdy_ConnectionToJson(this);

  _EEdy_Connection({
    required this.edy_retry_timeout,
    required this.edy_connect_timeout,
  });

  @JsonKey(defaultValue: 60)
  int    edy_retry_timeout;
  @JsonKey(defaultValue: 120)
  int    edy_connect_timeout;
}

@JsonSerializable()
class _Timeserver {
  factory _Timeserver.fromJson(Map<String, dynamic> json) => _$TimeserverFromJson(json);
  Map<String, dynamic> toJson() => _$TimeserverToJson(this);

  _Timeserver({
    required this.timeserver,
  });

  @JsonKey(defaultValue: 0)
  int    timeserver;
}

@JsonSerializable()
class _Fcon_version {
  factory _Fcon_version.fromJson(Map<String, dynamic> json) => _$Fcon_versionFromJson(json);
  Map<String, dynamic> toJson() => _$Fcon_versionToJson(this);

  _Fcon_version({
    required this.scpu1,
    required this.scpu2,
    required this.printer,
    required this.printer2,
  });

  @JsonKey(defaultValue: "")
  String scpu1;
  @JsonKey(defaultValue: "")
  String scpu2;
  @JsonKey(defaultValue: "")
  String printer;
  @JsonKey(defaultValue: "")
  String printer2;
}

@JsonSerializable()
class _MMC_Connection {
  factory _MMC_Connection.fromJson(Map<String, dynamic> json) => _$MMC_ConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$MMC_ConnectionToJson(this);

  _MMC_Connection({
    required this.mc_tenant_cd,
  });

  @JsonKey(defaultValue: 0)
  int    mc_tenant_cd;
}

@JsonSerializable()
class _Deccin_bkup {
  factory _Deccin_bkup.fromJson(Map<String, dynamic> json) => _$Deccin_bkupFromJson(json);
  Map<String, dynamic> toJson() => _$Deccin_bkupToJson(this);

  _Deccin_bkup({
    required this.bkup_auto_deccin,
    required this.bkup_acb_deccin,
    required this.bkup_acr_onoff,
    required this.bkup_acb_onoff,
  });

  @JsonKey(defaultValue: 0)
  int    bkup_auto_deccin;
  @JsonKey(defaultValue: 0)
  int    bkup_acb_deccin;
  @JsonKey(defaultValue: 0)
  int    bkup_acr_onoff;
  @JsonKey(defaultValue: 0)
  int    bkup_acb_onoff;
}

@JsonSerializable()
class _Identifies {
  factory _Identifies.fromJson(Map<String, dynamic> json) => _$IdentifiesFromJson(json);
  Map<String, dynamic> toJson() => _$IdentifiesToJson(this);

  _Identifies({
    required this.identifies_cd,
    required this.identifies_cd1,
    required this.identifies_cd2,
    required this.identifies_cd3,
    required this.identifies_cd4,
    required this.identifies_cd5,
    required this.identifies_cd6,
    required this.identifies_cd7,
    required this.identifies_cd8,
  });

  @JsonKey(defaultValue: "")
  String identifies_cd;
  @JsonKey(defaultValue: "")
  String identifies_cd1;
  @JsonKey(defaultValue: "")
  String identifies_cd2;
  @JsonKey(defaultValue: "")
  String identifies_cd3;
  @JsonKey(defaultValue: "")
  String identifies_cd4;
  @JsonKey(defaultValue: "")
  String identifies_cd5;
  @JsonKey(defaultValue: "")
  String identifies_cd6;
  @JsonKey(defaultValue: "")
  String identifies_cd7;
  @JsonKey(defaultValue: "")
  String identifies_cd8;
}

@JsonSerializable()
class _Acx_flg {
  factory _Acx_flg.fromJson(Map<String, dynamic> json) => _$Acx_flgFromJson(json);
  Map<String, dynamic> toJson() => _$Acx_flgToJson(this);

  _Acx_flg({
    required this.acr50_ssw14_0,
    required this.acr50_ssw14_1_2,
    required this.acr50_ssw14_3_4,
    required this.acr50_ssw14_5,
    required this.acr50_ssw14_7,
    required this.pick_end,
    required this.acxreal_system,
    required this.ecs_pick_positn10000,
    required this.ecs_pick_positn5000,
    required this.ecs_pick_positn2000,
    required this.ecs_pick_positn1000,
    required this.acx_pick_data10000,
    required this.acx_pick_data5000,
    required this.acx_pick_data2000,
    required this.acx_pick_data1000,
    required this.acx_pick_data500,
    required this.acx_pick_data100,
    required this.acx_pick_data50,
    required this.acx_pick_data10,
    required this.acx_pick_data5,
    required this.acx_pick_data1,
    required this.ecs_recalc_reject,
    required this.sst1_error_disp,
    required this.sst1_cin_retry,
    required this.acx_resv_min5000,
    required this.acx_resv_min2000,
    required this.acx_resv_min1000,
    required this.acx_resv_min500,
    required this.acx_resv_min100,
    required this.acx_resv_min50,
    required this.acx_resv_min10,
    required this.acx_resv_min5,
    required this.acx_resv_min1,
    required this.acb50_ssw13_0,
    required this.acb50_ssw13_1_2,
    required this.acb50_ssw13_3_4,
    required this.acb50_ssw13_5,
    required this.acb50_ssw13_6,
    required this.chgdrw_inout_tran,
    required this.chgdrw_loan_tran,
    required this.acb50_ssw15_0,
    required this.acb50_ssw15_1,
    required this.acb50_ssw15_2,
    required this.acb50_ssw15_3,
    required this.acb50_ssw24_0,
    required this.ecs_gpd_1_1,
    required this.ecs_gpd_1_2,
    required this.ecs_gpd_2_1,
    required this.ecs_gpd_2_2,
    required this.ecs_gpd_3_1,
    required this.ecs_gpd_3_2,
    required this.ecs_gpd_4_1,
    required this.ecs_gpd_5_1,
    required this.ecs_gpd_5_2,
    required this.ecs_gpd_5_3,
    required this.chgdrw_in_tran_cd,
    required this.chgdrw_out_tran_cd,
    required this.acx_nearfull_diff,
    required this.ecs_pick_flg,
    required this.acx_pick_cbillkind,
    required this.acb50_ssw50_0_1,
    required this.acb50_ssw50_2,
    required this.acb50_ssw50_3,
    required this.acb50_ssw50_4_5,
    required this.acb50_ssw50_6_7,
    required this.acb_control_mode,
    required this.acx_resv_drw,
    required this.acx_resv_drw500,
    required this.acx_resv_drw100,
    required this.acx_resv_drw50,
    required this.acx_resv_drw10,
    required this.acx_resv_drw5,
    required this.acx_resv_drw1,
    required this.acx_auto_stop_sec,
    required this.ecs_gp2_3_2,
    required this.ecs_gp2_4_1,
    required this.ecs_gp2_4_2,
    required this.ecs_gp2_5_1,
    required this.ecs_gp7_1_1,
    required this.ecs_gp7_1_2,
    required this.ecs_gp7_1_3,
    required this.ecs_gp7_2_1,
    required this.ecs_gp7_2_2,
    required this.ecs_gp7_3_1,
    required this.ecs_gp7_4_1,
    required this.ecs_gp7_5_1,
    required this.ecs_gp7_5_2,
    required this.ecs_gpb_1_1,
    required this.ecs_gpb_2_1,
    required this.ecs_gpb_2_2,
    required this.ecs_gpb_2_3,
    required this.ecs_gpb_3_1,
    required this.ecs_gpb_3_2,
    required this.ecs_gpb_4_2,
    required this.ecs_gpb_4_3,
    required this.ecs_gpb_5_1,
    required this.ecs_gpb_5_2,
    required this.ecs_gpc_3_1_fwdl,
    required this.ecs_overflowpick_use,
  });

  @JsonKey(defaultValue: 0)
  int    acr50_ssw14_0;
  @JsonKey(defaultValue: 0)
  int    acr50_ssw14_1_2;
  @JsonKey(defaultValue: 0)
  int    acr50_ssw14_3_4;
  @JsonKey(defaultValue: 0)
  int    acr50_ssw14_5;
  @JsonKey(defaultValue: 0)
  int    acr50_ssw14_7;
  @JsonKey(defaultValue: 0)
  int    pick_end;
  @JsonKey(defaultValue: 0)
  int    acxreal_system;
  @JsonKey(defaultValue: 1)
  int    ecs_pick_positn10000;
  @JsonKey(defaultValue: 1)
  int    ecs_pick_positn5000;
  @JsonKey(defaultValue: 1)
  int    ecs_pick_positn2000;
  @JsonKey(defaultValue: 1)
  int    ecs_pick_positn1000;
  @JsonKey(defaultValue: 0)
  int    acx_pick_data10000;
  @JsonKey(defaultValue: 1)
  int    acx_pick_data5000;
  @JsonKey(defaultValue: 0)
  int    acx_pick_data2000;
  @JsonKey(defaultValue: 10)
  int    acx_pick_data1000;
  @JsonKey(defaultValue: 5)
  int    acx_pick_data500;
  @JsonKey(defaultValue: 5)
  int    acx_pick_data100;
  @JsonKey(defaultValue: 5)
  int    acx_pick_data50;
  @JsonKey(defaultValue: 5)
  int    acx_pick_data10;
  @JsonKey(defaultValue: 5)
  int    acx_pick_data5;
  @JsonKey(defaultValue: 5)
  int    acx_pick_data1;
  @JsonKey(defaultValue: 2)
  int    ecs_recalc_reject;
  @JsonKey(defaultValue: 0)
  int    sst1_error_disp;
  @JsonKey(defaultValue: 3)
  int    sst1_cin_retry;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min5000;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min2000;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min1000;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min500;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min100;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min50;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min10;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min5;
  @JsonKey(defaultValue: 0)
  int    acx_resv_min1;
  @JsonKey(defaultValue: 1)
  int    acb50_ssw13_0;
  @JsonKey(defaultValue: 1)
  int    acb50_ssw13_1_2;
  @JsonKey(defaultValue: 1)
  int    acb50_ssw13_3_4;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw13_5;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw13_6;
  @JsonKey(defaultValue: 0)
  int    chgdrw_inout_tran;
  @JsonKey(defaultValue: 0)
  int    chgdrw_loan_tran;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw15_0;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw15_1;
  @JsonKey(defaultValue: 1)
  int    acb50_ssw15_2;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw15_3;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw24_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_4_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_5_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_5_3;
  @JsonKey(defaultValue: 0)
  int    chgdrw_in_tran_cd;
  @JsonKey(defaultValue: 0)
  int    chgdrw_out_tran_cd;
  @JsonKey(defaultValue: 20)
  int    acx_nearfull_diff;
  @JsonKey(defaultValue: "000000")
  String ecs_pick_flg;
  @JsonKey(defaultValue: "0000000000")
  String acx_pick_cbillkind;
  @JsonKey(defaultValue: 2)
  int    acb50_ssw50_0_1;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw50_2;
  @JsonKey(defaultValue: 1)
  int    acb50_ssw50_3;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw50_4_5;
  @JsonKey(defaultValue: 0)
  int    acb50_ssw50_6_7;
  @JsonKey(defaultValue: 0)
  int    acb_control_mode;
  @JsonKey(defaultValue: 0)
  int    acx_resv_drw;
  @JsonKey(defaultValue: 0)
  int    acx_resv_drw500;
  @JsonKey(defaultValue: 0)
  int    acx_resv_drw100;
  @JsonKey(defaultValue: 0)
  int    acx_resv_drw50;
  @JsonKey(defaultValue: 0)
  int    acx_resv_drw10;
  @JsonKey(defaultValue: 0)
  int    acx_resv_drw5;
  @JsonKey(defaultValue: 0)
  int    acx_resv_drw1;
  @JsonKey(defaultValue: 30)
  int    acx_auto_stop_sec;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_4_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_4_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_1_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_2_2;
  @JsonKey(defaultValue: 2)
  int    ecs_gp7_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_4_1;
  @JsonKey(defaultValue: 2)
  int    ecs_gp7_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_5_2;
  @JsonKey(defaultValue: 2)
  int    ecs_gpb_1_1;
  @JsonKey(defaultValue: 1)
  int    ecs_gpb_2_1;
  @JsonKey(defaultValue: 1)
  int    ecs_gpb_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_2_3;
  @JsonKey(defaultValue: 3)
  int    ecs_gpb_3_1;
  @JsonKey(defaultValue: 1)
  int    ecs_gpb_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_4_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_4_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_5_2;
  @JsonKey(defaultValue: 115200)
  int    ecs_gpc_3_1_fwdl;
  @JsonKey(defaultValue: 0)
  int    ecs_overflowpick_use;
}

@JsonSerializable()
class _Acx_timer {
  factory _Acx_timer.fromJson(Map<String, dynamic> json) => _$Acx_timerFromJson(json);
  Map<String, dynamic> toJson() => _$Acx_timerToJson(this);

  _Acx_timer({
    required this.acx_enq_interval,
    required this.acx_enq_timeout,
    required this.acxreal_interval,
  });

  @JsonKey(defaultValue: 3)
  int    acx_enq_interval;
  @JsonKey(defaultValue: 30)
  int    acx_enq_timeout;
  @JsonKey(defaultValue: 3)
  int    acxreal_interval;
}

@JsonSerializable()
class _Eventinput {
  factory _Eventinput.fromJson(Map<String, dynamic> json) => _$EventinputFromJson(json);
  Map<String, dynamic> toJson() => _$EventinputToJson(this);

  _Eventinput({
    required this.event_cd,
    required this.logo_cd,
    required this.event_hall,
  });

  @JsonKey(defaultValue: "0000")
  String event_cd;
  @JsonKey(defaultValue: "01")
  String logo_cd;
  @JsonKey(defaultValue: 0)
  int    event_hall;
}

@JsonSerializable()
class _Acx_stop_info {
  factory _Acx_stop_info.fromJson(Map<String, dynamic> json) => _$Acx_stop_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Acx_stop_infoToJson(this);

  _Acx_stop_info({
    required this.acx_stop_5000,
    required this.acx_stop_2000,
    required this.acx_stop_1000,
    required this.acx_stop_500,
    required this.acx_stop_100,
    required this.acx_stop_50,
    required this.acx_stop_10,
    required this.acx_stop_5,
    required this.acx_stop_1,
  });

  @JsonKey(defaultValue: 0)
  int    acx_stop_5000;
  @JsonKey(defaultValue: 0)
  int    acx_stop_2000;
  @JsonKey(defaultValue: 9)
  int    acx_stop_1000;
  @JsonKey(defaultValue: 1)
  int    acx_stop_500;
  @JsonKey(defaultValue: 4)
  int    acx_stop_100;
  @JsonKey(defaultValue: 1)
  int    acx_stop_50;
  @JsonKey(defaultValue: 4)
  int    acx_stop_10;
  @JsonKey(defaultValue: 1)
  int    acx_stop_5;
  @JsonKey(defaultValue: 5)
  int    acx_stop_1;
}

@JsonSerializable()
class _Scanner {
  factory _Scanner.fromJson(Map<String, dynamic> json) => _$ScannerFromJson(json);
  Map<String, dynamic> toJson() => _$ScannerToJson(this);

  _Scanner({
    required this.scn_cmd_desktop,
    required this.scn_cmd_tower,
    required this.scn_cmd_add,
    required this.scan_dp_snd_desktop,
    required this.scan_dp_snd_tower,
    required this.scan_dp_snd_add,
    required this.scan_happyself_2nd,
    required this.scan_display_mode,
    required this.scan_barcode_payment,
    required this.beep_times,
    required this.beep_interval,
  });

  @JsonKey(defaultValue: 0)
  int    scn_cmd_desktop;
  @JsonKey(defaultValue: 0)
  int    scn_cmd_tower;
  @JsonKey(defaultValue: 0)
  int    scn_cmd_add;
  @JsonKey(defaultValue: 0)
  int    scan_dp_snd_desktop;
  @JsonKey(defaultValue: 0)
  int    scan_dp_snd_tower;
  @JsonKey(defaultValue: 0)
  int    scan_dp_snd_add;
  @JsonKey(defaultValue: 0)
  int    scan_happyself_2nd;
  @JsonKey(defaultValue: 0)
  int    scan_display_mode;
  @JsonKey(defaultValue: 0)
  int    scan_barcode_payment;
  @JsonKey(defaultValue: 1)
  int    beep_times;
  @JsonKey(defaultValue: 1)
  int    beep_interval;
}

@JsonSerializable()
class _CCT3100_Connection {
  factory _CCT3100_Connection.fromJson(Map<String, dynamic> json) => _$CCT3100_ConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$CCT3100_ConnectionToJson(this);

  _CCT3100_Connection({
    required this.ct3100_waite_time,
    required this.ct3100_point_type,
  });

  @JsonKey(defaultValue: 12)
  int    ct3100_waite_time;
  @JsonKey(defaultValue: 2)
  int    ct3100_point_type;
}

@JsonSerializable()
class _Upd_chk {
  factory _Upd_chk.fromJson(Map<String, dynamic> json) => _$Upd_chkFromJson(json);
  Map<String, dynamic> toJson() => _$Upd_chkToJson(this);

  _Upd_chk({
    required this.upd_err_rbt,
    required this.timeout,
  });

  @JsonKey(defaultValue: 0)
  int    upd_err_rbt;
  @JsonKey(defaultValue: 30)
  int    timeout;
}

@JsonSerializable()
class _Drugrev {
  factory _Drugrev.fromJson(Map<String, dynamic> json) => _$DrugrevFromJson(json);
  Map<String, dynamic> toJson() => _$DrugrevToJson(this);

  _Drugrev({
    required this.name,
  });

  @JsonKey(defaultValue: "drugrev")
  String name;
}

@JsonSerializable()
class _Center_server {
  factory _Center_server.fromJson(Map<String, dynamic> json) => _$Center_serverFromJson(json);
  Map<String, dynamic> toJson() => _$Center_serverToJson(this);

  _Center_server({
    required this.hist_cycle,
    required this.stcls_send,
    required this.bult_send,
    required this.tslnkweb_timeout,
    required this.pmod_dspmode,
  });

  @JsonKey(defaultValue: 10)
  int    hist_cycle;
  @JsonKey(defaultValue: 0)
  int    stcls_send;
  @JsonKey(defaultValue: 0)
  int    bult_send;
  @JsonKey(defaultValue: 60)
  int    tslnkweb_timeout;
  @JsonKey(defaultValue: 0)
  int    pmod_dspmode;
}

@JsonSerializable()
class _Print {
  factory _Print.fromJson(Map<String, dynamic> json) => _$PrintFromJson(json);
  Map<String, dynamic> toJson() => _$PrintToJson(this);

  _Print(
  );

}

@JsonSerializable()
class _Stopn_retry {
  factory _Stopn_retry.fromJson(Map<String, dynamic> json) => _$Stopn_retryFromJson(json);
  Map<String, dynamic> toJson() => _$Stopn_retryToJson(this);

  _Stopn_retry({
    required this.retry_cnt,
    required this.retry_inter,
    required this.cls_downset,
    required this.cls_downtime,
  });

  @JsonKey(defaultValue: 20)
  int    retry_cnt;
  @JsonKey(defaultValue: 5)
  int    retry_inter;
  @JsonKey(defaultValue: 0)
  int    cls_downset;
  @JsonKey(defaultValue: "0000")
  String cls_downtime;
}

@JsonSerializable()
class _Select_batrepo {
  factory _Select_batrepo.fromJson(Map<String, dynamic> json) => _$Select_batrepoFromJson(json);
  Map<String, dynamic> toJson() => _$Select_batrepoToJson(this);

  _Select_batrepo({
    required this.batch_no1,
    required this.batch_no2,
    required this.batch_no3,
    required this.batch_no4,
    required this.batch_no5,
    required this.batch_no6,
    required this.batch_no7,
    required this.batch_no8,
    required this.batch_no9,
  });

  @JsonKey(defaultValue: 0)
  int    batch_no1;
  @JsonKey(defaultValue: 0)
  int    batch_no2;
  @JsonKey(defaultValue: 0)
  int    batch_no3;
  @JsonKey(defaultValue: 0)
  int    batch_no4;
  @JsonKey(defaultValue: 0)
  int    batch_no5;
  @JsonKey(defaultValue: 0)
  int    batch_no6;
  @JsonKey(defaultValue: 0)
  int    batch_no7;
  @JsonKey(defaultValue: 0)
  int    batch_no8;
  @JsonKey(defaultValue: 0)
  int    batch_no9;
}

@JsonSerializable()
class _Ftp {
  factory _Ftp.fromJson(Map<String, dynamic> json) => _$FtpFromJson(json);
  Map<String, dynamic> toJson() => _$FtpToJson(this);

  _Ftp({
    required this.rpm_timeout,
    required this.rpm_retry,
    required this.landisk_timeout,
    required this.landisk_retry,
    required this.mcput_timeout,
    required this.mcput_retry,
    required this.mcget_timeout,
    required this.mcget_retry,
    required this.void_timeout,
    required this.void_retry,
    required this.hqput_timeout,
    required this.hqput_retry,
    required this.offset_speed,
    required this.error_timeout,
    required this.offset_timeout,
    required this.default_timeout,
  });

  @JsonKey(defaultValue: 600)
  int    rpm_timeout;
  @JsonKey(defaultValue: 2)
  int    rpm_retry;
  @JsonKey(defaultValue: 600)
  int    landisk_timeout;
  @JsonKey(defaultValue: 2)
  int    landisk_retry;
  @JsonKey(defaultValue: 600)
  int    mcput_timeout;
  @JsonKey(defaultValue: 1)
  int    mcput_retry;
  @JsonKey(defaultValue: 600)
  int    mcget_timeout;
  @JsonKey(defaultValue: 1)
  int    mcget_retry;
  @JsonKey(defaultValue: 90)
  int    void_timeout;
  @JsonKey(defaultValue: 1)
  int    void_retry;
  @JsonKey(defaultValue: 180)
  int    hqput_timeout;
  @JsonKey(defaultValue: 1)
  int    hqput_retry;
  @JsonKey(defaultValue: 5)
  int    offset_speed;
  @JsonKey(defaultValue: 240)
  int    error_timeout;
  @JsonKey(defaultValue: 60)
  int    offset_timeout;
  @JsonKey(defaultValue: 60)
  int    default_timeout;
}

@JsonSerializable()
class _Movsend {
  factory _Movsend.fromJson(Map<String, dynamic> json) => _$MovsendFromJson(json);
  Map<String, dynamic> toJson() => _$MovsendToJson(this);

  _Movsend({
    required this.avispace,
    required this.send_speed2,
    required this.extend_time,
    required this.taking_start,
    required this.usbcam_send,
  });

  @JsonKey(defaultValue: 12)
  int    avispace;
  @JsonKey(defaultValue: 500)
  int    send_speed2;
  @JsonKey(defaultValue: 10)
  int    extend_time;
  @JsonKey(defaultValue: 0)
  int    taking_start;
  @JsonKey(defaultValue: 0)
  int    usbcam_send;
}

@JsonSerializable()
class _Disk_free {
  factory _Disk_free.fromJson(Map<String, dynamic> json) => _$Disk_freeFromJson(json);
  Map<String, dynamic> toJson() => _$Disk_freeToJson(this);

  _Disk_free({
    required this.limit_size,
    required this.stat,
  });

  @JsonKey(defaultValue: 2500)
  int    limit_size;
  @JsonKey(defaultValue: 0)
  int    stat;
}

@JsonSerializable()
class _Other {
  factory _Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);
  Map<String, dynamic> toJson() => _$OtherToJson(this);

  _Other({
    required this.ut1_wait,
    required this.multi_vega_env,
    required this.quo_useup_flg,
    required this.jpqr_err_nonprint,
  });

  @JsonKey(defaultValue: 10)
  int    ut1_wait;
  @JsonKey(defaultValue: 0)
  int    multi_vega_env;
  @JsonKey(defaultValue: 0)
  int    quo_useup_flg;
  @JsonKey(defaultValue: 0)
  int    jpqr_err_nonprint;
}

@JsonSerializable()
class _Sqrc_sys {
  factory _Sqrc_sys.fromJson(Map<String, dynamic> json) => _$Sqrc_sysFromJson(json);
  Map<String, dynamic> toJson() => _$Sqrc_sysToJson(this);

  _Sqrc_sys({
    required this.sqrc_back_timer,
  });

  @JsonKey(defaultValue: 30)
  int    sqrc_back_timer;
}

@JsonSerializable()
class _Histlog_get {
  factory _Histlog_get.fromJson(Map<String, dynamic> json) => _$Histlog_getFromJson(json);
  Map<String, dynamic> toJson() => _$Histlog_getToJson(this);

  _Histlog_get({
    required this.histlog_get_change,
  });

  @JsonKey(defaultValue: 0)
  int    histlog_get_change;
}

@JsonSerializable()
class _Sims_cnct {
  factory _Sims_cnct.fromJson(Map<String, dynamic> json) => _$Sims_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Sims_cnctToJson(this);

  _Sims_cnct({
    required this.cls_wait_time,
  });

  @JsonKey(defaultValue: 300)
  int    cls_wait_time;
}

@JsonSerializable()
class _Step2_bar {
  factory _Step2_bar.fromJson(Map<String, dynamic> json) => _$Step2_barFromJson(json);
  Map<String, dynamic> toJson() => _$Step2_barToJson(this);

  _Step2_bar({
    required this.step2_bar_order,
  });

  @JsonKey(defaultValue: 0)
  int    step2_bar_order;
}

@JsonSerializable()
class _Tax_free {
  factory _Tax_free.fromJson(Map<String, dynamic> json) => _$Tax_freeFromJson(json);
  Map<String, dynamic> toJson() => _$Tax_freeToJson(this);

  _Tax_free({
    required this.tax_free_add,
  });

  @JsonKey(defaultValue: 0)
  int    tax_free_add;
}

@JsonSerializable()
class _Stcls {
  factory _Stcls.fromJson(Map<String, dynamic> json) => _$StclsFromJson(json);
  Map<String, dynamic> toJson() => _$StclsToJson(this);

  _Stcls({
    required this.tran_interval,
  });

  @JsonKey(defaultValue: 2)
  int    tran_interval;
}

@JsonSerializable()
class _Ticket {
  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
  Map<String, dynamic> toJson() => _$TicketToJson(this);

  _Ticket({
    required this.ticket_cnt,
  });

  @JsonKey(defaultValue: 0)
  int    ticket_cnt;
}

@JsonSerializable()
class _Z_system {
  factory _Z_system.fromJson(Map<String, dynamic> json) => _$Z_systemFromJson(json);
  Map<String, dynamic> toJson() => _$Z_systemToJson(this);

  _Z_system({
    required this.z_demo_mode,
  });

  @JsonKey(defaultValue: 0)
  int    z_demo_mode;
}

@JsonSerializable()
class _Dpoint {
  factory _Dpoint.fromJson(Map<String, dynamic> json) => _$DpointFromJson(json);
  Map<String, dynamic> toJson() => _$DpointToJson(this);

  _Dpoint({
    required this.client,
    required this.branch,
    required this.store,
    required this.srvdate,
    required this.backup_macno,
  });

  @JsonKey(defaultValue: "")
  String client;
  @JsonKey(defaultValue: 0)
  int    branch;
  @JsonKey(defaultValue: 0)
  int    store;
  @JsonKey(defaultValue: "2019-01-01")
  String srvdate;
  @JsonKey(defaultValue: 0)
  int    backup_macno;
}

@JsonSerializable()
class _Tslnkweb_sys {
  factory _Tslnkweb_sys.fromJson(Map<String, dynamic> json) => _$Tslnkweb_sysFromJson(json);
  Map<String, dynamic> toJson() => _$Tslnkweb_sysToJson(this);

  _Tslnkweb_sys({
    required this.mkttl_timeout,
  });

  @JsonKey(defaultValue: 120)
  int    mkttl_timeout;
}

@JsonSerializable()
class _Coupon_off {
  factory _Coupon_off.fromJson(Map<String, dynamic> json) => _$Coupon_offFromJson(json);
  Map<String, dynamic> toJson() => _$Coupon_offToJson(this);

  _Coupon_off({
    required this.coupon_off_flg,
  });

  @JsonKey(defaultValue: 0)
  int    coupon_off_flg;
}

@JsonSerializable()
class _Scalerm {
  factory _Scalerm.fromJson(Map<String, dynamic> json) => _$ScalermFromJson(json);
  Map<String, dynamic> toJson() => _$ScalermToJson(this);

  _Scalerm({
    required this.over_plu_tare,
    required this.tare_auto_clear,
    required this.ad_res_watch,
  });

  @JsonKey(defaultValue: 0)
  int    over_plu_tare;
  @JsonKey(defaultValue: 0)
  int    tare_auto_clear;
  @JsonKey(defaultValue: 30)
  int    ad_res_watch;
}

@JsonSerializable()
class _Tax {
  factory _Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);
  Map<String, dynamic> toJson() => _$TaxToJson(this);

  _Tax({
    required this.realitmsend_add,
  });

  @JsonKey(defaultValue: 0)
  int    realitmsend_add;
}

@JsonSerializable()
class _Leavegate {
  factory _Leavegate.fromJson(Map<String, dynamic> json) => _$LeavegateFromJson(json);
  Map<String, dynamic> toJson() => _$LeavegateToJson(this);

  _Leavegate({
    required this.leave_ip01,
    required this.leave_port01,
  });

  @JsonKey(defaultValue: "0.0.0.0")
  String leave_ip01;
  @JsonKey(defaultValue: 4444)
  int    leave_port01;
}

