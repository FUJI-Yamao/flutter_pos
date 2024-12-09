// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proc_conJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proc_conJsonFile _$Proc_conJsonFileFromJson(Map<String, dynamic> json) =>
    Proc_conJsonFile()
      ..regs = _Regs.fromJson(json['regs'] as Map<String, dynamic>)
      ..regs_opt = _Regs_opt.fromJson(json['regs_opt'] as Map<String, dynamic>)
      ..regs_opt_dual =
          _Regs_opt_dual.fromJson(json['regs_opt_dual'] as Map<String, dynamic>)
      ..streopncls =
          _Streopncls.fromJson(json['streopncls'] as Map<String, dynamic>)
      ..menu = _Menu.fromJson(json['menu'] as Map<String, dynamic>)
      ..startup = _Startup.fromJson(json['startup'] as Map<String, dynamic>)
      ..another1 = _Another1.fromJson(json['another1'] as Map<String, dynamic>)
      ..another2 = _Another2.fromJson(json['another2'] as Map<String, dynamic>)
      ..simple2stf =
          _Simple2stf.fromJson(json['simple2stf'] as Map<String, dynamic>)
      ..simple2stf_dual = _Simple2stf_dual.fromJson(
          json['simple2stf_dual'] as Map<String, dynamic>)
      ..bank_prg = _Bank_prg.fromJson(json['bank_prg'] as Map<String, dynamic>)
      ..proc_id = _Proc_id.fromJson(json['proc_id'] as Map<String, dynamic>)
      ..FenceOver =
          _FFenceOver.fromJson(json['FenceOver'] as Map<String, dynamic>)
      ..EjConf = _EEjConf.fromJson(json['EjConf'] as Map<String, dynamic>)
      ..CashRecycle =
          _CCashRecycle.fromJson(json['CashRecycle'] as Map<String, dynamic>);

Map<String, dynamic> _$Proc_conJsonFileToJson(Proc_conJsonFile instance) =>
    <String, dynamic>{
      'regs': instance.regs.toJson(),
      'regs_opt': instance.regs_opt.toJson(),
      'regs_opt_dual': instance.regs_opt_dual.toJson(),
      'streopncls': instance.streopncls.toJson(),
      'menu': instance.menu.toJson(),
      'startup': instance.startup.toJson(),
      'another1': instance.another1.toJson(),
      'another2': instance.another2.toJson(),
      'simple2stf': instance.simple2stf.toJson(),
      'simple2stf_dual': instance.simple2stf_dual.toJson(),
      'bank_prg': instance.bank_prg.toJson(),
      'proc_id': instance.proc_id.toJson(),
      'FenceOver': instance.FenceOver.toJson(),
      'EjConf': instance.EjConf.toJson(),
      'CashRecycle': instance.CashRecycle.toJson(),
    };

_Regs _$RegsFromJson(Map<String, dynamic> json) => _Regs(
      entry01: json['entry01'] as String? ?? 'print',
      entry02: json['entry02'] as String? ?? 'drw',
      entry03: json['entry03'] as String? ?? 'print_jc_c',
      entry04: json['entry04'] as String? ?? 'print_kitchen1',
      entry05: json['entry05'] as String? ?? 'print_kitchen2',
    );

Map<String, dynamic> _$RegsToJson(_Regs instance) => <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
      'entry03': instance.entry03,
      'entry04': instance.entry04,
      'entry05': instance.entry05,
    };

_Regs_opt _$Regs_optFromJson(Map<String, dynamic> json) => _Regs_opt(
      entry01: json['entry01'] as String? ?? 'spool',
      entry02: json['entry02'] as String? ?? 'acx',
      entry03: json['entry03'] as String? ?? 'jpo',
      entry04: json['entry04'] as String? ?? 'scl',
      entry05: json['entry05'] as String? ?? 'rwc',
      entry06: json['entry06'] as String? ?? 'sgscl1',
      entry07: json['entry07'] as String? ?? 'sgscl2',
      entry08: json['entry08'] as String? ?? 's2pr',
      entry09: json['entry09'] as String? ?? 'cashier',
      entry10: json['entry10'] as String? ?? 'stpr2',
      entry11: json['entry11'] as String? ?? 'mp1',
      entry12: json['entry12'] as String? ?? 'multi',
      entry13: json['entry13'] as String? ?? 'custreal',
      entry14: json['entry14'] as String? ?? 'custreal2',
      entry15: json['entry15'] as String? ?? 'custreal_netdoa',
    );

