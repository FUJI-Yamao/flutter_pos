/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///
/// 関連tprxソース:cm_sys.h
/// Web2800機種別パラメータ
class CmSys {
  // Machine Type number in defined for MM System(cm_cksys.c)
  static const MacERR = -1; //  not follows ...
  static const MacS = 0; //  Satellite machine
  static const MacM2 = 1; //  Sub Master machine
  static const MacM1 = 2; //  Master machine
  static const MacMOnly = 3; //  Only 1 Master machine

  //  cmWebType()
  static const WEBTYPE_WEB2100 = 0; // Web2100
  static const WEBTYPE_WEBPRIME = 1; // WebPrime/WebRise
  static const WEBTYPE_WEB2200 = 2; // Web2200
  static const WEBTYPE_WEBPLUS = 3; // WebPrimePlus
  static const WEBTYPE_WEB2300 = 4; // Web2300
  static const WEBTYPE_WEB2800 = 5; // Web2800
  static const WEBTYPE_WEB2500 = 6; // Web2500
  static const WEBTYPE_WEB2350 = 7; // Web2350 (Web2300&CentOS)
  static const WEBTYPE_WEBPLUS2 = 8; // WebPrimePlus2

  //  cmWeb2800Type()
  static const WEB28TYPE_I = 0; // Web2800i
  static const WEB28TYPE_SP = 1; // WebSpeeza
  static const WEB28TYPE_IM = 2; // Web2800iM
  static const WEB28TYPE_IP = 3; // Web2800iPlus
  static const WEB28TYPE_SPP = 4; // WebSpeezaPlus
  static const WEB28TYPE_A3 = 5; // Web2800a-3
  static const WEB28TYPE_I3 = 6; // Web2800iPlus-3
  static const WEB28TYPE_SP3 = 7; // WebSpeeza-3
  static const WEB28TYPE_PR3 = 8; // WebPrime3
  static const WEB28TYPE_G3 = 9; // Web3800 G3 Series

  // TODO:Webの機種タイプ
  static const BOOT_DESKTOP = "boot_desktop";
  static const BOOT_TOWER = "boot_tower";
  static const BOOT_WEBPLUS2_DESKTOP = "boot_webplus2_desktop";
  static const BOOT_WEBPLUS2_TOWER = "boot_webplus2_tower";
  static const BOOT_WEBPLUS_DESKTOP = "boot_webplus_desktop";
  static const BOOT_WEBPLUS_TOWER = "boot_webplus_tower";
  static const BOOT_WEB2300_DESKTOP = "boot_web2300_desktop";
  static const BOOT_WEB2300_TOWER = "boot_web2300_tower";
  static const BOOT_WEB2800_DESKTOP = "boot_web2800_desktop";
  static const BOOT_WEB2800_TOWER = "boot_web2800_tower";
  static const BOOT_WEB2350_DESKTOP = "boot_web2350_desktop";
  static const BOOT_WEB2350_TOWER = "boot_web2350_tower";
  static const BOOT_WEB2500_DESKTOP = "boot_web2500_desktop";
  static const BOOT_WEB2500_TOWER = "boot_web2500_tower";
  static const BOOT_JR = "boot_jr";
  static const BOOT_JR_TOWER = "boot_jr_tower";
  static const BOOT_DUAL_DESKTOP = "boot_dual_desktop";
  static const BOOT_DUAL_TOWER = "boot_dual_tower";

  // TODO:10021 ファイルパス
  static const TYPE52KEY_D = "/etc/52key_desk.json";
  static const TYPE52KEY_T = "/etc/52key_tower.json";

  static const TYPE35KEY_D = "/etc/35key_desk.json";

  /* for cm_chk_tower() */
  static const TPR_TYPE_DESK  = 0;
  static const TPR_TYPE_TOWER  = 1;
  static const TPR_TYPE_OTHER  = 2;

  static const GODAI_RESERV = 2;

