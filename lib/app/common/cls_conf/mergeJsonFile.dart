/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'mergeJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class MergeJsonFile extends ConfigJsonFile {
  static final MergeJsonFile _instance = MergeJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "merge.json";

  MergeJsonFile(){
    setPath(_confPath, _fileName);
  }
  MergeJsonFile._internal();

  factory MergeJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$MergeJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$MergeJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$MergeJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        merge = _$MergeFromJson(jsonD['merge']);
      } catch(e) {
        merge = _$MergeFromJson({});
        ret = false;
      }
      try {
        quick_data = _$Quick_dataFromJson(jsonD['quick_data']);
      } catch(e) {
        quick_data = _$Quick_dataFromJson({});
        ret = false;
      }
      try {
        resetup_data = _$Resetup_dataFromJson(jsonD['resetup_data']);
      } catch(e) {
        resetup_data = _$Resetup_dataFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Merge merge = _Merge(
    file01                             : "",
    file02                             : "",
    file03                             : "",
    file04                             : "",
    file05                             : "",
    file06                             : "",
    file07                             : "",
    file08                             : "",
    file09                             : "",
    file10                             : "",
    file11                             : "",
    file12                             : "",
    file13                             : "",
    file14                             : "",
    file15                             : "",
    file16                             : "",
    file17                             : "",
    file18                             : "",
    file19                             : "",
    file20                             : "",
    file21                             : "",
    file22                             : "",
    file23                             : "",
    file24                             : "",
    file25                             : "",
    file26                             : "",
    file27                             : "",
    file28                             : "",
    file29                             : "",
    file30                             : "",
    file31                             : "",
    file32                             : "",
    file33                             : "",
    file34                             : "",
    file35                             : "",
    file36                             : "",
    file37                             : "",
    file38                             : "",
    file39                             : "",
    file40                             : "",
    file41                             : "",
    file42                             : "",
    file43                             : "",
    file44                             : "",
    file45                             : "",
    file46                             : "",
    file47                             : "",
    file50                             : "",
    file51                             : "",
    file52                             : "",
    file53                             : "",
    file54                             : "",
    file55                             : "",
    file56                             : "",
    file57                             : "",
    file58                             : "",
    file59                             : "",
    file60                             : "",
    file61                             : "",
    file62                             : "",
    file63                             : "",
    file64                             : "",
    file65                             : "",
    file66                             : "",
    file67                             : "",
    file68                             : "",
    file69                             : "",
    file70                             : "",
    file71                             : "",
    file72                             : "",
    file73                             : "",
    file74                             : "",
    file75                             : "",
    file76                             : "",
    file77                             : "",
    file78                             : "",
    file79                             : "",
    file80                             : "",
    file81                             : "",
    file82                             : "",
    file83                             : "",
    file84                             : "",
    file85                             : "",
    file86                             : "",
    file87                             : "",
    file88                             : "",
    file89                             : "",
    file90                             : "",
    file91                             : "",
    file92                             : "",
    file93                             : "",
    file94                             : "",
    file95                             : "",
    file96                             : "",
    file97                             : "",
    file98                             : "",
    file99                             : "",
    file100                            : "",
    file101                            : "",
    file_cnt                           : 0,
  );

  _Quick_data quick_data = _Quick_data(
    file_cnt                           : 0,
    file01                             : "",
    file02                             : "",
    file03                             : "",
    file04                             : "",
    file05                             : "",
    file06                             : "",
    file07                             : "",
    file08                             : "",
    file09                             : "",
    file10                             : "",
    file11                             : "",
    file12                             : "",
    file13                             : "",
    file14                             : "",
    file15                             : "",
    file16                             : "",
    file17                             : "",
    file18                             : "",
    file19                             : "",
    file20                             : "",
    file21                             : "",
    file22                             : "",
    file23                             : "",
    file24                             : "",
    file25                             : "",
    file26                             : "",
    file27                             : "",
    file28                             : "",
    file29                             : "",
    file30                             : "",
    file31                             : "",
  );

  _Resetup_data resetup_data = _Resetup_data(
    file_cnt                           : 0,
    file01                             : "",
    file02                             : "",
    file03                             : "",
    file04                             : "",
    file05                             : "",
    file06                             : "",
    file07                             : "",
    file08                             : "",
    file09                             : "",
    file10                             : "",
    file11                             : "",
    file12                             : "",
  );
}

