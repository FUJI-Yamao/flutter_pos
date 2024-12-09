/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../inc/sys/tpr_ch_field.dart';

/// SIO Define
/// 関連tprxソース:sio01.h, sio02.h, L_sio01.h
class SioDef {
  /// SIO Define (words)
  /// token table: device (sio.json: title)
  static const NOT_USE = "使用せず";
  static const PWRCTRL = "無線LAN再起動";
  /// button label
  static const BAUD = "ﾎﾞｰﾚｰﾄ";
  static const STOPB = "ｽﾄｯﾌﾟﾋﾞｯﾄ";
  static const DATAB = "ﾚｺｰﾄﾞ長";
  static const PARI = "ﾊﾟﾘﾃｨ";
  /// button label: parity
  static const NONE = "無";
  static const ODD = "奇数";
  static const EVEN = "偶数";
  /// ej file
  static const DEVICENAME = "接続機器";
  /// sio01.dart Define
  /// log filename
  static const SIOLOG = 00000000;
  /// selection item max (from sio.json - Button *)
  static const TOOL_MAX = 54;
  /// page max
  static const PAGE_MAX = 1;
  /// sio number MAX
  static const SIONUM_MAX = 4;
  /// com name
  static const SIO_COM1 = "com1";
  static const SIO_COM2 = "com2";
  static const SIO_COM3 = "com3";
  static const SIO_COM4 = "com4";
  static const SIO_COM5 = "com5";
  static const SIO_COM6 = "com6";
  static const SIO_COM7 = "com7";
  static const SIO_COM8 = "com8";
  /// baudrate
  static const BAUD1 = "1200";
  static const BAUD2 = "2400";
  static const BAUD3 = "4800";
  static const BAUD4 = "9600";
  static const BAUD5 = "19200";
  static const BAUD6 = "38400";
  static const BAUD7 = "115200";
  static const BAUD8 = "57600";
  /// stop bit
  static const STOPB1 = "1";
  static const STOPB2 = "2";
  /// data bit
  static const DATAB1 = "7";
  static const DATAB2 = "8";
  /// Use Ch_Field Table: baudrate
  static List<TprChTbl> sioBaudTbl = [
    TprChTbl(  '1200', BAUD1, 0),
    TprChTbl(  '2400', BAUD2, 1),
    TprChTbl(  '4800', BAUD3, 2),
    TprChTbl(  '9600', BAUD4, 3),
    TprChTbl( '19200', BAUD5, 4),
    TprChTbl( '38400', BAUD6, 5),
    TprChTbl('115200', BAUD7, 6),
    TprChTbl( '57600', BAUD8, 7),
    TprChTbl('', '', -1),
  ];
  /// Use Ch_Field Table: stop bit
  static List<TprChTbl> sioStopbTbl = [
    TprChTbl('1', STOPB1, 0),
    TprChTbl('2', STOPB2, 1),
    TprChTbl('', '', -1),
  ];
  /// Use Ch_Field Table: data bit
  static List<TprChTbl> sioDatabTbl = [
    TprChTbl('7', DATAB1, 0),
    TprChTbl('8', DATAB2, 1),
    TprChTbl('', '', -1),
  ];
  /// Use Ch_Field Table: parity
  static List<TprChTbl> sioPariTbl = [
    TprChTbl('none', NONE, 0),
    TprChTbl('odd',  ODD,  1),
    TprChTbl('even', EVEN, 2),
    TprChTbl('', '', -1),
  ];
  /// driver section
  static const SIO_SEC_SG1 = "sg_scale1";
  static const SIO_SEC_SG2 = "sg_scale2";
  static const SIO_SEC_SPRKT = "sprocket";
  static const SIO_SEC_SCALE = "scale";
  static const SIO_SEC_ACR = "acr";
  static const SIO_SEC_ACB = "acb";
  static const SIO_SEC_ACB20 = "acb20";
  static const SIO_SEC_REWRIT = "rewrite";
  static const SIO_SEC_VMC = "vismac";
  static const SIO_SEC_ORC = "orc";
  static const SIO_SEC_GCAT = "gcat";
  static const SIO_SEC_DEBIT = "debit";
  static const SIO_SEC_SIP60 = "sip60";
  static const SIO_SEC_PSP60 = "psp60";
  static const SIO_SEC_STPR = "stpr";
  static const SIO_SEC_PANA = "pana";
  static const SIO_SEC_GP = "gp";
  static const SIO_SEC_SM1 = "sm_scale1";
  static const SIO_SEC_SM2 = "sm_scale2";
  static const SIO_SEC_SC = "sm_scalesc";
  static const SIO_SEC_S2PR = "s2pr";
  static const SIO_SEC_ACB50 = "acb50";
  static const SIO_SEC_PWRCTRL = "pwrctrl";
  static const SIO_SEC_PW410 = "pw410";
  static const SIO_SEC_CCR = "ccr";
  static const SIO_SEC_PSP70 = "psp70";
  static const SIO_SEC_DISH = "dish";
  static const SIO_SEC_AIV = "aiv";
  static const SIO_SEC_SCAN_PLUS_1 = "scan_plus_1";
  static const SIO_SEC_YOMOCA = "yomoca";
  static const SIO_SEC_SMTPLUS = "smtplus";
  static const SIO_SEC_SUICA = "suica";
  static const SIO_SEC_RFID = "rfid";
  static const SIO_SEC_MCP = "mcp200";
  static const SIO_SEC_FCL = "fcl";
  static const SIO_SEC_SCAN_PLUS_2 = "scan_plus_2";
  static const SIO_SEC_JRW_MULTI = "jrw_multi";
  static const SIO_SEC_HT2980 = "ht2980";
  static const SIO_SEC_ABSV31 = "absv31";
  static const SIO_SEC_SCAN_2800_2 = "scan_2800ip_2";
  static const SIO_SEC_YAMATO = "yamato";
  static const SIO_SEC_CCT = "cct";
  static const SIO_SEC_MASR = "masr";
  static const SIO_SEC_JMUPS = "jmups";
  static const SIO_SEC_FAL2 = "fal2";
  static const SIO_SEC_MST = "mst";
  static const SIO_SEC_VEGA3000 = "vega3000";
  static const SIO_SEC_CASTLES = "castles";
  static const SIO_SEC_PCT = "pct";
  /// sql
  static const LOGIN_STAFF_CD = 0;
  /// sql: SIOセクション日本語名の一覧を取得する
  static const SIO_SQL_GET_SECTIONTITLE =
      "select sioMst.drv_sec_name, imgMst.img_data "
      "from c_sio_mst sioMst left outer join c_img_mst imgMst on (imgMst.img_cd = sioMst.sio_image_cd) "
      "where imgMst.comp_cd = @comp AND imgMst.stre_cd = @stre";
  /// sql: SIO情報レコードを取得する
  static const SIO_SQL_GET_SIO_DEFAULT_DATA =
      "select sioMst.cnct_kind, sioMst.cnct_grp, sioMst.drv_sec_name, COALESCE(imgMst.img_data, ' ') as img_data, "
      "sioMst.sio_rate, sioMst.sio_stop, sioMst.sio_record, sioMst.sio_parity "
      "from c_sio_mst sioMst left outer join c_img_mst imgMst on (imgMst.img_cd = sioMst.sio_image_cd) "
      "left outer join c_reginfo_grp_mst regGrp on (regGrp.grp_cd = imgMst.img_grp_cd and regGrp.grp_typ = '6') "
      "where sioMst.cnct_grp = @cnct_grp and sioMst.drv_sec_name = @drv_sec_name";
  /// sql: SIO情報レコードを確認する
  static const SIO_SQL_CHK_SIO_DATA =
      "select * from c_sio_mst "
      "where cnct_grp = @cnct_grp and drv_sec_name = @drv_sec_name";
  /// sql: レジ接続機器SIO情報レコードを取得する
  static const SIO_SQL_GET_REGCNCT_SIO_DATA	=
      "select regcnctMst.com_port_no, regcnctMst.cnct_kind, regcnctMst.cnct_grp, "
      "sioMst.drv_sec_name, COALESCE(imgMst.img_data, ' ') as img_data, "
      "regcnctMst.sio_rate, regcnctMst.sio_stop, regcnctMst.sio_record, "
      "regcnctMst.sio_parity, regcnctMst.qcjc_flg "
      "from c_regcnct_sio_mst regcnctMst "
      "inner join c_sio_mst sioMst on (sioMst.cnct_kind = regcnctMst.cnct_kind and sioMst.cnct_grp = regcnctMst.cnct_grp) "
      "left outer join c_img_mst imgMst on (imgMst.img_cd = sioMst.sio_image_cd) "
      "left outer join c_reginfo_grp_mst regGrp on (regGrp.grp_cd = imgMst.img_grp_cd and regGrp.grp_typ = '6') "
      "where regcnctMst.comp_cd = @comp and regcnctMst.stre_cd = @stre and regcnctMst.mac_no = @mac and "
      "regcnctMst.comp_cd = regGrp.comp_cd and regcnctMst.stre_cd = regGrp.stre_cd and regcnctMst.mac_no = regGrp.mac_no "
      "order by com_port_no asc";
  /// sql: レジ接続機器SIO情報レコードを更新する
  static const SIO_SQL_UPD_REGCNCT_SIO_DATA	=
      "update c_regcnct_sio_mst "
      "set cnct_kind = @cnct_kind, cnct_grp = @cnct_grp, "
      "sio_rate = @sio_rate, sio_stop = @sio_stop, sio_record = @sio_record, "
      "sio_parity = @sio_parity, qcjc_flg = @qcjc_flg, "
      "upd_datetime = 'now', upd_user = @upd_user, upd_system = 2 "
      "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
  /// sql: レジ接続機器SIO情報レコードを追加する
  static const SIO_SQL_INS_REGCNCT_SIO_DATA =
      "insert into c_regcnct_sio_mst values ("
      "@comp, @stre, @mac, @cp_no, "
      "@cnct_kind, @cnct_grp, "
      "@sio_rate, @sio_stop, @sio_record, @sio_parity, "
      "@qcjc_flg, 'now', 'now', 0, 0, @upd_user, 2)";
  /// sql: レジ接続機器SIO情報レコードを削除する
  static const SIO_SQL_DEL_REGCNCT_SIO_DATA =
      "delete from c_regcnct_sio_mst "
      "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
  /// sql: レジ接続機器SIO情報レコードを確認する
  static const SIO_SQL_CHK_REGCNCT_SIO_DATA =
      "select * from c_regcnct_sio_mst "
      "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
  /// sql: レジ接続機器SIO情報レコードを確認する（レコード挿入、更新の確認）
  static const SIO_SQL_CHK_INSUPD_REGCNCT_SIO_DATA =
      "select * from c_regcnct_sio_mst "
      "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no "
      "and cnct_kind = @cnct_kind and cnct_grp = @cnct_grp "
      "and sio_rate = @sio_rate and sio_stop = @sio_stop "
      "and sio_record = @sio_record and sio_parity = @sio_parity "
      "and qcjc_flg = @qcjc_flg and upd_user = @upd_user";
  /// sio02.dart Define
  static const NONE_CH = '';
}

