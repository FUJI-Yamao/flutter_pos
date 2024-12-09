/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'counterJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class CounterJsonFile extends ConfigJsonFile {
  static final CounterJsonFile _instance = CounterJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "counter.json";

  CounterJsonFile(){
    setPath(_confPath, _fileName);
  }
  CounterJsonFile._internal();

  factory CounterJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$CounterJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$CounterJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$CounterJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        tran = _$TranFromJson(jsonD['tran']);
      } catch(e) {
        tran = _$TranFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Tran tran = _Tran(
    rcpt_no                            : 0,
    print_no                           : 0,
    sale_date                          : "",
    last_sale_date                     : "",
    receipt_no                         : 0,
    debit_no                           : 0,
    credit_no                          : 0,
    last_ej_bkup                       : "",
    last_data_bkup                     : "",
    guarantee_no                       : 0,
    ttllog_all_cnt                     : 0,
    ttllog_m_cnt                       : 0,
    ttllog_bs_cnt                      : 0,
    pos_no                             : 0,
    onetime_no                         : 0,
    cardcash_no                        : 0,
    nocardcash_no                      : 0,
    cardfee_no                         : 0,
    othcrdt_no                         : 0,
    owncrdt_no                         : 0,
    crdtcan_no                         : 0,
    poppy_cnt                          : 0,
    nttasp_credit_no                   : 0,
    nttasp_corr_stat                   : 0,
    nttasp_corr_reno                   : 0,
    nttasp_corr_date                   : "",
    eat_in_now                         : 0,
    tw_no                              : 0,
    edy_pos_id                         : 0,
    sip_pos_ky                         : 0,
    encrypt_PidNew                     : "",
    encrypt_ErK1di                     : "",
    encrypt_send_date                  : "",
    encrypt_credit_no                  : "",
    deliv_rct_no                       : 0,
    order_no                           : 0,
    slip_no                            : 0,
    com_seq_no                         : 0,
    qs_at_clstime                      : "",
    qs_at_waittimer                    : 0,
    qs_at_opndatetime                  : "",
    fcl_dll_fix_time                   : "",
    end_saletime                       : "",
    qs_at_cls                          : 0,
    mbrdsctckt_no                      : 0,
    ht2980_seq_no                      : 0,
    duty_ej_count                      : 0,
    last_clr_total                     : "",
    special_user_count                 : 0,
    mbr_prize_counter                  : 0,
    sqrc_tct_cnt                       : 0,
    P11_prize_counter                  : 0,
    P7_prize_counter                   : 0,
    p11_prize_group_counter            : 0,
    strcls_counter                     : 0,
    stropn_counter                     : 0,
    last_rdly_clear                    : "",
    cr2_chgcin_no                      : 0,
    cr2_chgout_no                      : 0,
    now_open_datetime                  : "",
    certificate_no                     : 0,
    cct_seq_no                         : 0,
    dpoint_proc_no                     : 0,
    fresta_slip_no                     : 0,
    credit_no_vega                     : 0,
  );
}

@JsonSerializable()
class _Tran {
  factory _Tran.fromJson(Map<String, dynamic> json) => _$TranFromJson(json);
  Map<String, dynamic> toJson() => _$TranToJson(this);

  _Tran({
    required this.rcpt_no,
    required this.print_no,
    required this.sale_date,
    required this.last_sale_date,
    required this.receipt_no,
    required this.debit_no,
    required this.credit_no,
    required this.last_ej_bkup,
    required this.last_data_bkup,
    required this.guarantee_no,
    required this.ttllog_all_cnt,
    required this.ttllog_m_cnt,
    required this.ttllog_bs_cnt,
    required this.pos_no,
    required this.onetime_no,
    required this.cardcash_no,
    required this.nocardcash_no,
    required this.cardfee_no,
    required this.othcrdt_no,
    required this.owncrdt_no,
    required this.crdtcan_no,
    required this.poppy_cnt,
    required this.nttasp_credit_no,
    required this.nttasp_corr_stat,
    required this.nttasp_corr_reno,
    required this.nttasp_corr_date,
    required this.eat_in_now,
    required this.tw_no,
    required this.edy_pos_id,
    required this.sip_pos_ky,
    required this.encrypt_PidNew,
    required this.encrypt_ErK1di,
    required this.encrypt_send_date,
    required this.encrypt_credit_no,
    required this.deliv_rct_no,
    required this.order_no,
    required this.slip_no,
    required this.com_seq_no,
    required this.qs_at_clstime,
    required this.qs_at_waittimer,
    required this.qs_at_opndatetime,
    required this.fcl_dll_fix_time,
    required this.end_saletime,
    required this.qs_at_cls,
    required this.mbrdsctckt_no,
    required this.ht2980_seq_no,
    required this.duty_ej_count,
    required this.last_clr_total,
    required this.special_user_count,
    required this.mbr_prize_counter,
    required this.sqrc_tct_cnt,
    required this.P11_prize_counter,
    required this.P7_prize_counter,
    required this.p11_prize_group_counter,
    required this.strcls_counter,
    required this.stropn_counter,
    required this.last_rdly_clear,
    required this.cr2_chgcin_no,
    required this.cr2_chgout_no,
    required this.now_open_datetime,
    required this.certificate_no,
    required this.cct_seq_no,
    required this.dpoint_proc_no,
    required this.fresta_slip_no,
    required this.credit_no_vega,
  });