@JsonSerializable()
class _Merge {
  factory _Merge.fromJson(Map<String, dynamic> json) => _$MergeFromJson(json);
  Map<String, dynamic> toJson() => _$MergeToJson(this);

  _Merge({
    required this.file01,
    required this.file02,
    required this.file03,
    required this.file04,
    required this.file05,
    required this.file06,
    required this.file07,
    required this.file08,
    required this.file09,
    required this.file10,
    required this.file11,
    required this.file12,
    required this.file13,
    required this.file14,
    required this.file15,
    required this.file16,
    required this.file17,
    required this.file18,
    required this.file19,
    required this.file20,
    required this.file21,
    required this.file22,
    required this.file23,
    required this.file24,
    required this.file25,
    required this.file26,
    required this.file27,
    required this.file28,
    required this.file29,
    required this.file30,
    required this.file31,
    required this.file32,
    required this.file33,
    required this.file34,
    required this.file35,
    required this.file36,
    required this.file37,
    required this.file38,
    required this.file39,
    required this.file40,
    required this.file41,
    required this.file42,
    required this.file43,
    required this.file44,
    required this.file45,
    required this.file46,
    required this.file47,
    required this.file50,
    required this.file51,
    required this.file52,
    required this.file53,
    required this.file54,
    required this.file55,
    required this.file56,
    required this.file57,
    required this.file58,
    required this.file59,
    required this.file60,
    required this.file61,
    required this.file62,
    required this.file63,
    required this.file64,
    required this.file65,
    required this.file66,
    required this.file67,
    required this.file68,
    required this.file69,
    required this.file70,
    required this.file71,
    required this.file72,
    required this.file73,
    required this.file74,
    required this.file75,
    required this.file76,
    required this.file77,
    required this.file78,
    required this.file79,
    required this.file80,
    required this.file81,
    required this.file82,
    required this.file83,
    required this.file84,
    required this.file85,
    required this.file86,
    required this.file87,
    required this.file88,
    required this.file89,
    required this.file90,
    required this.file91,
    required this.file92,
    required this.file93,
    required this.file94,
    required this.file95,
    required this.file96,
    required this.file97,
    required this.file98,
    required this.file99,
    required this.file100,
    required this.file101,
    required this.file_cnt,
  });

