/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'proc_conJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Proc_conJsonFile extends ConfigJsonFile {
  static final Proc_conJsonFile _instance = Proc_conJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "proc_con.json";

  Proc_conJsonFile(){
    setPath(_confPath, _fileName);
  }
  Proc_conJsonFile._internal();

  factory Proc_conJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Proc_conJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Proc_conJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Proc_conJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        regs = _$RegsFromJson(jsonD['regs']);
      } catch(e) {
        regs = _$RegsFromJson({});
        ret = false;
      }
      try {
        regs_opt = _$Regs_optFromJson(jsonD['regs_opt']);
      } catch(e) {
        regs_opt = _$Regs_optFromJson({});
        ret = false;
      }
      try {
        regs_opt_dual = _$Regs_opt_dualFromJson(jsonD['regs_opt_dual']);
      } catch(e) {
        regs_opt_dual = _$Regs_opt_dualFromJson({});
        ret = false;
      }
      try {
        streopncls = _$StreopnclsFromJson(jsonD['streopncls']);
      } catch(e) {
        streopncls = _$StreopnclsFromJson({});
        ret = false;
      }
      try {
        menu = _$MenuFromJson(jsonD['menu']);
      } catch(e) {
        menu = _$MenuFromJson({});
        ret = false;
      }
      try {
        startup = _$StartupFromJson(jsonD['startup']);
      } catch(e) {
        startup = _$StartupFromJson({});
        ret = false;
      }
      try {
        another1 = _$Another1FromJson(jsonD['another1']);
      } catch(e) {
        another1 = _$Another1FromJson({});
        ret = false;
      }
      try {
        another2 = _$Another2FromJson(jsonD['another2']);
      } catch(e) {
        another2 = _$Another2FromJson({});
        ret = false;
      }
      try {
        simple2stf = _$Simple2stfFromJson(jsonD['simple2stf']);
      } catch(e) {
        simple2stf = _$Simple2stfFromJson({});
        ret = false;
      }
      try {
        simple2stf_dual = _$Simple2stf_dualFromJson(jsonD['simple2stf_dual']);
      } catch(e) {
        simple2stf_dual = _$Simple2stf_dualFromJson({});
        ret = false;
      }
      try {
        bank_prg = _$Bank_prgFromJson(jsonD['bank_prg']);
      } catch(e) {
        bank_prg = _$Bank_prgFromJson({});
        ret = false;
      }
      try {
        proc_id = _$Proc_idFromJson(jsonD['proc_id']);
      } catch(e) {
        proc_id = _$Proc_idFromJson({});
        ret = false;
      }
      try {
        FenceOver = _$FFenceOverFromJson(jsonD['FenceOver']);
      } catch(e) {
        FenceOver = _$FFenceOverFromJson({});
        ret = false;
      }
      try {
        EjConf = _$EEjConfFromJson(jsonD['EjConf']);
      } catch(e) {
        EjConf = _$EEjConfFromJson({});
        ret = false;
      }
      try {
        CashRecycle = _$CCashRecycleFromJson(jsonD['CashRecycle']);
      } catch(e) {
        CashRecycle = _$CCashRecycleFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Regs regs = _Regs(
    entry01                            : "",
    entry02                            : "",
    entry03                            : "",
    entry04                            : "",
    entry05                            : "",
  );

  _Regs_opt regs_opt = _Regs_opt(
    entry01                            : "",
    entry02                            : "",
    entry03                            : "",
    entry04                            : "",
    entry05                            : "",
    entry06                            : "",
    entry07                            : "",
    entry08                            : "",
    entry09                            : "",
    entry10                            : "",
    entry11                            : "",
    entry12                            : "",
    entry13                            : "",
    entry14                            : "",
    entry15                            : "",
  );

  _Regs_opt_dual regs_opt_dual = _Regs_opt_dual(
    entry01                            : "",
    entry02                            : "",
    entry03                            : "",
    entry04                            : "",
    entry05                            : "",
    entry06                            : "",
    entry07                            : "",
    entry08                            : "",
    entry09                            : "",
    entry10                            : "",
    entry11                            : "",
    entry12                            : "",
    entry13                            : "",
    entry14                            : "",
    entry15                            : "",
    entry16                            : "",
    entry17                            : "",
    entry18                            : "",
    entry19                            : "",
    entry20                            : "",
    entry21                            : "",
    entry22                            : "",
    entry23                            : "",
    entry24                            : "",
    entry25                            : "",
    entry26                            : "",
    entry27                            : "",
    entry28                            : "",
    entry29                            : "",
    entry30                            : "",
    entry31                            : "",
    entry32                            : "",
  );

  _Streopncls streopncls = _Streopncls(
    entry01                            : "",
    entry02                            : "",
  );

  _Menu menu = _Menu(
    entry01                            : "",
  );

  _Startup startup = _Startup(
    entry01                            : "",
    entry02                            : "",
    entry03                            : "",
    entry04                            : "",
    entry05                            : "",
    entry06                            : "",
    entry07                            : "",
    entry08                            : "",
    entry09                            : "",
    entry10                            : "",
    entry11                            : "",
    entry12                            : "",
    entry13                            : "",
    entry14                            : "",
    entry15                            : "",
    entry16                            : "",
    entry17                            : "",
    entry18                            : "",
    entry19                            : "",
    entry20                            : "",
    entry21                            : "",
    entry22                            : "",
    entry23                            : "",
    entry24                            : "",
    entry25                            : "",
    entry26                            : "",
    entry27                            : "",
    entry28                            : "",
    entry29                            : "",
    entry30                            : "",
    entry31                            : "",
    entry32                            : "",
    entry33                            : "",
    entry34                            : "",
    entry35                            : "",
    entry36                            : "",
    entry37                            : "",
    entry38                            : "",
    entry39                            : "",
    entry40                            : "",
    entry41                            : "",
  );

  _Another1 another1 = _Another1(
    entry01                            : "",
    entry02                            : "",
    entry03                            : "",
  );

  _Another2 another2 = _Another2(
    entry01                            : "",
    entry02                            : "",
    entry03                            : "",
    entry04                            : "",
    entry05                            : "",
    entry06                            : "",
    entry07                            : "",
  );

  _Simple2stf simple2stf = _Simple2stf(
    entry01                            : "",
    entry02                            : "",
  );

  _Simple2stf_dual simple2stf_dual = _Simple2stf_dual(
    entry01                            : "",
  );

  _Bank_prg bank_prg = _Bank_prg(
    entry01                            : "",
  );

  _Proc_id proc_id = _Proc_id(
    sound                              : 0,
    sound2                             : 0,
  );

  _FFenceOver FenceOver = _FFenceOver(
    entry01                            : "",
    entry02                            : "",
    entry03                            : "",
    entry04                            : "",
    entry05                            : "",
    entry06                            : "",
    entry07                            : "",
    entry08                            : "",
    entry09                            : "",
    entry10                            : "",
    entry11                            : "",
    entry12                            : "",
    entry13                            : "",
    entry14                            : "",
  );

  _EEjConf EjConf = _EEjConf(
    entry01                            : "",
  );

  _CCashRecycle CashRecycle = _CCashRecycle(
    entry01                            : "",
  );
}