  /* cm_PrinterType() */
  static const  SUBCPU_PRINTER = 0;
  static const  TPRTS	= 1;
  static const  TPRTF = 2;
  static const  TPRTSS = 3;
  static const  TPRTIM = 4;
  static const  TPRTHP = 5;
  static const  TPRTS_NAME = "tprts";
  static const  TPRTSS_NAME	= "tprtss";
  static const  TPRTIM_NAME = "tprtim";
  static const  TPRTSS2_NAME = "tprtss2";
  static const  TPRTRP_NAME = "tprtrp";
  static const  TPRTRP2_NAME = "tprtrp2";
  static const  TPRTHP_NAME = "tprthp";
  static const 	TPRTRP_FILE = "/etc/tprtrpd_smhd.json";
  static const 	TPRTRP2_FILE = "/etc/tprtrpd2_smhd.json";
  static const  TPRTIM_FILE = "/etc/tprtim_smhd.json";
  static const  TPRTIM2_FILE = "/etc/tprtim2_smhd.json";
  static const  TPRTSS_FILE = "/etc/tprtss_smhd.json";
  static const  TPRTSS2_FILE = "/etc/tprtss2_smhd.json";
  static const  TPRTHP_FILE = "/etc/tprthp_smhd.json";
  static const  TPRTS_FILE = "/etc/tprts_smhd.json";
  static const  TPRTRP_DESK = 1;
  static const  TPRTRP_TOWER = 2;

  static const  DD_MM_YY = 0;
  static const  MM_DD_YY = 0;
  static const  YY_MM_DD = 1;

  /* 顧客リアル「Ｐアーティスト」接続 */
  static const  PARTIST_SORP = 0;
  static const  PARTIST_SOCKET = 1;

  /* Make Date Size for cm_mkdat.c */
  static const DATE_TYPE1  = 1;
  static const DATE_TYPE2  = 2;
  static const DATE_TYPE3  = 3;
  static const DATE_TYPE4  = 4;
  static const DATE_TYPE5  = 5;
  static const DATE_TYPE6  = 6;
  static const DATE_TYPE7  = 7;
  static const DATE_TYPE8  = 8;
  static const DATE_TYPE9  = 9;	 // [    年    月    日]  空の年月日
  static const DATE_TYPE10 = 10;

  //c_header_logのvarous_flg_6が2桁の為、0x40までOK
  static const CNCT_INFO_ACX = 0x01; //釣銭機接続

  // for cmWeb2800RegCruising()
  static const RIGHT_FLOW = 0;
  static const LEFT_FLOW = 1;
  static const FACE_FLOW = 2;

  /// うるう年かチェックする
  /// 引数:[year] 指定年
  /// 関連tprxソース:cm_sys.h - chk_date_leap
  static bool chkDateLeap(int year) {
    return ((year % 4 == 0) && !((year % 400 != 0) && (year % 100 == 0)));
  }
}

/// 関連tprxソース:cm_sys.h - RPOINT_STD_TYPE_LIST
enum RpointStdTypeList {
  RPOINT_STD_NON(0),	//	0: 新楽天ポイント仕様なし
  RPOINT_STD_KANEHIDE(1),	//	1: 新楽天ポイント仕様[金秀商事様向け]
  RPOINT_STD_NISHITETSU(2),	//	2: 新楽天ポイント仕様[西鉄ストア様向け]
  RPOINT_STD_SUNPLAZA(3),	//	3: 新楽天ポイント仕様[サンプラザ様向け]
  RPOINT_STD_COMODI(4),	//	4: 新楽天ポイント仕様[コモディイイダ様向け]
  RPOINT_STD_ICHII(5),	//	5: 新楽天ポイント仕様[いちい様向け]
  RPOINT_STD_MATUGEN(6),	//	6: 新楽天ポイント仕様[松源様向け]
  RPOINT_STD_USER(100);	//    100: 新楽天ポイント仕様[汎用ユーザー様向け]

  const RpointStdTypeList(this.idx);
  final int idx;
}

/// 関連tprxソース:cm_sys.h - VERIFONE_CENCNT_TYP
enum VerifoneCencntTyp {  /* Verifone電子マネー決済センター接続先 */
  VERIFONE_CENCNT_NON(-1),	/* 未接続 */
  VERIFONE_CENCNT_1(0),		/* 接続先1 */
  VERIFONE_CENCNT_2(1);		/* 接続先2 */

  const VerifoneCencntTyp(this.idx);
  final int idx;
}