  @JsonKey(defaultValue: "changer.json")
  String file01;
  @JsonKey(defaultValue: "counter.json")
  String file02;
  @JsonKey(defaultValue: "gcat.json")
  String file03;
  @JsonKey(defaultValue: "mac_info.json")
  String file04;
  @JsonKey(defaultValue: "pana_gcat.json")
  String file05;
  @JsonKey(defaultValue: "sprt.json")
  String file06;
  @JsonKey(defaultValue: "sys.json")
  String file07;
  @JsonKey(defaultValue: "sys_param.json")
  String file08;
  @JsonKey(defaultValue: "recogkey_data.json")
  String file09;
  @JsonKey(defaultValue: "hqftp.json")
  String file10;
  @JsonKey(defaultValue: "hqhist.json")
  String file11;
  @JsonKey(defaultValue: "mupdate_counter.json")
  String file12;
  @JsonKey(defaultValue: "update_counter.json")
  String file13;
  @JsonKey(defaultValue: "fjss.json")
  String file14;
  @JsonKey(defaultValue: "eat_in.json")
  String file15;
  @JsonKey(defaultValue: "backupdata.json")
  String file16;
  @JsonKey(defaultValue: "sound.json")
  String file17;
  @JsonKey(defaultValue: "specificftp.json")
  String file18;
  @JsonKey(defaultValue: "suica.json")
  String file19;
  @JsonKey(defaultValue: "sm_scalesc_scl.json")
  String file20;
  @JsonKey(defaultValue: "sm_scalesc_signp.json")
  String file21;
  @JsonKey(defaultValue: "mm_abj.json")
  String file22;
  @JsonKey(defaultValue: "scan_plus_1.json")
  String file23;
  @JsonKey(defaultValue: "rsvsetup_SAPPORO.json")
  String file24;
  @JsonKey(defaultValue: "movie_info.json")
  String file25;
  @JsonKey(defaultValue: "qs_movie_start_dsp.json")
  String file26;
  @JsonKey(defaultValue: "reserv.json")
  String file27;
  @JsonKey(defaultValue: "pmouse_2800_1.json")
  String file28;
  @JsonKey(defaultValue: "pmouse_2800_2.json")
  String file29;
  @JsonKey(defaultValue: "image.json")
  String file30;
  @JsonKey(defaultValue: "pmouse_2500_1.json")
  String file31;
  @JsonKey(defaultValue: "pmouse_2500_2.json")
  String file32;
  @JsonKey(defaultValue: "pbchg.json")
  String file33;
  @JsonKey(defaultValue: "rsv_custreal.json")
  String file34;
  @JsonKey(defaultValue: "wiz_cnct.json")
  String file35;
  @JsonKey(defaultValue: "qcashier.json")
  String file36;
  @JsonKey(defaultValue: "pmouse_plus2_1.json")
  String file37;
  @JsonKey(defaultValue: "mbrreal.json")
  String file38;
  @JsonKey(defaultValue: "chkr_save.json")
  String file39;
  @JsonKey(defaultValue: "SystemCheck.json")
  String file40;
  @JsonKey(defaultValue: "scan_2800ip_2.json")
  String file41;
  @JsonKey(defaultValue: "speeza.json")
  String file42;
  @JsonKey(defaultValue: "scan_plus_2.json")
  String file43;
  @JsonKey(defaultValue: "masr.json")
  String file44;
  @JsonKey(defaultValue: "qc_start_dsp.json")
  String file45;
  @JsonKey(defaultValue: "speeza_com.json")
  String file46;
  @JsonKey(defaultValue: "custreal_nec.json")
  String file47;
  @JsonKey(defaultValue: "nttd_preca.json")
  String file50;
  @JsonKey(defaultValue: "mc_param.json")
  String file51;
  @JsonKey(defaultValue: "wol.json")
  String file52;
  @JsonKey(defaultValue: "counter_JC_C.json")
  String file53;
  @JsonKey(defaultValue: "mac_info_JC_C.json")
  String file54;
  @JsonKey(defaultValue: "TccUts.json")
  String file55;
  @JsonKey(defaultValue: "main_menu.json")
  String file56;
  @JsonKey(defaultValue: "add_parts.json")
  String file57;
  @JsonKey(defaultValue: "cnct_sio.json")
  String file58;
  @JsonKey(defaultValue: "hq_set.json")
  String file59;
  @JsonKey(defaultValue: "fal2_spec.json")
  String file60;
  @JsonKey(defaultValue: "msr_chk.json")
  String file61;
  @JsonKey(defaultValue: "mm_rept_taxchg.json")
  String file62;
  @JsonKey(defaultValue: "set_option.json")
  String file63;
  @JsonKey(defaultValue: "fal2_spec.json")
  String file64;
  @JsonKey(defaultValue: "battery.json")
  String file65;
  @JsonKey(defaultValue: "f_self_content.json")
  String file66;
  @JsonKey(defaultValue: "pmouse_2800_3.json")
  String file67;
  @JsonKey(defaultValue: "f_self_img.json")
  String file68;
  @JsonKey(defaultValue: "trk_preca.json")
  String file69;
  @JsonKey(defaultValue: "repica.json")
  String file70;
  @JsonKey(defaultValue: "lottery.json")
  String file71;
  @JsonKey(defaultValue: "cogca.json")
  String file72;
  @JsonKey(defaultValue: "auto_update.json")
  String file73;
  @JsonKey(defaultValue: "tprtim_counter.json")
  String file74;
  @JsonKey(defaultValue: "devread.json")
  String file75;
  @JsonKey(defaultValue: "ecs_spec.json")
  String file76;
  @JsonKey(defaultValue: "recogkey_activate.json")
  String file77;
  @JsonKey(defaultValue: "msr_int_1.json")
  String file78;
  @JsonKey(defaultValue: "f_self_hp_img.json")
  String file79;
  @JsonKey(defaultValue: "vacuum_date.json")
  String file80;
  @JsonKey(defaultValue: "pmouse_2800_4.json")
  String file81;
  @JsonKey(defaultValue: "barcode_pay.json")
  String file82;
  @JsonKey(defaultValue: "powli.json")
  String file83;
  @JsonKey(defaultValue: "webapi_key.json")
  String file84;
  @JsonKey(defaultValue: "custreal_ajs.json")
  String file85;
  @JsonKey(defaultValue: "ecs_fw.json")
  String file86;
  @JsonKey(defaultValue: "pmouse_5900_1.json")
  String file87;
  @JsonKey(defaultValue: "taxfree.json")
  String file88;
  @JsonKey(defaultValue: "mail_sender.json")
  String file89;
  @JsonKey(defaultValue: "pmouse_2800_5.json")
  String file90;
  @JsonKey(defaultValue: "f_self_vfhd_hp_img.json")
  String file91;
  @JsonKey(defaultValue: "valuecard.json")
  String file92;
  @JsonKey(defaultValue: "pmouse_2800_6.json")
  String file93;
  @JsonKey(defaultValue: "pmouse_2800_7.json")
  String file94;
  @JsonKey(defaultValue: "rpoint.json")
  String file95;
  @JsonKey(defaultValue: "tpoint.json")
  String file96;
  @JsonKey(defaultValue: "net_receipt.json")
  String file97;
  @JsonKey(defaultValue: "tomoIF.json")
  String file98;
  @JsonKey(defaultValue: "acttrigger.json")
  String file99;
  @JsonKey(defaultValue: "cust_fresta.json")
  String file100;
  @JsonKey(defaultValue: "cust_istyle.json")
  String file101;
  @JsonKey(defaultValue: 101)
  int    file_cnt;
}