@JsonSerializable()
class _Regs {
  factory _Regs.fromJson(Map<String, dynamic> json) => _$RegsFromJson(json);
  Map<String, dynamic> toJson() => _$RegsToJson(this);

  _Regs({
    required this.entry01,
    required this.entry02,
    required this.entry03,
    required this.entry04,
    required this.entry05,
  });

  @JsonKey(defaultValue: "print")
  String entry01;
  @JsonKey(defaultValue: "drw")
  String entry02;
  @JsonKey(defaultValue: "print_jc_c")
  String entry03;
  @JsonKey(defaultValue: "print_kitchen1")
  String entry04;
  @JsonKey(defaultValue: "print_kitchen2")
  String entry05;
}

@JsonSerializable()
class _Regs_opt {
  factory _Regs_opt.fromJson(Map<String, dynamic> json) => _$Regs_optFromJson(json);
  Map<String, dynamic> toJson() => _$Regs_optToJson(this);

  _Regs_opt({
    required this.entry01,
    required this.entry02,
    required this.entry03,
    required this.entry04,
    required this.entry05,
    required this.entry06,
    required this.entry07,
    required this.entry08,
    required this.entry09,
    required this.entry10,
    required this.entry11,
    required this.entry12,
    required this.entry13,
    required this.entry14,
    required this.entry15,
  });