/// SIOツールテーブル
/// 関連tprxソース:sio01.h - Sio_Tool_Table
class SioToolTbl {
  /// セクション日本語タイトル（sio.json - button** - title）
  String label = '';
  /// 機器グループ（sio.json - button** - kind）
  int kind = 0;
  ///ドライバセクション名（sio.json - button** - section）
  String section = '';
  /// inifile名（sys.json - SioToolTbl.section - inifile）
  String fName = '';
  /// ボーレート（sioBaudTblの要素数: c_sio_mst - sio_rate）
  int baud = 0;
  /// ストップビット（sioStopbTblの要素数: c_sio_mst - sio_stop）
  int stopB = 0;
  /// レコード長（sioDatabTblの要素数: c_sio_mst - sio_record）
  int dataB = 0;
  /// パリティ（sioPariTblの要素数: c_sio_mst - sio_parity）
  int parity = 0;
}

/// SIOデバイス（トークン）テーブル
/// 関連tprxソース:sio01.h - Sio_Tok_Table
class SioTokTbl {
  /// 接続デバイス名（セクション日本語タイトルに相当）
  String device;
  /// ボーレート（sioBaudTblの要素数: c_regcnct_sio_mst - sio_rate）
  int baud;
  /// ストップビット（sioStopbTblの要素数: c_regcnct_sio_mst - sio_stop）
  int stopB;
  /// ストップビット（sioDatabTblの要素数: c_regcnct_sio_mst - sio_record）
  int dataB;
  /// パリティ（sioPariTblの要素数: c_regcnct_sio_mst - sio_parity）
  int parity;