@JsonSerializable()
class _Quick_data {
  factory _Quick_data.fromJson(Map<String, dynamic> json) => _$Quick_dataFromJson(json);
  Map<String, dynamic> toJson() => _$Quick_dataToJson(this);

  _Quick_data({
    required this.file_cnt,
    required this.file01,
    required this.file02,
    required this.file03,
    required this.file04,
    required this.file05,
    required this.file06,
    required this.file07,
    required this.file08,
    required this.file09,
    required this.file10,
    required this.file11,
    required this.file12,
    required this.file13,
    required this.file14,
    required this.file15,
    required this.file16,
    required this.file17,
    required this.file18,
    required this.file19,
    required this.file20,
    required this.file21,
    required this.file22,
    required this.file23,
    required this.file24,
    required this.file25,
    required this.file26,
    required this.file27,
    required this.file28,
    required this.file29,
    required this.file30,
    required this.file31,
  });

  @JsonKey(defaultValue: 31)
  int    file_cnt;
  @JsonKey(defaultValue: "version.json")
  String file01;
  @JsonKey(defaultValue: "counter.json")
  String file02;
  @JsonKey(defaultValue: "recogkey_data.json")
  String file03;
  @JsonKey(defaultValue: "mupdate_counter.json")
  String file04;
  @JsonKey(defaultValue: "update_counter.json")
  String file05;
  @JsonKey(defaultValue: "eat_in.json")
  String file06;
  @JsonKey(defaultValue: "suica.json")
  String file07;
  @JsonKey(defaultValue: "mm_abj.json")
  String file08;
  @JsonKey(defaultValue: "pmouse_2800_1.json")
  String file09;
  @JsonKey(defaultValue: "pmouse_2800_2.json")
  String file10;
  @JsonKey(defaultValue: "pmouse_2500_1.json")
  String file11;
  @JsonKey(defaultValue: "pmouse_2500_2.json")
  String file12;
  @JsonKey(defaultValue: "pbchg.json")
  String file13;
  @JsonKey(defaultValue: "pmouse_plus2_1.json")
  String file14;
  @JsonKey(defaultValue: "counter_JC_C.json")
  String file15;
  @JsonKey(defaultValue: "battery.json")
  String file16;
  @JsonKey(defaultValue: "pmouse_2800_3.json")
  String file17;
  @JsonKey(defaultValue: "repica.json")
  String file18;
  @JsonKey(defaultValue: "auto_update.json")
  String file19;
  @JsonKey(defaultValue: "tprtim_counter.json")
  String file20;
  @JsonKey(defaultValue: "devread.json")
  String file21;
  @JsonKey(defaultValue: "vacuum_date.json")
  String file22;
  @JsonKey(defaultValue: "pmouse_2800_4.json")
  String file23;
  @JsonKey(defaultValue: "ecs_fw.json")
  String file24;
  @JsonKey(defaultValue: "pmouse_5900_1.json")
  String file25;
  @JsonKey(defaultValue: "pmouse_2800_5.json")
  String file26;
  @JsonKey(defaultValue: "pmouse_2800_6.json")
  String file27;
  @JsonKey(defaultValue: "pmouse_2800_7.json")
  String file28;
  @JsonKey(defaultValue: "taxfree.json")
  String file29;
  @JsonKey(defaultValue: "auto_strcls_tran.json")
  String file30;
  @JsonKey(defaultValue: "acttrigger.json")
  String file31;
}