  @JsonKey(defaultValue: "spool")
  String entry01;
  @JsonKey(defaultValue: "acx")
  String entry02;
  @JsonKey(defaultValue: "jpo")
  String entry03;
  @JsonKey(defaultValue: "scl")
  String entry04;
  @JsonKey(defaultValue: "rwc")
  String entry05;
  @JsonKey(defaultValue: "sgscl1")
  String entry06;
  @JsonKey(defaultValue: "sgscl2")
  String entry07;
  @JsonKey(defaultValue: "s2pr")
  String entry08;
  @JsonKey(defaultValue: "cashier")
  String entry09;
  @JsonKey(defaultValue: "stpr2")
  String entry10;
  @JsonKey(defaultValue: "mp1")
  String entry11;
  @JsonKey(defaultValue: "multi")
  String entry12;
  @JsonKey(defaultValue: "custreal")
  String entry13;
  @JsonKey(defaultValue: "custreal2")
  String entry14;
  @JsonKey(defaultValue: "custreal_netdoa")
  String entry15;
}

@JsonSerializable()
class _Regs_opt_dual {
  factory _Regs_opt_dual.fromJson(Map<String, dynamic> json) => _$Regs_opt_dualFromJson(json);
  Map<String, dynamic> toJson() => _$Regs_opt_dualToJson(this);

  _Regs_opt_dual({
    required this.entry01,
    required this.entry02,
    required this.entry03,
    required this.entry04,
    required this.entry05,
    required this.entry06,
    required this.entry07,
    required this.entry08,
    required this.entry09,
    required this.entry10,
    required this.entry11,
    required this.entry12,
    required this.entry13,
    required this.entry14,
    required this.entry15,
    required this.entry16,
    required this.entry17,
    required this.entry18,
    required this.entry19,
    required this.entry20,
    required this.entry21,
    required this.entry22,
    required this.entry23,
    required this.entry24,
    required this.entry25,
    required this.entry26,
    required this.entry27,
    required this.entry28,
    required this.entry29,
    required this.entry30,
    required this.entry31,
    required this.entry32,
  });