  @JsonKey(defaultValue: 1)
  int    rcpt_no;
  @JsonKey(defaultValue: 1)
  int    print_no;
  @JsonKey(defaultValue: "0000-00-00")
  String sale_date;
  @JsonKey(defaultValue: "0000-00-00")
  String last_sale_date;
  @JsonKey(defaultValue: 1)
  int    receipt_no;
  @JsonKey(defaultValue: 1)
  int    debit_no;
  @JsonKey(defaultValue: 1)
  int    credit_no;
  @JsonKey(defaultValue: "0000-00-00")
  String last_ej_bkup;
  @JsonKey(defaultValue: "0000-00-00")
  String last_data_bkup;
  @JsonKey(defaultValue: 1)
  int    guarantee_no;
  @JsonKey(defaultValue: 0)
  int    ttllog_all_cnt;
  @JsonKey(defaultValue: 0)
  int    ttllog_m_cnt;
  @JsonKey(defaultValue: 0)
  int    ttllog_bs_cnt;
  @JsonKey(defaultValue: 1)
  int    pos_no;
  @JsonKey(defaultValue: 500001)
  int    onetime_no;
  @JsonKey(defaultValue: 800001)
  int    cardcash_no;
  @JsonKey(defaultValue: 900001)
  int    nocardcash_no;
  @JsonKey(defaultValue: 1)
  int    cardfee_no;
  @JsonKey(defaultValue: 300001)
  int    othcrdt_no;
  @JsonKey(defaultValue: 1)
  int    owncrdt_no;
  @JsonKey(defaultValue: 1)
  int    crdtcan_no;
  @JsonKey(defaultValue: 0)
  int    poppy_cnt;
  @JsonKey(defaultValue: 1)
  int    nttasp_credit_no;
  @JsonKey(defaultValue: 0)
  int    nttasp_corr_stat;
  @JsonKey(defaultValue: 0)
  int    nttasp_corr_reno;
  @JsonKey(defaultValue: "00-00 00:00:00")
  String nttasp_corr_date;
  @JsonKey(defaultValue: 1)
  int    eat_in_now;
  @JsonKey(defaultValue: 0)
  int    tw_no;
  @JsonKey(defaultValue: 0)
  int    edy_pos_id;
  @JsonKey(defaultValue: 0)
  int    sip_pos_ky;
  @JsonKey(defaultValue: "00000000")
  String encrypt_PidNew;
  @JsonKey(defaultValue: "00000000")
  String encrypt_ErK1di;
  @JsonKey(defaultValue: "0000000000")
  String encrypt_send_date;
  @JsonKey(defaultValue: "00000")
  String encrypt_credit_no;
  @JsonKey(defaultValue: 1)
  int    deliv_rct_no;
  @JsonKey(defaultValue: 1)
  int    order_no;
  @JsonKey(defaultValue: 1)
  int    slip_no;
  @JsonKey(defaultValue: 2)
  int    com_seq_no;
  @JsonKey(defaultValue: "")
  String qs_at_clstime;
  @JsonKey(defaultValue: 60)
  int    qs_at_waittimer;
  @JsonKey(defaultValue: "000000000000")
  String qs_at_opndatetime;
  @JsonKey(defaultValue: "0000000000")
  String fcl_dll_fix_time;
  @JsonKey(defaultValue: "0000-00-00 00:00:00")
  String end_saletime;
  @JsonKey(defaultValue: 0)
  int    qs_at_cls;
  @JsonKey(defaultValue: 1)
  int    mbrdsctckt_no;
  @JsonKey(defaultValue: 1)
  int    ht2980_seq_no;
  @JsonKey(defaultValue: 0)
  int    duty_ej_count;
  @JsonKey(defaultValue: "0000-00-00")
  String last_clr_total;
  @JsonKey(defaultValue: 1)
  int    special_user_count;
  @JsonKey(defaultValue: 1)
  int    mbr_prize_counter;
  @JsonKey(defaultValue: 1)
  int    sqrc_tct_cnt;
  @JsonKey(defaultValue: 1)
  int    P11_prize_counter;
  @JsonKey(defaultValue: 1)
  int    P7_prize_counter;
  @JsonKey(defaultValue: 1)
  int    p11_prize_group_counter;
  @JsonKey(defaultValue: 0)
  int    strcls_counter;
  @JsonKey(defaultValue: 0)
  int    stropn_counter;
  @JsonKey(defaultValue: "0000-00-00")
  String last_rdly_clear;
  @JsonKey(defaultValue: 1)
  int    cr2_chgcin_no;
  @JsonKey(defaultValue: 1)
  int    cr2_chgout_no;
  @JsonKey(defaultValue: "00000000000000")
  String now_open_datetime;
  @JsonKey(defaultValue: 1)
  int    certificate_no;
  @JsonKey(defaultValue: 1)
  int    cct_seq_no;
  @JsonKey(defaultValue: 1)
  int    dpoint_proc_no;
  @JsonKey(defaultValue: 1)
  int    fresta_slip_no;
  @JsonKey(defaultValue: 1)
  int    credit_no_vega;
}