Map<String, dynamic> _$Regs_optToJson(_Regs_opt instance) => <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
      'entry03': instance.entry03,
      'entry04': instance.entry04,
      'entry05': instance.entry05,
      'entry06': instance.entry06,
      'entry07': instance.entry07,
      'entry08': instance.entry08,
      'entry09': instance.entry09,
      'entry10': instance.entry10,
      'entry11': instance.entry11,
      'entry12': instance.entry12,
      'entry13': instance.entry13,
      'entry14': instance.entry14,
      'entry15': instance.entry15,
    };

_Regs_opt_dual _$Regs_opt_dualFromJson(Map<String, dynamic> json) =>
    _Regs_opt_dual(
      entry01: json['entry01'] as String? ?? 'spool',
      entry02: json['entry02'] as String? ?? 'acx',
      entry03: json['entry03'] as String? ?? 'jpo',
      entry04: json['entry04'] as String? ?? 'scl',
      entry05: json['entry05'] as String? ?? 'rwc',
      entry06: json['entry06'] as String? ?? 'sgscl1',
      entry07: json['entry07'] as String? ?? 'sgscl2',
      entry08: json['entry08'] as String? ?? 's2pr',
      entry09: json['entry09'] as String? ?? 'stpr2',
      entry10: json['entry10'] as String? ?? 'fb_SelfMovie',
      entry11: json['entry11'] as String? ?? 'mp1',
      entry12: json['entry12'] as String? ?? 'multi',
      entry13: json['entry13'] as String? ?? 'fb_Movie',
      entry14: json['entry14'] as String? ?? 'custreal',
      entry15: json['entry15'] as String? ?? 'custreal2',
      entry16: json['entry16'] as String? ?? 'custreal_netdoa',
      entry17: json['entry17'] as String? ?? 'qcConnect',
      entry18: json['entry18'] as String? ?? 'credit',
      entry19: json['entry19'] as String? ?? 'nttd_preca',
      entry20: json['entry20'] as String? ?? 'sqrc',
      entry21: json['entry21'] as String? ?? 'trk_preca',
      entry22: json['entry22'] as String? ?? 'repica',
      entry23: json['entry23'] as String? ?? 'custreal2_pa',
      entry24: json['entry24'] as String? ?? 'custreal_odbc',
      entry25: json['entry25'] as String? ?? 'cogca',
      entry26: json['entry26'] as String? ?? 'basket_server',
      entry27: json['entry27'] as String? ?? 'vega3000',
      entry28: json['entry28'] as String? ?? 'dpoint',
      entry29: json['entry29'] as String? ?? 'ajs_emoney',
      entry30: json['entry30'] as String? ?? 'valuecard',
      entry31: json['entry31'] as String? ?? 'rpoint',
      entry32: json['entry32'] as String? ?? 'tpoint',
    );

Map<String, dynamic> _$Regs_opt_dualToJson(_Regs_opt_dual instance) =>
    <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
      'entry03': instance.entry03,
      'entry04': instance.entry04,
      'entry05': instance.entry05,
      'entry06': instance.entry06,
      'entry07': instance.entry07,
      'entry08': instance.entry08,
      'entry09': instance.entry09,
      'entry10': instance.entry10,
      'entry11': instance.entry11,
      'entry12': instance.entry12,
      'entry13': instance.entry13,
      'entry14': instance.entry14,
      'entry15': instance.entry15,
      'entry16': instance.entry16,
      'entry17': instance.entry17,
      'entry18': instance.entry18,
      'entry19': instance.entry19,
      'entry20': instance.entry20,
      'entry21': instance.entry21,
      'entry22': instance.entry22,
      'entry23': instance.entry23,
      'entry24': instance.entry24,
      'entry25': instance.entry25,
      'entry26': instance.entry26,
      'entry27': instance.entry27,
      'entry28': instance.entry28,
      'entry29': instance.entry29,
      'entry30': instance.entry30,
      'entry31': instance.entry31,
      'entry32': instance.entry32,
    };

_Streopncls _$StreopnclsFromJson(Map<String, dynamic> json) => _Streopncls(
      entry01: json['entry01'] as String? ?? 'stropncls',
      entry02: json['entry02'] as String? ?? 'jpo',
    );

Map<String, dynamic> _$StreopnclsToJson(_Streopncls instance) =>
    <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
    };

_Menu _$MenuFromJson(Map<String, dynamic> json) => _Menu(
      entry01: json['entry01'] as String? ?? 'acxreal',
    );

Map<String, dynamic> _$MenuToJson(_Menu instance) => <String, dynamic>{
      'entry01': instance.entry01,
    };