  @JsonKey(defaultValue: "spool")
  String entry01;
  @JsonKey(defaultValue: "acx")
  String entry02;
  @JsonKey(defaultValue: "jpo")
  String entry03;
  @JsonKey(defaultValue: "scl")
  String entry04;
  @JsonKey(defaultValue: "rwc")
  String entry05;
  @JsonKey(defaultValue: "sgscl1")
  String entry06;
  @JsonKey(defaultValue: "sgscl2")
  String entry07;
  @JsonKey(defaultValue: "s2pr")
  String entry08;
  @JsonKey(defaultValue: "stpr2")
  String entry09;
  @JsonKey(defaultValue: "fb_SelfMovie")
  String entry10;
  @JsonKey(defaultValue: "mp1")
  String entry11;
  @JsonKey(defaultValue: "multi")
  String entry12;
  @JsonKey(defaultValue: "fb_Movie")
  String entry13;
  @JsonKey(defaultValue: "custreal")
  String entry14;
  @JsonKey(defaultValue: "custreal2")
  String entry15;
  @JsonKey(defaultValue: "custreal_netdoa")
  String entry16;
  @JsonKey(defaultValue: "qcConnect")
  String entry17;
  @JsonKey(defaultValue: "credit")
  String entry18;
  @JsonKey(defaultValue: "nttd_preca")
  String entry19;
  @JsonKey(defaultValue: "sqrc")
  String entry20;
  @JsonKey(defaultValue: "trk_preca")
  String entry21;
  @JsonKey(defaultValue: "repica")
  String entry22;
  @JsonKey(defaultValue: "custreal2_pa")
  String entry23;
  @JsonKey(defaultValue: "custreal_odbc")
  String entry24;
  @JsonKey(defaultValue: "cogca")
  String entry25;
  @JsonKey(defaultValue: "basket_server")
  String entry26;
  @JsonKey(defaultValue: "vega3000")
  String entry27;
  @JsonKey(defaultValue: "dpoint")
  String entry28;
  @JsonKey(defaultValue: "ajs_emoney")
  String entry29;
  @JsonKey(defaultValue: "valuecard")
  String entry30;
  @JsonKey(defaultValue: "rpoint")
  String entry31;
  @JsonKey(defaultValue: "tpoint")
  String entry32;
}

@JsonSerializable()
class _Streopncls {
  factory _Streopncls.fromJson(Map<String, dynamic> json) => _$StreopnclsFromJson(json);
  Map<String, dynamic> toJson() => _$StreopnclsToJson(this);

  _Streopncls({
    required this.entry01,
    required this.entry02,
  });

  @JsonKey(defaultValue: "stropncls")
  String entry01;
  @JsonKey(defaultValue: "jpo")
  String entry02;
}

@JsonSerializable()
class _Menu {
  factory _Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);

  _Menu({
    required this.entry01,
  });

  @JsonKey(defaultValue: "acxreal")
  String entry01;
}

@JsonSerializable()
class _Startup {
  factory _Startup.fromJson(Map<String, dynamic> json) => _$StartupFromJson(json);
  Map<String, dynamic> toJson() => _$StartupToJson(this);

  _Startup({
    required this.entry01,
    required this.entry02,
    required this.entry03,
    required this.entry04,
    required this.entry05,
    required this.entry06,
    required this.entry07,
    required this.entry08,
    required this.entry09,
    required this.entry10,
    required this.entry11,
    required this.entry12,
    required this.entry13,
    required this.entry14,
    required this.entry15,
    required this.entry16,
    required this.entry17,
    required this.entry18,
    required this.entry19,
    required this.entry20,
    required this.entry21,
    required this.entry22,
    required this.entry23,
    required this.entry24,
    required this.entry25,
    required this.entry26,
    required this.entry27,
    required this.entry28,
    required this.entry29,
    required this.entry30,
    required this.entry31,
    required this.entry32,
    required this.entry33,
    required this.entry34,
    required this.entry35,
    required this.entry36,
    required this.entry37,
    required this.entry38,
    required this.entry39,
    required this.entry40,
    required this.entry41,
  });