  SioTokTbl(this.device, {this.baud = -1, this.stopB = -1, this.dataB = -1, this.parity = -1});
}

/// SIOセクションテーブル
/// 関連tprxソース:sio01.h - Sio_SectionTitle_Table
class SioSectTbl {
  /// ドライバセクション名（c_sio_mst - drv_sec_name）
  String sectionName = '';
  /// セクション日本語タイトル（c_img_mst - img_data）
  String titleName = '';
}

/// SIO画面のボタンパラメタ【フロント連携】
class Sio01BtnStat {
  /// ボタン表示有無：SIO#1~4
  bool sioOutput = false;
  /// ボタンラベル：SIO No（SIO #1~）
  String sio = '';
  /// ボタンラベル：ボーレート
  String baud = '';
  /// ボタンラベル：ストップビット
  String stopB = '';
  /// ボタンラベル：レコード長
  String dataB = '';
  /// ボタンラベル：パリティ
  String parity = '';
  /// ボタン表示有無：ボーレート、ストップビット、レコード長、パリティ
  bool slvOutput = false;
}

/// SIO接続機器一覧画面のボタンパラメタ【フロント連携】
class Sio02BtnStat {
  /// 画面タイトルラベル
  String titleLbl = '';
  /// SIO接続機器ボタン
  List<String> btnLbl = List.generate(SioDef.TOOL_MAX, (index) => '');
  /// 次頁、前頁ボタン表示有無（true:表示  false:非表示）
  bool toPageOutput = false;
  /// 画面現ページ
  int pageLbl = 1;
}