_Startup _$StartupFromJson(Map<String, dynamic> json) => _Startup(
      entry01: json['entry01'] as String? ?? 'csvsend',
      entry02: json['entry02'] as String? ?? 'iis',
      entry03: json['entry03'] as String? ?? 'tprapl_reglog',
      entry04: json['entry04'] as String? ?? 'mobile',
      entry05: json['entry05'] as String? ?? 'stpr',
      entry06: json['entry06'] as String? ?? 'pmod',
      entry07: json['entry07'] as String? ?? 'sale_com_mm',
      entry08: json['entry08'] as String? ?? 'menteserver',
      entry09: json['entry09'] as String? ?? 'menteclient',
      entry10: json['entry10'] as String? ?? 'sound_con',
      entry11: json['entry11'] as String? ?? 'mcftp',
      entry12: json['entry12'] as String? ?? 'upd_con',
      entry13: json['entry13'] as String? ?? 'ecoaserver',
      entry14: json['entry14'] as String? ?? 'kill_proc',
      entry15: json['entry15'] as String? ?? 'keyb',
      entry16: json['entry16'] as String? ?? 'multi',
      entry17: json['entry17'] as String? ?? 'icc',
      entry18: json['entry18'] as String? ?? 'drugrevs',
      entry19: json['entry19'] as String? ?? 'tprapl_tprt',
      entry20: json['entry20'] as String? ?? 'jpo',
      entry21: json['entry21'] as String? ?? 'pbchg_log_send',
      entry22: json['entry22'] as String? ?? 'ftp',
      entry23: json['entry23'] as String? ?? 'spqcs',
      entry24: json['entry24'] as String? ?? 'spqcc',
      entry25: json['entry25'] as String? ?? 'pbchg_test_server',
      entry26: json['entry26'] as String? ?? 'WizS',
      entry27: json['entry27'] as String? ?? 'qcSelectServer',
      entry28: json['entry28'] as String? ?? 'moviesend',
      entry29: json['entry29'] as String? ?? 'credit',
      entry30: json['entry30'] as String? ?? 'qcConnectServer',
      entry31: json['entry31'] as String? ?? 'custreal_nec',
      entry32: json['entry32'] as String? ?? 'masr',
      entry33: json['entry33'] as String? ?? 'multi_tmn',
      entry34: json['entry34'] as String? ?? 'multi_glory',
      entry35: json['entry35'] as String? ?? 'suica',
      entry36: json['entry36'] as String? ?? 'netdoa_pqs',
      entry37: json['entry37'] as String? ?? 'tpoint_ftp',
      entry38: json['entry38'] as String? ?? 'taxfree',
      entry39: json['entry39'] as String? ?? 'multi_tmn_vega3000',
      entry40: json['entry40'] as String? ?? 'basket_server',
      entry41: json['entry41'] as String? ?? 'acttrigger',
    );

Map<String, dynamic> _$StartupToJson(_Startup instance) => <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
      'entry03': instance.entry03,
      'entry04': instance.entry04,
      'entry05': instance.entry05,
      'entry06': instance.entry06,
      'entry07': instance.entry07,
      'entry08': instance.entry08,
      'entry09': instance.entry09,
      'entry10': instance.entry10,
      'entry11': instance.entry11,
      'entry12': instance.entry12,
      'entry13': instance.entry13,
      'entry14': instance.entry14,
      'entry15': instance.entry15,
      'entry16': instance.entry16,
      'entry17': instance.entry17,
      'entry18': instance.entry18,
      'entry19': instance.entry19,
      'entry20': instance.entry20,
      'entry21': instance.entry21,
      'entry22': instance.entry22,
      'entry23': instance.entry23,
      'entry24': instance.entry24,
      'entry25': instance.entry25,
      'entry26': instance.entry26,
      'entry27': instance.entry27,
      'entry28': instance.entry28,
      'entry29': instance.entry29,
      'entry30': instance.entry30,
      'entry31': instance.entry31,
      'entry32': instance.entry32,
      'entry33': instance.entry33,
      'entry34': instance.entry34,
      'entry35': instance.entry35,
      'entry36': instance.entry36,
      'entry37': instance.entry37,
      'entry38': instance.entry38,
      'entry39': instance.entry39,
      'entry40': instance.entry40,
      'entry41': instance.entry41,
    };

_Another1 _$Another1FromJson(Map<String, dynamic> json) => _Another1(
      entry01: json['entry01'] as String? ?? 'mente',
      entry02: json['entry02'] as String? ?? 'usetup',
      entry03: json['entry03'] as String? ?? 'history_get',
    );

Map<String, dynamic> _$Another1ToJson(_Another1 instance) => <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
      'entry03': instance.entry03,
    };