  @JsonKey(defaultValue: "csvsend")
  String entry01;
  @JsonKey(defaultValue: "iis")
  String entry02;
  @JsonKey(defaultValue: "tprapl_reglog")
  String entry03;
  @JsonKey(defaultValue: "mobile")
  String entry04;
  @JsonKey(defaultValue: "stpr")
  String entry05;
  @JsonKey(defaultValue: "pmod")
  String entry06;
  @JsonKey(defaultValue: "sale_com_mm")
  String entry07;
  @JsonKey(defaultValue: "menteserver")
  String entry08;
  @JsonKey(defaultValue: "menteclient")
  String entry09;
  @JsonKey(defaultValue: "sound_con")
  String entry10;
  @JsonKey(defaultValue: "mcftp")
  String entry11;
  @JsonKey(defaultValue: "upd_con")
  String entry12;
  @JsonKey(defaultValue: "ecoaserver")
  String entry13;
  @JsonKey(defaultValue: "kill_proc")
  String entry14;
  @JsonKey(defaultValue: "keyb")
  String entry15;
  @JsonKey(defaultValue: "multi")
  String entry16;
  @JsonKey(defaultValue: "icc")
  String entry17;
  @JsonKey(defaultValue: "drugrevs")
  String entry18;
  @JsonKey(defaultValue: "tprapl_tprt")
  String entry19;
  @JsonKey(defaultValue: "jpo")
  String entry20;
  @JsonKey(defaultValue: "pbchg_log_send")
  String entry21;
  @JsonKey(defaultValue: "ftp")
  String entry22;
  @JsonKey(defaultValue: "spqcs")
  String entry23;
  @JsonKey(defaultValue: "spqcc")
  String entry24;
  @JsonKey(defaultValue: "pbchg_test_server")
  String entry25;
  @JsonKey(defaultValue: "WizS")
  String entry26;
  @JsonKey(defaultValue: "qcSelectServer")
  String entry27;
  @JsonKey(defaultValue: "moviesend")
  String entry28;
  @JsonKey(defaultValue: "credit")
  String entry29;
  @JsonKey(defaultValue: "qcConnectServer")
  String entry30;
  @JsonKey(defaultValue: "custreal_nec")
  String entry31;
  @JsonKey(defaultValue: "masr")
  String entry32;
  @JsonKey(defaultValue: "multi_tmn")
  String entry33;
  @JsonKey(defaultValue: "multi_glory")
  String entry34;
  @JsonKey(defaultValue: "suica")
  String entry35;
  @JsonKey(defaultValue: "netdoa_pqs")
  String entry36;
  @JsonKey(defaultValue: "tpoint_ftp")
  String entry37;
  @JsonKey(defaultValue: "taxfree")
  String entry38;
  @JsonKey(defaultValue: "multi_tmn_vega3000")
  String entry39;
  @JsonKey(defaultValue: "basket_server")
  String entry40;
  @JsonKey(defaultValue: "acttrigger")
  String entry41;
}

@JsonSerializable()
class _Another1 {
  factory _Another1.fromJson(Map<String, dynamic> json) => _$Another1FromJson(json);
  Map<String, dynamic> toJson() => _$Another1ToJson(this);

  _Another1({
    required this.entry01,
    required this.entry02,
    required this.entry03,
  });

  @JsonKey(defaultValue: "mente")
  String entry01;
  @JsonKey(defaultValue: "usetup")
  String entry02;
  @JsonKey(defaultValue: "history_get")
  String entry03;
}

@JsonSerializable()
class _Another2 {
  factory _Another2.fromJson(Map<String, dynamic> json) => _$Another2FromJson(json);
  Map<String, dynamic> toJson() => _$Another2ToJson(this);

  _Another2({
    required this.entry01,
    required this.entry02,
    required this.entry03,
    required this.entry04,
    required this.entry05,
    required this.entry06,
    required this.entry07,
  });

  @JsonKey(defaultValue: "tcount")
  String entry01;
  @JsonKey(defaultValue: "fcon")
  String entry02;
  @JsonKey(defaultValue: "freq")
  String entry03;
  @JsonKey(defaultValue: "pmod_regctrl")
  String entry04;
  @JsonKey(defaultValue: "retotal")
  String entry05;
  @JsonKey(defaultValue: "cust_enq_clr")
  String entry06;
  @JsonKey(defaultValue: "resimslog")
  String entry07;
}

@JsonSerializable()
class _Simple2stf {
  factory _Simple2stf.fromJson(Map<String, dynamic> json) => _$Simple2stfFromJson(json);
  Map<String, dynamic> toJson() => _$Simple2stfToJson(this);

