/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'sysJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class SysJsonFile extends ConfigJsonFile {
  static final SysJsonFile _instance = SysJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "sys.json";

  SysJsonFile(){
    setPath(_confPath, _fileName);
  }
  SysJsonFile._internal();

  factory SysJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$SysJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$SysJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$SysJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        info = _$InfoFromJson(jsonD['info']);
      } catch(e) {
        info = _$InfoFromJson({});
        ret = false;
      }
      try {
        type = _$TypeFromJson(jsonD['type']);
      } catch(e) {
        type = _$TypeFromJson({});
        ret = false;
      }
      try {
        dip_sw = _$Dip_swFromJson(jsonD['dip_sw']);
      } catch(e) {
        dip_sw = _$Dip_swFromJson({});
        ret = false;
      }
      try {
        boot_webplus2_desktop = _$Boot_webplus2_desktopFromJson(jsonD['boot_webplus2_desktop']);
      } catch(e) {
        boot_webplus2_desktop = _$Boot_webplus2_desktopFromJson({});
        ret = false;
      }
      try {
        boot_web2350_tower = _$Boot_web2350_towerFromJson(jsonD['boot_web2350_tower']);
      } catch(e) {
        boot_web2350_tower = _$Boot_web2350_towerFromJson({});
        ret = false;
      }
      try {
        boot_web2350_desktop = _$Boot_web2350_desktopFromJson(jsonD['boot_web2350_desktop']);
      } catch(e) {
        boot_web2350_desktop = _$Boot_web2350_desktopFromJson({});
        ret = false;
      }
      try {
        boot_web2500_tower = _$Boot_web2500_towerFromJson(jsonD['boot_web2500_tower']);
      } catch(e) {
        boot_web2500_tower = _$Boot_web2500_towerFromJson({});
        ret = false;
      }
      try {
        boot_web2500_desktop = _$Boot_web2500_desktopFromJson(jsonD['boot_web2500_desktop']);
      } catch(e) {
        boot_web2500_desktop = _$Boot_web2500_desktopFromJson({});
        ret = false;
      }
      try {
        boot_web2800_tower = _$Boot_web2800_towerFromJson(jsonD['boot_web2800_tower']);
      } catch(e) {
        boot_web2800_tower = _$Boot_web2800_towerFromJson({});
        ret = false;
      }
      try {
        boot_web2800_desktop = _$Boot_web2800_desktopFromJson(jsonD['boot_web2800_desktop']);
      } catch(e) {
        boot_web2800_desktop = _$Boot_web2800_desktopFromJson({});
        ret = false;
      }
      try {
        boot_web2300_tower = _$Boot_web2300_towerFromJson(jsonD['boot_web2300_tower']);
      } catch(e) {
        boot_web2300_tower = _$Boot_web2300_towerFromJson({});
        ret = false;
      }
      try {
        boot_web2300_desktop = _$Boot_web2300_desktopFromJson(jsonD['boot_web2300_desktop']);
      } catch(e) {
        boot_web2300_desktop = _$Boot_web2300_desktopFromJson({});
        ret = false;
      }
      try {
        boot_webplus_desktop = _$Boot_webplus_desktopFromJson(jsonD['boot_webplus_desktop']);
      } catch(e) {
        boot_webplus_desktop = _$Boot_webplus_desktopFromJson({});
        ret = false;
      }
      try {
        boot_dual_tower = _$Boot_dual_towerFromJson(jsonD['boot_dual_tower']);
      } catch(e) {
        boot_dual_tower = _$Boot_dual_towerFromJson({});
        ret = false;
      }
      try {
        boot_dual_desktop = _$Boot_dual_desktopFromJson(jsonD['boot_dual_desktop']);
      } catch(e) {
        boot_dual_desktop = _$Boot_dual_desktopFromJson({});
        ret = false;
      }
      try {
        boot_jr = _$Boot_jrFromJson(jsonD['boot_jr']);
      } catch(e) {
        boot_jr = _$Boot_jrFromJson({});
        ret = false;
      }
      try {
        boot_jr_tower = _$Boot_jr_towerFromJson(jsonD['boot_jr_tower']);
      } catch(e) {
        boot_jr_tower = _$Boot_jr_towerFromJson({});
        ret = false;
      }
      try {
        boot_tower = _$Boot_towerFromJson(jsonD['boot_tower']);
      } catch(e) {
        boot_tower = _$Boot_towerFromJson({});
        ret = false;
      }
      try {
        boot_desktop = _$Boot_desktopFromJson(jsonD['boot_desktop']);
      } catch(e) {
        boot_desktop = _$Boot_desktopFromJson({});
        ret = false;
      }
      try {
        verup = _$VerupFromJson(jsonD['verup']);
      } catch(e) {
        verup = _$VerupFromJson({});
        ret = false;
      }
      try {
        speaker = _$SpeakerFromJson(jsonD['speaker']);
      } catch(e) {
        speaker = _$SpeakerFromJson({});
        ret = false;
      }
      try {
        lcdbright = _$LcdbrightFromJson(jsonD['lcdbright']);
      } catch(e) {
        lcdbright = _$LcdbrightFromJson({});
        ret = false;
      }
      try {
        logging = _$LoggingFromJson(jsonD['logging']);
      } catch(e) {
        logging = _$LoggingFromJson({});
        ret = false;
      }
      try {
        scanner = _$ScannerFromJson(jsonD['scanner']);
      } catch(e) {
        scanner = _$ScannerFromJson({});
        ret = false;
      }
      try {
        subcpu1 = _$Subcpu1FromJson(jsonD['subcpu1']);
      } catch(e) {
        subcpu1 = _$Subcpu1FromJson({});
        ret = false;
      }
      try {
        spk1 = _$Spk1FromJson(jsonD['spk1']);
      } catch(e) {
        spk1 = _$Spk1FromJson({});
        ret = false;
      }
      try {
        wand1 = _$Wand1FromJson(jsonD['wand1']);
      } catch(e) {
        wand1 = _$Wand1FromJson({});
        ret = false;
      }
      try {
        wand2 = _$Wand2FromJson(jsonD['wand2']);
      } catch(e) {
        wand2 = _$Wand2FromJson({});
        ret = false;
      }
      try {
        lcdbrt1 = _$Lcdbrt1FromJson(jsonD['lcdbrt1']);
      } catch(e) {
        lcdbrt1 = _$Lcdbrt1FromJson({});
        ret = false;
      }
      try {
        lcdbrt2 = _$Lcdbrt2FromJson(jsonD['lcdbrt2']);
      } catch(e) {
        lcdbrt2 = _$Lcdbrt2FromJson({});
        ret = false;
      }
      try {
        fip1 = _$Fip1FromJson(jsonD['fip1']);
      } catch(e) {
        fip1 = _$Fip1FromJson({});
        ret = false;
      }
      try {
        mkey1 = _$Mkey1FromJson(jsonD['mkey1']);
      } catch(e) {
        mkey1 = _$Mkey1FromJson({});
        ret = false;
      }
      try {
        mkey2 = _$Mkey2FromJson(jsonD['mkey2']);
      } catch(e) {
        mkey2 = _$Mkey2FromJson({});
        ret = false;
      }
      try {
        lcd57 = _$Lcd57FromJson(jsonD['lcd57']);
      } catch(e) {
        lcd57 = _$Lcd57FromJson({});
        ret = false;
      }
      try {
        tkey1t = _$Tkey1tFromJson(jsonD['tkey1t']);
      } catch(e) {
        tkey1t = _$Tkey1tFromJson({});
        ret = false;
      }
      try {
        tkey1d = _$Tkey1dFromJson(jsonD['tkey1d']);
      } catch(e) {
        tkey1d = _$Tkey1dFromJson({});
        ret = false;
      }
      try {
        msr11 = _$Msr11FromJson(jsonD['msr11']);
      } catch(e) {
        msr11 = _$Msr11FromJson({});
        ret = false;
      }
      try {
        msr12 = _$Msr12FromJson(jsonD['msr12']);
      } catch(e) {
        msr12 = _$Msr12FromJson({});
        ret = false;
      }
      try {
        msr21 = _$Msr21FromJson(jsonD['msr21']);
      } catch(e) {
        msr21 = _$Msr21FromJson({});
        ret = false;
      }
      try {
        msr22 = _$Msr22FromJson(jsonD['msr22']);
      } catch(e) {
        msr22 = _$Msr22FromJson({});
        ret = false;
      }
      try {
        subcpu2 = _$Subcpu2FromJson(jsonD['subcpu2']);
      } catch(e) {
        subcpu2 = _$Subcpu2FromJson({});
        ret = false;
      }
      try {
        spk2 = _$Spk2FromJson(jsonD['spk2']);
      } catch(e) {
        spk2 = _$Spk2FromJson({});
        ret = false;
      }
      try {
        fip2 = _$Fip2FromJson(jsonD['fip2']);
      } catch(e) {
        fip2 = _$Fip2FromJson({});
        ret = false;
      }
      try {
        tkey2 = _$Tkey2FromJson(jsonD['tkey2']);
      } catch(e) {
        tkey2 = _$Tkey2FromJson({});
        ret = false;
      }
      try {
        tprt = _$TprtFromJson(jsonD['tprt']);
      } catch(e) {
        tprt = _$TprtFromJson({});
        ret = false;
      }
      try {
        pmouse1 = _$Pmouse1FromJson(jsonD['pmouse1']);
      } catch(e) {
        pmouse1 = _$Pmouse1FromJson({});
        ret = false;
      }
      try {
        pmouse2 = _$Pmouse2FromJson(jsonD['pmouse2']);
      } catch(e) {
        pmouse2 = _$Pmouse2FromJson({});
        ret = false;
      }
      try {
        sprt = _$SprtFromJson(jsonD['sprt']);
      } catch(e) {
        sprt = _$SprtFromJson({});
        ret = false;
      }
      try {
        mupdate = _$MupdateFromJson(jsonD['mupdate']);
      } catch(e) {
        mupdate = _$MupdateFromJson({});
        ret = false;
      }
      try {
        history = _$HistoryFromJson(jsonD['history']);
      } catch(e) {
        history = _$HistoryFromJson({});
        ret = false;
      }
      try {
        hist_csrv = _$Hist_csrvFromJson(jsonD['hist_csrv']);
      } catch(e) {
        hist_csrv = _$Hist_csrvFromJson({});
        ret = false;
      }
      try {
        tqrcd = _$TqrcdFromJson(jsonD['tqrcd']);
      } catch(e) {
        tqrcd = _$TqrcdFromJson({});
        ret = false;
      }
      try {
        hqftp = _$HqftpFromJson(jsonD['hqftp']);
      } catch(e) {
        hqftp = _$HqftpFromJson({});
        ret = false;
      }
      try {
        supdate = _$SupdateFromJson(jsonD['supdate']);
      } catch(e) {
        supdate = _$SupdateFromJson({});
        ret = false;
      }
      try {
        hqhist = _$HqhistFromJson(jsonD['hqhist']);
      } catch(e) {
        hqhist = _$HqhistFromJson({});
        ret = false;
      }
      try {
        hqprod = _$HqprodFromJson(jsonD['hqprod']);
      } catch(e) {
        hqprod = _$HqprodFromJson({});
        ret = false;
      }
      try {
        signp = _$SignpFromJson(jsonD['signp']);
      } catch(e) {
        signp = _$SignpFromJson({});
        ret = false;
      }
      try {
        detect = _$DetectFromJson(jsonD['detect']);
      } catch(e) {
        detect = _$DetectFromJson({});
        ret = false;
      }
      try {
        callsw = _$CallswFromJson(jsonD['callsw']);
      } catch(e) {
        callsw = _$CallswFromJson({});
        ret = false;
      }
      try {
        subcpu3 = _$Subcpu3FromJson(jsonD['subcpu3']);
      } catch(e) {
        subcpu3 = _$Subcpu3FromJson({});
        ret = false;
      }
      try {
        spk3 = _$Spk3FromJson(jsonD['spk3']);
      } catch(e) {
        spk3 = _$Spk3FromJson({});
        ret = false;
      }
      try {
        tkey3d = _$Tkey3dFromJson(jsonD['tkey3d']);
      } catch(e) {
        tkey3d = _$Tkey3dFromJson({});
        ret = false;
      }
      try {
        seg1 = _$Seg1FromJson(jsonD['seg1']);
      } catch(e) {
        seg1 = _$Seg1FromJson({});
        ret = false;
      }
      try {
        seg2 = _$Seg2FromJson(jsonD['seg2']);
      } catch(e) {
        seg2 = _$Seg2FromJson({});
        ret = false;
      }
      try {
        wand3 = _$Wand3FromJson(jsonD['wand3']);
      } catch(e) {
        wand3 = _$Wand3FromJson({});
        ret = false;
      }
      try {
        lcdbrt3 = _$Lcdbrt3FromJson(jsonD['lcdbrt3']);
      } catch(e) {
        lcdbrt3 = _$Lcdbrt3FromJson({});
        ret = false;
      }
      try {
        mkey3 = _$Mkey3FromJson(jsonD['mkey3']);
      } catch(e) {
        mkey3 = _$Mkey3FromJson({});
        ret = false;
      }
      try {
        msr31 = _$Msr31FromJson(jsonD['msr31']);
      } catch(e) {
        msr31 = _$Msr31FromJson({});
        ret = false;
      }
      try {
        msr32 = _$Msr32FromJson(jsonD['msr32']);
      } catch(e) {
        msr32 = _$Msr32FromJson({});
        ret = false;
      }
      try {
        pmouse3 = _$Pmouse3FromJson(jsonD['pmouse3']);
      } catch(e) {
        pmouse3 = _$Pmouse3FromJson({});
        ret = false;
      }
      try {
        schctrl = _$SchctrlFromJson(jsonD['schctrl']);
      } catch(e) {
        schctrl = _$SchctrlFromJson({});
        ret = false;
      }
      try {
        fip3 = _$Fip3FromJson(jsonD['fip3']);
      } catch(e) {
        fip3 = _$Fip3FromJson({});
        ret = false;
      }
      try {
        vfd57_3 = _$Vfd57_3FromJson(jsonD['vfd57_3']);
      } catch(e) {
        vfd57_3 = _$Vfd57_3FromJson({});
        ret = false;
      }
      try {
        tprtf = _$TprtfFromJson(jsonD['tprtf']);
      } catch(e) {
        tprtf = _$TprtfFromJson({});
        ret = false;
      }
      try {
        tprts = _$TprtsFromJson(jsonD['tprts']);
      } catch(e) {
        tprts = _$TprtsFromJson({});
        ret = false;
      }
      try {
        pmouse_plus_1 = _$Pmouse_plus_1FromJson(jsonD['pmouse_plus_1']);
      } catch(e) {
        pmouse_plus_1 = _$Pmouse_plus_1FromJson({});
        ret = false;
      }
      try {
        pmouse_2300_1 = _$Pmouse_2300_1FromJson(jsonD['pmouse_2300_1']);
      } catch(e) {
        pmouse_2300_1 = _$Pmouse_2300_1FromJson({});
        ret = false;
      }
      try {
        pmouse_2300_2 = _$Pmouse_2300_2FromJson(jsonD['pmouse_2300_2']);
      } catch(e) {
        pmouse_2300_2 = _$Pmouse_2300_2FromJson({});
        ret = false;
      }
      try {
        fip_plus_1 = _$Fip_plus_1FromJson(jsonD['fip_plus_1']);
      } catch(e) {
        fip_plus_1 = _$Fip_plus_1FromJson({});
        ret = false;
      }
      try {
        fip_2300_1 = _$Fip_2300_1FromJson(jsonD['fip_2300_1']);
      } catch(e) {
        fip_2300_1 = _$Fip_2300_1FromJson({});
        ret = false;
      }
      try {
        fip_2300_2 = _$Fip_2300_2FromJson(jsonD['fip_2300_2']);
      } catch(e) {
        fip_2300_2 = _$Fip_2300_2FromJson({});
        ret = false;
      }
      try {
        segd_plus_1 = _$Segd_plus_1FromJson(jsonD['segd_plus_1']);
      } catch(e) {
        segd_plus_1 = _$Segd_plus_1FromJson({});
        ret = false;
      }
      try {
        segd_2300_1 = _$Segd_2300_1FromJson(jsonD['segd_2300_1']);
      } catch(e) {
        segd_2300_1 = _$Segd_2300_1FromJson({});
        ret = false;
      }
      try {
        segd_2300_2 = _$Segd_2300_2FromJson(jsonD['segd_2300_2']);
      } catch(e) {
        segd_2300_2 = _$Segd_2300_2FromJson({});
        ret = false;
      }
      try {
        vfd57_plus_1 = _$Vfd57_plus_1FromJson(jsonD['vfd57_plus_1']);
      } catch(e) {
        vfd57_plus_1 = _$Vfd57_plus_1FromJson({});
        ret = false;
      }
      try {
        vfd57_2300_1 = _$Vfd57_2300_1FromJson(jsonD['vfd57_2300_1']);
      } catch(e) {
        vfd57_2300_1 = _$Vfd57_2300_1FromJson({});
        ret = false;
      }
      try {
        vfd57_2300_2 = _$Vfd57_2300_2FromJson(jsonD['vfd57_2300_2']);
      } catch(e) {
        vfd57_2300_2 = _$Vfd57_2300_2FromJson({});
        ret = false;
      }
      try {
        mkey_plus_1 = _$Mkey_plus_1FromJson(jsonD['mkey_plus_1']);
      } catch(e) {
        mkey_plus_1 = _$Mkey_plus_1FromJson({});
        ret = false;
      }
      try {
        mkey_2300_1 = _$Mkey_2300_1FromJson(jsonD['mkey_2300_1']);
      } catch(e) {
        mkey_2300_1 = _$Mkey_2300_1FromJson({});
        ret = false;
      }
      try {
        mkey_2300_2 = _$Mkey_2300_2FromJson(jsonD['mkey_2300_2']);
      } catch(e) {
        mkey_2300_2 = _$Mkey_2300_2FromJson({});
        ret = false;
      }
      try {
        scan_plus_1 = _$Scan_plus_1FromJson(jsonD['scan_plus_1']);
      } catch(e) {
        scan_plus_1 = _$Scan_plus_1FromJson({});
        ret = false;
      }
      try {
        scan_plus_2 = _$Scan_plus_2FromJson(jsonD['scan_plus_2']);
      } catch(e) {
        scan_plus_2 = _$Scan_plus_2FromJson({});
        ret = false;
      }
      try {
        scan_2300_1 = _$Scan_2300_1FromJson(jsonD['scan_2300_1']);
      } catch(e) {
        scan_2300_1 = _$Scan_2300_1FromJson({});
        ret = false;
      }
      try {
        scan_2300_2 = _$Scan_2300_2FromJson(jsonD['scan_2300_2']);
      } catch(e) {
        scan_2300_2 = _$Scan_2300_2FromJson({});
        ret = false;
      }
      try {
        msr_2300_1 = _$Msr_2300_1FromJson(jsonD['msr_2300_1']);
      } catch(e) {
        msr_2300_1 = _$Msr_2300_1FromJson({});
        ret = false;
      }
      try {
        msr_2300_2 = _$Msr_2300_2FromJson(jsonD['msr_2300_2']);
      } catch(e) {
        msr_2300_2 = _$Msr_2300_2FromJson({});
        ret = false;
      }
      try {
        mkey_2800_1 = _$Mkey_2800_1FromJson(jsonD['mkey_2800_1']);
      } catch(e) {
        mkey_2800_1 = _$Mkey_2800_1FromJson({});
        ret = false;
      }
      try {
        mkey_2800_2 = _$Mkey_2800_2FromJson(jsonD['mkey_2800_2']);
      } catch(e) {
        mkey_2800_2 = _$Mkey_2800_2FromJson({});
        ret = false;
      }
      try {
        pmouse_2800_1 = _$Pmouse_2800_1FromJson(jsonD['pmouse_2800_1']);
      } catch(e) {
        pmouse_2800_1 = _$Pmouse_2800_1FromJson({});
        ret = false;
      }
      try {
        pmouse_2800_2 = _$Pmouse_2800_2FromJson(jsonD['pmouse_2800_2']);
      } catch(e) {
        pmouse_2800_2 = _$Pmouse_2800_2FromJson({});
        ret = false;
      }
      try {
        pmouse_2800_3 = _$Pmouse_2800_3FromJson(jsonD['pmouse_2800_3']);
      } catch(e) {
        pmouse_2800_3 = _$Pmouse_2800_3FromJson({});
        ret = false;
      }
      try {
        scan_2800_1 = _$Scan_2800_1FromJson(jsonD['scan_2800_1']);
      } catch(e) {
        scan_2800_1 = _$Scan_2800_1FromJson({});
        ret = false;
      }
      try {
        scan_2800_2 = _$Scan_2800_2FromJson(jsonD['scan_2800_2']);
      } catch(e) {
        scan_2800_2 = _$Scan_2800_2FromJson({});
        ret = false;
      }
      try {
        fip_2800_1 = _$Fip_2800_1FromJson(jsonD['fip_2800_1']);
      } catch(e) {
        fip_2800_1 = _$Fip_2800_1FromJson({});
        ret = false;
      }
      try {
        fip_2800_2 = _$Fip_2800_2FromJson(jsonD['fip_2800_2']);
      } catch(e) {
        fip_2800_2 = _$Fip_2800_2FromJson({});
        ret = false;
      }
      try {
        fip_2800_3 = _$Fip_2800_3FromJson(jsonD['fip_2800_3']);
      } catch(e) {
        fip_2800_3 = _$Fip_2800_3FromJson({});
        ret = false;
      }
      try {
        drw_2800_1 = _$Drw_2800_1FromJson(jsonD['drw_2800_1']);
      } catch(e) {
        drw_2800_1 = _$Drw_2800_1FromJson({});
        ret = false;
      }
      try {
        drw_2800_2 = _$Drw_2800_2FromJson(jsonD['drw_2800_2']);
      } catch(e) {
        drw_2800_2 = _$Drw_2800_2FromJson({});
        ret = false;
      }
      try {
        tprtss = _$TprtssFromJson(jsonD['tprtss']);
      } catch(e) {
        tprtss = _$TprtssFromJson({});
        ret = false;
      }
      try {
        tprtss2 = _$Tprtss2FromJson(jsonD['tprtss2']);
      } catch(e) {
        tprtss2 = _$Tprtss2FromJson({});
        ret = false;
      }
      try {
        pmouse_2500_1 = _$Pmouse_2500_1FromJson(jsonD['pmouse_2500_1']);
      } catch(e) {
        pmouse_2500_1 = _$Pmouse_2500_1FromJson({});
        ret = false;
      }
      try {
        pmouse_2500_2 = _$Pmouse_2500_2FromJson(jsonD['pmouse_2500_2']);
      } catch(e) {
        pmouse_2500_2 = _$Pmouse_2500_2FromJson({});
        ret = false;
      }
      try {
        fip_2500_1 = _$Fip_2500_1FromJson(jsonD['fip_2500_1']);
      } catch(e) {
        fip_2500_1 = _$Fip_2500_1FromJson({});
        ret = false;
      }
      try {
        fip_2500_2 = _$Fip_2500_2FromJson(jsonD['fip_2500_2']);
      } catch(e) {
        fip_2500_2 = _$Fip_2500_2FromJson({});
        ret = false;
      }
      try {
        scan_2500_1 = _$Scan_2500_1FromJson(jsonD['scan_2500_1']);
      } catch(e) {
        scan_2500_1 = _$Scan_2500_1FromJson({});
        ret = false;
      }
      try {
        scan_2500_2 = _$Scan_2500_2FromJson(jsonD['scan_2500_2']);
      } catch(e) {
        scan_2500_2 = _$Scan_2500_2FromJson({});
        ret = false;
      }
      try {
        msr_2500_1 = _$Msr_2500_1FromJson(jsonD['msr_2500_1']);
      } catch(e) {
        msr_2500_1 = _$Msr_2500_1FromJson({});
        ret = false;
      }
      try {
        msr_2500_2 = _$Msr_2500_2FromJson(jsonD['msr_2500_2']);
      } catch(e) {
        msr_2500_2 = _$Msr_2500_2FromJson({});
        ret = false;
      }
      try {
        pmouse_2350_1 = _$Pmouse_2350_1FromJson(jsonD['pmouse_2350_1']);
      } catch(e) {
        pmouse_2350_1 = _$Pmouse_2350_1FromJson({});
        ret = false;
      }
      try {
        pmouse_2350_2 = _$Pmouse_2350_2FromJson(jsonD['pmouse_2350_2']);
      } catch(e) {
        pmouse_2350_2 = _$Pmouse_2350_2FromJson({});
        ret = false;
      }
      try {
        scan_2800ip_1 = _$Scan_2800ip_1FromJson(jsonD['scan_2800ip_1']);
      } catch(e) {
        scan_2800ip_1 = _$Scan_2800ip_1FromJson({});
        ret = false;
      }
      try {
        scan_2800ip_2 = _$Scan_2800ip_2FromJson(jsonD['scan_2800ip_2']);
      } catch(e) {
        scan_2800ip_2 = _$Scan_2800ip_2FromJson({});
        ret = false;
      }
      try {
        tprtim = _$TprtimFromJson(jsonD['tprtim']);
      } catch(e) {
        tprtim = _$TprtimFromJson({});
        ret = false;
      }
      try {
        fip_2800im_1 = _$Fip_2800im_1FromJson(jsonD['fip_2800im_1']);
      } catch(e) {
        fip_2800im_1 = _$Fip_2800im_1FromJson({});
        ret = false;
      }
      try {
        fip_2800im_2 = _$Fip_2800im_2FromJson(jsonD['fip_2800im_2']);
      } catch(e) {
        fip_2800im_2 = _$Fip_2800im_2FromJson({});
        ret = false;
      }
      try {
        fip_2800im_3 = _$Fip_2800im_3FromJson(jsonD['fip_2800im_3']);
      } catch(e) {
        fip_2800im_3 = _$Fip_2800im_3FromJson({});
        ret = false;
      }
      try {
        scan_2800im_1 = _$Scan_2800im_1FromJson(jsonD['scan_2800im_1']);
      } catch(e) {
        scan_2800im_1 = _$Scan_2800im_1FromJson({});
        ret = false;
      }
      try {
        scan_2800im_2 = _$Scan_2800im_2FromJson(jsonD['scan_2800im_2']);
      } catch(e) {
        scan_2800im_2 = _$Scan_2800im_2FromJson({});
        ret = false;
      }
      try {
        pmouse_plus2_1 = _$Pmouse_plus2_1FromJson(jsonD['pmouse_plus2_1']);
      } catch(e) {
        pmouse_plus2_1 = _$Pmouse_plus2_1FromJson({});
        ret = false;
      }
      try {
        fip_plus2_1 = _$Fip_plus2_1FromJson(jsonD['fip_plus2_1']);
      } catch(e) {
        fip_plus2_1 = _$Fip_plus2_1FromJson({});
        ret = false;
      }
      try {
        fip_plus2_2 = _$Fip_plus2_2FromJson(jsonD['fip_plus2_2']);
      } catch(e) {
        fip_plus2_2 = _$Fip_plus2_2FromJson({});
        ret = false;
      }
      try {
        fip_plus2_3 = _$Fip_plus2_3FromJson(jsonD['fip_plus2_3']);
      } catch(e) {
        fip_plus2_3 = _$Fip_plus2_3FromJson({});
        ret = false;
      }
      try {
        msr_plus2_1 = _$Msr_plus2_1FromJson(jsonD['msr_plus2_1']);
      } catch(e) {
        msr_plus2_1 = _$Msr_plus2_1FromJson({});
        ret = false;
      }
      try {
        scan_2800a3_1 = _$Scan_2800a3_1FromJson(jsonD['scan_2800a3_1']);
      } catch(e) {
        scan_2800a3_1 = _$Scan_2800a3_1FromJson({});
        ret = false;
      }
      try {
        scan_2800i3_1 = _$Scan_2800i3_1FromJson(jsonD['scan_2800i3_1']);
      } catch(e) {
        scan_2800i3_1 = _$Scan_2800i3_1FromJson({});
        ret = false;
      }
      try {
        msr_int_1 = _$Msr_int_1FromJson(jsonD['msr_int_1']);
      } catch(e) {
        msr_int_1 = _$Msr_int_1FromJson({});
        ret = false;
      }
      try {
        scan_2800g3_1 = _$Scan_2800g3_1FromJson(jsonD['scan_2800g3_1']);
      } catch(e) {
        scan_2800g3_1 = _$Scan_2800g3_1FromJson({});
        ret = false;
      }
      try {
        pmouse_2800_4 = _$Pmouse_2800_4FromJson(jsonD['pmouse_2800_4']);
      } catch(e) {
        pmouse_2800_4 = _$Pmouse_2800_4FromJson({});
        ret = false;
      }
      try {
        tprthp = _$TprthpFromJson(jsonD['tprthp']);
      } catch(e) {
        tprthp = _$TprthpFromJson({});
        ret = false;
      }
      try {
        sprocket = _$SprocketFromJson(jsonD['sprocket']);
      } catch(e) {
        sprocket = _$SprocketFromJson({});
        ret = false;
      }
      try {
        acr = _$AcrFromJson(jsonD['acr']);
      } catch(e) {
        acr = _$AcrFromJson({});
        ret = false;
      }
      try {
        acb = _$AcbFromJson(jsonD['acb']);
      } catch(e) {
        acb = _$AcbFromJson({});
        ret = false;
      }
      try {
        acb20 = _$Acb20FromJson(jsonD['acb20']);
      } catch(e) {
        acb20 = _$Acb20FromJson({});
        ret = false;
      }
      try {
        rewrite = _$RewriteFromJson(jsonD['rewrite']);
      } catch(e) {
        rewrite = _$RewriteFromJson({});
        ret = false;
      }
      try {
        vismac = _$VismacFromJson(jsonD['vismac']);
      } catch(e) {
        vismac = _$VismacFromJson({});
        ret = false;
      }
      try {
        gcat = _$GcatFromJson(jsonD['gcat']);
      } catch(e) {
        gcat = _$GcatFromJson({});
        ret = false;
      }
      try {
        debit = _$DebitFromJson(jsonD['debit']);
      } catch(e) {
        debit = _$DebitFromJson({});
        ret = false;
      }
      try {
        scale = _$ScaleFromJson(jsonD['scale']);
      } catch(e) {
        scale = _$ScaleFromJson({});
        ret = false;
      }
      try {
        orc = _$OrcFromJson(jsonD['orc']);
      } catch(e) {
        orc = _$OrcFromJson({});
        ret = false;
      }
      try {
        sg_scale1 = _$Sg_scale1FromJson(jsonD['sg_scale1']);
      } catch(e) {
        sg_scale1 = _$Sg_scale1FromJson({});
        ret = false;
      }
      try {
        sg_scale2 = _$Sg_scale2FromJson(jsonD['sg_scale2']);
      } catch(e) {
        sg_scale2 = _$Sg_scale2FromJson({});
        ret = false;
      }
      try {
        sm_scale1 = _$Sm_scale1FromJson(jsonD['sm_scale1']);
      } catch(e) {
        sm_scale1 = _$Sm_scale1FromJson({});
        ret = false;
      }
      try {
        sm_scale2 = _$Sm_scale2FromJson(jsonD['sm_scale2']);
      } catch(e) {
        sm_scale2 = _$Sm_scale2FromJson({});
        ret = false;
      }
      try {
        sip60 = _$Sip60FromJson(jsonD['sip60']);
      } catch(e) {
        sip60 = _$Sip60FromJson({});
        ret = false;
      }
      try {
        psp60 = _$Psp60FromJson(jsonD['psp60']);
      } catch(e) {
        psp60 = _$Psp60FromJson({});
        ret = false;
      }
      try {
        stpr = _$StprFromJson(jsonD['stpr']);
      } catch(e) {
        stpr = _$StprFromJson({});
        ret = false;
      }
      try {
        pana = _$PanaFromJson(jsonD['pana']);
      } catch(e) {
        pana = _$PanaFromJson({});
        ret = false;
      }
      try {
        gp = _$GpFromJson(jsonD['gp']);
      } catch(e) {
        gp = _$GpFromJson({});
        ret = false;
      }
      try {
        sm_scalesc = _$Sm_scalescFromJson(jsonD['sm_scalesc']);
      } catch(e) {
        sm_scalesc = _$Sm_scalescFromJson({});
        ret = false;
      }
      try {
        sm_scalesc_scl = _$Sm_scalesc_sclFromJson(jsonD['sm_scalesc_scl']);
      } catch(e) {
        sm_scalesc_scl = _$Sm_scalesc_sclFromJson({});
        ret = false;
      }
      try {
        sm_scalesc_signp = _$Sm_scalesc_signpFromJson(jsonD['sm_scalesc_signp']);
      } catch(e) {
        sm_scalesc_signp = _$Sm_scalesc_signpFromJson({});
        ret = false;
      }
      try {
        s2pr = _$S2prFromJson(jsonD['s2pr']);
      } catch(e) {
        s2pr = _$S2prFromJson({});
        ret = false;
      }
      try {
        acb50 = _$Acb50FromJson(jsonD['acb50']);
      } catch(e) {
        acb50 = _$Acb50FromJson({});
        ret = false;
      }
      try {
        pwrctrl = _$PwrctrlFromJson(jsonD['pwrctrl']);
      } catch(e) {
        pwrctrl = _$PwrctrlFromJson({});
        ret = false;
      }
      try {
        pw410 = _$Pw410FromJson(jsonD['pw410']);
      } catch(e) {
        pw410 = _$Pw410FromJson({});
        ret = false;
      }
      try {
        ccr = _$CcrFromJson(jsonD['ccr']);
      } catch(e) {
        ccr = _$CcrFromJson({});
        ret = false;
      }
      try {
        psp70 = _$Psp70FromJson(jsonD['psp70']);
      } catch(e) {
        psp70 = _$Psp70FromJson({});
        ret = false;
      }
      try {
        dish = _$DishFromJson(jsonD['dish']);
      } catch(e) {
        dish = _$DishFromJson({});
        ret = false;
      }
      try {
        aiv = _$AivFromJson(jsonD['aiv']);
      } catch(e) {
        aiv = _$AivFromJson({});
        ret = false;
      }
      try {
        ar_stts_01 = _$Ar_stts_01FromJson(jsonD['ar_stts_01']);
      } catch(e) {
        ar_stts_01 = _$Ar_stts_01FromJson({});
        ret = false;
      }
      try {
        gcat_cnct = _$Gcat_cnctFromJson(jsonD['gcat_cnct']);
      } catch(e) {
        gcat_cnct = _$Gcat_cnctFromJson({});
        ret = false;
      }
      try {
        yomoca = _$YomocaFromJson(jsonD['yomoca']);
      } catch(e) {
        yomoca = _$YomocaFromJson({});
        ret = false;
      }
      try {
        smtplus = _$SmtplusFromJson(jsonD['smtplus']);
      } catch(e) {
        smtplus = _$SmtplusFromJson({});
        ret = false;
      }
      try {
        suica = _$SuicaFromJson(jsonD['suica']);
      } catch(e) {
        suica = _$SuicaFromJson({});
        ret = false;
      }
      try {
        rfid = _$RfidFromJson(jsonD['rfid']);
      } catch(e) {
        rfid = _$RfidFromJson({});
        ret = false;
      }
      try {
        disht = _$DishtFromJson(jsonD['disht']);
      } catch(e) {
        disht = _$DishtFromJson({});
        ret = false;
      }
      try {
        mcp200 = _$Mcp200FromJson(jsonD['mcp200']);
      } catch(e) {
        mcp200 = _$Mcp200FromJson({});
        ret = false;
      }
      try {
        fcl = _$FclFromJson(jsonD['fcl']);
      } catch(e) {
        fcl = _$FclFromJson({});
        ret = false;
      }
      try {
        jrw_multi = _$Jrw_multiFromJson(jsonD['jrw_multi']);
      } catch(e) {
        jrw_multi = _$Jrw_multiFromJson({});
        ret = false;
      }
      try {
        ht2980 = _$Ht2980FromJson(jsonD['ht2980']);
      } catch(e) {
        ht2980 = _$Ht2980FromJson({});
        ret = false;
      }
      try {
        absv31 = _$Absv31FromJson(jsonD['absv31']);
      } catch(e) {
        absv31 = _$Absv31FromJson({});
        ret = false;
      }
      try {
        yamato = _$YamatoFromJson(jsonD['yamato']);
      } catch(e) {
        yamato = _$YamatoFromJson({});
        ret = false;
      }
      try {
        cct = _$CctFromJson(jsonD['cct']);
      } catch(e) {
        cct = _$CctFromJson({});
        ret = false;
      }
      try {
        castles = _$CastlesFromJson(jsonD['castles']);
      } catch(e) {
        castles = _$CastlesFromJson({});
        ret = false;
      }
      try {
        usbcam = _$UsbcamFromJson(jsonD['usbcam']);
      } catch(e) {
        usbcam = _$UsbcamFromJson({});
        ret = false;
      }
      try {
        masr = _$MasrFromJson(jsonD['masr']);
      } catch(e) {
        masr = _$MasrFromJson({});
        ret = false;
      }
      try {
        jmups = _$JmupsFromJson(jsonD['jmups']);
      } catch(e) {
        jmups = _$JmupsFromJson({});
        ret = false;
      }
      try {
        fal2 = _$Fal2FromJson(jsonD['fal2']);
      } catch(e) {
        fal2 = _$Fal2FromJson({});
        ret = false;
      }
      try {
        sqrc = _$SqrcFromJson(jsonD['sqrc']);
      } catch(e) {
        sqrc = _$SqrcFromJson({});
        ret = false;
      }
      try {
        tprtrp = _$TprtrpFromJson(jsonD['tprtrp']);
      } catch(e) {
        tprtrp = _$TprtrpFromJson({});
        ret = false;
      }
      try {
        tprtrp2 = _$Tprtrp2FromJson(jsonD['tprtrp2']);
      } catch(e) {
        tprtrp2 = _$Tprtrp2FromJson({});
        ret = false;
      }
      try {
        iccard = _$IccardFromJson(jsonD['iccard']);
      } catch(e) {
        iccard = _$IccardFromJson({});
        ret = false;
      }
      try {
        mst = _$MstFromJson(jsonD['mst']);
      } catch(e) {
        mst = _$MstFromJson({});
        ret = false;
      }
      try {
        scan_2800_3 = _$Scan_2800_3FromJson(jsonD['scan_2800_3']);
      } catch(e) {
        scan_2800_3 = _$Scan_2800_3FromJson({});
        ret = false;
      }
      try {
        vega3000 = _$Vega3000FromJson(jsonD['vega3000']);
      } catch(e) {
        vega3000 = _$Vega3000FromJson({});
        ret = false;
      }
      try {
        powli = _$PowliFromJson(jsonD['powli']);
      } catch(e) {
        powli = _$PowliFromJson({});
        ret = false;
      }
      try {
        scan_2800_4 = _$Scan_2800_4FromJson(jsonD['scan_2800_4']);
      } catch(e) {
        scan_2800_4 = _$Scan_2800_4FromJson({});
        ret = false;
      }
      try {
        psensor_1 = _$Psensor_1FromJson(jsonD['psensor_1']);
      } catch(e) {
        psensor_1 = _$Psensor_1FromJson({});
        ret = false;
      }
      try {
        apbf_1 = _$Apbf_1FromJson(jsonD['apbf_1']);
      } catch(e) {
        apbf_1 = _$Apbf_1FromJson({});
        ret = false;
      }
      try {
        scalerm = _$ScalermFromJson(jsonD['scalerm']);
      } catch(e) {
        scalerm = _$ScalermFromJson({});
        ret = false;
      }
      try {
        exc = _$ExcFromJson(jsonD['exc']);
      } catch(e) {
        exc = _$ExcFromJson({});
        ret = false;
      }
      try {
        pct = _$PctFromJson(jsonD['pct']);
      } catch(e) {
        pct = _$PctFromJson({});
        ret = false;
      }
      try {
        hitouch = _$HitouchFromJson(jsonD['hitouch']);
      } catch(e) {
        hitouch = _$HitouchFromJson({});
        ret = false;
      }
      try {
        ami = _$AmiFromJson(jsonD['ami']);
      } catch(e) {
        ami = _$AmiFromJson({});
        ret = false;
      }
      try {
        scale_sks = _$Scale_sksFromJson(jsonD['scale_sks']);
      } catch(e) {
        scale_sks = _$Scale_sksFromJson({});
        ret = false;
      }
      try {
        aibox = _$AiboxFromJson(jsonD['aibox']);
      } catch(e) {
        aibox = _$AiboxFromJson({});
        ret = false;
      }

    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Info info = _Info(
    version                            : "",
    comment                            : "",
  );

  _Type type = _Type(
    dual                               : "",
    webjr                              : "",
    web2300                            : "",
    webplus                            : "",
    web2800                            : "",
    web2350                            : "",
    web2500                            : "",
    webplus2                           : "",
    tower                              : "",
    mskind                             : "",
    standalone                         : "",
    membersystem                       : "",
    memberpoint                        : "",
    memberfsp                          : "",
    creditsystem                       : "",
    special_receipt                    : "",
    disc_barcode                       : "",
    iwaisystem                         : "",
    self_gate                          : "",
    vismacsystem                       : "",
    sys_24hour                         : "",
    hq_asp                             : "",
    jasaitama_sys                      : "",
    promsystem                         : "",
    edysystem                          : "",
    fresh_barcode                      : "",
    sugi_sys                           : "",
    hesokurisystem                     : "",
    greenstamp_sys                     : "",
    coopsystem                         : "",
    pointcardsystem                    : "",
    mobilesystem                       : "",
    hq_other                           : "",
    regconnectsystem                   : "",
    clothes_barcode                    : "",
    fjss                               : "",
    mcsystem                           : "",
    network_prn                        : "",
    poppy_print                        : "",
    tag_print                          : "",
    taurus                             : "",
    ntt_asp                            : "",
    eat_in                             : "",
    mobilesystem2                      : "",
    magazine_barcode                   : "",
    hq_other_real                      : "",
    pw410system                        : "",
    nsc_credit                         : "",
    hq_prod                            : "",
    felicasystem                       : "",
    psp70system                        : "",
    ntt_bcom                           : "",
    catalinasystem                     : "",
    prcchkr                            : "",
    dishcalcsystem                     : "",
    itf_barcode                        : "",
    css_act                            : "",
    cust_detail                        : "",
    custrealsvr                        : "",
    suica_cat                          : "",
    yomocasystem                       : "",
    smartplussystem                    : "",
    duty                               : "",
    ecoasystem                         : "",
    iccardsystem                       : "",
    sub_ticket                         : "",
    quicpaysystem                      : "",
    idsystem                           : "",
    revival_receipt                    : "",
    quick_self                         : "",
    quick_self_chg                     : "",
    assist_monitor                     : "",
    mp1_print                          : "",
    realitmsend                        : "",
    rainbowcard                        : "",
    gramx                              : "",
    mm_abj                             : "",
    cat_point                          : "",
    tagrdwt                            : "",
    department_store                   : "",
    edyno_mbr                          : "",
    fcf_card                           : "",
    panamembersystem                   : "",
    landisk                            : "",
    pitapasystem                       : "",
    tuocardsystem                      : "",
    sallmtbar                          : "",
    business_mode                      : "",
    mcp200system                       : "",
    spvtsystem                         : "",
    remotesystem                       : "",
    order_mode                         : "",
    jrem_multisystem                   : "",
    media_info                         : "",
    gs1_barcode                        : "",
    assortsystem                       : "",
    center_server                      : "",
    reservsystem                       : "",
    drug_rev                           : "",
    gincardsystem                      : "",
    fclqpsystem                        : "",
    fcledysystem                       : "",
    caps_cafis                         : "",
    fclidsystem                        : "",
    ptcktissusystem                    : "",
    abs_prepaid                        : "",
    prod_item_autoset                  : "",
    prod_itf14_barcode                 : "",
    special_coupon                     : "",
    bluechip_server                    : "",
    hitachi_bluechip                   : "",
    hq_other_cantevole                 : "",
    qcashier_system                    : "",
    receipt_qr_system                  : "",
    visatouch_infox                    : "",
    pbchg_system                       : "",
    hc1_system                         : "",
    caps_hc1_cafis                     : "",
    remoteserver                       : "",
    mrycardsystem                      : "",
    sp_department                      : "",
    decimalitmsend                     : "",
    wiz_cnct                           : "",
    absv31_rwt                         : "",
    pluralqr_system                    : "",
    netdoareserv                       : "",
    selpluadj                          : "",
    custreal_webser                    : "",
    wiz_abj                            : "",
    custreal_uid                       : "",
    bdlitmsend                         : "",
    custreal_netdoa                    : "",
    ut_cnct                            : "",
    caps_pqvic                         : "",
    yamato_system                      : "",
    caps_cafis_standard                : "",
    nttd_preca                         : "",
    usbcam_cnct                        : "",
    drugstore                          : "",
    custreal_nec                       : "",
    custreal_op                        : "",
    dummy_crdt                         : "",
    hc2_system                         : "",
    price_sound                        : "",
    dummy_preca                        : "",
    monitored_system                   : "",
    jmups_system                       : "",
    ut1qpsystem                        : "",
    ut1idsystem                        : "",
    brain_system                       : "",
    pfmpitapasystem                    : "",
    pfmjricsystem                      : "",
    chargeslip_system                  : "",
    pfmjricchargesystem                : "",
    itemprc_reduction_coupon           : "",
    cat_jmups_system                   : "",
    sqrc_ticket_system                 : "",
    cct_connect_system                 : "",
    cct_emoney_system                  : "",
    tec_infox_jet_s_system             : "",
    prod_instore_zero_flg              : "",
    front_self_system                  : "",
    trk_preca                          : "",
    desktop_cashier_system             : "",
    suica_charge_system                : "",
    nimoca_point_system                : "",
    custreal_pointartist               : "",
    tb1_system                         : "",
    tax_free_system                    : "",
    repica_system                      : "",
    caps_cardnet_system                : "",
    yumeca_system                      : "",
    dummy_suica                        : "",
    payment_mng                        : "",
    custreal_tpoint                    : "",
    mammy_system                       : "",
    itemtyp_send                       : "",
    yumeca_pol_system                  : "",
    custreal_hps                       : "",
    maruto_system                      : "",
    hc3_system                         : "",
    sm3_marui_system                   : "",
    kitchen_print                      : "",
    cogca_system                       : "",
    bdl_multi_select_system            : "",
    sallmtbar26                        : "",
    purchase_ticket_system             : "",
    custreal_uni_system                : "",
    ej_animation_system                : "",
    value_card_system                  : "",
    sm4_comodi_system                  : "",
    sm5_itoku_system                   : "",
    cct_pointuse_system                : "",
    zhq_system                         : "",
    rpoint_system                      : "",
    vesca_system                       : "",
    ajs_emoney_system                  : "",
    sm16_taiyo_toyocho_system          : "",
    infox_detail_send_system           : "",
    self_medication_system             : "",
    sm20_maeda_system                  : "",
    pana_waon_system                   : "",
    onepay_system                      : "",
    happyself_system                   : "",
    happyself_smile_system             : "",
    linepay_system                     : "",
    staff_release_system               : "",
    wiz_base_system                    : "",
    pack_on_time_system                : "",
    shop_and_go_system                 : "",
    staffid1_ymss_system               : "",
    sm33_nishizawa_system              : "",
    ds2_godai_system                   : "",
    taxfree_passportinfo_system        : "",
    sm36_sanpraza_system               : "",
    cr50_system                        : "",
    case_clothes_barcode_system        : "",
    custreal_dummy_system              : "",
    reason_select_std_system           : "",
    barcode_pay1_system                : "",
    custreal_ptactix                   : "",
    cr3_sharp_system                   : "",
    game_barcode_system                : "",
    cct_codepay_system                 : "",
    ws_system                          : "",
    custreal_pointinfinity             : "",
    toy_system                         : "",
    canal_payment_service_system       : "",
    multi_vega_system                  : "",
    dispensing_pharmacy_system         : "",
    sm41_bellejois_system              : "",
    sm42_kanesue_system                : "",
    dpoint_system                      : "",
    public_barcode_pay_system          : "",
    ts_indiv_setting_system            : "",
    sm44_ja_tsuruoka_system            : "",
    stera_terminal_system              : "",
    repica_point_system                : "",
    sm45_ocean_system                  : "",
    fujitsu_fip_codepay_system         : "",
    sm49_itochain_system               : "",
    taxfree_server_system              : "",
    employee_card_payment_system       : "",
    net_receipt_system                 : "",
    public_barcode_pay2_system         : "",
    sm52_palette_system                : "",
    public_barcode_pay3_system         : "",
    svscls2_stlpdsc_system             : "",
    sm55_takayanagi_system             : "",
    mail_send_system                   : "",
    netstars_codepay_system            : "",
    sm56_kobebussan_system             : "",
    hys1_seria_system                  : "",
    liqr_taxfree_system                : "",
    custreal_gyomuca_system            : "",
    sm59_takaramc_system               : "",
    detail_noprn_system                : "",
    sm61_fujifilm_system               : "",
    department2_system                 : "",
    custreal_crosspoint                : "",
    hc12_joyful_honda_system           : "",
    sm62_maruichi_system               : "",
    sm65_ryubo_system                  : "",
    tomoIF_system                      : "",
    sm66_fresta_system                 : "",
    cosme1_istyle_system               : "",
    sm71_selection_system              : "",
    kitchen_print_recipt               : "",
    miyazaki_city_system               : "",
    public_barcode_pay4_system         : "",
    sp1_qr_read_system                 : "",
    aibox_alignment_system             : "",
    cashonly_keyopt_system             : "",
    sm74_ozeki_system                  : "",
    carparking_qr_system               : "",
    olc_system                         : "",
    quiz_payment_system                : "",
    jets_lane_system                   : "",
    rf1_hs_system                      : "",
  );

  _Dip_sw dip_sw = _Dip_sw(
    subcpu1                            : "",
    subcpu2                            : "",
  );

  _Boot_webplus2_desktop boot_webplus2_desktop = _Boot_webplus2_desktop(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_web2350_tower boot_web2350_tower = _Boot_web2350_tower(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_web2350_desktop boot_web2350_desktop = _Boot_web2350_desktop(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_web2500_tower boot_web2500_tower = _Boot_web2500_tower(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers25                          : "",
    drivers26                          : "",
    drivers27                          : "",
    drivers28                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_web2500_desktop boot_web2500_desktop = _Boot_web2500_desktop(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_web2800_tower boot_web2800_tower = _Boot_web2800_tower(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers25                          : "",
    drivers26                          : "",
    drivers27                          : "",
    drivers28                          : "",
    drivers29                          : "",
    drivers30                          : "",
    drivers31                          : "",
    drivers32                          : "",
    drivers33                          : "",
    drivers34                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_web2800_desktop boot_web2800_desktop = _Boot_web2800_desktop(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers25                          : "",
    drivers26                          : "",
    drivers27                          : "",
    drivers28                          : "",
    drivers29                          : "",
    drivers30                          : "",
    drivers31                          : "",
    drivers32                          : "",
    drivers33                          : "",
    drivers34                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_web2300_tower boot_web2300_tower = _Boot_web2300_tower(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_web2300_desktop boot_web2300_desktop = _Boot_web2300_desktop(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_webplus_desktop boot_webplus_desktop = _Boot_webplus_desktop(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_dual_tower boot_dual_tower = _Boot_dual_tower(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers25                          : "",
    drivers26                          : "",
    drivers27                          : "",
    drivers28                          : "",
    drivers29                          : "",
    drivers30                          : "",
    drivers31                          : "",
    drivers32                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_dual_desktop boot_dual_desktop = _Boot_dual_desktop(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_jr boot_jr = _Boot_jr(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_jr_tower boot_jr_tower = _Boot_jr_tower(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers25                          : "",
    drivers26                          : "",
    drivers27                          : "",
    drivers28                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_tower boot_tower = _Boot_tower(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers22                          : "",
    drivers23                          : "",
    drivers24                          : "",
    drivers25                          : "",
    drivers26                          : "",
    drivers27                          : "",
    drivers28                          : "",
    drivers29                          : "",
    drivers30                          : "",
    drivers31                          : "",
    drivers32                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Boot_desktop boot_desktop = _Boot_desktop(
    drivers01                          : "",
    drivers02                          : "",
    drivers03                          : "",
    drivers04                          : "",
    drivers05                          : "",
    drivers06                          : "",
    drivers07                          : "",
    drivers08                          : "",
    drivers09                          : "",
    drivers10                          : "",
    drivers11                          : "",
    drivers12                          : "",
    drivers13                          : "",
    drivers14                          : "",
    drivers15                          : "",
    drivers16                          : "",
    drivers17                          : "",
    drivers18                          : "",
    drivers19                          : "",
    drivers20                          : "",
    drivers21                          : "",
    drivers36                          : "",
    drivers37                          : "",
    drivers38                          : "",
    drivers39                          : "",
  );

  _Verup verup = _Verup(
    verup                              : "",
    date                               : "",
    time                               : "",
    command                            : "",
    param                              : "",
  );

  _Speaker speaker = _Speaker(
    keyvol1                            : 0,
    keytone1                           : 0,
    scanvol1                           : 0,
    scantone1                          : 0,
    keyvol2                            : 0,
    keytone2                           : 0,
    scanvol2                           : 0,
    scantone2                          : 0,
  );

  _Lcdbright lcdbright = _Lcdbright(
    lcdbright1                         : 0,
    lcdbright2                         : 0,
  );

  _Logging logging = _Logging(
    maxsize                            : 0,
    level                              : 0,
  );

  _Scanner scanner = _Scanner(
    reschar                            : 0,
    reschar_tower                      : 0,
    reschar_add                        : 0,
  );

  _Subcpu1 subcpu1 = _Subcpu1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Spk1 spk1 = _Spk1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Wand1 wand1 = _Wand1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Wand2 wand2 = _Wand2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Lcdbrt1 lcdbrt1 = _Lcdbrt1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Lcdbrt2 lcdbrt2 = _Lcdbrt2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Fip1 fip1 = _Fip1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Mkey1 mkey1 = _Mkey1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Mkey2 mkey2 = _Mkey2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Lcd57 lcd57 = _Lcd57(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tkey1t tkey1t = _Tkey1t(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tkey1d tkey1d = _Tkey1d(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Msr11 msr11 = _Msr11(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Msr12 msr12 = _Msr12(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Msr21 msr21 = _Msr21(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Msr22 msr22 = _Msr22(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Subcpu2 subcpu2 = _Subcpu2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Spk2 spk2 = _Spk2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Fip2 fip2 = _Fip2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tkey2 tkey2 = _Tkey2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tprt tprt = _Tprt(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pmouse1 pmouse1 = _Pmouse1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pmouse2 pmouse2 = _Pmouse2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sprt sprt = _Sprt(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Mupdate mupdate = _Mupdate(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _History history = _History(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Hist_csrv hist_csrv = _Hist_csrv(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tqrcd tqrcd = _Tqrcd(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Hqftp hqftp = _Hqftp(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Supdate supdate = _Supdate(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Hqhist hqhist = _Hqhist(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Hqprod hqprod = _Hqprod(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Signp signp = _Signp(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Detect detect = _Detect(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Callsw callsw = _Callsw(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Subcpu3 subcpu3 = _Subcpu3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Spk3 spk3 = _Spk3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tkey3d tkey3d = _Tkey3d(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Seg1 seg1 = _Seg1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Seg2 seg2 = _Seg2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Wand3 wand3 = _Wand3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Lcdbrt3 lcdbrt3 = _Lcdbrt3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Mkey3 mkey3 = _Mkey3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Msr31 msr31 = _Msr31(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Msr32 msr32 = _Msr32(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pmouse3 pmouse3 = _Pmouse3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Schctrl schctrl = _Schctrl(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Fip3 fip3 = _Fip3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Vfd57_3 vfd57_3 = _Vfd57_3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tprtf tprtf = _Tprtf(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tprts tprts = _Tprts(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pmouse_plus_1 pmouse_plus_1 = _Pmouse_plus_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Pmouse_2300_1 pmouse_2300_1 = _Pmouse_2300_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Pmouse_2300_2 pmouse_2300_2 = _Pmouse_2300_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_plus_1 fip_plus_1 = _Fip_plus_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2300_1 fip_2300_1 = _Fip_2300_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2300_2 fip_2300_2 = _Fip_2300_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Segd_plus_1 segd_plus_1 = _Segd_plus_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Segd_2300_1 segd_2300_1 = _Segd_2300_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Segd_2300_2 segd_2300_2 = _Segd_2300_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Vfd57_plus_1 vfd57_plus_1 = _Vfd57_plus_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Vfd57_2300_1 vfd57_2300_1 = _Vfd57_2300_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Vfd57_2300_2 vfd57_2300_2 = _Vfd57_2300_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Mkey_plus_1 mkey_plus_1 = _Mkey_plus_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Mkey_2300_1 mkey_2300_1 = _Mkey_2300_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Mkey_2300_2 mkey_2300_2 = _Mkey_2300_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_plus_1 scan_plus_1 = _Scan_plus_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_plus_2 scan_plus_2 = _Scan_plus_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2300_1 scan_2300_1 = _Scan_2300_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2300_2 scan_2300_2 = _Scan_2300_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Msr_2300_1 msr_2300_1 = _Msr_2300_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Msr_2300_2 msr_2300_2 = _Msr_2300_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Mkey_2800_1 mkey_2800_1 = _Mkey_2800_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Mkey_2800_2 mkey_2800_2 = _Mkey_2800_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Pmouse_2800_1 pmouse_2800_1 = _Pmouse_2800_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    inifile2                           : "",
    tower                              : 0,
  );

  _Pmouse_2800_2 pmouse_2800_2 = _Pmouse_2800_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Pmouse_2800_3 pmouse_2800_3 = _Pmouse_2800_3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    inifile2                           : "",
    inifile3                           : "",
    tower                              : 0,
  );

  _Scan_2800_1 scan_2800_1 = _Scan_2800_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2800_2 scan_2800_2 = _Scan_2800_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2800_1 fip_2800_1 = _Fip_2800_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2800_2 fip_2800_2 = _Fip_2800_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2800_3 fip_2800_3 = _Fip_2800_3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Drw_2800_1 drw_2800_1 = _Drw_2800_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Drw_2800_2 drw_2800_2 = _Drw_2800_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Tprtss tprtss = _Tprtss(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tprtss2 tprtss2 = _Tprtss2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pmouse_2500_1 pmouse_2500_1 = _Pmouse_2500_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    inifile2                           : "",
    tower                              : 0,
  );

  _Pmouse_2500_2 pmouse_2500_2 = _Pmouse_2500_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2500_1 fip_2500_1 = _Fip_2500_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2500_2 fip_2500_2 = _Fip_2500_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2500_1 scan_2500_1 = _Scan_2500_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2500_2 scan_2500_2 = _Scan_2500_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Msr_2500_1 msr_2500_1 = _Msr_2500_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Msr_2500_2 msr_2500_2 = _Msr_2500_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Pmouse_2350_1 pmouse_2350_1 = _Pmouse_2350_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Pmouse_2350_2 pmouse_2350_2 = _Pmouse_2350_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2800ip_1 scan_2800ip_1 = _Scan_2800ip_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2800ip_2 scan_2800ip_2 = _Scan_2800ip_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Tprtim tprtim = _Tprtim(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Fip_2800im_1 fip_2800im_1 = _Fip_2800im_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2800im_2 fip_2800im_2 = _Fip_2800im_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_2800im_3 fip_2800im_3 = _Fip_2800im_3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2800im_1 scan_2800im_1 = _Scan_2800im_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2800im_2 scan_2800im_2 = _Scan_2800im_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Pmouse_plus2_1 pmouse_plus2_1 = _Pmouse_plus2_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_plus2_1 fip_plus2_1 = _Fip_plus2_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_plus2_2 fip_plus2_2 = _Fip_plus2_2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Fip_plus2_3 fip_plus2_3 = _Fip_plus2_3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Msr_plus2_1 msr_plus2_1 = _Msr_plus2_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2800a3_1 scan_2800a3_1 = _Scan_2800a3_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2800i3_1 scan_2800i3_1 = _Scan_2800i3_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Msr_int_1 msr_int_1 = _Msr_int_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Scan_2800g3_1 scan_2800g3_1 = _Scan_2800g3_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Pmouse_2800_4 pmouse_2800_4 = _Pmouse_2800_4(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    inifile2                           : "",
    tower                              : 0,
  );

  _Tprthp tprthp = _Tprthp(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sprocket sprocket = _Sprocket(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Acr acr = _Acr(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Acb acb = _Acb(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Acb20 acb20 = _Acb20(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Rewrite rewrite = _Rewrite(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Vismac vismac = _Vismac(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Gcat gcat = _Gcat(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Debit debit = _Debit(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Scale scale = _Scale(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Orc orc = _Orc(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sg_scale1 sg_scale1 = _Sg_scale1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sg_scale2 sg_scale2 = _Sg_scale2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sm_scale1 sm_scale1 = _Sm_scale1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sm_scale2 sm_scale2 = _Sm_scale2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sip60 sip60 = _Sip60(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Psp60 psp60 = _Psp60(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Stpr stpr = _Stpr(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pana pana = _Pana(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Gp gp = _Gp(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sm_scalesc sm_scalesc = _Sm_scalesc(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sm_scalesc_scl sm_scalesc_scl = _Sm_scalesc_scl(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sm_scalesc_signp sm_scalesc_signp = _Sm_scalesc_signp(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _S2pr s2pr = _S2pr(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Acb50 acb50 = _Acb50(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pwrctrl pwrctrl = _Pwrctrl(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pw410 pw410 = _Pw410(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Ccr ccr = _Ccr(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Psp70 psp70 = _Psp70(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Dish dish = _Dish(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Aiv aiv = _Aiv(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Ar_stts_01 ar_stts_01 = _Ar_stts_01(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Gcat_cnct gcat_cnct = _Gcat_cnct(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Yomoca yomoca = _Yomoca(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Smtplus smtplus = _Smtplus(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Suica suica = _Suica(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Rfid rfid = _Rfid(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Disht disht = _Disht(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Mcp200 mcp200 = _Mcp200(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Fcl fcl = _Fcl(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Jrw_multi jrw_multi = _Jrw_multi(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Ht2980 ht2980 = _Ht2980(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Absv31 absv31 = _Absv31(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Yamato yamato = _Yamato(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Cct cct = _Cct(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Castles castles = _Castles(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Usbcam usbcam = _Usbcam(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Masr masr = _Masr(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Jmups jmups = _Jmups(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Fal2 fal2 = _Fal2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Sqrc sqrc = _Sqrc(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tprtrp tprtrp = _Tprtrp(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Tprtrp2 tprtrp2 = _Tprtrp2(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Iccard iccard = _Iccard(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Mst mst = _Mst(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Scan_2800_3 scan_2800_3 = _Scan_2800_3(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Vega3000 vega3000 = _Vega3000(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Powli powli = _Powli(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Scan_2800_4 scan_2800_4 = _Scan_2800_4(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
    tower                              : 0,
  );

  _Psensor_1 psensor_1 = _Psensor_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Apbf_1 apbf_1 = _Apbf_1(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Scalerm scalerm = _Scalerm(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Exc exc = _Exc(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Pct pct = _Pct(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Hitouch hitouch = _Hitouch(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Ami ami = _Ami(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Scale_sks scale_sks = _Scale_sks(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );

  _Aibox aibox = _Aibox(
    entry                              : "",
    priority                           : 0,
    inifile                            : "",
  );
}

@JsonSerializable()
class _Info {
  factory _Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);

  _Info({
    required this.version,
    required this.comment,
  });

  @JsonKey(defaultValue: "00.00.85")
  String version;
  @JsonKey(defaultValue: "release version for fsiabc")
  String comment;
}

@JsonSerializable()
class _Type {
  factory _Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
  Map<String, dynamic> toJson() => _$TypeToJson(this);

  _Type({
    required this.dual,
    required this.webjr,
    required this.web2300,
    required this.webplus,
    required this.web2800,
    required this.web2350,
    required this.web2500,
    required this.webplus2,
    required this.tower,
    required this.mskind,
    required this.standalone,
    required this.membersystem,
    required this.memberpoint,
    required this.memberfsp,
    required this.creditsystem,
    required this.special_receipt,
    required this.disc_barcode,
    required this.iwaisystem,
    required this.self_gate,
    required this.vismacsystem,
    required this.sys_24hour,
    required this.hq_asp,
    required this.jasaitama_sys,
    required this.promsystem,
    required this.edysystem,
    required this.fresh_barcode,
    required this.sugi_sys,
    required this.hesokurisystem,
    required this.greenstamp_sys,
    required this.coopsystem,
    required this.pointcardsystem,
    required this.mobilesystem,
    required this.hq_other,
    required this.regconnectsystem,
    required this.clothes_barcode,
    required this.fjss,
    required this.mcsystem,
    required this.network_prn,
    required this.poppy_print,
    required this.tag_print,
    required this.taurus,
    required this.ntt_asp,
    required this.eat_in,
    required this.mobilesystem2,
    required this.magazine_barcode,
    required this.hq_other_real,
    required this.pw410system,
    required this.nsc_credit,
    required this.hq_prod,
    required this.felicasystem,
    required this.psp70system,
    required this.ntt_bcom,
    required this.catalinasystem,
    required this.prcchkr,
    required this.dishcalcsystem,
    required this.itf_barcode,
    required this.css_act,
    required this.cust_detail,
    required this.custrealsvr,
    required this.suica_cat,
    required this.yomocasystem,
    required this.smartplussystem,
    required this.duty,
    required this.ecoasystem,
    required this.iccardsystem,
    required this.sub_ticket,
    required this.quicpaysystem,
    required this.idsystem,
    required this.revival_receipt,
    required this.quick_self,
    required this.quick_self_chg,
    required this.assist_monitor,
    required this.mp1_print,
    required this.realitmsend,
    required this.rainbowcard,
    required this.gramx,
    required this.mm_abj,
    required this.cat_point,
    required this.tagrdwt,
    required this.department_store,
    required this.edyno_mbr,
    required this.fcf_card,
    required this.panamembersystem,
    required this.landisk,
    required this.pitapasystem,
    required this.tuocardsystem,
    required this.sallmtbar,
    required this.business_mode,
    required this.mcp200system,
    required this.spvtsystem,
    required this.remotesystem,
    required this.order_mode,
    required this.jrem_multisystem,
    required this.media_info,
    required this.gs1_barcode,
    required this.assortsystem,
    required this.center_server,
    required this.reservsystem,
    required this.drug_rev,
    required this.gincardsystem,
    required this.fclqpsystem,
    required this.fcledysystem,
    required this.caps_cafis,
    required this.fclidsystem,
    required this.ptcktissusystem,
    required this.abs_prepaid,
    required this.prod_item_autoset,
    required this.prod_itf14_barcode,
    required this.special_coupon,
    required this.bluechip_server,
    required this.hitachi_bluechip,
    required this.hq_other_cantevole,
    required this.qcashier_system,
    required this.receipt_qr_system,
    required this.visatouch_infox,
    required this.pbchg_system,
    required this.hc1_system,
    required this.caps_hc1_cafis,
    required this.remoteserver,
    required this.mrycardsystem,
    required this.sp_department,
    required this.decimalitmsend,
    required this.wiz_cnct,
    required this.absv31_rwt,
    required this.pluralqr_system,
    required this.netdoareserv,
    required this.selpluadj,
    required this.custreal_webser,
    required this.wiz_abj,
    required this.custreal_uid,
    required this.bdlitmsend,
    required this.custreal_netdoa,
    required this.ut_cnct,
    required this.caps_pqvic,
    required this.yamato_system,
    required this.caps_cafis_standard,
    required this.nttd_preca,
    required this.usbcam_cnct,
    required this.drugstore,
    required this.custreal_nec,
    required this.custreal_op,
    required this.dummy_crdt,
    required this.hc2_system,
    required this.price_sound,
    required this.dummy_preca,
    required this.monitored_system,
    required this.jmups_system,
    required this.ut1qpsystem,
    required this.ut1idsystem,
    required this.brain_system,
    required this.pfmpitapasystem,
    required this.pfmjricsystem,
    required this.chargeslip_system,
    required this.pfmjricchargesystem,
    required this.itemprc_reduction_coupon,
    required this.cat_jmups_system,
    required this.sqrc_ticket_system,
    required this.cct_connect_system,
    required this.cct_emoney_system,
    required this.tec_infox_jet_s_system,
    required this.prod_instore_zero_flg,
    required this.front_self_system,
    required this.trk_preca,
    required this.desktop_cashier_system,
    required this.suica_charge_system,
    required this.nimoca_point_system,
    required this.custreal_pointartist,
    required this.tb1_system,
    required this.tax_free_system,
    required this.repica_system,
    required this.caps_cardnet_system,
    required this.yumeca_system,
    required this.dummy_suica,
    required this.payment_mng,
    required this.custreal_tpoint,
    required this.mammy_system,
    required this.itemtyp_send,
    required this.yumeca_pol_system,
    required this.custreal_hps,
    required this.maruto_system,
    required this.hc3_system,
    required this.sm3_marui_system,
    required this.kitchen_print,
    required this.cogca_system,
    required this.bdl_multi_select_system,
    required this.sallmtbar26,
    required this.purchase_ticket_system,
    required this.custreal_uni_system,
    required this.ej_animation_system,
    required this.value_card_system,
    required this.sm4_comodi_system,
    required this.sm5_itoku_system,
    required this.cct_pointuse_system,
    required this.zhq_system,
    required this.rpoint_system,
    required this.vesca_system,
    required this.ajs_emoney_system,
    required this.sm16_taiyo_toyocho_system,
    required this.infox_detail_send_system,
    required this.self_medication_system,
    required this.sm20_maeda_system,
    required this.pana_waon_system,
    required this.onepay_system,
    required this.happyself_system,
    required this.happyself_smile_system,
    required this.linepay_system,
    required this.staff_release_system,
    required this.wiz_base_system,
    required this.pack_on_time_system,
    required this.shop_and_go_system,
    required this.staffid1_ymss_system,
    required this.sm33_nishizawa_system,
    required this.ds2_godai_system,
    required this.taxfree_passportinfo_system,
    required this.sm36_sanpraza_system,
    required this.cr50_system,
    required this.case_clothes_barcode_system,
    required this.custreal_dummy_system,
    required this.reason_select_std_system,
    required this.barcode_pay1_system,
    required this.custreal_ptactix,
    required this.cr3_sharp_system,
    required this.game_barcode_system,
    required this.cct_codepay_system,
    required this.ws_system,
    required this.custreal_pointinfinity,
    required this.toy_system,
    required this.canal_payment_service_system,
    required this.multi_vega_system,
    required this.dispensing_pharmacy_system,
    required this.sm41_bellejois_system,
    required this.sm42_kanesue_system,
    required this.dpoint_system,
    required this.public_barcode_pay_system,
    required this.ts_indiv_setting_system,
    required this.sm44_ja_tsuruoka_system,
    required this.stera_terminal_system,
    required this.repica_point_system,
    required this.sm45_ocean_system,
    required this.fujitsu_fip_codepay_system,
    required this.sm49_itochain_system,
    required this.taxfree_server_system,
    required this.employee_card_payment_system,
    required this.net_receipt_system,
    required this.public_barcode_pay2_system,
    required this.sm52_palette_system,
    required this.public_barcode_pay3_system,
    required this.svscls2_stlpdsc_system,
    required this.sm55_takayanagi_system,
    required this.mail_send_system,
    required this.netstars_codepay_system,
    required this.sm56_kobebussan_system,
    required this.hys1_seria_system,
    required this.liqr_taxfree_system,
    required this.custreal_gyomuca_system,
    required this.sm59_takaramc_system,
    required this.detail_noprn_system,
    required this.sm61_fujifilm_system,
    required this.department2_system,
    required this.custreal_crosspoint,
    required this.hc12_joyful_honda_system,
    required this.sm62_maruichi_system,
    required this.sm65_ryubo_system,
    required this.tomoIF_system,
    required this.sm66_fresta_system,
    required this.cosme1_istyle_system,
    required this.sm71_selection_system,
    required this.kitchen_print_recipt,
    required this.miyazaki_city_system,
    required this.public_barcode_pay4_system,
    required this.sp1_qr_read_system,
    required this.aibox_alignment_system,
    required this.cashonly_keyopt_system,
    required this.sm74_ozeki_system,
    required this.carparking_qr_system,
    required this.olc_system,
    required this.quiz_payment_system,
    required this.jets_lane_system,
    required this.rf1_hs_system,
  });

  @JsonKey(defaultValue: "no")
  String dual;
  @JsonKey(defaultValue: "no")
  String webjr;
  @JsonKey(defaultValue: "no")
  String web2300;
  @JsonKey(defaultValue: "no")
  String webplus;
  @JsonKey(defaultValue: "no")
  String web2800;
  @JsonKey(defaultValue: "no")
  String web2350;
  @JsonKey(defaultValue: "no")
  String web2500;
  @JsonKey(defaultValue: "no")
  String webplus2;
  @JsonKey(defaultValue: "no")
  String tower;
  @JsonKey(defaultValue: "m")
  String mskind;
  @JsonKey(defaultValue: "no")
  String standalone;
  @JsonKey(defaultValue: "no")
  String membersystem;
  @JsonKey(defaultValue: "no")
  String memberpoint;
  @JsonKey(defaultValue: "no")
  String memberfsp;
  @JsonKey(defaultValue: "no")
  String creditsystem;
  @JsonKey(defaultValue: "no")
  String special_receipt;
  @JsonKey(defaultValue: "no")
  String disc_barcode;
  @JsonKey(defaultValue: "no")
  String iwaisystem;
  @JsonKey(defaultValue: "no")
  String self_gate;
  @JsonKey(defaultValue: "no")
  String vismacsystem;
  @JsonKey(defaultValue: "no")
  String sys_24hour;
  @JsonKey(defaultValue: "no")
  String hq_asp;
  @JsonKey(defaultValue: "no")
  String jasaitama_sys;
  @JsonKey(defaultValue: "no")
  String promsystem;
  @JsonKey(defaultValue: "no")
  String edysystem;
  @JsonKey(defaultValue: "no")
  String fresh_barcode;
  @JsonKey(defaultValue: "no")
  String sugi_sys;
  @JsonKey(defaultValue: "no")
  String hesokurisystem;
  @JsonKey(defaultValue: "no")
  String greenstamp_sys;
  @JsonKey(defaultValue: "no")
  String coopsystem;
  @JsonKey(defaultValue: "no")
  String pointcardsystem;
  @JsonKey(defaultValue: "no")
  String mobilesystem;
  @JsonKey(defaultValue: "no")
  String hq_other;
  @JsonKey(defaultValue: "no")
  String regconnectsystem;
  @JsonKey(defaultValue: "no")
  String clothes_barcode;
  @JsonKey(defaultValue: "no")
  String fjss;
  @JsonKey(defaultValue: "no")
  String mcsystem;
  @JsonKey(defaultValue: "no")
  String network_prn;
  @JsonKey(defaultValue: "no")
  String poppy_print;
  @JsonKey(defaultValue: "no")
  String tag_print;
  @JsonKey(defaultValue: "no")
  String taurus;
  @JsonKey(defaultValue: "no")
  String ntt_asp;
  @JsonKey(defaultValue: "no")
  String eat_in;
  @JsonKey(defaultValue: "no")
  String mobilesystem2;
  @JsonKey(defaultValue: "no")
  String magazine_barcode;
  @JsonKey(defaultValue: "no")
  String hq_other_real;
  @JsonKey(defaultValue: "no")
  String pw410system;
  @JsonKey(defaultValue: "no")
  String nsc_credit;
  @JsonKey(defaultValue: "no")
  String hq_prod;
  @JsonKey(defaultValue: "no")
  String felicasystem;
  @JsonKey(defaultValue: "no")
  String psp70system;
  @JsonKey(defaultValue: "no")
  String ntt_bcom;
  @JsonKey(defaultValue: "no")
  String catalinasystem;
  @JsonKey(defaultValue: "no")
  String prcchkr;
  @JsonKey(defaultValue: "no")
  String dishcalcsystem;
  @JsonKey(defaultValue: "no")
  String itf_barcode;
  @JsonKey(defaultValue: "no")
  String css_act;
  @JsonKey(defaultValue: "no")
  String cust_detail;
  @JsonKey(defaultValue: "no")
  String custrealsvr;
  @JsonKey(defaultValue: "no")
  String suica_cat;
  @JsonKey(defaultValue: "no")
  String yomocasystem;
  @JsonKey(defaultValue: "no")
  String smartplussystem;
  @JsonKey(defaultValue: "no")
  String duty;
  @JsonKey(defaultValue: "no")
  String ecoasystem;
  @JsonKey(defaultValue: "no")
  String iccardsystem;
  @JsonKey(defaultValue: "no")
  String sub_ticket;
  @JsonKey(defaultValue: "no")
  String quicpaysystem;
  @JsonKey(defaultValue: "no")
  String idsystem;
  @JsonKey(defaultValue: "no")
  String revival_receipt;
  @JsonKey(defaultValue: "no")
  String quick_self;
  @JsonKey(defaultValue: "no")
  String quick_self_chg;
  @JsonKey(defaultValue: "no")
  String assist_monitor;
  @JsonKey(defaultValue: "no")
  String mp1_print;
  @JsonKey(defaultValue: "no")
  String realitmsend;
  @JsonKey(defaultValue: "no")
  String rainbowcard;
  @JsonKey(defaultValue: "no")
  String gramx;
  @JsonKey(defaultValue: "no")
  String mm_abj;
  @JsonKey(defaultValue: "no")
  String cat_point;
  @JsonKey(defaultValue: "no")
  String tagrdwt;
  @JsonKey(defaultValue: "no")
  String department_store;
  @JsonKey(defaultValue: "no")
  String edyno_mbr;
  @JsonKey(defaultValue: "no")
  String fcf_card;
  @JsonKey(defaultValue: "no")
  String panamembersystem;
  @JsonKey(defaultValue: "no")
  String landisk;
  @JsonKey(defaultValue: "no")
  String pitapasystem;
  @JsonKey(defaultValue: "no")
  String tuocardsystem;
  @JsonKey(defaultValue: "no")
  String sallmtbar;
  @JsonKey(defaultValue: "no")
  String business_mode;
  @JsonKey(defaultValue: "no")
  String mcp200system;
  @JsonKey(defaultValue: "no")
  String spvtsystem;
  @JsonKey(defaultValue: "no")
  String remotesystem;
  @JsonKey(defaultValue: "no")
  String order_mode;
  @JsonKey(defaultValue: "no")
  String jrem_multisystem;
  @JsonKey(defaultValue: "no")
  String media_info;
  @JsonKey(defaultValue: "no")
  String gs1_barcode;
  @JsonKey(defaultValue: "no")
  String assortsystem;
  @JsonKey(defaultValue: "no")
  String center_server;
  @JsonKey(defaultValue: "no")
  String reservsystem;
  @JsonKey(defaultValue: "no")
  String drug_rev;
  @JsonKey(defaultValue: "no")
  String gincardsystem;
  @JsonKey(defaultValue: "no")
  String fclqpsystem;
  @JsonKey(defaultValue: "no")
  String fcledysystem;
  @JsonKey(defaultValue: "no")
  String caps_cafis;
  @JsonKey(defaultValue: "no")
  String fclidsystem;
  @JsonKey(defaultValue: "no")
  String ptcktissusystem;
  @JsonKey(defaultValue: "no")
  String abs_prepaid;
  @JsonKey(defaultValue: "no")
  String prod_item_autoset;
  @JsonKey(defaultValue: "no")
  String prod_itf14_barcode;
  @JsonKey(defaultValue: "no")
  String special_coupon;
  @JsonKey(defaultValue: "no")
  String bluechip_server;
  @JsonKey(defaultValue: "no")
  String hitachi_bluechip;
  @JsonKey(defaultValue: "no")
  String hq_other_cantevole;
  @JsonKey(defaultValue: "no")
  String qcashier_system;
  @JsonKey(defaultValue: "no")
  String receipt_qr_system;
  @JsonKey(defaultValue: "no")
  String visatouch_infox;
  @JsonKey(defaultValue: "no")
  String pbchg_system;
  @JsonKey(defaultValue: "no")
  String hc1_system;
  @JsonKey(defaultValue: "no")
  String caps_hc1_cafis;
  @JsonKey(defaultValue: "no")
  String remoteserver;
  @JsonKey(defaultValue: "no")
  String mrycardsystem;
  @JsonKey(defaultValue: "no")
  String sp_department;
  @JsonKey(defaultValue: "no")
  String decimalitmsend;
  @JsonKey(defaultValue: "no")
  String wiz_cnct;
  @JsonKey(defaultValue: "no")
  String absv31_rwt;
  @JsonKey(defaultValue: "no")
  String pluralqr_system;
  @JsonKey(defaultValue: "no")
  String netdoareserv;
  @JsonKey(defaultValue: "no")
  String selpluadj;
  @JsonKey(defaultValue: "no")
  String custreal_webser;
  @JsonKey(defaultValue: "no")
  String wiz_abj;
  @JsonKey(defaultValue: "no")
  String custreal_uid;
  @JsonKey(defaultValue: "no")
  String bdlitmsend;
  @JsonKey(defaultValue: "no")
  String custreal_netdoa;
  @JsonKey(defaultValue: "no")
  String ut_cnct;
  @JsonKey(defaultValue: "no")
  String caps_pqvic;
  @JsonKey(defaultValue: "no")
  String yamato_system;
  @JsonKey(defaultValue: "no")
  String caps_cafis_standard;
  @JsonKey(defaultValue: "no")
  String nttd_preca;
  @JsonKey(defaultValue: "no")
  String usbcam_cnct;
  @JsonKey(defaultValue: "no")
  String drugstore;
  @JsonKey(defaultValue: "no")
  String custreal_nec;
  @JsonKey(defaultValue: "no")
  String custreal_op;
  @JsonKey(defaultValue: "no")
  String dummy_crdt;
  @JsonKey(defaultValue: "no")
  String hc2_system;
  @JsonKey(defaultValue: "no")
  String price_sound;
  @JsonKey(defaultValue: "no")
  String dummy_preca;
  @JsonKey(defaultValue: "no")
  String monitored_system;
  @JsonKey(defaultValue: "no")
  String jmups_system;
  @JsonKey(defaultValue: "no")
  String ut1qpsystem;
  @JsonKey(defaultValue: "no")
  String ut1idsystem;
  @JsonKey(defaultValue: "no")
  String brain_system;
  @JsonKey(defaultValue: "no")
  String pfmpitapasystem;
  @JsonKey(defaultValue: "no")
  String pfmjricsystem;
  @JsonKey(defaultValue: "no")
  String chargeslip_system;
  @JsonKey(defaultValue: "no")
  String pfmjricchargesystem;
  @JsonKey(defaultValue: "no")
  String itemprc_reduction_coupon;
  @JsonKey(defaultValue: "no")
  String cat_jmups_system;
  @JsonKey(defaultValue: "no")
  String sqrc_ticket_system;
  @JsonKey(defaultValue: "no")
  String cct_connect_system;
  @JsonKey(defaultValue: "no")
  String cct_emoney_system;
  @JsonKey(defaultValue: "no")
  String tec_infox_jet_s_system;
  @JsonKey(defaultValue: "no")
  String prod_instore_zero_flg;
  @JsonKey(defaultValue: "no")
  String front_self_system;
  @JsonKey(defaultValue: "no")
  String trk_preca;
  @JsonKey(defaultValue: "no")
  String desktop_cashier_system;
  @JsonKey(defaultValue: "no")
  String suica_charge_system;
  @JsonKey(defaultValue: "no")
  String nimoca_point_system;
  @JsonKey(defaultValue: "no")
  String custreal_pointartist;
  @JsonKey(defaultValue: "no")
  String tb1_system;
  @JsonKey(defaultValue: "no")
  String tax_free_system;
  @JsonKey(defaultValue: "no")
  String repica_system;
  @JsonKey(defaultValue: "no")
  String caps_cardnet_system;
  @JsonKey(defaultValue: "no")
  String yumeca_system;
  @JsonKey(defaultValue: "no")
  String dummy_suica;
  @JsonKey(defaultValue: "no")
  String payment_mng;
  @JsonKey(defaultValue: "no")
  String custreal_tpoint;
  @JsonKey(defaultValue: "no")
  String mammy_system;
  @JsonKey(defaultValue: "no")
  String itemtyp_send;
  @JsonKey(defaultValue: "no")
  String yumeca_pol_system;
  @JsonKey(defaultValue: "no")
  String custreal_hps;
  @JsonKey(defaultValue: "no")
  String maruto_system;
  @JsonKey(defaultValue: "no")
  String hc3_system;
  @JsonKey(defaultValue: "no")
  String sm3_marui_system;
  @JsonKey(defaultValue: "no")
  String kitchen_print;
  @JsonKey(defaultValue: "no")
  String cogca_system;
  @JsonKey(defaultValue: "no")
  String bdl_multi_select_system;
  @JsonKey(defaultValue: "no")
  String sallmtbar26;
  @JsonKey(defaultValue: "no")
  String purchase_ticket_system;
  @JsonKey(defaultValue: "no")
  String custreal_uni_system;
  @JsonKey(defaultValue: "no")
  String ej_animation_system;
  @JsonKey(defaultValue: "no")
  String value_card_system;
  @JsonKey(defaultValue: "no")
  String sm4_comodi_system;
  @JsonKey(defaultValue: "no")
  String sm5_itoku_system;
  @JsonKey(defaultValue: "no")
  String cct_pointuse_system;
  @JsonKey(defaultValue: "no")
  String zhq_system;
  @JsonKey(defaultValue: "no")
  String rpoint_system;
  @JsonKey(defaultValue: "no")
  String vesca_system;
  @JsonKey(defaultValue: "no")
  String ajs_emoney_system;
  @JsonKey(defaultValue: "no")
  String sm16_taiyo_toyocho_system;
  @JsonKey(defaultValue: "no")
  String infox_detail_send_system;
  @JsonKey(defaultValue: "no")
  String self_medication_system;
  @JsonKey(defaultValue: "no")
  String sm20_maeda_system;
  @JsonKey(defaultValue: "no")
  String pana_waon_system;
  @JsonKey(defaultValue: "no")
  String onepay_system;
  @JsonKey(defaultValue: "no")
  String happyself_system;
  @JsonKey(defaultValue: "no")
  String happyself_smile_system;
  @JsonKey(defaultValue: "no")
  String linepay_system;
  @JsonKey(defaultValue: "no")
  String staff_release_system;
  @JsonKey(defaultValue: "no")
  String wiz_base_system;
  @JsonKey(defaultValue: "no")
  String pack_on_time_system;
  @JsonKey(defaultValue: "no")
  String shop_and_go_system;
  @JsonKey(defaultValue: "no")
  String staffid1_ymss_system;
  @JsonKey(defaultValue: "no")
  String sm33_nishizawa_system;
  @JsonKey(defaultValue: "no")
  String ds2_godai_system;
  @JsonKey(defaultValue: "no")
  String taxfree_passportinfo_system;
  @JsonKey(defaultValue: "no")
  String sm36_sanpraza_system;
  @JsonKey(defaultValue: "no")
  String cr50_system;
  @JsonKey(defaultValue: "no")
  String case_clothes_barcode_system;
  @JsonKey(defaultValue: "no")
  String custreal_dummy_system;
  @JsonKey(defaultValue: "no")
  String reason_select_std_system;
  @JsonKey(defaultValue: "no")
  String barcode_pay1_system;
  @JsonKey(defaultValue: "no")
  String custreal_ptactix;
  @JsonKey(defaultValue: "no")
  String cr3_sharp_system;
  @JsonKey(defaultValue: "no")
  String game_barcode_system;
  @JsonKey(defaultValue: "no")
  String cct_codepay_system;
  @JsonKey(defaultValue: "no")
  String ws_system;
  @JsonKey(defaultValue: "no")
  String custreal_pointinfinity;
  @JsonKey(defaultValue: "no")
  String toy_system;
  @JsonKey(defaultValue: "no")
  String canal_payment_service_system;
  @JsonKey(defaultValue: "no")
  String multi_vega_system;
  @JsonKey(defaultValue: "no")
  String dispensing_pharmacy_system;
  @JsonKey(defaultValue: "no")
  String sm41_bellejois_system;
  @JsonKey(defaultValue: "no")
  String sm42_kanesue_system;
  @JsonKey(defaultValue: "no")
  String dpoint_system;
  @JsonKey(defaultValue: "no")
  String public_barcode_pay_system;
  @JsonKey(defaultValue: "no")
  String ts_indiv_setting_system;
  @JsonKey(defaultValue: "no")
  String sm44_ja_tsuruoka_system;
  @JsonKey(defaultValue: "no")
  String stera_terminal_system;
  @JsonKey(defaultValue: "no")
  String repica_point_system;
  @JsonKey(defaultValue: "no")
  String sm45_ocean_system;
  @JsonKey(defaultValue: "no")
  String fujitsu_fip_codepay_system;
  @JsonKey(defaultValue: "no")
  String sm49_itochain_system;
  @JsonKey(defaultValue: "no")
  String taxfree_server_system;
  @JsonKey(defaultValue: "no")
  String employee_card_payment_system;
  @JsonKey(defaultValue: "no")
  String net_receipt_system;
  @JsonKey(defaultValue: "no")
  String public_barcode_pay2_system;
  @JsonKey(defaultValue: "no")
  String sm52_palette_system;
  @JsonKey(defaultValue: "no")
  String public_barcode_pay3_system;
  @JsonKey(defaultValue: "no")
  String svscls2_stlpdsc_system;
  @JsonKey(defaultValue: "no")
  String sm55_takayanagi_system;
  @JsonKey(defaultValue: "no")
  String mail_send_system;
  @JsonKey(defaultValue: "no")
  String netstars_codepay_system;
  @JsonKey(defaultValue: "no")
  String sm56_kobebussan_system;
  @JsonKey(defaultValue: "no")
  String hys1_seria_system;
  @JsonKey(defaultValue: "no")
  String liqr_taxfree_system;
  @JsonKey(defaultValue: "no")
  String custreal_gyomuca_system;
  @JsonKey(defaultValue: "no")
  String sm59_takaramc_system;
  @JsonKey(defaultValue: "no")
  String detail_noprn_system;
  @JsonKey(defaultValue: "no")
  String sm61_fujifilm_system;
  @JsonKey(defaultValue: "no")
  String department2_system;
  @JsonKey(defaultValue: "no")
  String custreal_crosspoint;
  @JsonKey(defaultValue: "no")
  String hc12_joyful_honda_system;
  @JsonKey(defaultValue: "no")
  String sm62_maruichi_system;
  @JsonKey(defaultValue: "no")
  String sm65_ryubo_system;
  @JsonKey(defaultValue: "no")
  String tomoIF_system;
  @JsonKey(defaultValue: "no")
  String sm66_fresta_system;
  @JsonKey(defaultValue: "no")
  String cosme1_istyle_system;
  @JsonKey(defaultValue: "no")
  String sm71_selection_system;
  @JsonKey(defaultValue: "no")
  String kitchen_print_recipt;
  @JsonKey(defaultValue: "no")
  String miyazaki_city_system;
  @JsonKey(defaultValue: "no")
  String public_barcode_pay4_system;
  @JsonKey(defaultValue: "no")
  String sp1_qr_read_system;
  @JsonKey(defaultValue: "no")
  String aibox_alignment_system;
  @JsonKey(defaultValue: "no")
  String cashonly_keyopt_system;
  @JsonKey(defaultValue: "no")
  String sm74_ozeki_system;
  @JsonKey(defaultValue: "no")
  String carparking_qr_system;
  @JsonKey(defaultValue: "no")
  String olc_system;
  @JsonKey(defaultValue: "no")
  String quiz_payment_system;
  @JsonKey(defaultValue: "no")
  String jets_lane_system;
  @JsonKey(defaultValue: "no")
  String rf1_hs_system;
}

@JsonSerializable()
class _Dip_sw {
  factory _Dip_sw.fromJson(Map<String, dynamic> json) => _$Dip_swFromJson(json);
  Map<String, dynamic> toJson() => _$Dip_swToJson(this);

  _Dip_sw({
    required this.subcpu1,
    required this.subcpu2,
  });

  @JsonKey(defaultValue: "")
  String subcpu1;
  @JsonKey(defaultValue: "")
  String subcpu2;
}

@JsonSerializable()
class _Boot_webplus2_desktop {
  factory _Boot_webplus2_desktop.fromJson(Map<String, dynamic> json) => _$Boot_webplus2_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_webplus2_desktopToJson(this);

  _Boot_webplus2_desktop({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mkey_2800_1")
  String drivers01;
  @JsonKey(defaultValue: "pmouse_plus2_1")
  String drivers02;
  @JsonKey(defaultValue: "fip_plus2_1")
  String drivers03;
  @JsonKey(defaultValue: "mupdate")
  String drivers04;
  @JsonKey(defaultValue: "history")
  String drivers05;
  @JsonKey(defaultValue: "hqftp")
  String drivers06;
  @JsonKey(defaultValue: "supdate")
  String drivers07;
  @JsonKey(defaultValue: "hqhist")
  String drivers08;
  @JsonKey(defaultValue: "schctrl")
  String drivers09;
  @JsonKey(defaultValue: "hqprod")
  String drivers10;
  @JsonKey(defaultValue: "tprtss")
  String drivers11;
  @JsonKey(defaultValue: "msr_plus2_1")
  String drivers12;
  @JsonKey(defaultValue: "fip_plus2_2")
  String drivers13;
  @JsonKey(defaultValue: "fip_plus2_3")
  String drivers14;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers15;
  @JsonKey(defaultValue: "tprtrp")
  String drivers16;
  @JsonKey(defaultValue: "tprtrp2")
  String drivers17;
  @JsonKey(defaultValue: "iccard")
  String drivers18;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_web2350_tower {
  factory _Boot_web2350_tower.fromJson(Map<String, dynamic> json) => _$Boot_web2350_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_web2350_towerToJson(this);

  _Boot_web2350_tower({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mkey_2800_1")
  String drivers01;
  @JsonKey(defaultValue: "mkey_2800_2")
  String drivers02;
  @JsonKey(defaultValue: "pmouse_2350_1")
  String drivers03;
  @JsonKey(defaultValue: "pmouse_2350_2")
  String drivers04;
  @JsonKey(defaultValue: "mupdate")
  String drivers05;
  @JsonKey(defaultValue: "history")
  String drivers06;
  @JsonKey(defaultValue: "hqftp")
  String drivers07;
  @JsonKey(defaultValue: "supdate")
  String drivers08;
  @JsonKey(defaultValue: "hqhist")
  String drivers09;
  @JsonKey(defaultValue: "schctrl")
  String drivers10;
  @JsonKey(defaultValue: "hqprod")
  String drivers11;
  @JsonKey(defaultValue: "fip_2500_1")
  String drivers12;
  @JsonKey(defaultValue: "fip_2500_2")
  String drivers13;
  @JsonKey(defaultValue: "tprts")
  String drivers14;
  @JsonKey(defaultValue: "scan_2500_1")
  String drivers15;
  @JsonKey(defaultValue: "scan_2500_2")
  String drivers16;
  @JsonKey(defaultValue: "msr_2500_1")
  String drivers17;
  @JsonKey(defaultValue: "msr_2500_2")
  String drivers18;
  @JsonKey(defaultValue: "signp")
  String drivers19;
  @JsonKey(defaultValue: "detect")
  String drivers20;
  @JsonKey(defaultValue: "callsw")
  String drivers21;
  @JsonKey(defaultValue: "sm_scalesc_scl")
  String drivers22;
  @JsonKey(defaultValue: "sm_scalesc_signp")
  String drivers23;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers24;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_web2350_desktop {
  factory _Boot_web2350_desktop.fromJson(Map<String, dynamic> json) => _$Boot_web2350_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_web2350_desktopToJson(this);

  _Boot_web2350_desktop({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mkey_2800_1")
  String drivers01;
  @JsonKey(defaultValue: "pmouse_2350_1")
  String drivers02;
  @JsonKey(defaultValue: "scan_2500_1")
  String drivers03;
  @JsonKey(defaultValue: "fip_2500_1")
  String drivers04;
  @JsonKey(defaultValue: "msr_2500_1")
  String drivers05;
  @JsonKey(defaultValue: "mupdate")
  String drivers06;
  @JsonKey(defaultValue: "history")
  String drivers07;
  @JsonKey(defaultValue: "hqftp")
  String drivers08;
  @JsonKey(defaultValue: "supdate")
  String drivers09;
  @JsonKey(defaultValue: "hqhist")
  String drivers10;
  @JsonKey(defaultValue: "schctrl")
  String drivers11;
  @JsonKey(defaultValue: "hqprod")
  String drivers12;
  @JsonKey(defaultValue: "tprts")
  String drivers13;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers14;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_web2500_tower {
  factory _Boot_web2500_tower.fromJson(Map<String, dynamic> json) => _$Boot_web2500_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_web2500_towerToJson(this);

  _Boot_web2500_tower({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers25,
    required this.drivers26,
    required this.drivers27,
    required this.drivers28,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mkey_2800_1")
  String drivers01;
  @JsonKey(defaultValue: "mkey_2800_2")
  String drivers02;
  @JsonKey(defaultValue: "pmouse_2500_1")
  String drivers03;
  @JsonKey(defaultValue: "pmouse_2500_2")
  String drivers04;
  @JsonKey(defaultValue: "mupdate")
  String drivers05;
  @JsonKey(defaultValue: "history")
  String drivers06;
  @JsonKey(defaultValue: "hqftp")
  String drivers07;
  @JsonKey(defaultValue: "supdate")
  String drivers08;
  @JsonKey(defaultValue: "hqhist")
  String drivers09;
  @JsonKey(defaultValue: "schctrl")
  String drivers10;
  @JsonKey(defaultValue: "hqprod")
  String drivers11;
  @JsonKey(defaultValue: "fip_2500_1")
  String drivers12;
  @JsonKey(defaultValue: "fip_2500_2")
  String drivers13;
  @JsonKey(defaultValue: "tprts")
  String drivers14;
  @JsonKey(defaultValue: "scan_2500_1")
  String drivers15;
  @JsonKey(defaultValue: "scan_2500_2")
  String drivers16;
  @JsonKey(defaultValue: "signp")
  String drivers17;
  @JsonKey(defaultValue: "detect")
  String drivers18;
  @JsonKey(defaultValue: "callsw")
  String drivers19;
  @JsonKey(defaultValue: "sm_scalesc_scl")
  String drivers20;
  @JsonKey(defaultValue: "sm_scalesc_signp")
  String drivers21;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers22;
  @JsonKey(defaultValue: "drw_2800_1")
  String drivers23;
  @JsonKey(defaultValue: "msr_2500_1")
  String drivers24;
  @JsonKey(defaultValue: "msr_2500_2")
  String drivers25;
  @JsonKey(defaultValue: "usbcam")
  String drivers26;
  @JsonKey(defaultValue: "iccard")
  String drivers27;
  @JsonKey(defaultValue: "tprtrp")
  String drivers28;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_web2500_desktop {
  factory _Boot_web2500_desktop.fromJson(Map<String, dynamic> json) => _$Boot_web2500_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_web2500_desktopToJson(this);

  _Boot_web2500_desktop({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mkey_2800_1")
  String drivers01;
  @JsonKey(defaultValue: "pmouse_2500_1")
  String drivers02;
  @JsonKey(defaultValue: "scan_2500_1")
  String drivers03;
  @JsonKey(defaultValue: "fip_2500_1")
  String drivers04;
  @JsonKey(defaultValue: "mupdate")
  String drivers05;
  @JsonKey(defaultValue: "history")
  String drivers06;
  @JsonKey(defaultValue: "hqftp")
  String drivers07;
  @JsonKey(defaultValue: "supdate")
  String drivers08;
  @JsonKey(defaultValue: "hqhist")
  String drivers09;
  @JsonKey(defaultValue: "schctrl")
  String drivers10;
  @JsonKey(defaultValue: "hqprod")
  String drivers11;
  @JsonKey(defaultValue: "tprts")
  String drivers12;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers13;
  @JsonKey(defaultValue: "drw_2800_1")
  String drivers14;
  @JsonKey(defaultValue: "msr_2500_1")
  String drivers15;
  @JsonKey(defaultValue: "usbcam")
  String drivers16;
  @JsonKey(defaultValue: "iccard")
  String drivers17;
  @JsonKey(defaultValue: "tprtrp")
  String drivers18;
  @JsonKey(defaultValue: "scalerm")
  String drivers19;
  @JsonKey(defaultValue: "hitouch")
  String drivers20;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_web2800_tower {
  factory _Boot_web2800_tower.fromJson(Map<String, dynamic> json) => _$Boot_web2800_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_web2800_towerToJson(this);

  _Boot_web2800_tower({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers25,
    required this.drivers26,
    required this.drivers27,
    required this.drivers28,
    required this.drivers29,
    required this.drivers30,
    required this.drivers31,
    required this.drivers32,
    required this.drivers33,
    required this.drivers34,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mkey_2800_1")
  String drivers01;
  @JsonKey(defaultValue: "mkey_2800_2")
  String drivers02;
  @JsonKey(defaultValue: "pmouse_2800_1")
  String drivers03;
  @JsonKey(defaultValue: "pmouse_2800_2")
  String drivers04;
  @JsonKey(defaultValue: "scan_2800_1")
  String drivers05;
  @JsonKey(defaultValue: "scan_2800_2")
  String drivers06;
  @JsonKey(defaultValue: "fip_2800_1")
  String drivers07;
  @JsonKey(defaultValue: "fip_2800_2")
  String drivers08;
  @JsonKey(defaultValue: "drw_2800_1")
  String drivers09;
  @JsonKey(defaultValue: "tprtss")
  String drivers10;
  @JsonKey(defaultValue: "mupdate")
  String drivers11;
  @JsonKey(defaultValue: "history")
  String drivers12;
  @JsonKey(defaultValue: "hqftp")
  String drivers13;
  @JsonKey(defaultValue: "supdate")
  String drivers14;
  @JsonKey(defaultValue: "hqhist")
  String drivers15;
  @JsonKey(defaultValue: "schctrl")
  String drivers16;
  @JsonKey(defaultValue: "hqprod")
  String drivers17;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers18;
  @JsonKey(defaultValue: "sm_scalesc_scl")
  String drivers19;
  @JsonKey(defaultValue: "sm_scalesc_signp")
  String drivers20;
  @JsonKey(defaultValue: "usbcam")
  String drivers21;
  @JsonKey(defaultValue: "tprtss2")
  String drivers22;
  @JsonKey(defaultValue: "sqrc")
  String drivers23;
  @JsonKey(defaultValue: "pmouse_2800_3")
  String drivers24;
  @JsonKey(defaultValue: "tprtrp")
  String drivers25;
  @JsonKey(defaultValue: "tprtrp2")
  String drivers26;
  @JsonKey(defaultValue: "iccard")
  String drivers27;
  @JsonKey(defaultValue: "msr_int_1")
  String drivers28;
  @JsonKey(defaultValue: "powli")
  String drivers29;
  @JsonKey(defaultValue: "scan_2800_4")
  String drivers30;
  @JsonKey(defaultValue: "apbf_1")
  String drivers31;
  @JsonKey(defaultValue: "exc")
  String drivers32;
  @JsonKey(defaultValue: "ami")
  String drivers33;
  @JsonKey(defaultValue: "aibox")
  String drivers34;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_web2800_desktop {
  factory _Boot_web2800_desktop.fromJson(Map<String, dynamic> json) => _$Boot_web2800_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_web2800_desktopToJson(this);

  _Boot_web2800_desktop({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers25,
    required this.drivers26,
    required this.drivers27,
    required this.drivers28,
    required this.drivers29,
    required this.drivers30,
    required this.drivers31,
    required this.drivers32,
    required this.drivers33,
    required this.drivers34,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mkey_2800_1")
  String drivers01;
  @JsonKey(defaultValue: "pmouse_2800_1")
  String drivers02;
  @JsonKey(defaultValue: "scan_2800_1")
  String drivers03;
  @JsonKey(defaultValue: "fip_2800_1")
  String drivers04;
  @JsonKey(defaultValue: "drw_2800_1")
  String drivers05;
  @JsonKey(defaultValue: "mupdate")
  String drivers06;
  @JsonKey(defaultValue: "history")
  String drivers07;
  @JsonKey(defaultValue: "hqftp")
  String drivers08;
  @JsonKey(defaultValue: "supdate")
  String drivers09;
  @JsonKey(defaultValue: "hqhist")
  String drivers10;
  @JsonKey(defaultValue: "schctrl")
  String drivers11;
  @JsonKey(defaultValue: "hqprod")
  String drivers12;
  @JsonKey(defaultValue: "tprtss")
  String drivers13;
  @JsonKey(defaultValue: "fip_2800_2")
  String drivers14;
  @JsonKey(defaultValue: "fip_2800_3")
  String drivers15;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers16;
  @JsonKey(defaultValue: "sm_scalesc_scl")
  String drivers17;
  @JsonKey(defaultValue: "sm_scalesc_signp")
  String drivers18;
  @JsonKey(defaultValue: "usbcam")
  String drivers19;
  @JsonKey(defaultValue: "sqrc")
  String drivers20;
  @JsonKey(defaultValue: "pmouse_2800_3")
  String drivers21;
  @JsonKey(defaultValue: "tprtrp")
  String drivers22;
  @JsonKey(defaultValue: "tprtrp2")
  String drivers23;
  @JsonKey(defaultValue: "iccard")
  String drivers24;
  @JsonKey(defaultValue: "msr_plus2_1")
  String drivers25;
  @JsonKey(defaultValue: "scan_2800_3")
  String drivers26;
  @JsonKey(defaultValue: "powli")
  String drivers27;
  @JsonKey(defaultValue: "scan_2800_4")
  String drivers28;
  @JsonKey(defaultValue: "psensor_1")
  String drivers29;
  @JsonKey(defaultValue: "apbf_1")
  String drivers30;
  @JsonKey(defaultValue: "pmouse_2800_4")
  String drivers31;
  @JsonKey(defaultValue: "exc")
  String drivers32;
  @JsonKey(defaultValue: "ami")
  String drivers33;
  @JsonKey(defaultValue: "aibox")
  String drivers34;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_web2300_tower {
  factory _Boot_web2300_tower.fromJson(Map<String, dynamic> json) => _$Boot_web2300_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_web2300_towerToJson(this);

  _Boot_web2300_tower({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "pmouse_2300_2")
  String drivers01;
  @JsonKey(defaultValue: "mkey_2300_1")
  String drivers02;
  @JsonKey(defaultValue: "mkey_2300_2")
  String drivers03;
  @JsonKey(defaultValue: "pmouse_2300_1")
  String drivers04;
  @JsonKey(defaultValue: "mupdate")
  String drivers05;
  @JsonKey(defaultValue: "history")
  String drivers06;
  @JsonKey(defaultValue: "hqftp")
  String drivers07;
  @JsonKey(defaultValue: "supdate")
  String drivers08;
  @JsonKey(defaultValue: "hqhist")
  String drivers09;
  @JsonKey(defaultValue: "schctrl")
  String drivers10;
  @JsonKey(defaultValue: "hqprod")
  String drivers11;
  @JsonKey(defaultValue: "fip_2300_1")
  String drivers12;
  @JsonKey(defaultValue: "fip_2300_2")
  String drivers13;
  @JsonKey(defaultValue: "tprts")
  String drivers14;
  @JsonKey(defaultValue: "scan_2300_1")
  String drivers15;
  @JsonKey(defaultValue: "scan_2300_2")
  String drivers16;
  @JsonKey(defaultValue: "msr_2300_1")
  String drivers17;
  @JsonKey(defaultValue: "msr_2300_2")
  String drivers18;
  @JsonKey(defaultValue: "signp")
  String drivers19;
  @JsonKey(defaultValue: "detect")
  String drivers20;
  @JsonKey(defaultValue: "callsw")
  String drivers21;
  @JsonKey(defaultValue: "sm_scalesc_scl")
  String drivers22;
  @JsonKey(defaultValue: "sm_scalesc_signp")
  String drivers23;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers24;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_web2300_desktop {
  factory _Boot_web2300_desktop.fromJson(Map<String, dynamic> json) => _$Boot_web2300_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_web2300_desktopToJson(this);

  _Boot_web2300_desktop({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mkey_2300_1")
  String drivers01;
  @JsonKey(defaultValue: "pmouse_2300_1")
  String drivers02;
  @JsonKey(defaultValue: "scan_2300_1")
  String drivers03;
  @JsonKey(defaultValue: "fip_2300_1")
  String drivers04;
  @JsonKey(defaultValue: "msr_2300_1")
  String drivers05;
  @JsonKey(defaultValue: "mupdate")
  String drivers06;
  @JsonKey(defaultValue: "history")
  String drivers07;
  @JsonKey(defaultValue: "hqftp")
  String drivers08;
  @JsonKey(defaultValue: "supdate")
  String drivers09;
  @JsonKey(defaultValue: "hqhist")
  String drivers10;
  @JsonKey(defaultValue: "schctrl")
  String drivers11;
  @JsonKey(defaultValue: "hqprod")
  String drivers12;
  @JsonKey(defaultValue: "tprts")
  String drivers13;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers14;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_webplus_desktop {
  factory _Boot_webplus_desktop.fromJson(Map<String, dynamic> json) => _$Boot_webplus_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_webplus_desktopToJson(this);

  _Boot_webplus_desktop({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "mupdate")
  String drivers01;
  @JsonKey(defaultValue: "history")
  String drivers02;
  @JsonKey(defaultValue: "hqftp")
  String drivers03;
  @JsonKey(defaultValue: "supdate")
  String drivers04;
  @JsonKey(defaultValue: "hqhist")
  String drivers05;
  @JsonKey(defaultValue: "schctrl")
  String drivers06;
  @JsonKey(defaultValue: "hqprod")
  String drivers07;
  @JsonKey(defaultValue: "pmouse_plus_1")
  String drivers08;
  @JsonKey(defaultValue: "segd_plus_1")
  String drivers09;
  @JsonKey(defaultValue: "tprtf")
  String drivers10;
  @JsonKey(defaultValue: "mkey_plus_1")
  String drivers11;
  @JsonKey(defaultValue: "msr_2300_1")
  String drivers12;
  @JsonKey(defaultValue: "sm_scalesc_scl")
  String drivers13;
  @JsonKey(defaultValue: "sm_scalesc_signp")
  String drivers14;
  @JsonKey(defaultValue: "fip_plus_1")
  String drivers15;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers16;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "scan_plus_1")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_dual_tower {
  factory _Boot_dual_tower.fromJson(Map<String, dynamic> json) => _$Boot_dual_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_dual_towerToJson(this);

  _Boot_dual_tower({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers25,
    required this.drivers26,
    required this.drivers27,
    required this.drivers28,
    required this.drivers29,
    required this.drivers30,
    required this.drivers31,
    required this.drivers32,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "subcpu2")
  String drivers01;
  @JsonKey(defaultValue: "subcpu1")
  String drivers02;
  @JsonKey(defaultValue: "spk1")
  String drivers03;
  @JsonKey(defaultValue: "fip1")
  String drivers04;
  @JsonKey(defaultValue: "lcdbrt1")
  String drivers05;
  @JsonKey(defaultValue: "mkey1")
  String drivers06;
  @JsonKey(defaultValue: "wand1")
  String drivers07;
  @JsonKey(defaultValue: "msr11")
  String drivers08;
  @JsonKey(defaultValue: "msr12")
  String drivers09;
  @JsonKey(defaultValue: "tkey1d")
  String drivers10;
  @JsonKey(defaultValue: "spk2")
  String drivers11;
  @JsonKey(defaultValue: "fip2")
  String drivers12;
  @JsonKey(defaultValue: "lcdbrt2")
  String drivers13;
  @JsonKey(defaultValue: "wand2")
  String drivers14;
  @JsonKey(defaultValue: "tkey2")
  String drivers15;
  @JsonKey(defaultValue: "mkey2")
  String drivers16;
  @JsonKey(defaultValue: "tprt")
  String drivers17;
  @JsonKey(defaultValue: "pmouse2")
  String drivers18;
  @JsonKey(defaultValue: "pmouse1")
  String drivers19;
  @JsonKey(defaultValue: "mupdate")
  String drivers20;
  @JsonKey(defaultValue: "history")
  String drivers21;
  @JsonKey(defaultValue: "msr21")
  String drivers22;
  @JsonKey(defaultValue: "msr22")
  String drivers23;
  @JsonKey(defaultValue: "hqftp")
  String drivers24;
  @JsonKey(defaultValue: "supdate")
  String drivers25;
  @JsonKey(defaultValue: "hqhist")
  String drivers26;
  @JsonKey(defaultValue: "signp")
  String drivers27;
  @JsonKey(defaultValue: "detect")
  String drivers28;
  @JsonKey(defaultValue: "callsw")
  String drivers29;
  @JsonKey(defaultValue: "schctrl")
  String drivers30;
  @JsonKey(defaultValue: "hqprod")
  String drivers31;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers32;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_dual_desktop {
  factory _Boot_dual_desktop.fromJson(Map<String, dynamic> json) => _$Boot_dual_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_dual_desktopToJson(this);

  _Boot_dual_desktop({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "subcpu2")
  String drivers01;
  @JsonKey(defaultValue: "subcpu1")
  String drivers02;
  @JsonKey(defaultValue: "spk1")
  String drivers03;
  @JsonKey(defaultValue: "spk2")
  String drivers04;
  @JsonKey(defaultValue: "fip1")
  String drivers05;
  @JsonKey(defaultValue: "lcdbrt1")
  String drivers06;
  @JsonKey(defaultValue: "lcdbrt2")
  String drivers07;
  @JsonKey(defaultValue: "mkey1")
  String drivers08;
  @JsonKey(defaultValue: "wand1")
  String drivers09;
  @JsonKey(defaultValue: "msr11")
  String drivers10;
  @JsonKey(defaultValue: "msr12")
  String drivers11;
  @JsonKey(defaultValue: "tkey1d")
  String drivers12;
  @JsonKey(defaultValue: "tkey2")
  String drivers13;
  @JsonKey(defaultValue: "tprt")
  String drivers14;
  @JsonKey(defaultValue: "pmouse2")
  String drivers15;
  @JsonKey(defaultValue: "pmouse1")
  String drivers16;
  @JsonKey(defaultValue: "mupdate")
  String drivers17;
  @JsonKey(defaultValue: "history")
  String drivers18;
  @JsonKey(defaultValue: "hqftp")
  String drivers19;
  @JsonKey(defaultValue: "supdate")
  String drivers20;
  @JsonKey(defaultValue: "hqhist")
  String drivers21;
  @JsonKey(defaultValue: "schctrl")
  String drivers22;
  @JsonKey(defaultValue: "hqprod")
  String drivers23;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers24;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_jr {
  factory _Boot_jr.fromJson(Map<String, dynamic> json) => _$Boot_jrFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_jrToJson(this);

  _Boot_jr({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "subcpu3")
  String drivers01;
  @JsonKey(defaultValue: "spk3")
  String drivers02;
  @JsonKey(defaultValue: "seg1")
  String drivers03;
  @JsonKey(defaultValue: "lcdbrt3")
  String drivers04;
  @JsonKey(defaultValue: "mkey3")
  String drivers05;
  @JsonKey(defaultValue: "lcd57")
  String drivers06;
  @JsonKey(defaultValue: "wand3")
  String drivers07;
  @JsonKey(defaultValue: "msr31")
  String drivers08;
  @JsonKey(defaultValue: "msr32")
  String drivers09;
  @JsonKey(defaultValue: "tkey3d")
  String drivers10;
  @JsonKey(defaultValue: "tprt")
  String drivers11;
  @JsonKey(defaultValue: "pmouse3")
  String drivers12;
  @JsonKey(defaultValue: "mupdate")
  String drivers13;
  @JsonKey(defaultValue: "history")
  String drivers14;
  @JsonKey(defaultValue: "hqftp")
  String drivers15;
  @JsonKey(defaultValue: "supdate")
  String drivers16;
  @JsonKey(defaultValue: "hqhist")
  String drivers17;
  @JsonKey(defaultValue: "schctrl")
  String drivers18;
  @JsonKey(defaultValue: "fip3")
  String drivers19;
  @JsonKey(defaultValue: "hqprod")
  String drivers20;
  @JsonKey(defaultValue: "vfd57_3")
  String drivers21;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers22;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_jr_tower {
  factory _Boot_jr_tower.fromJson(Map<String, dynamic> json) => _$Boot_jr_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_jr_towerToJson(this);

  _Boot_jr_tower({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers25,
    required this.drivers26,
    required this.drivers27,
    required this.drivers28,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "subcpu3")
  String drivers01;
  @JsonKey(defaultValue: "subcpu2")
  String drivers02;
  @JsonKey(defaultValue: "spk3")
  String drivers03;
  @JsonKey(defaultValue: "seg1")
  String drivers04;
  @JsonKey(defaultValue: "mkey3")
  String drivers05;
  @JsonKey(defaultValue: "wand3")
  String drivers06;
  @JsonKey(defaultValue: "msr31")
  String drivers07;
  @JsonKey(defaultValue: "msr32")
  String drivers08;
  @JsonKey(defaultValue: "spk2")
  String drivers09;
  @JsonKey(defaultValue: "seg2")
  String drivers10;
  @JsonKey(defaultValue: "lcdbrt2")
  String drivers11;
  @JsonKey(defaultValue: "mkey2")
  String drivers12;
  @JsonKey(defaultValue: "wand2")
  String drivers13;
  @JsonKey(defaultValue: "msr21")
  String drivers14;
  @JsonKey(defaultValue: "msr22")
  String drivers15;
  @JsonKey(defaultValue: "tkey2")
  String drivers16;
  @JsonKey(defaultValue: "tprt")
  String drivers17;
  @JsonKey(defaultValue: "pmouse2")
  String drivers18;
  @JsonKey(defaultValue: "mupdate")
  String drivers19;
  @JsonKey(defaultValue: "history")
  String drivers20;
  @JsonKey(defaultValue: "hqftp")
  String drivers21;
  @JsonKey(defaultValue: "supdate")
  String drivers22;
  @JsonKey(defaultValue: "hqhist")
  String drivers23;
  @JsonKey(defaultValue: "schctrl")
  String drivers24;
  @JsonKey(defaultValue: "fip2")
  String drivers25;
  @JsonKey(defaultValue: "fip3")
  String drivers26;
  @JsonKey(defaultValue: "hqprod")
  String drivers27;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers28;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_tower {
  factory _Boot_tower.fromJson(Map<String, dynamic> json) => _$Boot_towerFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_towerToJson(this);

  _Boot_tower({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers22,
    required this.drivers23,
    required this.drivers24,
    required this.drivers25,
    required this.drivers26,
    required this.drivers27,
    required this.drivers28,
    required this.drivers29,
    required this.drivers30,
    required this.drivers31,
    required this.drivers32,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "subcpu2")
  String drivers01;
  @JsonKey(defaultValue: "subcpu1")
  String drivers02;
  @JsonKey(defaultValue: "spk1")
  String drivers03;
  @JsonKey(defaultValue: "fip1")
  String drivers04;
  @JsonKey(defaultValue: "lcdbrt1")
  String drivers05;
  @JsonKey(defaultValue: "mkey1")
  String drivers06;
  @JsonKey(defaultValue: "lcd57")
  String drivers07;
  @JsonKey(defaultValue: "wand1")
  String drivers08;
  @JsonKey(defaultValue: "msr11")
  String drivers09;
  @JsonKey(defaultValue: "msr12")
  String drivers10;
  @JsonKey(defaultValue: "tkey1t")
  String drivers11;
  @JsonKey(defaultValue: "spk2")
  String drivers12;
  @JsonKey(defaultValue: "fip2")
  String drivers13;
  @JsonKey(defaultValue: "lcdbrt2")
  String drivers14;
  @JsonKey(defaultValue: "wand2")
  String drivers15;
  @JsonKey(defaultValue: "tkey2")
  String drivers16;
  @JsonKey(defaultValue: "mkey2")
  String drivers17;
  @JsonKey(defaultValue: "tprt")
  String drivers18;
  @JsonKey(defaultValue: "pmouse2")
  String drivers19;
  @JsonKey(defaultValue: "mupdate")
  String drivers20;
  @JsonKey(defaultValue: "history")
  String drivers21;
  @JsonKey(defaultValue: "msr21")
  String drivers22;
  @JsonKey(defaultValue: "msr22")
  String drivers23;
  @JsonKey(defaultValue: "hqftp")
  String drivers24;
  @JsonKey(defaultValue: "supdate")
  String drivers25;
  @JsonKey(defaultValue: "hqhist")
  String drivers26;
  @JsonKey(defaultValue: "signp")
  String drivers27;
  @JsonKey(defaultValue: "detect")
  String drivers28;
  @JsonKey(defaultValue: "callsw")
  String drivers29;
  @JsonKey(defaultValue: "schctrl")
  String drivers30;
  @JsonKey(defaultValue: "hqprod")
  String drivers31;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers32;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Boot_desktop {
  factory _Boot_desktop.fromJson(Map<String, dynamic> json) => _$Boot_desktopFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_desktopToJson(this);

  _Boot_desktop({
    required this.drivers01,
    required this.drivers02,
    required this.drivers03,
    required this.drivers04,
    required this.drivers05,
    required this.drivers06,
    required this.drivers07,
    required this.drivers08,
    required this.drivers09,
    required this.drivers10,
    required this.drivers11,
    required this.drivers12,
    required this.drivers13,
    required this.drivers14,
    required this.drivers15,
    required this.drivers16,
    required this.drivers17,
    required this.drivers18,
    required this.drivers19,
    required this.drivers20,
    required this.drivers21,
    required this.drivers36,
    required this.drivers37,
    required this.drivers38,
    required this.drivers39,
  });

  @JsonKey(defaultValue: "subcpu2")
  String drivers01;
  @JsonKey(defaultValue: "subcpu1")
  String drivers02;
  @JsonKey(defaultValue: "spk1")
  String drivers03;
  @JsonKey(defaultValue: "fip1")
  String drivers04;
  @JsonKey(defaultValue: "lcdbrt1")
  String drivers05;
  @JsonKey(defaultValue: "mkey1")
  String drivers06;
  @JsonKey(defaultValue: "lcd57")
  String drivers07;
  @JsonKey(defaultValue: "wand1")
  String drivers08;
  @JsonKey(defaultValue: "msr11")
  String drivers09;
  @JsonKey(defaultValue: "msr12")
  String drivers10;
  @JsonKey(defaultValue: "tkey1d")
  String drivers11;
  @JsonKey(defaultValue: "tprt")
  String drivers12;
  @JsonKey(defaultValue: "pmouse1")
  String drivers13;
  @JsonKey(defaultValue: "mupdate")
  String drivers14;
  @JsonKey(defaultValue: "history")
  String drivers15;
  @JsonKey(defaultValue: "hqftp")
  String drivers16;
  @JsonKey(defaultValue: "supdate")
  String drivers17;
  @JsonKey(defaultValue: "hqhist")
  String drivers18;
  @JsonKey(defaultValue: "schctrl")
  String drivers19;
  @JsonKey(defaultValue: "hqprod")
  String drivers20;
  @JsonKey(defaultValue: "hist_csrv")
  String drivers21;
  @JsonKey(defaultValue: "")
  String drivers36;
  @JsonKey(defaultValue: "")
  String drivers37;
  @JsonKey(defaultValue: "")
  String drivers38;
  @JsonKey(defaultValue: "")
  String drivers39;
}

@JsonSerializable()
class _Verup {
  factory _Verup.fromJson(Map<String, dynamic> json) => _$VerupFromJson(json);
  Map<String, dynamic> toJson() => _$VerupToJson(this);

  _Verup({
    required this.verup,
    required this.date,
    required this.time,
    required this.command,
    required this.param,
  });

  @JsonKey(defaultValue: "no")
  String verup;
  @JsonKey(defaultValue: "")
  String date;
  @JsonKey(defaultValue: "")
  String time;
  @JsonKey(defaultValue: "vup/xxxxx.cmd")
  String command;
  @JsonKey(defaultValue: "-Uvh --nodeps --force")
  String param;
}

@JsonSerializable()
class _Speaker {
  factory _Speaker.fromJson(Map<String, dynamic> json) => _$SpeakerFromJson(json);
  Map<String, dynamic> toJson() => _$SpeakerToJson(this);

  _Speaker({
    required this.keyvol1,
    required this.keytone1,
    required this.scanvol1,
    required this.scantone1,
    required this.keyvol2,
    required this.keytone2,
    required this.scanvol2,
    required this.scantone2,
  });

  @JsonKey(defaultValue: 7)
  int    keyvol1;
  @JsonKey(defaultValue: 1)
  int    keytone1;
  @JsonKey(defaultValue: 6)
  int    scanvol1;
  @JsonKey(defaultValue: 6)
  int    scantone1;
  @JsonKey(defaultValue: 7)
  int    keyvol2;
  @JsonKey(defaultValue: 4)
  int    keytone2;
  @JsonKey(defaultValue: 6)
  int    scanvol2;
  @JsonKey(defaultValue: 6)
  int    scantone2;
}

@JsonSerializable()
class _Lcdbright {
  factory _Lcdbright.fromJson(Map<String, dynamic> json) => _$LcdbrightFromJson(json);
  Map<String, dynamic> toJson() => _$LcdbrightToJson(this);

  _Lcdbright({
    required this.lcdbright1,
    required this.lcdbright2,
  });

  @JsonKey(defaultValue: 4)
  int    lcdbright1;
  @JsonKey(defaultValue: 2)
  int    lcdbright2;
}

@JsonSerializable()
class _Logging {
  factory _Logging.fromJson(Map<String, dynamic> json) => _$LoggingFromJson(json);
  Map<String, dynamic> toJson() => _$LoggingToJson(this);

  _Logging({
    required this.maxsize,
    required this.level,
  });

  @JsonKey(defaultValue: 10000)
  int    maxsize;
  @JsonKey(defaultValue: 5)
  int    level;
}

@JsonSerializable()
class _Scanner {
  factory _Scanner.fromJson(Map<String, dynamic> json) => _$ScannerFromJson(json);
  Map<String, dynamic> toJson() => _$ScannerToJson(this);

  _Scanner({
    required this.reschar,
    required this.reschar_tower,
    required this.reschar_add,
  });

  @JsonKey(defaultValue: 0)
  int    reschar;
  @JsonKey(defaultValue: 0)
  int    reschar_tower;
  @JsonKey(defaultValue: 0)
  int    reschar_add;
}

@JsonSerializable()
class _Subcpu1 {
  factory _Subcpu1.fromJson(Map<String, dynamic> json) => _$Subcpu1FromJson(json);
  Map<String, dynamic> toJson() => _$Subcpu1ToJson(this);

  _Subcpu1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpu")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/subcpu1.json")
  String inifile;
}

@JsonSerializable()
class _Spk1 {
  factory _Spk1.fromJson(Map<String, dynamic> json) => _$Spk1FromJson(json);
  Map<String, dynamic> toJson() => _$Spk1ToJson(this);

  _Spk1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpuspkd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/speaker1.json")
  String inifile;
}

@JsonSerializable()
class _Wand1 {
  factory _Wand1.fromJson(Map<String, dynamic> json) => _$Wand1FromJson(json);
  Map<String, dynamic> toJson() => _$Wand1ToJson(this);

  _Wand1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scan")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scanner1.json")
  String inifile;
}

@JsonSerializable()
class _Wand2 {
  factory _Wand2.fromJson(Map<String, dynamic> json) => _$Wand2FromJson(json);
  Map<String, dynamic> toJson() => _$Wand2ToJson(this);

  _Wand2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scan")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scanner2.json")
  String inifile;
}

@JsonSerializable()
class _Lcdbrt1 {
  factory _Lcdbrt1.fromJson(Map<String, dynamic> json) => _$Lcdbrt1FromJson(json);
  Map<String, dynamic> toJson() => _$Lcdbrt1ToJson(this);

  _Lcdbrt1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpulcdd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/lcdbrt1.json")
  String inifile;
}

@JsonSerializable()
class _Lcdbrt2 {
  factory _Lcdbrt2.fromJson(Map<String, dynamic> json) => _$Lcdbrt2FromJson(json);
  Map<String, dynamic> toJson() => _$Lcdbrt2ToJson(this);

  _Lcdbrt2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpulcdd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/lcdbrt2.json")
  String inifile;
}

@JsonSerializable()
class _Fip1 {
  factory _Fip1.fromJson(Map<String, dynamic> json) => _$Fip1FromJson(json);
  Map<String, dynamic> toJson() => _$Fip1ToJson(this);

  _Fip1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpufipd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip1.json")
  String inifile;
}

@JsonSerializable()
class _Mkey1 {
  factory _Mkey1.fromJson(Map<String, dynamic> json) => _$Mkey1FromJson(json);
  Map<String, dynamic> toJson() => _$Mkey1ToJson(this);

  _Mkey1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_mkey")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mkey1.json")
  String inifile;
}

@JsonSerializable()
class _Mkey2 {
  factory _Mkey2.fromJson(Map<String, dynamic> json) => _$Mkey2FromJson(json);
  Map<String, dynamic> toJson() => _$Mkey2ToJson(this);

  _Mkey2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_mkey")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mkey2.json")
  String inifile;
}

@JsonSerializable()
class _Lcd57 {
  factory _Lcd57.fromJson(Map<String, dynamic> json) => _$Lcd57FromJson(json);
  Map<String, dynamic> toJson() => _$Lcd57ToJson(this);

  _Lcd57({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_lcd57")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/lcd57.json")
  String inifile;
}

@JsonSerializable()
class _Tkey1t {
  factory _Tkey1t.fromJson(Map<String, dynamic> json) => _$Tkey1tFromJson(json);
  Map<String, dynamic> toJson() => _$Tkey1tToJson(this);

  _Tkey1t({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tkey")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tkey1t.json")
  String inifile;
}

@JsonSerializable()
class _Tkey1d {
  factory _Tkey1d.fromJson(Map<String, dynamic> json) => _$Tkey1dFromJson(json);
  Map<String, dynamic> toJson() => _$Tkey1dToJson(this);

  _Tkey1d({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tkey")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tkey1d.json")
  String inifile;
}

@JsonSerializable()
class _Msr11 {
  factory _Msr11.fromJson(Map<String, dynamic> json) => _$Msr11FromJson(json);
  Map<String, dynamic> toJson() => _$Msr11ToJson(this);

  _Msr11({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_msr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr1jis1.json")
  String inifile;
}

@JsonSerializable()
class _Msr12 {
  factory _Msr12.fromJson(Map<String, dynamic> json) => _$Msr12FromJson(json);
  Map<String, dynamic> toJson() => _$Msr12ToJson(this);

  _Msr12({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_msr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr1jis2.json")
  String inifile;
}

@JsonSerializable()
class _Msr21 {
  factory _Msr21.fromJson(Map<String, dynamic> json) => _$Msr21FromJson(json);
  Map<String, dynamic> toJson() => _$Msr21ToJson(this);

  _Msr21({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_msr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr2jis1.json")
  String inifile;
}

@JsonSerializable()
class _Msr22 {
  factory _Msr22.fromJson(Map<String, dynamic> json) => _$Msr22FromJson(json);
  Map<String, dynamic> toJson() => _$Msr22ToJson(this);

  _Msr22({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_msr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr2jis2.json")
  String inifile;
}

@JsonSerializable()
class _Subcpu2 {
  factory _Subcpu2.fromJson(Map<String, dynamic> json) => _$Subcpu2FromJson(json);
  Map<String, dynamic> toJson() => _$Subcpu2ToJson(this);

  _Subcpu2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpu")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/subcpu2.json")
  String inifile;
}

@JsonSerializable()
class _Spk2 {
  factory _Spk2.fromJson(Map<String, dynamic> json) => _$Spk2FromJson(json);
  Map<String, dynamic> toJson() => _$Spk2ToJson(this);

  _Spk2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpuspkd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/speaker2.json")
  String inifile;
}

@JsonSerializable()
class _Fip2 {
  factory _Fip2.fromJson(Map<String, dynamic> json) => _$Fip2FromJson(json);
  Map<String, dynamic> toJson() => _$Fip2ToJson(this);

  _Fip2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpufipd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip2.json")
  String inifile;
}

@JsonSerializable()
class _Tkey2 {
  factory _Tkey2.fromJson(Map<String, dynamic> json) => _$Tkey2FromJson(json);
  Map<String, dynamic> toJson() => _$Tkey2ToJson(this);

  _Tkey2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tkey")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tkey2.json")
  String inifile;
}

@JsonSerializable()
class _Tprt {
  factory _Tprt.fromJson(Map<String, dynamic> json) => _$TprtFromJson(json);
  Map<String, dynamic> toJson() => _$TprtToJson(this);

  _Tprt({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprt")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprt.json")
  String inifile;
}

@JsonSerializable()
class _Pmouse1 {
  factory _Pmouse1.fromJson(Map<String, dynamic> json) => _$Pmouse1FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse1ToJson(this);

  _Pmouse1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse1.json")
  String inifile;
}

@JsonSerializable()
class _Pmouse2 {
  factory _Pmouse2.fromJson(Map<String, dynamic> json) => _$Pmouse2FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse2ToJson(this);

  _Pmouse2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse2.json")
  String inifile;
}

@JsonSerializable()
class _Sprt {
  factory _Sprt.fromJson(Map<String, dynamic> json) => _$SprtFromJson(json);
  Map<String, dynamic> toJson() => _$SprtToJson(this);

  _Sprt({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_sprt")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _Mupdate {
  factory _Mupdate.fromJson(Map<String, dynamic> json) => _$MupdateFromJson(json);
  Map<String, dynamic> toJson() => _$MupdateToJson(this);

  _Mupdate({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "mupdate")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _History {
  factory _History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryToJson(this);

  _History({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "history")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _Hist_csrv {
  factory _Hist_csrv.fromJson(Map<String, dynamic> json) => _$Hist_csrvFromJson(json);
  Map<String, dynamic> toJson() => _$Hist_csrvToJson(this);

  _Hist_csrv({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "hist_csrv")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _Tqrcd {
  factory _Tqrcd.fromJson(Map<String, dynamic> json) => _$TqrcdFromJson(json);
  Map<String, dynamic> toJson() => _$TqrcdToJson(this);

  _Tqrcd({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tqrcd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tqrcd.json")
  String inifile;
}

@JsonSerializable()
class _Hqftp {
  factory _Hqftp.fromJson(Map<String, dynamic> json) => _$HqftpFromJson(json);
  Map<String, dynamic> toJson() => _$HqftpToJson(this);

  _Hqftp({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "hqftp")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _Supdate {
  factory _Supdate.fromJson(Map<String, dynamic> json) => _$SupdateFromJson(json);
  Map<String, dynamic> toJson() => _$SupdateToJson(this);

  _Supdate({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "supdate")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _Hqhist {
  factory _Hqhist.fromJson(Map<String, dynamic> json) => _$HqhistFromJson(json);
  Map<String, dynamic> toJson() => _$HqhistToJson(this);

  _Hqhist({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "hqhist")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _Hqprod {
  factory _Hqprod.fromJson(Map<String, dynamic> json) => _$HqprodFromJson(json);
  Map<String, dynamic> toJson() => _$HqprodToJson(this);

  _Hqprod({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "hqprod")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _Signp {
  factory _Signp.fromJson(Map<String, dynamic> json) => _$SignpFromJson(json);
  Map<String, dynamic> toJson() => _$SignpToJson(this);

  _Signp({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_signp")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/signp.json")
  String inifile;
}

@JsonSerializable()
class _Detect {
  factory _Detect.fromJson(Map<String, dynamic> json) => _$DetectFromJson(json);
  Map<String, dynamic> toJson() => _$DetectToJson(this);

  _Detect({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_detect")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/detect.json")
  String inifile;
}

@JsonSerializable()
class _Callsw {
  factory _Callsw.fromJson(Map<String, dynamic> json) => _$CallswFromJson(json);
  Map<String, dynamic> toJson() => _$CallswToJson(this);

  _Callsw({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_callsw")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/callsw.json")
  String inifile;
}

@JsonSerializable()
class _Subcpu3 {
  factory _Subcpu3.fromJson(Map<String, dynamic> json) => _$Subcpu3FromJson(json);
  Map<String, dynamic> toJson() => _$Subcpu3ToJson(this);

  _Subcpu3({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpu")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/subcpu3.json")
  String inifile;
}

@JsonSerializable()
class _Spk3 {
  factory _Spk3.fromJson(Map<String, dynamic> json) => _$Spk3FromJson(json);
  Map<String, dynamic> toJson() => _$Spk3ToJson(this);

  _Spk3({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpuspkd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/speaker3.json")
  String inifile;
}

@JsonSerializable()
class _Tkey3d {
  factory _Tkey3d.fromJson(Map<String, dynamic> json) => _$Tkey3dFromJson(json);
  Map<String, dynamic> toJson() => _$Tkey3dToJson(this);

  _Tkey3d({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tkey")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tkey3d.json")
  String inifile;
}

@JsonSerializable()
class _Seg1 {
  factory _Seg1.fromJson(Map<String, dynamic> json) => _$Seg1FromJson(json);
  Map<String, dynamic> toJson() => _$Seg1ToJson(this);

  _Seg1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_segment")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/seg1.json")
  String inifile;
}

@JsonSerializable()
class _Seg2 {
  factory _Seg2.fromJson(Map<String, dynamic> json) => _$Seg2FromJson(json);
  Map<String, dynamic> toJson() => _$Seg2ToJson(this);

  _Seg2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_segment")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/seg2.json")
  String inifile;
}

@JsonSerializable()
class _Wand3 {
  factory _Wand3.fromJson(Map<String, dynamic> json) => _$Wand3FromJson(json);
  Map<String, dynamic> toJson() => _$Wand3ToJson(this);

  _Wand3({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scan")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scanner3.json")
  String inifile;
}

@JsonSerializable()
class _Lcdbrt3 {
  factory _Lcdbrt3.fromJson(Map<String, dynamic> json) => _$Lcdbrt3FromJson(json);
  Map<String, dynamic> toJson() => _$Lcdbrt3ToJson(this);

  _Lcdbrt3({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpulcdd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/lcdbrt3.json")
  String inifile;
}

@JsonSerializable()
class _Mkey3 {
  factory _Mkey3.fromJson(Map<String, dynamic> json) => _$Mkey3FromJson(json);
  Map<String, dynamic> toJson() => _$Mkey3ToJson(this);

  _Mkey3({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_mkey")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mkey3.json")
  String inifile;
}

@JsonSerializable()
class _Msr31 {
  factory _Msr31.fromJson(Map<String, dynamic> json) => _$Msr31FromJson(json);
  Map<String, dynamic> toJson() => _$Msr31ToJson(this);

  _Msr31({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_msr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr3jis1.json")
  String inifile;
}

@JsonSerializable()
class _Msr32 {
  factory _Msr32.fromJson(Map<String, dynamic> json) => _$Msr32FromJson(json);
  Map<String, dynamic> toJson() => _$Msr32ToJson(this);

  _Msr32({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_msr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr3jis2.json")
  String inifile;
}

@JsonSerializable()
class _Pmouse3 {
  factory _Pmouse3.fromJson(Map<String, dynamic> json) => _$Pmouse3FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse3ToJson(this);

  _Pmouse3({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse3.json")
  String inifile;
}

@JsonSerializable()
class _Schctrl {
  factory _Schctrl.fromJson(Map<String, dynamic> json) => _$SchctrlFromJson(json);
  Map<String, dynamic> toJson() => _$SchctrlToJson(this);

  _Schctrl({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "schctrl")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprt.json")
  String inifile;
}

@JsonSerializable()
class _Fip3 {
  factory _Fip3.fromJson(Map<String, dynamic> json) => _$Fip3FromJson(json);
  Map<String, dynamic> toJson() => _$Fip3ToJson(this);

  _Fip3({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpufipd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip3.json")
  String inifile;
}

@JsonSerializable()
class _Vfd57_3 {
  factory _Vfd57_3.fromJson(Map<String, dynamic> json) => _$Vfd57_3FromJson(json);
  Map<String, dynamic> toJson() => _$Vfd57_3ToJson(this);

  _Vfd57_3({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scpu57vfd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/vfd57_3.json")
  String inifile;
}

@JsonSerializable()
class _Tprtf {
  factory _Tprtf.fromJson(Map<String, dynamic> json) => _$TprtfFromJson(json);
  Map<String, dynamic> toJson() => _$TprtfToJson(this);

  _Tprtf({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprtf")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprtf.json")
  String inifile;
}

@JsonSerializable()
class _Tprts {
  factory _Tprts.fromJson(Map<String, dynamic> json) => _$TprtsFromJson(json);
  Map<String, dynamic> toJson() => _$TprtsToJson(this);

  _Tprts({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprts")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprts.json")
  String inifile;
}

@JsonSerializable()
class _Pmouse_plus_1 {
  factory _Pmouse_plus_1.fromJson(Map<String, dynamic> json) => _$Pmouse_plus_1FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_plus_1ToJson(this);

  _Pmouse_plus_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_plus_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2300_1 {
  factory _Pmouse_2300_1.fromJson(Map<String, dynamic> json) => _$Pmouse_2300_1FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2300_1ToJson(this);

  _Pmouse_2300_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2300_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2300_2 {
  factory _Pmouse_2300_2.fromJson(Map<String, dynamic> json) => _$Pmouse_2300_2FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2300_2ToJson(this);

  _Pmouse_2300_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2300_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Fip_plus_1 {
  factory _Fip_plus_1.fromJson(Map<String, dynamic> json) => _$Fip_plus_1FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_plus_1ToJson(this);

  _Fip_plus_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_plus_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Fip_2300_1 {
  factory _Fip_2300_1.fromJson(Map<String, dynamic> json) => _$Fip_2300_1FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2300_1ToJson(this);

  _Fip_2300_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2300_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Fip_2300_2 {
  factory _Fip_2300_2.fromJson(Map<String, dynamic> json) => _$Fip_2300_2FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2300_2ToJson(this);

  _Fip_2300_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2300_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Segd_plus_1 {
  factory _Segd_plus_1.fromJson(Map<String, dynamic> json) => _$Segd_plus_1FromJson(json);
  Map<String, dynamic> toJson() => _$Segd_plus_1ToJson(this);

  _Segd_plus_1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_segd_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/segd_plus_1.json")
  String inifile;
}

@JsonSerializable()
class _Segd_2300_1 {
  factory _Segd_2300_1.fromJson(Map<String, dynamic> json) => _$Segd_2300_1FromJson(json);
  Map<String, dynamic> toJson() => _$Segd_2300_1ToJson(this);

  _Segd_2300_1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_segd_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/segd_2300_1.json")
  String inifile;
}

@JsonSerializable()
class _Segd_2300_2 {
  factory _Segd_2300_2.fromJson(Map<String, dynamic> json) => _$Segd_2300_2FromJson(json);
  Map<String, dynamic> toJson() => _$Segd_2300_2ToJson(this);

  _Segd_2300_2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_segd_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/segd_2300_2.json")
  String inifile;
}

@JsonSerializable()
class _Vfd57_plus_1 {
  factory _Vfd57_plus_1.fromJson(Map<String, dynamic> json) => _$Vfd57_plus_1FromJson(json);
  Map<String, dynamic> toJson() => _$Vfd57_plus_1ToJson(this);

  _Vfd57_plus_1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_vfd57_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/vfd57_plus_1.json")
  String inifile;
}

@JsonSerializable()
class _Vfd57_2300_1 {
  factory _Vfd57_2300_1.fromJson(Map<String, dynamic> json) => _$Vfd57_2300_1FromJson(json);
  Map<String, dynamic> toJson() => _$Vfd57_2300_1ToJson(this);

  _Vfd57_2300_1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_vfd57_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/vfd57_2300_1.json")
  String inifile;
}

@JsonSerializable()
class _Vfd57_2300_2 {
  factory _Vfd57_2300_2.fromJson(Map<String, dynamic> json) => _$Vfd57_2300_2FromJson(json);
  Map<String, dynamic> toJson() => _$Vfd57_2300_2ToJson(this);

  _Vfd57_2300_2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_vfd57_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/vfd57_2300_2.json")
  String inifile;
}

@JsonSerializable()
class _Mkey_plus_1 {
  factory _Mkey_plus_1.fromJson(Map<String, dynamic> json) => _$Mkey_plus_1FromJson(json);
  Map<String, dynamic> toJson() => _$Mkey_plus_1ToJson(this);

  _Mkey_plus_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_mkey_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mkey_plus_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Mkey_2300_1 {
  factory _Mkey_2300_1.fromJson(Map<String, dynamic> json) => _$Mkey_2300_1FromJson(json);
  Map<String, dynamic> toJson() => _$Mkey_2300_1ToJson(this);

  _Mkey_2300_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_mkey_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mkey_2300_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Mkey_2300_2 {
  factory _Mkey_2300_2.fromJson(Map<String, dynamic> json) => _$Mkey_2300_2FromJson(json);
  Map<String, dynamic> toJson() => _$Mkey_2300_2ToJson(this);

  _Mkey_2300_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_mkey_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mkey_2300_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Scan_plus_1 {
  factory _Scan_plus_1.fromJson(Map<String, dynamic> json) => _$Scan_plus_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_plus_1ToJson(this);

  _Scan_plus_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_plus_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_plus_2 {
  factory _Scan_plus_2.fromJson(Map<String, dynamic> json) => _$Scan_plus_2FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_plus_2ToJson(this);

  _Scan_plus_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_plus_2.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2300_1 {
  factory _Scan_2300_1.fromJson(Map<String, dynamic> json) => _$Scan_2300_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2300_1ToJson(this);

  _Scan_2300_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2300_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2300_2 {
  factory _Scan_2300_2.fromJson(Map<String, dynamic> json) => _$Scan_2300_2FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2300_2ToJson(this);

  _Scan_2300_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2300_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Msr_2300_1 {
  factory _Msr_2300_1.fromJson(Map<String, dynamic> json) => _$Msr_2300_1FromJson(json);
  Map<String, dynamic> toJson() => _$Msr_2300_1ToJson(this);

  _Msr_2300_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_msr_2300")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr_2300_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Msr_2300_2 {
  factory _Msr_2300_2.fromJson(Map<String, dynamic> json) => _$Msr_2300_2FromJson(json);
  Map<String, dynamic> toJson() => _$Msr_2300_2ToJson(this);

  _Msr_2300_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_msr_2300")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr_2300_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Mkey_2800_1 {
  factory _Mkey_2800_1.fromJson(Map<String, dynamic> json) => _$Mkey_2800_1FromJson(json);
  Map<String, dynamic> toJson() => _$Mkey_2800_1ToJson(this);

  _Mkey_2800_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_mkey_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mkey_2800_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Mkey_2800_2 {
  factory _Mkey_2800_2.fromJson(Map<String, dynamic> json) => _$Mkey_2800_2FromJson(json);
  Map<String, dynamic> toJson() => _$Mkey_2800_2ToJson(this);

  _Mkey_2800_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_mkey_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mkey_2800_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2800_1 {
  factory _Pmouse_2800_1.fromJson(Map<String, dynamic> json) => _$Pmouse_2800_1FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2800_1ToJson(this);

  _Pmouse_2800_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.inifile2,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2800_1.json")
  String inifile;
  @JsonKey(defaultValue: "conf/pmouse_2800_5.json")
  String inifile2;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2800_2 {
  factory _Pmouse_2800_2.fromJson(Map<String, dynamic> json) => _$Pmouse_2800_2FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2800_2ToJson(this);

  _Pmouse_2800_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2800_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2800_3 {
  factory _Pmouse_2800_3.fromJson(Map<String, dynamic> json) => _$Pmouse_2800_3FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2800_3ToJson(this);

  _Pmouse_2800_3({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.inifile2,
    required this.inifile3,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2800_3.json")
  String inifile;
  @JsonKey(defaultValue: "conf/pmouse_2800_4.json")
  String inifile2;
  @JsonKey(defaultValue: "conf/pmouse_2800_5.json")
  String inifile3;
  @JsonKey(defaultValue: 2)
  int    tower;
}

@JsonSerializable()
class _Scan_2800_1 {
  factory _Scan_2800_1.fromJson(Map<String, dynamic> json) => _$Scan_2800_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800_1ToJson(this);

  _Scan_2800_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2800_2 {
  factory _Scan_2800_2.fromJson(Map<String, dynamic> json) => _$Scan_2800_2FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800_2ToJson(this);

  _Scan_2800_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Fip_2800_1 {
  factory _Fip_2800_1.fromJson(Map<String, dynamic> json) => _$Fip_2800_1FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2800_1ToJson(this);

  _Fip_2800_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2800_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Fip_2800_2 {
  factory _Fip_2800_2.fromJson(Map<String, dynamic> json) => _$Fip_2800_2FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2800_2ToJson(this);

  _Fip_2800_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2800_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Fip_2800_3 {
  factory _Fip_2800_3.fromJson(Map<String, dynamic> json) => _$Fip_2800_3FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2800_3ToJson(this);

  _Fip_2800_3({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2800_3.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Drw_2800_1 {
  factory _Drw_2800_1.fromJson(Map<String, dynamic> json) => _$Drw_2800_1FromJson(json);
  Map<String, dynamic> toJson() => _$Drw_2800_1ToJson(this);

  _Drw_2800_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_drw_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/drw_2800_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Drw_2800_2 {
  factory _Drw_2800_2.fromJson(Map<String, dynamic> json) => _$Drw_2800_2FromJson(json);
  Map<String, dynamic> toJson() => _$Drw_2800_2ToJson(this);

  _Drw_2800_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_drw_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/drw_2800_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Tprtss {
  factory _Tprtss.fromJson(Map<String, dynamic> json) => _$TprtssFromJson(json);
  Map<String, dynamic> toJson() => _$TprtssToJson(this);

  _Tprtss({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprtss")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprtss.json")
  String inifile;
}

@JsonSerializable()
class _Tprtss2 {
  factory _Tprtss2.fromJson(Map<String, dynamic> json) => _$Tprtss2FromJson(json);
  Map<String, dynamic> toJson() => _$Tprtss2ToJson(this);

  _Tprtss2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprtss")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprtss.json")
  String inifile;
}

@JsonSerializable()
class _Pmouse_2500_1 {
  factory _Pmouse_2500_1.fromJson(Map<String, dynamic> json) => _$Pmouse_2500_1FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2500_1ToJson(this);

  _Pmouse_2500_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.inifile2,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2500_1.json")
  String inifile;
  @JsonKey(defaultValue: "conf/pmouse_5900_1.json")
  String inifile2;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2500_2 {
  factory _Pmouse_2500_2.fromJson(Map<String, dynamic> json) => _$Pmouse_2500_2FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2500_2ToJson(this);

  _Pmouse_2500_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2500_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Fip_2500_1 {
  factory _Fip_2500_1.fromJson(Map<String, dynamic> json) => _$Fip_2500_1FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2500_1ToJson(this);

  _Fip_2500_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2500_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Fip_2500_2 {
  factory _Fip_2500_2.fromJson(Map<String, dynamic> json) => _$Fip_2500_2FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2500_2ToJson(this);

  _Fip_2500_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2500_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Scan_2500_1 {
  factory _Scan_2500_1.fromJson(Map<String, dynamic> json) => _$Scan_2500_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2500_1ToJson(this);

  _Scan_2500_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2500_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2500_2 {
  factory _Scan_2500_2.fromJson(Map<String, dynamic> json) => _$Scan_2500_2FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2500_2ToJson(this);

  _Scan_2500_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2500_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Msr_2500_1 {
  factory _Msr_2500_1.fromJson(Map<String, dynamic> json) => _$Msr_2500_1FromJson(json);
  Map<String, dynamic> toJson() => _$Msr_2500_1ToJson(this);

  _Msr_2500_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_msr_2300")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr_2500_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Msr_2500_2 {
  factory _Msr_2500_2.fromJson(Map<String, dynamic> json) => _$Msr_2500_2FromJson(json);
  Map<String, dynamic> toJson() => _$Msr_2500_2ToJson(this);

  _Msr_2500_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_msr_2300")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr_2500_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2350_1 {
  factory _Pmouse_2350_1.fromJson(Map<String, dynamic> json) => _$Pmouse_2350_1FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2350_1ToJson(this);

  _Pmouse_2350_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2350_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2350_2 {
  factory _Pmouse_2350_2.fromJson(Map<String, dynamic> json) => _$Pmouse_2350_2FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2350_2ToJson(this);

  _Pmouse_2350_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2350_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Scan_2800ip_1 {
  factory _Scan_2800ip_1.fromJson(Map<String, dynamic> json) => _$Scan_2800ip_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800ip_1ToJson(this);

  _Scan_2800ip_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800ip_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2800ip_2 {
  factory _Scan_2800ip_2.fromJson(Map<String, dynamic> json) => _$Scan_2800ip_2FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800ip_2ToJson(this);

  _Scan_2800ip_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800ip_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Tprtim {
  factory _Tprtim.fromJson(Map<String, dynamic> json) => _$TprtimFromJson(json);
  Map<String, dynamic> toJson() => _$TprtimToJson(this);

  _Tprtim({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprtim")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprtim.json")
  String inifile;
}

@JsonSerializable()
class _Fip_2800im_1 {
  factory _Fip_2800im_1.fromJson(Map<String, dynamic> json) => _$Fip_2800im_1FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2800im_1ToJson(this);

  _Fip_2800im_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2800im_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Fip_2800im_2 {
  factory _Fip_2800im_2.fromJson(Map<String, dynamic> json) => _$Fip_2800im_2FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2800im_2ToJson(this);

  _Fip_2800im_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2800im_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Fip_2800im_3 {
  factory _Fip_2800im_3.fromJson(Map<String, dynamic> json) => _$Fip_2800im_3FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_2800im_3ToJson(this);

  _Fip_2800im_3({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2800im_3.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Scan_2800im_1 {
  factory _Scan_2800im_1.fromJson(Map<String, dynamic> json) => _$Scan_2800im_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800im_1ToJson(this);

  _Scan_2800im_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800im_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2800im_2 {
  factory _Scan_2800im_2.fromJson(Map<String, dynamic> json) => _$Scan_2800im_2FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800im_2ToJson(this);

  _Scan_2800im_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800im_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Pmouse_plus2_1 {
  factory _Pmouse_plus2_1.fromJson(Map<String, dynamic> json) => _$Pmouse_plus2_1FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_plus2_1ToJson(this);

  _Pmouse_plus2_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_plus2")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_plus2_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Fip_plus2_1 {
  factory _Fip_plus2_1.fromJson(Map<String, dynamic> json) => _$Fip_plus2_1FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_plus2_1ToJson(this);

  _Fip_plus2_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_plus2_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Fip_plus2_2 {
  factory _Fip_plus2_2.fromJson(Map<String, dynamic> json) => _$Fip_plus2_2FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_plus2_2ToJson(this);

  _Fip_plus2_2({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2800im_2.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Fip_plus2_3 {
  factory _Fip_plus2_3.fromJson(Map<String, dynamic> json) => _$Fip_plus2_3FromJson(json);
  Map<String, dynamic> toJson() => _$Fip_plus2_3ToJson(this);

  _Fip_plus2_3({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_fip_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fip_2800im_3.json")
  String inifile;
  @JsonKey(defaultValue: 1)
  int    tower;
}

@JsonSerializable()
class _Msr_plus2_1 {
  factory _Msr_plus2_1.fromJson(Map<String, dynamic> json) => _$Msr_plus2_1FromJson(json);
  Map<String, dynamic> toJson() => _$Msr_plus2_1ToJson(this);

  _Msr_plus2_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_msr_2300")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr_2500_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2800a3_1 {
  factory _Scan_2800a3_1.fromJson(Map<String, dynamic> json) => _$Scan_2800a3_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800a3_1ToJson(this);

  _Scan_2800a3_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800a3_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2800i3_1 {
  factory _Scan_2800i3_1.fromJson(Map<String, dynamic> json) => _$Scan_2800i3_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800i3_1ToJson(this);

  _Scan_2800i3_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800i3_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Msr_int_1 {
  factory _Msr_int_1.fromJson(Map<String, dynamic> json) => _$Msr_int_1FromJson(json);
  Map<String, dynamic> toJson() => _$Msr_int_1ToJson(this);

  _Msr_int_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_msr_int")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/msr_int_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Scan_2800g3_1 {
  factory _Scan_2800g3_1.fromJson(Map<String, dynamic> json) => _$Scan_2800g3_1FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800g3_1ToJson(this);

  _Scan_2800g3_1({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800g3_1.json")
  String inifile;
  @JsonKey(defaultValue: 0)
  int    tower;
}

@JsonSerializable()
class _Pmouse_2800_4 {
  factory _Pmouse_2800_4.fromJson(Map<String, dynamic> json) => _$Pmouse_2800_4FromJson(json);
  Map<String, dynamic> toJson() => _$Pmouse_2800_4ToJson(this);

  _Pmouse_2800_4({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.inifile2,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_pmouse_2800")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pmouse_2800_6.json")
  String inifile;
  @JsonKey(defaultValue: "conf/pmouse_2800_7.json")
  String inifile2;
  @JsonKey(defaultValue: 3)
  int    tower;
}

@JsonSerializable()
class _Tprthp {
  factory _Tprthp.fromJson(Map<String, dynamic> json) => _$TprthpFromJson(json);
  Map<String, dynamic> toJson() => _$TprthpToJson(this);

  _Tprthp({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprthp")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprthp.json")
  String inifile;
}

@JsonSerializable()
class _Sprocket {
  factory _Sprocket.fromJson(Map<String, dynamic> json) => _$SprocketFromJson(json);
  Map<String, dynamic> toJson() => _$SprocketToJson(this);

  _Sprocket({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sprocket_prn.json")
  String inifile;
}

@JsonSerializable()
class _Acr {
  factory _Acr.fromJson(Map<String, dynamic> json) => _$AcrFromJson(json);
  Map<String, dynamic> toJson() => _$AcrToJson(this);

  _Acr({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_changer")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/acr.json")
  String inifile;
}

@JsonSerializable()
class _Acb {
  factory _Acb.fromJson(Map<String, dynamic> json) => _$AcbFromJson(json);
  Map<String, dynamic> toJson() => _$AcbToJson(this);

  _Acb({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_changer")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/acb.json")
  String inifile;
}

@JsonSerializable()
class _Acb20 {
  factory _Acb20.fromJson(Map<String, dynamic> json) => _$Acb20FromJson(json);
  Map<String, dynamic> toJson() => _$Acb20ToJson(this);

  _Acb20({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_changer")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/acb20.json")
  String inifile;
}

@JsonSerializable()
class _Rewrite {
  factory _Rewrite.fromJson(Map<String, dynamic> json) => _$RewriteFromJson(json);
  Map<String, dynamic> toJson() => _$RewriteToJson(this);

  _Rewrite({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tqrcd")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/rewrite_card.json")
  String inifile;
}

@JsonSerializable()
class _Vismac {
  factory _Vismac.fromJson(Map<String, dynamic> json) => _$VismacFromJson(json);
  Map<String, dynamic> toJson() => _$VismacToJson(this);

  _Vismac({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_vismac")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/vismac.json")
  String inifile;
}

@JsonSerializable()
class _Gcat {
  factory _Gcat.fromJson(Map<String, dynamic> json) => _$GcatFromJson(json);
  Map<String, dynamic> toJson() => _$GcatToJson(this);

  _Gcat({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_gcat")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pana_gcat.json")
  String inifile;
}

@JsonSerializable()
class _Debit {
  factory _Debit.fromJson(Map<String, dynamic> json) => _$DebitFromJson(json);
  Map<String, dynamic> toJson() => _$DebitToJson(this);

  _Debit({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_debit")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/j_debit.json")
  String inifile;
}

@JsonSerializable()
class _Scale {
  factory _Scale.fromJson(Map<String, dynamic> json) => _$ScaleFromJson(json);
  Map<String, dynamic> toJson() => _$ScaleToJson(this);

  _Scale({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scale")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scale.json")
  String inifile;
}

@JsonSerializable()
class _Orc {
  factory _Orc.fromJson(Map<String, dynamic> json) => _$OrcFromJson(json);
  Map<String, dynamic> toJson() => _$OrcToJson(this);

  _Orc({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_orc")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/orc.json")
  String inifile;
}

@JsonSerializable()
class _Sg_scale1 {
  factory _Sg_scale1.fromJson(Map<String, dynamic> json) => _$Sg_scale1FromJson(json);
  Map<String, dynamic> toJson() => _$Sg_scale1ToJson(this);

  _Sg_scale1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_sgscl")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sg_scale1.json")
  String inifile;
}

@JsonSerializable()
class _Sg_scale2 {
  factory _Sg_scale2.fromJson(Map<String, dynamic> json) => _$Sg_scale2FromJson(json);
  Map<String, dynamic> toJson() => _$Sg_scale2ToJson(this);

  _Sg_scale2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_sgscl")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sg_scale2.json")
  String inifile;
}

@JsonSerializable()
class _Sm_scale1 {
  factory _Sm_scale1.fromJson(Map<String, dynamic> json) => _$Sm_scale1FromJson(json);
  Map<String, dynamic> toJson() => _$Sm_scale1ToJson(this);

  _Sm_scale1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_smscl")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sm_scale1.json")
  String inifile;
}

@JsonSerializable()
class _Sm_scale2 {
  factory _Sm_scale2.fromJson(Map<String, dynamic> json) => _$Sm_scale2FromJson(json);
  Map<String, dynamic> toJson() => _$Sm_scale2ToJson(this);

  _Sm_scale2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_smscl")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sm_scale2.json")
  String inifile;
}

@JsonSerializable()
class _Sip60 {
  factory _Sip60.fromJson(Map<String, dynamic> json) => _$Sip60FromJson(json);
  Map<String, dynamic> toJson() => _$Sip60ToJson(this);

  _Sip60({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_sip60")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sip60.json")
  String inifile;
}

@JsonSerializable()
class _Psp60 {
  factory _Psp60.fromJson(Map<String, dynamic> json) => _$Psp60FromJson(json);
  Map<String, dynamic> toJson() => _$Psp60ToJson(this);

  _Psp60({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_psp60")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/psp60.json")
  String inifile;
}

@JsonSerializable()
class _Stpr {
  factory _Stpr.fromJson(Map<String, dynamic> json) => _$StprFromJson(json);
  Map<String, dynamic> toJson() => _$StprToJson(this);

  _Stpr({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_stpr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/stpr.json")
  String inifile;
}

@JsonSerializable()
class _Pana {
  factory _Pana.fromJson(Map<String, dynamic> json) => _$PanaFromJson(json);
  Map<String, dynamic> toJson() => _$PanaToJson(this);

  _Pana({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_pana")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pana.json")
  String inifile;
}

@JsonSerializable()
class _Gp {
  factory _Gp.fromJson(Map<String, dynamic> json) => _$GpFromJson(json);
  Map<String, dynamic> toJson() => _$GpToJson(this);

  _Gp({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_gp")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/gp.json")
  String inifile;
}

@JsonSerializable()
class _Sm_scalesc {
  factory _Sm_scalesc.fromJson(Map<String, dynamic> json) => _$Sm_scalescFromJson(json);
  Map<String, dynamic> toJson() => _$Sm_scalescToJson(this);

  _Sm_scalesc({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_smsclsc")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sm_scalesc.json")
  String inifile;
}

@JsonSerializable()
class _Sm_scalesc_scl {
  factory _Sm_scalesc_scl.fromJson(Map<String, dynamic> json) => _$Sm_scalesc_sclFromJson(json);
  Map<String, dynamic> toJson() => _$Sm_scalesc_sclToJson(this);

  _Sm_scalesc_scl({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_smsclsc")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sm_scalesc_scl.json")
  String inifile;
}

@JsonSerializable()
class _Sm_scalesc_signp {
  factory _Sm_scalesc_signp.fromJson(Map<String, dynamic> json) => _$Sm_scalesc_signpFromJson(json);
  Map<String, dynamic> toJson() => _$Sm_scalesc_signpToJson(this);

  _Sm_scalesc_signp({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_smsclsc")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sm_scalesc_signp.json")
  String inifile;
}

@JsonSerializable()
class _S2pr {
  factory _S2pr.fromJson(Map<String, dynamic> json) => _$S2prFromJson(json);
  Map<String, dynamic> toJson() => _$S2prToJson(this);

  _S2pr({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_stpr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/s2pr.json")
  String inifile;
}

@JsonSerializable()
class _Acb50 {
  factory _Acb50.fromJson(Map<String, dynamic> json) => _$Acb50FromJson(json);
  Map<String, dynamic> toJson() => _$Acb50ToJson(this);

  _Acb50({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_changer")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/acb50.json")
  String inifile;
}

@JsonSerializable()
class _Pwrctrl {
  factory _Pwrctrl.fromJson(Map<String, dynamic> json) => _$PwrctrlFromJson(json);
  Map<String, dynamic> toJson() => _$PwrctrlToJson(this);

  _Pwrctrl({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_pwrctrl")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pwrctrl.json")
  String inifile;
}

@JsonSerializable()
class _Pw410 {
  factory _Pw410.fromJson(Map<String, dynamic> json) => _$Pw410FromJson(json);
  Map<String, dynamic> toJson() => _$Pw410ToJson(this);

  _Pw410({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_pw410")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pw410.json")
  String inifile;
}

@JsonSerializable()
class _Ccr {
  factory _Ccr.fromJson(Map<String, dynamic> json) => _$CcrFromJson(json);
  Map<String, dynamic> toJson() => _$CcrToJson(this);

  _Ccr({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_ccr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/ccr.json")
  String inifile;
}

@JsonSerializable()
class _Psp70 {
  factory _Psp70.fromJson(Map<String, dynamic> json) => _$Psp70FromJson(json);
  Map<String, dynamic> toJson() => _$Psp70ToJson(this);

  _Psp70({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_psp60")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/psp70.json")
  String inifile;
}

@JsonSerializable()
class _Dish {
  factory _Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);

  _Dish({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_dish")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/dish.json")
  String inifile;
}

@JsonSerializable()
class _Aiv {
  factory _Aiv.fromJson(Map<String, dynamic> json) => _$AivFromJson(json);
  Map<String, dynamic> toJson() => _$AivToJson(this);

  _Aiv({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_aiv")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/aiv.json")
  String inifile;
}

@JsonSerializable()
class _Ar_stts_01 {
  factory _Ar_stts_01.fromJson(Map<String, dynamic> json) => _$Ar_stts_01FromJson(json);
  Map<String, dynamic> toJson() => _$Ar_stts_01ToJson(this);

  _Ar_stts_01({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_arstts")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/ar_stts_01.json")
  String inifile;
}

@JsonSerializable()
class _Gcat_cnct {
  factory _Gcat_cnct.fromJson(Map<String, dynamic> json) => _$Gcat_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Gcat_cnctToJson(this);

  _Gcat_cnct({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_gcat")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/gcat_cnct.json")
  String inifile;
}

@JsonSerializable()
class _Yomoca {
  factory _Yomoca.fromJson(Map<String, dynamic> json) => _$YomocaFromJson(json);
  Map<String, dynamic> toJson() => _$YomocaToJson(this);

  _Yomoca({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_yomoca")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/yomoca.json")
  String inifile;
}

@JsonSerializable()
class _Smtplus {
  factory _Smtplus.fromJson(Map<String, dynamic> json) => _$SmtplusFromJson(json);
  Map<String, dynamic> toJson() => _$SmtplusToJson(this);

  _Smtplus({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_smtplus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/smtplus.json")
  String inifile;
}

@JsonSerializable()
class _Suica {
  factory _Suica.fromJson(Map<String, dynamic> json) => _$SuicaFromJson(json);
  Map<String, dynamic> toJson() => _$SuicaToJson(this);

  _Suica({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_suica")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/suica_cnct.json")
  String inifile;
}

@JsonSerializable()
class _Rfid {
  factory _Rfid.fromJson(Map<String, dynamic> json) => _$RfidFromJson(json);
  Map<String, dynamic> toJson() => _$RfidToJson(this);

  _Rfid({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_rfid")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/rfid.json")
  String inifile;
}

@JsonSerializable()
class _Disht {
  factory _Disht.fromJson(Map<String, dynamic> json) => _$DishtFromJson(json);
  Map<String, dynamic> toJson() => _$DishtToJson(this);

  _Disht({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_disht")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/disht.json")
  String inifile;
}

@JsonSerializable()
class _Mcp200 {
  factory _Mcp200.fromJson(Map<String, dynamic> json) => _$Mcp200FromJson(json);
  Map<String, dynamic> toJson() => _$Mcp200ToJson(this);

  _Mcp200({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_mcp200")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mcp200.json")
  String inifile;
}

@JsonSerializable()
class _Fcl {
  factory _Fcl.fromJson(Map<String, dynamic> json) => _$FclFromJson(json);
  Map<String, dynamic> toJson() => _$FclToJson(this);

  _Fcl({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_fcl")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fcl.json")
  String inifile;
}

@JsonSerializable()
class _Jrw_multi {
  factory _Jrw_multi.fromJson(Map<String, dynamic> json) => _$Jrw_multiFromJson(json);
  Map<String, dynamic> toJson() => _$Jrw_multiToJson(this);

  _Jrw_multi({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/jrw_multi.json")
  String inifile;
}

@JsonSerializable()
class _Ht2980 {
  factory _Ht2980.fromJson(Map<String, dynamic> json) => _$Ht2980FromJson(json);
  Map<String, dynamic> toJson() => _$Ht2980ToJson(this);

  _Ht2980({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_smtplus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/ht2980.json")
  String inifile;
}

@JsonSerializable()
class _Absv31 {
  factory _Absv31.fromJson(Map<String, dynamic> json) => _$Absv31FromJson(json);
  Map<String, dynamic> toJson() => _$Absv31ToJson(this);

  _Absv31({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_absv31")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/absv31.json")
  String inifile;
}

@JsonSerializable()
class _Yamato {
  factory _Yamato.fromJson(Map<String, dynamic> json) => _$YamatoFromJson(json);
  Map<String, dynamic> toJson() => _$YamatoToJson(this);

  _Yamato({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_yamato")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/yamato.json")
  String inifile;
}

@JsonSerializable()
class _Cct {
  factory _Cct.fromJson(Map<String, dynamic> json) => _$CctFromJson(json);
  Map<String, dynamic> toJson() => _$CctToJson(this);

  _Cct({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_cct")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/cct.json")
  String inifile;
}

@JsonSerializable()
class _Castles {
  factory _Castles.fromJson(Map<String, dynamic> json) => _$CastlesFromJson(json);
  Map<String, dynamic> toJson() => _$CastlesToJson(this);

  _Castles({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_cct")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/cct.json")
  String inifile;
}

@JsonSerializable()
class _Usbcam {
  factory _Usbcam.fromJson(Map<String, dynamic> json) => _$UsbcamFromJson(json);
  Map<String, dynamic> toJson() => _$UsbcamToJson(this);

  _Usbcam({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_usbcam")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/usbcam.json")
  String inifile;
}

@JsonSerializable()
class _Masr {
  factory _Masr.fromJson(Map<String, dynamic> json) => _$MasrFromJson(json);
  Map<String, dynamic> toJson() => _$MasrToJson(this);

  _Masr({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_masr")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/masr.json")
  String inifile;
}

@JsonSerializable()
class _Jmups {
  factory _Jmups.fromJson(Map<String, dynamic> json) => _$JmupsFromJson(json);
  Map<String, dynamic> toJson() => _$JmupsToJson(this);

  _Jmups({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_jmups")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/jmups.json")
  String inifile;
}

@JsonSerializable()
class _Fal2 {
  factory _Fal2.fromJson(Map<String, dynamic> json) => _$Fal2FromJson(json);
  Map<String, dynamic> toJson() => _$Fal2ToJson(this);

  _Fal2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_changer_fal2")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/fal2.json")
  String inifile;
}

@JsonSerializable()
class _Sqrc {
  factory _Sqrc.fromJson(Map<String, dynamic> json) => _$SqrcFromJson(json);
  Map<String, dynamic> toJson() => _$SqrcToJson(this);

  _Sqrc({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_sqrc")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/sqrc_spec.json")
  String inifile;
}

@JsonSerializable()
class _Tprtrp {
  factory _Tprtrp.fromJson(Map<String, dynamic> json) => _$TprtrpFromJson(json);
  Map<String, dynamic> toJson() => _$TprtrpToJson(this);

  _Tprtrp({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprtrp")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprtrp.json")
  String inifile;
}

@JsonSerializable()
class _Tprtrp2 {
  factory _Tprtrp2.fromJson(Map<String, dynamic> json) => _$Tprtrp2FromJson(json);
  Map<String, dynamic> toJson() => _$Tprtrp2ToJson(this);

  _Tprtrp2({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_tprtrp")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/tprtrp.json")
  String inifile;
}

@JsonSerializable()
class _Iccard {
  factory _Iccard.fromJson(Map<String, dynamic> json) => _$IccardFromJson(json);
  Map<String, dynamic> toJson() => _$IccardToJson(this);

  _Iccard({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_iccard")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/iccard.json")
  String inifile;
}

@JsonSerializable()
class _Mst {
  factory _Mst.fromJson(Map<String, dynamic> json) => _$MstFromJson(json);
  Map<String, dynamic> toJson() => _$MstToJson(this);

  _Mst({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_mst")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/mst.json")
  String inifile;
}

@JsonSerializable()
class _Scan_2800_3 {
  factory _Scan_2800_3.fromJson(Map<String, dynamic> json) => _$Scan_2800_3FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800_3ToJson(this);

  _Scan_2800_3({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800_3.json")
  String inifile;
  @JsonKey(defaultValue: 2)
  int    tower;
}

@JsonSerializable()
class _Vega3000 {
  factory _Vega3000.fromJson(Map<String, dynamic> json) => _$Vega3000FromJson(json);
  Map<String, dynamic> toJson() => _$Vega3000ToJson(this);

  _Vega3000({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/vega3000.json")
  String inifile;
}

@JsonSerializable()
class _Powli {
  factory _Powli.fromJson(Map<String, dynamic> json) => _$PowliFromJson(json);
  Map<String, dynamic> toJson() => _$PowliToJson(this);

  _Powli({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_powli")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/powli.json")
  String inifile;
}

@JsonSerializable()
class _Scan_2800_4 {
  factory _Scan_2800_4.fromJson(Map<String, dynamic> json) => _$Scan_2800_4FromJson(json);
  Map<String, dynamic> toJson() => _$Scan_2800_4ToJson(this);

  _Scan_2800_4({
    required this.entry,
    required this.priority,
    required this.inifile,
    required this.tower,
  });

  @JsonKey(defaultValue: "tprdrv_scan_plus")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scan_2800_4.json")
  String inifile;
  @JsonKey(defaultValue: 3)
  int    tower;
}

@JsonSerializable()
class _Psensor_1 {
  factory _Psensor_1.fromJson(Map<String, dynamic> json) => _$Psensor_1FromJson(json);
  Map<String, dynamic> toJson() => _$Psensor_1ToJson(this);

  _Psensor_1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_psensor")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/psensor_1.json")
  String inifile;
}

@JsonSerializable()
class _Apbf_1 {
  factory _Apbf_1.fromJson(Map<String, dynamic> json) => _$Apbf_1FromJson(json);
  Map<String, dynamic> toJson() => _$Apbf_1ToJson(this);

  _Apbf_1({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_apbf")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/apbf_1.json")
  String inifile;
}

@JsonSerializable()
class _Scalerm {
  factory _Scalerm.fromJson(Map<String, dynamic> json) => _$ScalermFromJson(json);
  Map<String, dynamic> toJson() => _$ScalermToJson(this);

  _Scalerm({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scalerm")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scalerm.json")
  String inifile;
}

@JsonSerializable()
class _Exc {
  factory _Exc.fromJson(Map<String, dynamic> json) => _$ExcFromJson(json);
  Map<String, dynamic> toJson() => _$ExcToJson(this);

  _Exc({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_exc")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "")
  String inifile;
}

@JsonSerializable()
class _Pct {
  factory _Pct.fromJson(Map<String, dynamic> json) => _$PctFromJson(json);
  Map<String, dynamic> toJson() => _$PctToJson(this);

  _Pct({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/pct.json")
  String inifile;
}

@JsonSerializable()
class _Hitouch {
  factory _Hitouch.fromJson(Map<String, dynamic> json) => _$HitouchFromJson(json);
  Map<String, dynamic> toJson() => _$HitouchToJson(this);

  _Hitouch({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_hitouch")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/hitouch.json")
  String inifile;
}

@JsonSerializable()
class _Ami {
  factory _Ami.fromJson(Map<String, dynamic> json) => _$AmiFromJson(json);
  Map<String, dynamic> toJson() => _$AmiToJson(this);

  _Ami({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_ami")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "")
  String inifile;
}

@JsonSerializable()
class _Scale_sks {
  factory _Scale_sks.fromJson(Map<String, dynamic> json) => _$Scale_sksFromJson(json);
  Map<String, dynamic> toJson() => _$Scale_sksToJson(this);

  _Scale_sks({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_scale_sks")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "conf/scale_sks.json")
  String inifile;
}

@JsonSerializable()
class _Aibox {
  factory _Aibox.fromJson(Map<String, dynamic> json) => _$AiboxFromJson(json);
  Map<String, dynamic> toJson() => _$AiboxToJson(this);

  _Aibox({
    required this.entry,
    required this.priority,
    required this.inifile,
  });

  @JsonKey(defaultValue: "tprdrv_aibox")
  String entry;
  @JsonKey(defaultValue: 10)
  int    priority;
  @JsonKey(defaultValue: "")
  String inifile;
}