@JsonSerializable()
class _Resetup_data {
  factory _Resetup_data.fromJson(Map<String, dynamic> json) => _$Resetup_dataFromJson(json);
  Map<String, dynamic> toJson() => _$Resetup_dataToJson(this);

  _Resetup_data({
    required this.file_cnt,
    required this.file01,
    required this.file02,
    required this.file03,
    required this.file04,
    required this.file05,
    required this.file06,
    required this.file07,
    required this.file08,
    required this.file09,
    required this.file10,
    required this.file11,
    required this.file12,
  });

  @JsonKey(defaultValue: 12)
  int    file_cnt;
  @JsonKey(defaultValue: "pmouse_2800_1.json")
  String file01;
  @JsonKey(defaultValue: "pmouse_2800_2.json")
  String file02;
  @JsonKey(defaultValue: "pmouse_2500_1.json")
  String file03;
  @JsonKey(defaultValue: "pmouse_2500_2.json")
  String file04;
  @JsonKey(defaultValue: "pmouse_plus2_1.json")
  String file05;
  @JsonKey(defaultValue: "pmouse_2800_3.json")
  String file06;
  @JsonKey(defaultValue: "pmouse_2800_4.json")
  String file07;
  @JsonKey(defaultValue: "pmouse_2800_5.json")
  String file08;
  @JsonKey(defaultValue: "ecs_fw.json")
  String file09;
  @JsonKey(defaultValue: "pmouse_5900_1.json")
  String file10;
  @JsonKey(defaultValue: "pmouse_2800_6.json")
  String file11;
  @JsonKey(defaultValue: "pmouse_2800_7.json")
  String file12;
}