  _Simple2stf({
    required this.entry01,
    required this.entry02,
  });

  @JsonKey(defaultValue: "spool")
  String entry01;
  @JsonKey(defaultValue: "cashier")
  String entry02;
}

@JsonSerializable()
class _Simple2stf_dual {
  factory _Simple2stf_dual.fromJson(Map<String, dynamic> json) => _$Simple2stf_dualFromJson(json);
  Map<String, dynamic> toJson() => _$Simple2stf_dualToJson(this);

  _Simple2stf_dual({
    required this.entry01,
  });

  @JsonKey(defaultValue: "spool")
  String entry01;
}

@JsonSerializable()
class _Bank_prg {
  factory _Bank_prg.fromJson(Map<String, dynamic> json) => _$Bank_prgFromJson(json);
  Map<String, dynamic> toJson() => _$Bank_prgToJson(this);

  _Bank_prg({
    required this.entry01,
  });

  @JsonKey(defaultValue: "bankprg")
  String entry01;
}

@JsonSerializable()
class _Proc_id {
  factory _Proc_id.fromJson(Map<String, dynamic> json) => _$Proc_idFromJson(json);
  Map<String, dynamic> toJson() => _$Proc_idToJson(this);

  _Proc_id({
    required this.sound,
    required this.sound2,
  });

  @JsonKey(defaultValue: 0)
  int    sound;
  @JsonKey(defaultValue: 0)
  int    sound2;
}

@JsonSerializable()
class _FFenceOver {
  factory _FFenceOver.fromJson(Map<String, dynamic> json) => _$FFenceOverFromJson(json);
  Map<String, dynamic> toJson() => _$FFenceOverToJson(this);

  _FFenceOver({
    required this.entry01,
    required this.entry02,
    required this.entry03,
    required this.entry04,
    required this.entry05,
    required this.entry06,
    required this.entry07,
    required this.entry08,
    required this.entry09,
    required this.entry10,
    required this.entry11,
    required this.entry12,
    required this.entry13,
    required this.entry14,
  });

  @JsonKey(defaultValue: "custd_srch")
  String entry01;
  @JsonKey(defaultValue: "custd_hist")
  String entry02;
  @JsonKey(defaultValue: "custd_mtg")
  String entry03;
  @JsonKey(defaultValue: "prg_cust_popup")
  String entry04;
  @JsonKey(defaultValue: "cd_contents")
  String entry05;
  @JsonKey(defaultValue: "reserv_conf")
  String entry06;
  @JsonKey(defaultValue: "chprice")
  String entry07;
  @JsonKey(defaultValue: "autotest")
  String entry08;
  @JsonKey(defaultValue: "pbchg_util")
  String entry09;
  @JsonKey(defaultValue: "Cons")
  String entry10;
  @JsonKey(defaultValue: "DSft")
  String entry11;
  @JsonKey(defaultValue: "FMente")
  String entry12;
  @JsonKey(defaultValue: "acx_recalc_g")
  String entry13;
  @JsonKey(defaultValue: "acx_recalc")
  String entry14;
}

@JsonSerializable()
class _EEjConf {
  factory _EEjConf.fromJson(Map<String, dynamic> json) => _$EEjConfFromJson(json);
  Map<String, dynamic> toJson() => _$EEjConfToJson(this);

  _EEjConf({
    required this.entry01,
  });

  @JsonKey(defaultValue: "fb_Movie")
  String entry01;
}

@JsonSerializable()
class _CCashRecycle {
  factory _CCashRecycle.fromJson(Map<String, dynamic> json) => _$CCashRecycleFromJson(json);
  Map<String, dynamic> toJson() => _$CCashRecycleToJson(this);

  _CCashRecycle({
    required this.entry01,
  });

  @JsonKey(defaultValue: "cash_recycle")
  String entry01;
}

