/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: db_newdays.h
class DbNewdays {
  static const String ND_ITEM_NAME = "c_plu_newdays_mst";

  static const String SQL_ND_ITEM = "CREATE TABLE %s ("
    "  stre_cd                   numeric(6),"
    "  plu_cd                    char(13),"
    "  kas_cd                    numeric(7),"
    "  tenpo_binlbl_cd           varchar(13),"
    "  tenpo_syohin_cd           varchar(7),"
    "  tenpo_seisikimeisyo_kanji varchar(36),"
    "  tenpo_seisikimeisyo_kana  varchar(20),"
    "  tenpo_baika               numeric(7),"
    "  tenpo_bumon_cd            numeric(2),"
    "  tenpo_plu_baika           numeric(7),"
    "  hin_cd                    numeric(2),"
    "  hin_meisyo_kanji          varchar(30),"
    "  daibun_cd                 numeric(2),"
    "  daibun_meisyo_kanji       varchar(30),"
    "  cyubun_cd                 numeric(2),"
    "  cyubun_meisyo_kanji       varchar(30),"
    "  syobun_cd                 numeric(2),"
    "  syobun_meisyo_kanji       varchar(30),"
    "  saibun_cd                 numeric(2),"
    "  saibun_meisyo_kanji       varchar(30),"
    "  PRIMARY KEY (stre_cd,plu_cd) );";
}