_Another2 _$Another2FromJson(Map<String, dynamic> json) => _Another2(
      entry01: json['entry01'] as String? ?? 'tcount',
      entry02: json['entry02'] as String? ?? 'fcon',
      entry03: json['entry03'] as String? ?? 'freq',
      entry04: json['entry04'] as String? ?? 'pmod_regctrl',
      entry05: json['entry05'] as String? ?? 'retotal',
      entry06: json['entry06'] as String? ?? 'cust_enq_clr',
      entry07: json['entry07'] as String? ?? 'resimslog',
    );

Map<String, dynamic> _$Another2ToJson(_Another2 instance) => <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
      'entry03': instance.entry03,
      'entry04': instance.entry04,
      'entry05': instance.entry05,
      'entry06': instance.entry06,
      'entry07': instance.entry07,
    };

_Simple2stf _$Simple2stfFromJson(Map<String, dynamic> json) => _Simple2stf(
      entry01: json['entry01'] as String? ?? 'spool',
      entry02: json['entry02'] as String? ?? 'cashier',
    );

Map<String, dynamic> _$Simple2stfToJson(_Simple2stf instance) =>
    <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
    };

_Simple2stf_dual _$Simple2stf_dualFromJson(Map<String, dynamic> json) =>
    _Simple2stf_dual(
      entry01: json['entry01'] as String? ?? 'spool',
    );

Map<String, dynamic> _$Simple2stf_dualToJson(_Simple2stf_dual instance) =>
    <String, dynamic>{
      'entry01': instance.entry01,
    };

_Bank_prg _$Bank_prgFromJson(Map<String, dynamic> json) => _Bank_prg(
      entry01: json['entry01'] as String? ?? 'bankprg',
    );

Map<String, dynamic> _$Bank_prgToJson(_Bank_prg instance) => <String, dynamic>{
      'entry01': instance.entry01,
    };

_Proc_id _$Proc_idFromJson(Map<String, dynamic> json) => _Proc_id(
      sound: json['sound'] as int? ?? 0,
      sound2: json['sound2'] as int? ?? 0,
    );

Map<String, dynamic> _$Proc_idToJson(_Proc_id instance) => <String, dynamic>{
      'sound': instance.sound,
      'sound2': instance.sound2,
    };

_FFenceOver _$FFenceOverFromJson(Map<String, dynamic> json) => _FFenceOver(
      entry01: json['entry01'] as String? ?? 'custd_srch',
      entry02: json['entry02'] as String? ?? 'custd_hist',
      entry03: json['entry03'] as String? ?? 'custd_mtg',
      entry04: json['entry04'] as String? ?? 'prg_cust_popup',
      entry05: json['entry05'] as String? ?? 'cd_contents',
      entry06: json['entry06'] as String? ?? 'reserv_conf',
      entry07: json['entry07'] as String? ?? 'chprice',
      entry08: json['entry08'] as String? ?? 'autotest',
      entry09: json['entry09'] as String? ?? 'pbchg_util',
      entry10: json['entry10'] as String? ?? 'Cons',
      entry11: json['entry11'] as String? ?? 'DSft',
      entry12: json['entry12'] as String? ?? 'FMente',
      entry13: json['entry13'] as String? ?? 'acx_recalc_g',
      entry14: json['entry14'] as String? ?? 'acx_recalc',
    );

Map<String, dynamic> _$FFenceOverToJson(_FFenceOver instance) =>
    <String, dynamic>{
      'entry01': instance.entry01,
      'entry02': instance.entry02,
      'entry03': instance.entry03,
      'entry04': instance.entry04,
      'entry05': instance.entry05,
      'entry06': instance.entry06,
      'entry07': instance.entry07,
      'entry08': instance.entry08,
      'entry09': instance.entry09,
      'entry10': instance.entry10,
      'entry11': instance.entry11,
      'entry12': instance.entry12,
      'entry13': instance.entry13,
      'entry14': instance.entry14,
    };

_EEjConf _$EEjConfFromJson(Map<String, dynamic> json) => _EEjConf(
      entry01: json['entry01'] as String? ?? 'fb_Movie',
    );

Map<String, dynamic> _$EEjConfToJson(_EEjConf instance) => <String, dynamic>{
      'entry01': instance.entry01,
    };

_CCashRecycle _$CCashRecycleFromJson(Map<String, dynamic> json) =>
    _CCashRecycle(
      entry01: json['entry01'] as String? ?? 'cash_recycle',
    );

Map<String, dynamic> _$CCashRecycleToJson(_CCashRecycle instance) =>
    <String, dynamic>{
      'entry01': instance.entry01,
    };
