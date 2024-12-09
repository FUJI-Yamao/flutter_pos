/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';

/// on database created
/// 引数:なし
/// 戻り値:なし
/// DBがなかった場合にこのメソッドが呼びだされて初期化処理をします
FutureOr _onCreate(db, value) async {
  //Write here on database created
  //region 01_基本マスタ系
  /// 01_1	企業マスタ	c_comp_mst
  await db.execute('''create table c_comp_mst (
      comp_cd INTEGER  not null
      , comp_typ INTEGER  default 0 not null
      , rtr_id INTEGER  default 0 not null
      , name TEXT
      , short_name TEXT
      , kana_name TEXT
      , post_no TEXT
      , adress1 TEXT
      , adress2 TEXT
      , adress3 TEXT
      , telno1 TEXT
      , telno2 TEXT
      , srch_telno1 TEXT
      , srch_telno2 TEXT
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER  default 0 not null
      , send_flg INTEGER  default 0 not null
      , upd_user INTEGER  default 0 not null
      , upd_system INTEGER  default 0 not null
      , primary key (comp_cd)
    )''');

  /// 01_2	店舗マスタ	c_stre_mst
  await db.execute('''create table c_stre_mst (
    stre_cd INTEGER not null
    , comp_cd INTEGER not null
    , zone_cd INTEGER default 0 not null
    , bsct_cd INTEGER default 0 not null
    , name TEXT
    , short_name TEXT
    , kana_name TEXT
    , post_no TEXT
    , adress1 TEXT
    , adress2 TEXT
    , adress3 TEXT
    , telno1 TEXT
    , telno2 TEXT
    , srch_telno1 TEXT
    , srch_telno2 TEXT
    , ip_addr TEXT
    , trends_typ INTEGER default 0 not null
    , stre_typ INTEGER default 0 not null
    , flg_shp INTEGER default 0 not null
    , business_typ1 INTEGER default 0 not null
    , business_typ2 INTEGER default 0 not null
    , chain_other_flg INTEGER default 0 not null
    , locate_typ INTEGER default 0 not null
    , openclose_flg INTEGER default 0 not null
    , opentime TEXT
    , closetime TEXT
    , floorspace REAL default 0 not null
    , today TEXT
    , bfrday TEXT
    , twodaybfr TEXT
    , nextday TEXT
    , sysflg_base INTEGER default 0 not null
    , sysflg_sale INTEGER default 0 not null
    , sysflg_purchs INTEGER default 0 not null
    , sysflg_order INTEGER default 0 not null
    , sysflg_invtry INTEGER default 0 not null
    , sysflg_cust INTEGER default 0 not null
    , sysflg_poppy INTEGER default 0 not null
    , sysflg_elslbl INTEGER default 0 not null
    , sysflg_fresh INTEGER default 0 not null
    , sysflg_wdslbl INTEGER default 0 not null
    , sysflg_24hour INTEGER default 0 not null
    , showorder INTEGER default 0 not null
    , opendate TEXT
    , stre_ver_flg INTEGER default 0 not null
    , sunday_off_flg INTEGER default 0 not null
    , monday_off_flg INTEGER default 0 not null
    , tuesday_off_flg INTEGER default 0 not null
    , wednesday_off_flg INTEGER default 0 not null
    , thursday_off_flg INTEGER default 0 not null
    , friday_off_flg INTEGER default 0 not null
    , saturday_off_flg INTEGER default 0 not null
    , itemstock_flg INTEGER default 0 not null
    , wait_time TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , entry_no TEXT
    , primary key (stre_cd, comp_cd)
    )''');

  /// 01_3	店舗通信マスタ	c_connect_mst
  await db.execute('''create table c_connect_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , connect_cd INTEGER not null
    , connect_typ INTEGER default 0 not null
    , name TEXT
    , short_name TEXT
    , kana_name TEXT
    , host_name TEXT
    , opentime TEXT
    , closetime TEXT
    , format_typ INTEGER default 0 not null
    , network_typ INTEGER default 0 not null
    , telno1 TEXT
    , telno2 TEXT
    , srch_telno1 TEXT
    , srch_telno2 TEXT
    , ip_addr TEXT
    , retry_cnt INTEGER default 0 not null
    , retry_time INTEGER default 0 not null
    , time_out INTEGER default 0 not null
    , ftp_put_dir TEXT
    , ftp_get_dir TEXT
    , connect_time1 INTEGER default 0 not null
    , connect_time2 INTEGER default 0 not null
    , cnt_usr TEXT
    , cnt_pwd TEXT
    , wait_time1 INTEGER default 0 not null
    , wait_time2 INTEGER default 0 not null
    , cnt_interval1 INTEGER default 0 not null
    , cnt_interval2 INTEGER default 0 not null
    , stre_chk_dgt INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, connect_cd)
      )''');

  /// 01_4	分類マスタ	c_cls_mst
  await db.execute('''create table c_cls_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , cls_typ INTEGER not null
    , lrgcls_cd INTEGER not null
    , mdlcls_cd INTEGER not null
    , smlcls_cd INTEGER not null
    , tnycls_cd INTEGER not null
    , plu_cd TEXT
    , cls_flg INTEGER default 0 not null
    , tax_cd1 INTEGER default 0 not null
    , tax_cd2 INTEGER default 0 not null
    , tax_cd3 INTEGER default 0 not null
    , tax_cd4 INTEGER default 0 not null
    , name TEXT
    , short_name TEXT
    , kana_name TEXT
    , margin_flg INTEGER default 0 not null
    , regsale_flg INTEGER default 0 not null
    , clothdeal_flg INTEGER default 0 not null
    , dfltcls_cd INTEGER default 0 not null
    , msg_name TEXT
    , pop_msg TEXT
    , nonact_flg INTEGER default 0 not null
    , max_prc INTEGER default 0 not null
    , min_prc INTEGER default 0 not null
    , cost_per REAL default 0 not null
    , loss_per REAL default 0 not null
    , rbtpremium_per REAL default 1.00 not null
    , prc_chg_flg INTEGER default 0 not null
    , rbttarget_flg INTEGER default 0 not null
    , stl_dsc_flg INTEGER default 0 not null
    , labeldept_cd INTEGER default 0 not null
    , multprc_flg INTEGER default 0 not null
    , multprc_per REAL default 0 not null
    , sch_flg INTEGER default 0 not null
    , stlplus_flg INTEGER default 0 not null
    , pctr_tckt_flg INTEGER default 0 not null
    , clothing_flg INTEGER default 0 not null
    , spclsdsc_flg INTEGER default 0 not null
    , bdl_dsc_flg INTEGER default 0 not null
    , self_alert_flg INTEGER default 0 not null
    , chg_ckt_flg INTEGER default 0 not null
    , self_weight_flg INTEGER default 0 not null
    , msg_flg INTEGER default 0 not null
    , pop_msg_flg INTEGER default 0 not null
    , itemstock_flg INTEGER default 0 not null
    , orderpatrn_flg INTEGER default 0 not null
    , orderbook_flg INTEGER default 0 not null
    , safestock_per REAL default 0 not null
    , autoorder_typ INTEGER default 0 not null
    , casecntup_typ INTEGER default 0 not null
    , producer_cd INTEGER default 0 not null
    , cust_dtl_flg INTEGER default 0 not null
    , coupon_flg INTEGER default 0 not null
    , kitchen_prn_flg INTEGER default 0 not null
    , pricing_flg INTEGER default 0 not null
    , user_val_1 INTEGER default 0 not null
    , user_val_2 INTEGER default 0 not null
    , user_val_3 INTEGER default 0 not null
    , user_val_4 INTEGER default 0 not null
    , user_val_5 INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , tax_exemption_flg INTEGER default 0 not null
    , dpnt_rbttarget_flg INTEGER default 0 not null
    , dpnt_usetarget_flg INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, cls_typ, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd)
      )''');

  /// 01_5	分類グループマスタ	c_grp_mst
  await db.execute('''create table c_grp_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , cls_grp_cd INTEGER not null
    , mdl_smlcls_cd INTEGER not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, cls_grp_cd, mdl_smlcls_cd)
      )''');

  /// 01_6	郵便番号マスタ	c_zipcode_mst
  await db.execute('''create table c_zipcode_mst (
    serial_no INTEGER not null
    , post_no TEXT
    , address1 TEXT
    , address2 TEXT
    , address3 TEXT
    , kana_address1 TEXT
    , kana_address2 TEXT
    , kana_address3 TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (serial_no)
      )''');

  /// 01_7	税金テーブルマスタ	c_tax_mst
  await db.execute('''create table c_tax_mst (
      comp_cd INTEGER not null
      , tax_cd INTEGER not null
      , tax_name TEXT
      , tax_typ INTEGER default 0 not null
      , odd_flg INTEGER default 0 not null
      , tax_per REAL default 0 not null
      , mov_cd INTEGER default 0 not null
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , primary key (comp_cd, tax_cd)
      )''');

  /// 01_8	カレンダーマスタ	c_caldr_mst
  await db.execute('''create table c_caldr_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , caldr_date TEXT not null
    , dayoff_flg INTEGER default 0 not null
    , comment1 TEXT
    , comment2 TEXT
    , am_weather INTEGER default 0 not null
    , pm_weather INTEGER default 0 not null
    , min_temp REAL default 0 not null
    , max_temp REAL default 0 not null
    , close_flg INTEGER default 0 not null
    , open_rslt INTEGER default 0 not null
    , close_rslt INTEGER default 0 not null
    , rsrv_cust INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , rsrv_cust_ai INTEGER
    , primary key (comp_cd, stre_cd, caldr_date)
      )''');

  /// 01_9	祝日マスタ	s_nathldy_mst
  await db.execute('''create table s_nathldy_mst (
    caldr_date TEXT not null
    , comment1 TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (caldr_date)
      )''');

  /// 01_10	サブ1分類マスタ	c_sub1_cls_mst
  await db.execute('''create table c_sub1_cls_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , cls_typ INTEGER not null
    , sub1_lrg_cd INTEGER not null
    , sub1_mdl_cd INTEGER not null
    , sub1_sml_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , kana_name TEXT
    , rbttarget_flg INTEGER default 0 not null
    , stl_dsc_flg INTEGER default 0 not null
    , stlplus_flg INTEGER default 0 not null
    , pctr_tckt_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , rbtpremium_per REAL default 1.00 not null
    , primary key (comp_cd, stre_cd, cls_typ, sub1_lrg_cd, sub1_mdl_cd, sub1_sml_cd)
      )''');

  /// 01_11	サブ2分類マスタ	c_sub2_cls_mst
  await db.execute('''create table c_sub2_cls_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , cls_typ INTEGER not null
    , sub2_lrg_cd INTEGER not null
    , sub2_mdl_cd INTEGER not null
    , sub2_sml_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , kana_name TEXT
    , rbttarget_flg INTEGER default 0 not null
    , stl_dsc_flg INTEGER default 0 not null
    , stlplus_flg INTEGER default 0 not null
    , pctr_tckt_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , rbtpremium_per REAL default 1.00 not null
    , primary key (comp_cd, stre_cd, cls_typ, sub2_lrg_cd, sub2_mdl_cd, sub2_sml_cd)
      )''');
  //endregion
  //region 02_販売マスタ系
  /// 02_1	商品マスタ	c_plu_mst
  await db.execute('''create table c_plu_mst (
      comp_cd INTEGER not null
      , stre_cd INTEGER not null
      , plu_cd TEXT not null
      , lrgcls_cd INTEGER default 0 not null
      , mdlcls_cd INTEGER default 0 not null
      , smlcls_cd INTEGER default 0 not null
      , tnycls_cd INTEGER default 0 not null
      , eos_cd TEXT
      , bar_typ INTEGER default 0 not null
      , item_typ INTEGER default 0 not null
      , item_name TEXT
      , pos_name TEXT
      , list_typcapa TEXT
      , list_prc INTEGER default 0 not null
      , instruct_prc INTEGER default 0 not null
      , pos_prc INTEGER default 0 not null
      , cust_prc INTEGER default 0 not null
      , cost_prc REAL default 0 not null
      , chk_amt INTEGER default 0 not null
      , tax_cd_1 INTEGER default 0 not null
      , tax_cd_2 INTEGER default 0 not null
      , tax_cd_3 INTEGER default 0 not null
      , tax_cd_4 INTEGER default 0 not null
      , cost_tax_cd INTEGER default 0 not null
      , cost_per REAL default 0 not null
      , rbtpremium_per REAL default 1.00 not null
      , nonact_flg INTEGER default 0 not null
      , prc_chg_flg INTEGER default 0 not null
      , rbttarget_flg INTEGER default 0 not null
      , stl_dsc_flg INTEGER default 0 not null
      , weight_cnt INTEGER default 0 not null
      , plu_tare INTEGER default 0 not null
      , self_cnt_flg INTEGER default 0 not null
      , guara_month INTEGER default 0 not null
      , multprc_flg INTEGER default 0 not null
      , multprc_per REAL default 0 not null
      , weight_flg INTEGER default 0 not null
      , mbrdsc_flg INTEGER default 0 not null
      , mbrdsc_prc INTEGER default 0 not null
      , mny_tckt_flg INTEGER default 0 not null
      , stlplus_flg INTEGER default 0 not null
      , prom_tckt_no INTEGER default 0 not null
      , weight INTEGER default 0 not null
      , pctr_tckt_flg INTEGER default 0 not null
      , btl_prc INTEGER default 0 not null
      , clsdsc_flg INTEGER default 0 not null
      , cpn_flg INTEGER default 0 not null
      , cpn_prc INTEGER default 0 not null
      , plu_cd_flg INTEGER default 0 not null
      , self_alert_flg INTEGER default 0 not null
      , chg_ckt_flg INTEGER default 0 not null
      , self_weight_flg INTEGER default 0 not null
      , msg_name TEXT
      , msg_flg INTEGER default 0 not null
      , msg_name_cd INTEGER default 0 not null
      , pop_msg TEXT
      , pop_msg_flg INTEGER default 0 not null
      , pop_msg_cd INTEGER default 0 not null
      , liqrcls_cd INTEGER default 0 not null
      , liqr_typcapa INTEGER default 0 not null
      , alcohol_per REAL default 0 not null
      , liqrtax_cd INTEGER default 0 not null
      , use1_start_date TEXT
      , use2_start_date TEXT
      , prc_exe_flg INTEGER default 0 not null
      , tmp_exe_flg INTEGER default 0 not null
      , cust_dtl_flg INTEGER default 0 not null
      , tax_exemption_flg INTEGER default 0 not null
      , point_add INTEGER default 0 not null
      , coupon_flg INTEGER default 0 not null
      , kitchen_prn_flg INTEGER default 0 not null
      , pricing_flg INTEGER default 0 not null
      , bc_tckt_cnt INTEGER default 0 not null
      , last_sale_datetime TEXT
      , maker_cd INTEGER default 0 not null
      , user_val_1 INTEGER default 0 not null
      , user_val_2 INTEGER default 0 not null
      , user_val_3 INTEGER default 0 not null
      , user_val_4 INTEGER default 0 not null
      , user_val_5 INTEGER default 0 not null
      , user_val_6 TEXT
      , prc_upd_system INTEGER default 0 not null
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , cust_prc2 INTEGER default 0 not null
      , mbrdsc_prc2 INTEGER default 0 not null
      , producer_cd INTEGER default 0 not null
      , certificate_typ INTEGER default 0 not null
      , kind_cd INTEGER default 0 not null
      , div_cd INTEGER default 0 not null
      , sub1_lrg_cd INTEGER default 0 not null
      , sub1_mdl_cd INTEGER default 0 not null
      , sub1_sml_cd INTEGER default 0 not null
      , sub2_lrg_cd INTEGER default 0 not null
      , sub2_mdl_cd INTEGER default 0 not null
      , sub2_sml_cd INTEGER default 0 not null
      , disc_cd INTEGER default 0 not null
      , typ_no TEXT
      , dlug_flg INTEGER default 0 not null
      , otc_flg INTEGER default 0 not null
      , item_flg1 INTEGER default 0 not null
      , item_flg2 INTEGER default 0 not null
      , item_flg3 INTEGER default 0 not null
      , item_flg4 INTEGER default 0 not null
      , item_flg5 INTEGER default 0 not null
      , item_flg6 INTEGER default 0 not null
      , item_flg7 INTEGER default 0 not null
      , item_flg8 INTEGER default 0 not null
      , item_flg9 INTEGER default 0 not null
      , item_flg10 INTEGER default 0 not null
      , dpnt_rbttarget_flg INTEGER default 0 not null
      , dpnt_usetarget_flg INTEGER default 0 not null
      , primary key (comp_cd, stre_cd, plu_cd)
        )''');

  /// 02_2	スキャニングＰＬＵテーブル	c_scanplu_mst
  await db.execute('''create table c_scanplu_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , sku_cd TEXT not null
    , plu_cd TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, sku_cd)
      )''');

  /// 02_3	セット商品マスタ	c_setitem_mst
  await db.execute('''create table c_setitem_mst (
    comp_cd INTEGER not null
    , setplu_cd TEXT not null
    , plu_cd TEXT not null
    , item_qty INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, setplu_cd, plu_cd)
      )''');

  /// 02_4	ケース商品マスタ	c_caseitem_mst
  await db.execute('''create table c_caseitem_mst (
    comp_cd INTEGER not null
    , caseitem_cd TEXT not null
    , plu_cd TEXT
    , item_qty INTEGER default 0 not null
    , val_prc INTEGER default 0 not null
    , case_typ INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, caseitem_cd)
      )''');

  /// 02_5	属性マスタ	c_attrib_mst
  await db.execute('''create table c_attrib_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , attrib_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , hq_send_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, attrib_cd)
      )''');

  /// 02_6	属性商品マスタ	c_attribitem_mst
  await db.execute('''create table c_attribitem_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , attrib_cd INTEGER not null
    , plu_cd TEXT not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, attrib_cd, plu_cd)
      )''');

  /// 02_7	酒類分類マスタ	c_liqrcls_mst
  await db.execute('''create table c_liqrcls_mst (
    comp_cd INTEGER not null
    , liqrcls_cd INTEGER not null
    , liqrcls_name TEXT
    , prn_order INTEGER default 0 not null
    , odd_flg INTEGER default 0 not null
    , vcnmng INTEGER default 0 not null
    , amt_prn INTEGER default 0 not null
    , amtclr_flg INTEGER default 0 not null
    , powliqr_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, liqrcls_cd)
      )''');

  /// 02_8	産地・メーカーマスタ	c_maker_mst
  await db.execute('''create table c_maker_mst (
    comp_cd INTEGER not null
    , maker_cd INTEGER not null
    , parentmaker_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , kana_name TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, maker_cd, parentmaker_cd)
      )''');

  /// 02_9	生産者品目マスタ	c_producer_mst
  await db.execute('''create table c_producer_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , producer_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , tax_cd INTEGER default 0 not null
    , producer_misc_1 INTEGER default 0 not null
    , producer_misc_2 INTEGER default 0 not null
    , producer_misc_3 INTEGER default 0 not null
    , producer_misc_4 INTEGER default 0 not null
    , producer_misc_5 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, producer_cd)
      )''');

  /// 酒品目マスタ c_liqritem_mst
  await db.execute('''create table c_liqritem_mst (
    comp_cd INTEGER
    , liqritem_cd INTEGER
    , liqritem_name1 TEXT
    , liqritem_name2 TEXT
    , liqritem_name3 TEXT
    , powliqr_flg  INTEGER default 0 not null
    , data_c_01 TEXT
    , data_c_02 TEXT
    , data_n_01 INTEGER
    , data_n_02 INTEGER
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd,liqritem_cd)
      )''');

  /// 酒税マスタ c_liqrtax_mst
  await db.execute('''create table c_liqrtax_mst (
    comp_cd INTEGER
    , liqrtax_cd INTEGER
    , liqrtax_name TEXT
    , liqrtax_rate INTEGER default 0 not null
    , liqrtax_alc REAL default 0 not null
    , liqrtax_add REAL default 0 not null
    , liqrtax_add_amt INTEGER default 0 not null
    , liqrtax_odd_flg INTEGER default 2 not null
    , data_c_01 TEXT
    , data_n_01 INTEGER
    , data_n_02 INTEGER
    , data_n_03 REAL
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd,liqrtax_cd)
      )''');
  //endregion
  //region 03_POS基本マスタ系
  /// 03_1	レジ情報マスタ	c_reginfo_mst
  await db.execute('''create table c_reginfo_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , mac_typ INTEGER default 0 not null
    , mac_addr TEXT
    , ip_addr TEXT
    , brdcast_addr TEXT
    , ip_addr2 TEXT
    , brdcast_addr2 TEXT
    , org_mac_no INTEGER default 0 not null
    , crdt_trm_cd TEXT
    , set_owner_flg INTEGER default 0 not null
    , mac_role1 INTEGER default 0 not null
    , mac_role2 INTEGER default 0 not null
    , mac_role3 INTEGER default 0 not null
    , pbchg_flg INTEGER default 0 not null
    , auto_opn_cshr_cd INTEGER default 0 not null
    , auto_opn_chkr_cd INTEGER default 0 not null
    , auto_cls_cshr_cd INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , mac_name TEXT
    , primary key (comp_cd, stre_cd, mac_no)
      )''');

  /// 03_2	レジ開閉店情報マスタ	c_openclose_mst
  await db.execute('''create table c_openclose_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , sale_date TEXT not null
    , open_flg INTEGER default 0 not null
    , close_flg INTEGER default 0 not null
    , not_update_flg INTEGER default 0 not null
    , log_not_sndflg INTEGER default 0 not null
    , custlog_not_sndflg INTEGER default 0 not null
    , custlog_not_delflg INTEGER default 0 not null
    , stepup_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , pos_ver TEXT
    , pos_sub_ver TEXT
    , recal_flg INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, sale_date)
      )''');

  /// 03_3	レジ接続機器SIO情報マスタ	c_regcnct_sio_mst
  await db.execute('''create table c_regcnct_sio_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , com_port_no INTEGER not null
    , cnct_kind INTEGER default 0 not null
    , cnct_grp INTEGER default 0 not null
    , sio_rate INTEGER default 0 not null
    , sio_stop INTEGER default 0 not null
    , sio_record INTEGER default 0 not null
    , sio_parity INTEGER default 0 not null
    , qcjc_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, com_port_no)
      )''');

  /// 03_4	SIO情報マスタ	c_sio_mst
  await db.execute('''create table c_sio_mst (
    cnct_kind INTEGER not null
    , cnct_grp INTEGER default 0 not null
    , drv_sec_name TEXT not null
    , sio_image_cd INTEGER default 0 not null
    , sio_rate INTEGER default 0 not null
    , sio_stop INTEGER default 0 not null
    , sio_record INTEGER default 0 not null
    , sio_parity INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (cnct_kind)
      )''');

  /// 03_5	レジ情報グループ管理マスタ	c_reginfo_grp_mst
  await db.execute('''create table c_reginfo_grp_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , grp_typ INTEGER not null
    , grp_cd INTEGER default 0
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, grp_typ)
      )''');

  /// 03_6	イメージマスタ	c_img_mst
  await db.execute('''create table c_img_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , img_grp_cd INTEGER not null
    , img_cd INTEGER not null
    , img_data TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, img_grp_cd, img_cd)
      )''');

  /// 03_7	プリセットキーマスタ	c_preset_mst
  await db.execute('''create table c_preset_mst (
      comp_cd INTEGER not null
      , stre_cd INTEGER not null
      , preset_grp_cd INTEGER not null
      , preset_cd INTEGER not null
      , preset_no INTEGER not null
      , presetcolor INTEGER default 0 not null
      , ky_cd INTEGER default 0 not null
      , ky_plu_cd TEXT
      , ky_smlcls_cd INTEGER default 0 not null
      , ky_size_flg INTEGER default 0 not null
      , ky_status INTEGER default 0 not null
      , ky_name TEXT
      , img_num INTEGER default 0 not null
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , primary key (comp_cd, stre_cd, preset_grp_cd, preset_cd, preset_no)
    )''');

  /// 03_8	画像プリセットマスタ	c_preset_img_mst
  await db.execute('''create table c_preset_img_mst (
      comp_cd INTEGER not null
      , img_num INTEGER not null
      , cls_cd INTEGER default 0 not null
      , typ INTEGER default 0 not null
      , name TEXT
      , size1 INTEGER default 0 not null
      , size2 INTEGER default 0 not null
      , color INTEGER default 0 not null
      , contrast INTEGER default 0 not null
      , memo TEXT
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , primary key (comp_cd, img_num)
      )''');

  /// 03_9	共通コントロールマスタ	c_ctrl_mst
  await db.execute('''create table c_ctrl_mst (
    comp_cd INTEGER not null
    , ctrl_cd INTEGER not null
    , ctrl_data REAL default 0 not null
    , data_typ INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, ctrl_cd)
      )''');

  /// 03_10	共通コントロール設定マスタ	c_ctrl_set_mst
  await db.execute('''create table c_ctrl_set_mst (
    ctrl_cd INTEGER not null
    , ctrl_name TEXT
    , ctrl_dsp_cond INTEGER default 0 not null
    , ctrl_inp_cond INTEGER default 0 not null
    , ctrl_limit_max REAL default 0 not null
    , ctrl_limit_min REAL default 0 not null
    , ctrl_digits INTEGER default 0 not null
    , ctrl_zero_typ INTEGER default 0 not null
    , ctrl_btn_color INTEGER default 0 not null
    , ctrl_info_comment TEXT
    , ctrl_info_pic INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (ctrl_cd)
      )''');

  /// 03_11	共通コントロールサブマスタ	c_ctrl_sub_mst
  await db.execute('''create table c_ctrl_sub_mst (
    ctrl_cd INTEGER not null
    , ctrl_ordr INTEGER not null
    , ctrl_data REAL default 0 not null
    , img_cd INTEGER default 0 not null
    , ctrl_comment TEXT
    , ctrl_btn_color INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (ctrl_cd, ctrl_ordr)
      )''');

  /// 03_12	ターミナルマスタ	c_trm_mst
  await db.execute('''create table c_trm_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , trm_grp_cd INTEGER not null
    , trm_cd INTEGER not null
    , trm_data REAL default 0 not null
    , trm_data_typ INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, trm_grp_cd, trm_cd)
      )''');

  /// 03_13	ターミナル設定マスタ	c_trm_set_mst
  await db.execute('''create table c_trm_set_mst (
    trm_cd INTEGER not null
    , trm_name TEXT
    , trm_dsp_cond INTEGER default 0 not null
    , trm_inp_cond INTEGER default 0 not null
    , trm_limit_max REAL default 0 not null
    , trm_limit_min REAL default 0 not null
    , trm_digits INTEGER default 0 not null
    , trm_zero_typ INTEGER default 0 not null
    , trm_btn_color INTEGER default 0 not null
    , trm_info_comment TEXT
    , trm_info_pic INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (trm_cd)
      )''');

  /// 03_14	ターミナルサブマスタ	c_trm_sub_mst
  await db.execute('''create table c_trm_sub_mst (
    trm_cd INTEGER not null
    , trm_ordr INTEGER not null
    , trm_data REAL default 0 not null
    , fnc_cd INTEGER default 0 not null
    , img_cd INTEGER default 0 not null
    , trm_comment TEXT
    , trm_btn_color INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (trm_cd, trm_ordr)
      )''');

  /// 03_15	ターミナルメニューマスタ	c_trm_menu_mst
  await db.execute('''create table c_trm_menu_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , menu_kind INTEGER not null
    , trm_title TEXT
    , trm_btn_max INTEGER default 0 not null
    , trm_page INTEGER not null
    , trm_btn_pos INTEGER not null
    , trm_btn_name TEXT
    , trm_btn_color INTEGER default 0 not null
    , trm_menu INTEGER default 0 not null
    , trm_tag INTEGER default 0 not null
    , trm_quick INTEGER default 0 not null
    , cust_disp_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, menu_kind, trm_page, trm_btn_pos)
      )''');

  /// 03_16	ターミナルタググループマスタ	c_trm_tag_grp_mst
  await db.execute('''create table c_trm_tag_grp_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , trm_tag INTEGER not null
    , trm_ordr INTEGER not null
    , trm_cd INTEGER not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, trm_tag, trm_ordr, trm_cd)
      )''');

  /// 03_17	ファンクションキーマスタ	c_keyfnc_mst
  await db.execute('''create table c_keyfnc_mst (
      comp_cd INTEGER not null
      , stre_cd INTEGER not null
      , kopt_grp_cd INTEGER not null
      , fnc_cd INTEGER not null
      , fnc_name TEXT
      , fnc_comment TEXT
      , fnc_disp_flg INTEGER default 0 not null
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , ext_preset_disp INTEGER default 0 not null
      , primary key (comp_cd, stre_cd, kopt_grp_cd, fnc_cd)
      )''');

  /// 03_18	キーオプションマスタ	c_keyopt_mst
  await db.execute('''create table c_keyopt_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , kopt_grp_cd INTEGER not null
    , fnc_cd INTEGER not null
    , kopt_cd INTEGER not null
    , kopt_data INTEGER default 0 not null
    , kopt_str_data TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, kopt_grp_cd, fnc_cd, kopt_cd)
      )''');

  /// 03_19	キー種別マスタ	c_keykind_mst
  await db.execute('''create table c_keykind_mst (
    key_kind_cd INTEGER not null
    , kind_name TEXT
    , primary key (key_kind_cd)
      )''');

  /// 03_20	キー種別管理マスタ	c_keykind_grp_mst
  await db.execute('''create table c_keykind_grp_mst (
      key_kind_cd INTEGER not null
      , fnc_cd INTEGER not null
      , ref_fnc_cd INTEGER not null
      , primary key (key_kind_cd, fnc_cd)
      )''');

  /// 03_21	キーオプション設定マスタ	c_keyopt_set_mst
  await db.execute('''create table c_keyopt_set_mst (
    ref_fnc_cd INTEGER not null
    , kopt_cd INTEGER not null
    , kopt_name TEXT
    , kopt_dsp_cond INTEGER default 0 not null
    , kopt_inp_cond INTEGER default 0 not null
    , kopt_limit_max INTEGER default 0 not null
    , kopt_limit_min INTEGER default 0 not null
    , kopt_digits INTEGER default 0 not null
    , kopt_zero_typ INTEGER default 0 not null
    , kopt_btn_color INTEGER default 0 not null
    , kopt_info_comment TEXT
    , kopt_info_pic INTEGER default 0 not null
    , kopt_div_kind_cd INTEGER default 0 not null
    , primary key (ref_fnc_cd, kopt_cd)
      )''');

  /// 03_22	キーオプションサブマスタ	c_keyopt_sub_mst
  await db.execute('''create table c_keyopt_sub_mst (
    ref_fnc_cd INTEGER not null
    , kopt_cd INTEGER not null
    , koptsub_ordr INTEGER not null
    , koptsub_data INTEGER default 0 not null
    , fnc_cd INTEGER default 0 not null
    , img_cd INTEGER default 0 not null
    , koptsub_comment TEXT
    , koptsub_btn_color INTEGER default 0 not null
    , primary key (ref_fnc_cd, kopt_cd, koptsub_ordr)
      )''');

  /// 03_23	区分マスタ	c_divide_mst
  await db.execute('''create table c_divide_mst (
    comp_cd INTEGER not null
    , kind_cd INTEGER not null
    , div_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , exp_cd1 INTEGER not null
    , exp_cd2 INTEGER not null
    , exp_data TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , exp_amt INTEGER default 0 not null
    , primary key (comp_cd, kind_cd, div_cd)
      )''');

  /// 03_24	仮登録ログ	c_tmp_log
  await db.execute('''create table c_tmp_log (
    serial_no TEXT not null
    , seq_no INTEGER default 0 not null
    , comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER default 0 not null
    , cshr_cd INTEGER default 0 not null
    , plu_cd TEXT
    , lrgcls_cd INTEGER default 0 not null
    , mdlcls_cd INTEGER default 0 not null
    , smlcls_cd INTEGER default 0 not null
    , dflttnycls_cd INTEGER default 0 not null
    , u_prc INTEGER default 0 not null
    , item_name TEXT
    , tran_flg INTEGER default 0 not null
    , sub_tran_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (serial_no, seq_no, comp_cd, stre_cd)
      )''');

  /// 03_25	売価変更マスタ	c_prcchg_mst
  await db.execute('''create table c_prcchg_mst (
    serial_no TEXT not null
    , seq_no INTEGER default 0 not null
    , comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , plu_cd TEXT
    , pos_prc INTEGER default 0 not null
    , cust_prc INTEGER default 0 not null
    , mac_no INTEGER default 0 not null
    , staff_cd INTEGER default 0 not null
    , maker_cd INTEGER default 0 not null
    , tran_flg INTEGER default 0 not null
    , sub_tran_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (serial_no, seq_no, comp_cd, stre_cd)
      )''');

  /// 03_26	予約レポートマスタ	c_batrepo_mst
  await db.execute('''create table c_batrepo_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , batch_grp_cd INTEGER not null
    , batch_no INTEGER not null
    , report_ordr INTEGER not null
    , batch_flg INTEGER default 0 not null
    , batch_name TEXT
    , batch_report_no INTEGER default 0 not null
    , condi_typ1 INTEGER default 0 not null
    , condi_typ2 INTEGER default 0 not null
    , condi_typ3 INTEGER default 0 not null
    , condi_typ4 INTEGER default 0 not null
    , condi_typ5 INTEGER default 0 not null
    , condi_typ6 INTEGER default 0 not null
    , condi_typ7 INTEGER default 0 not null
    , condi_typ8 INTEGER default 0 not null
    , condi_typ9 INTEGER default 0 not null
    , out_dvc_flg INTEGER default 0 not null
    , batch_flg2 INTEGER default 0 not null
    , condi_start1 INTEGER default 0 not null
    , condi_end1 INTEGER default 0 not null
    , condi_start2 INTEGER default 0 not null
    , condi_end2 INTEGER default 0 not null
    , condi_start3 INTEGER default 0 not null
    , condi_end3 INTEGER default 0 not null
    , condi_start4 INTEGER default 0 not null
    , condi_end4 INTEGER default 0 not null
    , condi_start5 INTEGER default 0 not null
    , condi_end5 INTEGER default 0 not null
    , condi_start6 INTEGER default 0 not null
    , condi_end6 INTEGER default 0 not null
    , condi_start7 INTEGER default 0 not null
    , condi_end7 INTEGER default 0 not null
    , condi_start8 INTEGER default 0 not null
    , condi_end8 INTEGER default 0 not null
    , condi_start9 INTEGER default 0 not null
    , condi_end9 INTEGER default 0 not null
    , sel_mac_type INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, batch_grp_cd, batch_no, report_ordr)
      )''');

  /// 03_27	レポートカウンタ	c_report_cnt
  await db.execute('''create table c_report_cnt (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , report_cnt_cd INTEGER not null
    , settle_cnt INTEGER default 0 not null
    , bfr_datetime TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, report_cnt_cd)
      )''');

  /// 03_28	レジメモマスタ	c_memo_mst
  await db.execute('''create table c_memo_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , img_cd INTEGER not null
    , color INTEGER default 0 not null
    , memo1 TEXT
    , memo2 TEXT
    , memo3 TEXT
    , memo4 TEXT
    , memo5 TEXT
    , memo6 TEXT
    , memo7 TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , title TEXT
    , img_name TEXT
    , stop_flg INTEGER default 0 not null
    , read_flg INTEGER default 0 not null
    , renew_flg INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, img_cd)
      )''');

  /// 03_29	レジメモ連絡先マスタ	c_memosnd_mst
  await db.execute('''create table c_memosnd_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , img_cd INTEGER not null
    , ecr_no INTEGER not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, img_cd, ecr_no)
      )''');

  /// 03_30	承認キーグループマスタ	c_recog_grp_mst
  await db.execute('''create table c_recog_grp_mst (
    recog_grp_cd INTEGER not null
    , recog_sub_grp_cd INTEGER not null
    , page INTEGER not null
    , posi INTEGER not null
    , recog_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (recog_grp_cd, recog_sub_grp_cd, page, posi)
      )''');

  /// 03_31	承認キーマスタ	p_recog_mst
  await db.execute('''create table p_recog_mst (
    page INTEGER not null
    , posi INTEGER not null
    , recog_name TEXT
    , recog_set_flg INTEGER default 0 not null
    , primary key (page, posi)
      )''');

  /// 03_32	承認キー情報マスタ	c_recoginfo_mst
  await db.execute('''create table c_recoginfo_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , page INTEGER not null
    , password TEXT
    , fcode TEXT
    , qcjc_type TEXT
    , emergency_type TEXT
    , emergency_date TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, page)
      )''');

  /// 03_33	帳票マスタ	c_report_mst
  await db.execute('''create table c_report_mst (
    code INTEGER not null
    , prn_ordr INTEGER not null
    , srch_ordr INTEGER default 0 not null
    , grp_cd INTEGER not null
    , sub_grp_cd INTEGER default 0 not null
    , left_offset INTEGER default 0 not null
    , typ INTEGER default 0 not null
    , val_kind INTEGER default 0 not null
    , val_calc INTEGER default 0 not null
    , val_mark INTEGER default 0 not null
    , fmt_typ INTEGER default 0 not null
    , img_cd INTEGER default 0 not null
    , field1 TEXT
    , field2 TEXT
    , field3 TEXT
    , condi1 TEXT
    , condi2 TEXT
    , condi3 TEXT
    , repo_sql_cd INTEGER default 0 not null
    , recog_grp_cd INTEGER default 0 not null
    , trm_chk_grp_cd INTEGER default 0 not null
    , judge TEXT
    , printer_no INTEGER default 0 not null
    , primary key (code, prn_ordr)
      )''');

  /// 03_34	メニューオブジェクト割当マスタ	c_menu_obj_mst
  await db.execute('''create table c_menu_obj_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , proc TEXT not null
    , win_name TEXT not null
    , page INTEGER not null
    , btn_pos_x INTEGER not null
    , btn_pos_y INTEGER not null
    , btn_width INTEGER default 0 not null
    , btn_height INTEGER default 0 not null
    , object_div INTEGER default 0 not null
    , appl_grp_cd INTEGER default 0 not null
    , btn_color INTEGER default 0 not null
    , img_name TEXT
    , pass_chk_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, proc, win_name, page, btn_pos_x, btn_pos_y)
      )''');

  /// 03_35	トリガーキー割当マスタ	p_trigger_key_mst
  await db.execute('''create table p_trigger_key_mst (
    proc TEXT not null
    , win_name TEXT not null
    , trigger_key TEXT not null
    , call_type INTEGER default 0 not null
    , target_code INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (proc, win_name, trigger_key)
      )''');

  /// 03_36	ファイル初期・リクエストマスタ	c_finit_mst
  await db.execute('''create table c_finit_mst (
    finit_grp_cd INTEGER not null
    , finit_cd INTEGER not null
    , set_tbl_name TEXT not null
    , set_tbl_typ INTEGER not null
    , finit_dsp_chk_div INTEGER default 0 not null
    , freq_dsp_chk_div INTEGER default 0 not null
    , freq_ope_mode INTEGER default 0 not null
    , offline_chk_flg INTEGER default 1 not null
    , seq_name TEXT
    , freq_csrv_cnct_skip INTEGER default 1 not null
    , freq_csrc_cust_real_skip INTEGER default 1 not null
    , freq_csrv_cnct_key TEXT
    , freq_csrv_del_oth_stre INTEGER default 0 not null
    , svr_div INTEGER default 0 not null
    , default_file_name TEXT
    , rmst_freq_dsp_chk_div INTEGER default 0 not null
    , primary key (finit_grp_cd, finit_cd)
      )''');

  /// 03_37	ファイル初期・リクエストグループマスタ	c_finit_grp_mst
  await db.execute('''create table c_finit_grp_mst (
    finit_grp_cd INTEGER not null
    , finit_grp_name TEXT not null
    , primary key (finit_grp_cd)
      )''');

  /// 03_38	テーブル名管理マスタ	c_set_tbl_name_mst
  await db.execute('''create table c_set_tbl_name_mst (
    set_tbl_name TEXT not null
    , disp_name TEXT not null
    , primary key (set_tbl_name)
      )''');

  /// 03_39	アプリグループマスタ	c_appl_grp_mst
  await db.execute('''create table c_appl_grp_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , appl_grp_cd INTEGER not null
    , appl_name TEXT
    , cond_con_typ TEXT
    , cond_trm_cd INTEGER default 0 not null
    , recog_grp_cd INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , menu_chk_flg INTEGER default 0 not null
    , flg_1 INTEGER default 0 not null
    , flg_2 INTEGER default 0 not null
    , flg_3 INTEGER default 0 not null
    , flg_4 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, appl_grp_cd)
      )''');

  /// 03_40	アプリマスタ	p_appl_mst
  await db.execute('''create table p_appl_mst (
    appl_grp_cd INTEGER not null
    , appl_cd INTEGER not null
    , call_type INTEGER default 0 not null
    , name TEXT
    , position TEXT
    , param1 TEXT
    , param2 TEXT
    , param3 TEXT
    , param4 TEXT
    , param5 TEXT
    , recog_grp_cd INTEGER default 0 not null
    , pause_flg INTEGER default 0 not null
    , primary key (appl_grp_cd, appl_cd)
      )''');

  /// 03_41	ダイアログマスタ	c_dialog_mst
  await db.execute('''create table c_dialog_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , dialog_cd INTEGER not null
    , title_img_cd INTEGER default 0 not null
    , title_col INTEGER default 0 not null
    , title_siz INTEGER default 0 not null
    , message1 TEXT
    , message1_col INTEGER default 0 not null
    , message1_siz INTEGER default 0 not null
    , message2 TEXT
    , message2_col INTEGER default 0 not null
    , message2_siz INTEGER default 0 not null
    , message3 TEXT
    , message3_col INTEGER default 0 not null
    , message3_siz INTEGER default 0 not null
    , message4 TEXT
    , message4_col INTEGER default 0 not null
    , message4_siz INTEGER default 0 not null
    , message5 TEXT
    , message5_col INTEGER default 0 not null
    , message5_siz INTEGER default 0 not null
    , dialog_typ INTEGER default 0 not null
    , dialog_img_cd INTEGER default 0 not null
    , dialog_icon_cd INTEGER default 0 not null
    , dialog_sound_cd INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, dialog_cd)
      )''');

  /// 03_42	ダイアログマスタ(英語)	c_dialog_ex_mst
  await db.execute('''create table c_dialog_ex_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , dialog_cd INTEGER not null
    , title_img_cd INTEGER default 0 not null
    , title_col INTEGER default 0 not null
    , title_siz INTEGER default 0 not null
    , message1 TEXT
    , message1_col INTEGER default 0 not null
    , message1_siz INTEGER default 0 not null
    , message2 TEXT
    , message2_col INTEGER default 0 not null
    , message2_siz INTEGER default 0 not null
    , message3 TEXT
    , message3_col INTEGER default 0 not null
    , message3_siz INTEGER default 0 not null
    , message4 TEXT
    , message4_col INTEGER default 0 not null
    , message4_siz INTEGER default 0 not null
    , message5 TEXT
    , message5_col INTEGER default 0 not null
    , message5_siz INTEGER default 0 not null
    , dialog_typ INTEGER default 0 not null
    , dialog_img_cd INTEGER default 0 not null
    , dialog_icon_cd INTEGER default 0 not null
    , dialog_sound_cd INTEGER default 0 not null
    , btn1_msg TEXT
    , btn2_msg TEXT
    , btn3_msg TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, dialog_cd)
      )''');

  /// 03_43	プロモーションスケジュールマスタ	p_promsch_mst
  await db.execute('''create table p_promsch_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , plan_cd TEXT not null
    , prom_cd INTEGER not null
    , prom_typ INTEGER not null
    , sch_typ INTEGER default 0 not null
    , prom_name TEXT
    , reward_val INTEGER default 0 not null
    , item_cd TEXT not null
    , lrgcls_cd INTEGER default 0 not null
    , mdlcls_cd INTEGER default 0 not null
    , smlcls_cd INTEGER default 0 not null
    , tnycls_cd INTEGER default 0 not null
    , dsc_val INTEGER default 0 not null
    , cost REAL default 0 not null
    , cost_per REAL default 0 not null
    , cust_dsc_val INTEGER default 0 not null
    , form_qty1 INTEGER default 0 not null
    , form_qty2 INTEGER default 0 not null
    , form_qty3 INTEGER default 0 not null
    , form_qty4 INTEGER default 0 not null
    , form_qty5 INTEGER default 0 not null
    , form_prc1 INTEGER default 0 not null
    , form_prc2 INTEGER default 0 not null
    , form_prc3 INTEGER default 0 not null
    , form_prc4 INTEGER default 0 not null
    , form_prc5 INTEGER default 0 not null
    , cust_form_prc1 INTEGER default 0 not null
    , cust_form_prc2 INTEGER default 0 not null
    , cust_form_prc3 INTEGER default 0 not null
    , cust_form_prc4 INTEGER default 0 not null
    , cust_form_prc5 INTEGER default 0 not null
    , av_prc INTEGER default 0 not null
    , cust_av_prc INTEGER default 0 not null
    , avprc_adpt_flg INTEGER default 0 not null
    , avprc_util_flg INTEGER default 0 not null
    , low_limit INTEGER default 0 not null
    , svs_typ INTEGER default 0 not null
    , dsc_typ INTEGER default 0 not null
    , rec_limit INTEGER default 0 not null
    , rec_buy_limit INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 0 not null
    , mon_flg INTEGER default 0 not null
    , tue_flg INTEGER default 0 not null
    , wed_flg INTEGER default 0 not null
    , thu_flg INTEGER default 0 not null
    , fri_flg INTEGER default 0 not null
    , sat_flg INTEGER default 0 not null
    , eachsch_typ INTEGER default 0 not null
    , eachsch_flg TEXT
    , stop_flg INTEGER default 0 not null
    , min_prc INTEGER default 0 not null
    , max_prc INTEGER default 0 not null
    , tax_flg INTEGER default 0 not null
    , member_qty INTEGER default 0 not null
    , div_cd INTEGER default 0
    , acct_cd INTEGER default 0 not null
    , promo_ext_id TEXT default '0'
    , trends_typ INTEGER default 0 not null
    , user_val_1 INTEGER default 0 not null
    , user_val_2 INTEGER default 0 not null
    , user_val_3 INTEGER default 0 not null
    , user_val_4 INTEGER default 0 not null
    , user_val_5 INTEGER default 0 not null
    , user_val_6 TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , point_add_magn REAL default 0 not null
    , point_add_mem_typ INTEGER default 0 not null
    , svs_cls_f_data1 REAL default 0 not null
    , svs_cls_s_data1 INTEGER default 0 not null
    , svs_cls_s_data2 INTEGER default 0 not null
    , svs_cls_s_data3 INTEGER default 0 not null
    , plupts_rate REAL default 0 not null
    , custsvs_unit INTEGER default 0 not null
    , ref_acct INTEGER default 0 not null
    , linked_prom_id INTEGER default 0 not null
    , date_flg1 INTEGER default 0 not null
    , date_flg2 INTEGER default 0 not null
    , date_flg3 INTEGER default 0 not null
    , date_flg4 INTEGER default 0 not null
    , date_flg5 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, plan_cd, prom_cd, prom_typ, item_cd, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd)
      )''');

  /// 03_44	プロモーション商品マスタ	p_promitem_mst
  await db.execute('''create table p_promitem_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , plan_cd TEXT not null
    , prom_cd INTEGER not null
    , prom_typ INTEGER not null
    , item_typ INTEGER default 0 not null
    , item_cd TEXT not null
    , item_cd2 TEXT not null
    , stop_flg INTEGER default 0 not null
    , set_qty INTEGER default 0 not null
    , grp_cd INTEGER not null
    , user_val_1 INTEGER default 0 not null
    , user_val_2 INTEGER default 0 not null
    , user_val_3 INTEGER default 0 not null
    , user_val_4 INTEGER default 0 not null
    , user_val_5 INTEGER default 0 not null
    , user_val_6 TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, plan_cd, prom_cd, item_cd, item_cd2, grp_cd)
      )''');

  /// 03_45	インストアマーキングマスタ	c_instre_mst
  await db.execute('''create table c_instre_mst (
      comp_cd INTEGER not null
      , instre_flg TEXT not null
      , format_no INTEGER not null
      , format_typ INTEGER default 0 not null
      , cls_code INTEGER default 0 not null
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , primary key (comp_cd, instre_flg, format_no)
      )''');

  /// 03_46	フォーマットタイプマスタ	c_fmttyp_mst
  await db.execute('''create table c_fmttyp_mst (
    format_typ INTEGER not null
    , format_typ_name TEXT
    , disp_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (format_typ)
      )''');

  /// 03_47	バーコードフォーマットマスタ	c_barfmt_mst
  await db.execute('''create table c_barfmt_mst (
    format_no INTEGER not null
    , format_typ INTEGER not null
    , format TEXT
    , flg_num INTEGER default 0 not null
    , format_num INTEGER default 0 not null
    , disp_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , cls_flg INTEGER default 0 not null
    , primary key (format_no, format_typ)
      )''');

  /// 03_48	メッセージマスタ	c_msg_mst
  await db.execute('''create table c_msg_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , msg_cd INTEGER not null
    , msg_kind INTEGER default 0 not null
    , msg_data_1 TEXT
    , msg_data_2 TEXT
    , msg_data_3 TEXT
    , msg_data_4 TEXT
    , msg_data_5 TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , msg_size_1 INTEGER default 0 not null
    , msg_size_2 INTEGER default 0 not null
    , msg_size_3 INTEGER default 0 not null
    , msg_size_4 INTEGER default 0 not null
    , msg_size_5 INTEGER default 0 not null
    , msg_color_1 INTEGER default 11 not null
    , msg_color_2 INTEGER default 11 not null
    , msg_color_3 INTEGER default 11 not null
    , msg_color_4 INTEGER default 11 not null
    , msg_color_5 INTEGER default 11 not null
    , back_color INTEGER default 15 not null
    , back_pict_typ INTEGER default 0 not null
    , second INTEGER default 5 not null
    , flg_01 INTEGER default 0 not null
    , flg_02 INTEGER default 0 not null
    , flg_03 INTEGER default 0 not null
    , flg_04 INTEGER default 0 not null
    , flg_05 INTEGER default 0 not null
    , msg_data_6 TEXT
    , msg_data_7 TEXT
    , msg_data_8 TEXT
    , msg_data_9 TEXT
    , msg_data_10 TEXT
    , msg_size_6 INTEGER default 0 not null
    , msg_size_7 INTEGER default 0 not null
    , msg_size_8 INTEGER default 0 not null
    , msg_size_9 INTEGER default 0 not null
    , msg_size_10 INTEGER default 0 not null
    , msg_color_6 INTEGER default 11 not null
    , msg_color_7 INTEGER default 11 not null
    , msg_color_8 INTEGER default 11 not null
    , msg_color_9 INTEGER default 11 not null
    , msg_color_10 INTEGER default 11 not null
    , flg_06 INTEGER default 0 not null
    , flg_07 INTEGER default 0 not null
    , flg_08 INTEGER default 0 not null
    , flg_09 INTEGER default 0 not null
    , flg_10 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, msg_cd)
      )''');

  /// 03_49	メッセージレイアウトマスタ	c_msglayout_mst
  await db.execute('''create table c_msglayout_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , msggrp_cd INTEGER not null
    , msg_typ INTEGER default 0 not null
    , msg_cd INTEGER default 0 not null
    , target_typ INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, msggrp_cd, msg_typ)
      )''');

  /// 03_50	メッセージスケジュールマスタ	c_msgsch_mst
  await db.execute('''create table c_msgsch_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , msgsch_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 0 not null
    , mon_flg INTEGER default 0 not null
    , tue_flg INTEGER default 0 not null
    , wed_flg INTEGER default 0 not null
    , thu_flg INTEGER default 0 not null
    , fri_flg INTEGER default 0 not null
    , sat_flg INTEGER default 0 not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, msgsch_cd)
      )''');

  /// 03_51	メッセージスケジュールレイアウトマスタ	c_msgsch_layout_mst
  await db.execute('''create table c_msgsch_layout_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , msgsch_cd INTEGER not null
    , msggrp_cd INTEGER not null
    , msg_typ INTEGER default 0 not null
    , msg_cd INTEGER default 0 not null
    , target_typ INTEGER default 0 not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, msgsch_cd, msggrp_cd, msg_typ)
      )''');

  /// 03_52	ターミナルチェックマスタ	c_trm_chk_mst
  await db.execute('''create table c_trm_chk_mst (
    trm_chk_grp_cd INTEGER not null
    , trm_cd INTEGER not null
    , trm_data REAL default 0 not null
    , trm_chk_eq_flg INTEGER default 0 not null
    , primary key (trm_chk_grp_cd, trm_cd)
      )''');

  /// 03_53	帳票印字条件マスタ	c_report_cond_mst
  await db.execute('''create table c_report_cond_mst (
    code INTEGER not null
    , menu_kind INTEGER not null
    , sub_menu_kind INTEGER not null
    , btn_stp INTEGER not null
    , btn_grp INTEGER default 0 not null
    , attr_cd INTEGER default 0 not null
    , primary key (code, menu_kind, sub_menu_kind, btn_stp)
      )''');

  /// 03_54	帳票属性マスタ	c_report_attr_mst
  await db.execute('''create table c_report_attr_mst (
    attr_cd INTEGER not null
    , attr_sub_cd INTEGER default 0 not null
    , attr_typ INTEGER default 0 not null
    , start_data TEXT not null
    , end_data TEXT not null
    , digits INTEGER default 0 not null
    , img_cd INTEGER default 0 not null
    , repo_sql_cd INTEGER default 0 not null
    , primary key (attr_cd)
      )''');

  /// 03_55	帳票属性サブマスタ	c_report_attr_sub_mst
  await db.execute('''create table c_report_attr_sub_mst (
    attr_sub_cd INTEGER not null
    , attr_sub_ordr INTEGER not null
    , img_cd INTEGER default 0
    , repo_sql_cd INTEGER default 0
    , primary key (attr_sub_cd, attr_sub_ordr)
      )''');

  /// 03_56	帳票SQLマスタ	c_report_sql_mst
  await db.execute('''create table c_report_sql_mst (
    repo_sql_cd INTEGER not null
    , repo_sql_typ INTEGER not null
    , cond_sql TEXT
    , cnct_sql1 INTEGER not null
    , cond_sql1 TEXT
    , cnct_sql2 INTEGER not null
    , cond_sql2 TEXT
    , primary key (repo_sql_cd)
      )''');

  /// 03_57	件数確認マスタ	c_tcount_mst
  await db.execute('''create table c_tcount_mst (
    tcount_cd INTEGER not null
    , set_tbl_name TEXT not null
    , set_tbl_typ INTEGER default 0 not null
    , file_dir TEXT
    , dat_div INTEGER default 0 not null
    , recog_grp_cd INTEGER default 0 not null
    , primary key (tcount_cd)
      )''');

  /// 03_58	自動開閉店マスタ	c_stropncls_mst
  await db.execute('''create table c_stropncls_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , stropncls_grp INTEGER not null
    , stropncls_cd INTEGER not null
    , stropncls_data REAL default 0 not null
    , data_typ INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, stropncls_grp, stropncls_cd)
      )''');

  /// 03_59	自動開閉店設定マスタ	c_stropncls_set_mst
  await db.execute('''create table c_stropncls_set_mst (
    stropncls_cd INTEGER not null
    , stropncls_name TEXT
    , stropncls_dsp_cond INTEGER default 0 not null
    , stropncls_inp_cond INTEGER default 0 not null
    , stropncls_limit_max REAL default 0 not null
    , stropncls_limit_min REAL default 0 not null
    , stropncls_digits INTEGER default 0 not null
    , stropncls_zero_typ INTEGER default 0 not null
    , stropncls_btn_color INTEGER default 0 not null
    , stropncls_info_comment TEXT
    , stropncls_info_pic INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (stropncls_cd)
      )''');

  /// 03_60	自動開閉店サブマスタ	c_stropncls_sub_mst
  await db.execute('''create table c_stropncls_sub_mst (
    stropncls_cd INTEGER not null
    , stropncls_ordr INTEGER not null
    , stropncls_data REAL default 0 not null
    , img_cd INTEGER default 0 not null
    , stropncls_comment TEXT
    , stropncls_btn_color INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (stropncls_cd, stropncls_ordr)
      )''');

  /// 03_61	キャッシュリサイクルマスタ	c_cashrecycle_mst
  await db.execute('''create table c_cashrecycle_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , cashrecycle_grp INTEGER not null
    , code INTEGER not null
    , data REAL default 0 not null
    , data_typ INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, cashrecycle_grp, code)
      )''');

  /// 03_62	キャッシュリサイクル設定マスタ	c_cashrecycle_set_mst
  await db.execute('''create table c_cashrecycle_set_mst (
    code INTEGER not null
    , set_name TEXT
    , dsp_cond INTEGER default 0 not null
    , inp_cond INTEGER default 0 not null
    , limit_max REAL default 0 not null
    , limit_min REAL default 0 not null
    , digits INTEGER default 0 not null
    , zero_typ INTEGER default 0 not null
    , btn_color INTEGER default 0 not null
    , info_comment TEXT
    , info_pic INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (code)
      )''');

  /// 03_63	キャッシュリサイクルサブマスタ	c_cashrecycle_sub_mst
  await db.execute('''create table c_cashrecycle_sub_mst (
    code INTEGER not null
    , ordr INTEGER not null
    , data REAL default 0 not null
    , img_cd INTEGER default 0 not null
    , comment TEXT
    , btn_color INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (code, ordr)
      )''');

  /// 03_64	キャッシュリサイクル管理マスタ	c_cashrecycle_info_mst
  await db.execute('''create table c_cashrecycle_info_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , cashrecycle_grp INTEGER default 1 not null
    , cal_grp_cd INTEGER default 0 not null
    , server INTEGER default 0 not null
    , server_macno INTEGER default 0 not null
    , server_info TEXT
    , sub_server INTEGER default 0 not null
    , sub_server_macno INTEGER default 0 not null
    , sub_server_info TEXT
    , first_disp_macno1 INTEGER default 0 not null
    , first_disp_macno2 INTEGER default 0 not null
    , first_disp_macno3 INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no)
      )''');

  /// 03_65	メッセージレイアウト設定マスタ	c_msglayout_set_mst
  await db.execute('''create table c_msglayout_set_mst (
    msg_set_kind INTEGER not null
    , msg_data INTEGER default 0 not null
    , msg_name TEXT
    , msg_dsp_cond INTEGER default 0 not null
    , msg_target_dsp_cond INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (msg_set_kind, msg_data)
      )''');

  /// 03_66	コード決済事業者マスタ	c_payoperator_mst
  await db.execute('''create table c_payoperator_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , payopera_typ TEXT not null
    , payopera_cd INTEGER default 0 not null
    , name TEXT
    , short_name TEXT
    , misc_cd INTEGER default 0 not null
    , showorder INTEGER default 1 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, payopera_typ, payopera_cd)
      )''');

  /// c_batprcchg_mst c_batprcchg_mst
  await db.execute('''create table c_batprcchg_mst (
    prcchg_cd INTEGER
    , order_cd INTEGER
    , comp_cd INTEGER
    , stre_cd INTEGER
    , plu_cd TEXT
    , flg INTEGER
    , pos_prc INTEGER default 0 not null
    , cust_prc INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 0 not null
    , mon_flg INTEGER default 0 not null
    , tue_flg INTEGER default 0 not null
    , wed_flg INTEGER default 0 not null
    , thu_flg INTEGER default 0 not null
    , fri_flg INTEGER default 0 not null
    , sat_flg INTEGER default 0 not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (prcchg_cd,order_cd,comp_cd,stre_cd)
      )''');

  /// 区分マスタ2 c_divide2_mst
  await db.execute('''create table c_divide2_mst (
    comp_cd INTEGER
    , stre_cd INTEGER
    , kind_cd INTEGER
    , div_cd INTEGER
    , name TEXT
    , short_name TEXT
    , exp_cd1 INTEGER not null
    , exp_cd2 INTEGER not null
    , exp_cd3 INTEGER default 0 not null
    , exp_cd4 INTEGER default 0 not null
    , exp_data1 TEXT
    , exp_data2 TEXT
    , exp_data3 TEXT
    , exp_l_cd1 INTEGER default 0 not null
    , exp_l_cd2 INTEGER default 0 not null
    , exp_l_cd3 INTEGER default 0 not null
    , exp_d_cd1 REAL default 0 not null
    , exp_d_cd2 REAL default 0 not null
    , exp_amt INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd,stre_cd,kind_cd,div_cd)
      )''');
  //endregion
  //region 04_POS_その他
  /// 04_1	予約テーブル	c_reserv_tbl
  await db.execute('''create table c_reserv_tbl (
    serial_no TEXT default '0' not null
    , cust_no TEXT
    , last_name TEXT
    , first_name TEXT
    , tel_no1 TEXT
    , tel_no2 TEXT
    , post_no TEXT
    , address1 TEXT
    , address2 TEXT
    , address3 TEXT
    , recept_date TEXT
    , ferry_date TEXT
    , arrival_date TEXT
    , qty INTEGER default 0 not null
    , ttl INTEGER default 0 not null
    , advance_money INTEGER default 0 not null
    , memo1 TEXT
    , memo2 TEXT
    , finish INTEGER default 0 not null
    , primary key (serial_no)
      )''');

  /// 04_2	公共料金_残高情報テーブル	p_pbchg_balance_tbl
  await db.execute('''create table p_pbchg_balance_tbl (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , groupcd INTEGER not null
    , officecd INTEGER not null
    , dwn_balance INTEGER default 0 not null
    , validflag INTEGER default 0 not null
    , now_balance INTEGER default 0 not null
    , pay_amt INTEGER default 0 not null
    , settle_flg INTEGER default 0 not null
    , fil1 INTEGER default 0 not null
    , fil2 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, groupcd, officecd)
      )''');

  /// 04_3	公共料金_店舗情報テーブル	p_pbchg_stre_tbl
  await db.execute('''create table p_pbchg_stre_tbl (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , groupcd INTEGER not null
    , officecd INTEGER not null
    , strecd INTEGER not null
    , termcd INTEGER not null
    , minimum INTEGER default 0 not null
    , svcstopclassify INTEGER default 0 not null
    , svcstopmoney INTEGER default 0 not null
    , office_svcclassify INTEGER default 0 not null
    , office_validflag INTEGER default 0 not null
    , office_changed TEXT
    , stre_svcclassify INTEGER default 0 not null
    , stre_validflag INTEGER default 0 not null
    , stre_changed TEXT
    , eastclassify INTEGER default 0 not null
    , westclassify INTEGER default 0 not null
    , term_svcclassify INTEGER default 0 not null
    , term_validflag INTEGER default 0 not null
    , term_changed TEXT
    , fil1 INTEGER default 0 not null
    , fil2 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, groupcd, officecd, strecd, termcd)
      )''');

  /// 04_4	公共料金_収納企業情報テーブル	p_pbchg_corp_tbl
  await db.execute('''create table p_pbchg_corp_tbl (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , corpcd INTEGER not null
    , subclassify INTEGER not null
    , subcd INTEGER not null
    , name TEXT
    , kana TEXT
    , isntt INTEGER default 0 not null
    , corp_svcclassify INTEGER default 0 not null
    , corp_validflag INTEGER default 0 not null
    , corp_svcstart TEXT
    , barcodekind INTEGER default 0 not null
    , sclassify INTEGER default 0 not null
    , sjclassify INTEGER default 0 not null
    , sjmoney INTEGER default 0 not null
    , sjcolumn INTEGER default 0 not null
    , sjrow INTEGER default 0 not null
    , pclassify INTEGER default 0 not null
    , ddclassify INTEGER default 0 not null
    , ddcolumn INTEGER default 0 not null
    , ddrows INTEGER default 0 not null
    , ddrowe INTEGER default 0 not null
    , ddmethod INTEGER default 0 not null
    , orgcolumn INTEGER default 0 not null
    , orgrows INTEGER default 0 not null
    , orgrowe INTEGER default 0 not null
    , rclassify INTEGER default 0 not null
    , fclassify INTEGER default 0 not null
    , fmoney1 INTEGER default 0 not null
    , funit1 INTEGER default 0 not null
    , fee1 INTEGER default 0 not null
    , fmoney2 INTEGER default 0 not null
    , funit2 INTEGER default 0 not null
    , fee2 INTEGER default 0 not null
    , fmoney3 INTEGER default 0 not null
    , funit3 INTEGER default 0 not null
    , fee3 INTEGER default 0 not null
    , fmoney4 INTEGER default 0 not null
    , funit4 INTEGER default 0 not null
    , fee4 INTEGER default 0 not null
    , fmoney5 INTEGER default 0 not null
    , funit5 INTEGER default 0 not null
    , fee5 INTEGER default 0 not null
    , limit_amt INTEGER default 0 not null
    , decision_svcclassify INTEGER default 0 not null
    , decision_validflag INTEGER default 0 not null
    , decision_changed TEXT
    , fil1 INTEGER default 0 not null
    , fil2 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, corpcd, subclassify, subcd)
      )''');

  /// 04_5	公共料金_端末別収納不可企業情報テーブル	p_pbchg_ncorp_tbl
  await db.execute('''create table p_pbchg_ncorp_tbl (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , groupcd INTEGER not null
    , officecd INTEGER not null
    , strecd INTEGER not null
    , termcd INTEGER not null
    , corpcd INTEGER not null
    , subcd INTEGER not null
    , validflag INTEGER default 0 not null
    , changed TEXT
    , fil1 INTEGER default 0 not null
    , fil2 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, groupcd, officecd, strecd, termcd, corpcd, subcd)
      )''');

  /// 04_6	公共料金_NTT東日本局番情報テーブル	p_pbchg_ntte_tbl
  await db.execute('''create table p_pbchg_ntte_tbl (
    comp_cd INTEGER
    , stre_cd INTEGER
    , startno INTEGER default 0 not null
    , endno INTEGER default 0 not null
    , validflag INTEGER default 0 not null
    , changed TEXT
    , fil1 INTEGER default 0 not null
    , fil2 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd)
      )''');

  /// 04_7	クレジット会社請求テーブル	c_crdt_demand_tbl
  await db.execute('''create table c_crdt_demand_tbl (
    comp_cd INTEGER default 0
    , card_kind INTEGER default 0
    , company_cd INTEGER default 0 not null
    , id TEXT
    , business INTEGER default 0 not null
    , mbr_no_from INTEGER default 0 not null
    , mbr_no_to INTEGER default 0 not null
    , mbr_no_position INTEGER default 1 not null
    , mbr_no_digit INTEGER default 1 not null
    , ckdigit_chk INTEGER default 0 not null
    , ckdigit_wait TEXT
    , card_company_name TEXT
    , good_thru_position INTEGER default 1 not null
    , pay_autoinput_chk INTEGER default 0 not null
    , pay_shut_day INTEGER default 1 not null
    , pay_day INTEGER default 1 not null
    , lump INTEGER default 0 not null
    , twice INTEGER default 0 not null
    , divide INTEGER default 0 not null
    , bonus_lump INTEGER default 0 not null
    , bonus_twice INTEGER default 0 not null
    , bonus_use INTEGER default 0 not null
    , ribo INTEGER default 0 not null
    , skip INTEGER default 0 not null
    , divide3 INTEGER default 0 not null
    , divide4 INTEGER default 0 not null
    , divide5 INTEGER default 0 not null
    , divide6 INTEGER default 0 not null
    , divide7 INTEGER default 0 not null
    , divide8 INTEGER default 0 not null
    , divide9 INTEGER default 0 not null
    , divide10 INTEGER default 0 not null
    , divide11 INTEGER default 0 not null
    , divide12 INTEGER default 0 not null
    , divide15 INTEGER default 0 not null
    , divide18 INTEGER default 0 not null
    , divide20 INTEGER default 0 not null
    , divide24 INTEGER default 0 not null
    , divide25 INTEGER default 0 not null
    , divide30 INTEGER default 0 not null
    , divide35 INTEGER default 0 not null
    , divide36 INTEGER default 0 not null
    , divide3_limit INTEGER default 0 not null
    , divide4_limit INTEGER default 0 not null
    , divide5_limit INTEGER default 0 not null
    , divide6_limit INTEGER default 0 not null
    , divide7_limit INTEGER default 0 not null
    , divide8_limit INTEGER default 0 not null
    , divide9_limit INTEGER default 0 not null
    , divide10_limit INTEGER default 0 not null
    , divide11_limit INTEGER default 0 not null
    , divide12_limit INTEGER default 0 not null
    , divide15_limit INTEGER default 0 not null
    , divide18_limit INTEGER default 0 not null
    , divide20_limit INTEGER default 0 not null
    , divide24_limit INTEGER default 0 not null
    , divide25_limit INTEGER default 0 not null
    , divide30_limit INTEGER default 0 not null
    , divide35_limit INTEGER default 0 not null
    , divide36_limit INTEGER default 0 not null
    , bonus_use2 INTEGER default 0 not null
    , bonus_use3 INTEGER default 0 not null
    , bonus_use4 INTEGER default 0 not null
    , bonus_use5 INTEGER default 0 not null
    , bonus_use6 INTEGER default 0 not null
    , bonus_use7 INTEGER default 0 not null
    , bonus_use8 INTEGER default 0 not null
    , bonus_use9 INTEGER default 0 not null
    , bonus_use10 INTEGER default 0 not null
    , bonus_use11 INTEGER default 0 not null
    , bonus_use12 INTEGER default 0 not null
    , bonus_use15 INTEGER default 0 not null
    , bonus_use18 INTEGER default 0 not null
    , bonus_use20 INTEGER default 0 not null
    , bonus_use24 INTEGER default 0 not null
    , bonus_use25 INTEGER default 0 not null
    , bonus_use30 INTEGER default 0 not null
    , bonus_use35 INTEGER default 0 not null
    , bonus_use36 INTEGER default 0 not null
    , bonus_use2_limit INTEGER default 0 not null
    , bonus_use3_limit INTEGER default 0 not null
    , bonus_use4_limit INTEGER default 0 not null
    , bonus_use5_limit INTEGER default 0 not null
    , bonus_use6_limit INTEGER default 0 not null
    , bonus_use7_limit INTEGER default 0 not null
    , bonus_use8_limit INTEGER default 0 not null
    , bonus_use9_limit INTEGER default 0 not null
    , bonus_use10_limit INTEGER default 0 not null
    , bonus_use11_limit INTEGER default 0 not null
    , bonus_use12_limit INTEGER default 0 not null
    , bonus_use15_limit INTEGER default 0 not null
    , bonus_use18_limit INTEGER default 0 not null
    , bonus_use20_limit INTEGER default 0 not null
    , bonus_use24_limit INTEGER default 0 not null
    , bonus_use25_limit INTEGER default 0 not null
    , bonus_use30_limit INTEGER default 0 not null
    , bonus_use35_limit INTEGER default 0 not null
    , bonus_use36_limit INTEGER default 0 not null
    , pay_input_chk INTEGER default 0 not null
    , winter_bonus_from INTEGER default 0 not null
    , winter_bonus_to INTEGER default 0 not null
    , winter_bonus_pay1 INTEGER default 0 not null
    , winter_bonus_pay2 INTEGER default 0 not null
    , winter_bonus_pay3 INTEGER default 0 not null
    , summer_bonus_from INTEGER default 0 not null
    , summer_bonus_to INTEGER default 0 not null
    , summer_bonus_pay1 INTEGER default 0 not null
    , summer_bonus_pay2 INTEGER default 0 not null
    , summer_bonus_pay3 INTEGER default 0 not null
    , bonus_lump_limit INTEGER default 0 not null
    , bonus_twice_limit INTEGER default 0 not null
    , offline_limit INTEGER default 0 not null
    , card_jis INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER
    , send_flg INTEGER
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER
    , company_cd_to INTEGER default 0 not null
    , stlcrdtdsc_per INTEGER default 0 not null
    , mkr_cd INTEGER default 0 not null
    , destination TEXT
    , signless_flg INTEGER default 0 not null
    , coopcode1 INTEGER default 0 not null
    , coopcode2 INTEGER default 0 not null
    , coopcode3 INTEGER default 0 not null
    , bonus_add_input_chk INTEGER default 0 not null
    , bonus_cnt_input_chk INTEGER default 0 not null
    , bonus_cnt INTEGER default 0 not null
    , paymonth_input_chk INTEGER default 0 not null
    , sign_amt INTEGER default 0 not null
    , effect_code INTEGER default 0 not null
    , fil1 INTEGER default 0 not null
    , fil2 INTEGER default 0 not null
    , primary key (comp_cd, card_kind)
      )''');

  /// 04_8	予約売価変更スケジュールマスタ	p_prcchg_sch_mst
  await db.execute('''create table p_prcchg_sch_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , prcchg_cd INTEGER not null
    , div_cd INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, prcchg_cd)
      )''');

  /// 04_9	予約売価変更商品マスタ	p_prcchg_item_mst
  await db.execute('''create table p_prcchg_item_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , prcchg_cd INTEGER not null
    , bkup_flg INTEGER not null
    , plu_cd TEXT not null
    , item_name TEXT
    , pos_prc INTEGER default 0 not null
    , cust_prc INTEGER default 0 not null
    , cost_prc REAL default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, prcchg_cd, bkup_flg, plu_cd)
      )''');

  /// 04_10	売価変更マスタ	p_prcchg_mst
  await db.execute('''create table p_prcchg_mst (
    serial_no INTEGER not null
    , plu_cd TEXT
    , item_name TEXT
    , pos_prc INTEGER default 0 not null
    , cust_prc INTEGER default 0 not null
    , cost_prc REAL default 0 not null
    , prcchg_cd INTEGER default 0 not null
    , mac_no INTEGER default 0 not null
    , div_cd INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (serial_no)
      )''');

  /// 04_11	ﾊﾞｯｸﾔｰﾄﾞ機器ﾏｽﾀ	s_backyard_grp_mst
  await db.execute('''create table s_backyard_grp_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , cnct_no INTEGER not null
    , cls_typ INTEGER not null
    , cls_cd INTEGER not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, cnct_no, cls_typ, cls_cd)
      )''');

  /// 04_12	Wiz情報テーブル	c_wiz_inf_tbl
  await db.execute('''create table c_wiz_inf_tbl (
    cd INTEGER not null
    , ipaddr TEXT
    , mac_addr TEXT
    , pwr_sts INTEGER
    , run_flg INTEGER
    , run_bfre_date TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (cd)
      )''');

  /// 04_13	パスポート情報マスタ	c_passport_info_mst
  await db.execute('''create table c_passport_info_mst (
    kind INTEGER not null
    , code INTEGER not null
    , data_jp TEXT
    , data_ex TEXT
    , langue INTEGER
    , data_01 TEXT
    , data_02 TEXT
    , country_code INTEGER
    , data_03 TEXT
    , flg_01 INTEGER
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (kind, code)
      )''');

  /// 04_14	緊急ﾒﾝﾃﾅﾝｽｵﾌﾗｲﾝﾃｰﾌﾞﾙ	p_notfplu_off_tbl
  await db.execute('''create table p_notfplu_off_tbl (
    plu_cd TEXT not null
    , lrgcls_cd INTEGER default 0 not null
    , mdlcls_cd INTEGER default 0 not null
    , smlcls_cd INTEGER default 0 not null
    , tnycls_cd INTEGER default 0 not null
    , item_name TEXT
    , pos_name TEXT
    , pos_prc INTEGER default 0 not null
    , tax_cd_1 INTEGER default 0 not null
    , mac_no INTEGER default 0 not null
    , staff_cd INTEGER default 0 not null
    , primary key (plu_cd)
      )''');
  //endregion
  //region 05_POS_ログ
  for(var i = 1;i <= 2;i++){
    var j;
    switch(i){
      case 1:
        // 05_1	実績ヘッダログ	c_header_log
        j = "log";
        break;
      case 2:
        // RM3800 フローティング用実績ヘッダログ	c_header_log_floating
        j = "log_floating";
        break;
    }
    /// 05_1	実績ヘッダログ	c_header_log
    /// RM3800 フローティング用実績ヘッダログ	c_header_log_floating
    await db.execute('''create table c_header_$j (
      serial_no TEXT default '0' not null
      , comp_cd INTEGER default 0 not null
      , stre_cd INTEGER default 0 not null
      , mac_no INTEGER default 0 not null
      , receipt_no INTEGER default 0 not null
      , print_no INTEGER default 0 not null
      , cshr_no INTEGER default 0 not null
      , chkr_no INTEGER default 0 not null
      , cust_no TEXT
      , sale_date TEXT
      , starttime TEXT
      , endtime TEXT
      , ope_mode_flg INTEGER default 0 not null
      , inout_flg INTEGER default 0 not null
      , prn_typ INTEGER default 0 not null
      , void_serial_no TEXT default '0' not null
      , qc_serial_no TEXT default '0' not null
      , void_kind INTEGER default 0 not null
      , void_sale_date TEXT
      , data_log_cnt INTEGER default 0 not null
      , ej_log_cnt INTEGER default 0 not null
      , status_log_cnt INTEGER default 0 not null
      , tran_flg INTEGER default 0 not null
      , sub_tran_flg INTEGER default 0 not null
      , off_entry_flg INTEGER default 0 not null
      , various_flg_1 INTEGER default 0 not null
      , various_flg_2 INTEGER default 0 not null
      , various_flg_3 INTEGER default 0 not null
      , various_num_1 INTEGER default 0 not null
      , various_num_2 INTEGER default 0 not null
      , various_num_3 INTEGER default 0 not null
      , various_data TEXT
      , various_flg_4 INTEGER default 0 not null
      , various_flg_5 INTEGER default 0 not null
      , various_flg_6 INTEGER default 0 not null
      , various_flg_7 INTEGER default 0 not null
      , various_flg_8 INTEGER default 0 not null
      , various_flg_9 INTEGER default 0 not null
      , various_flg_10 INTEGER default 0 not null
      , various_flg_11 INTEGER default 0 not null
      , various_flg_12 INTEGER default 0 not null
      , various_flg_13 INTEGER default 0 not null
      , reserv_flg INTEGER default 0 not null
      , reserv_stre_cd INTEGER default 0 not null
      , reserv_status INTEGER default 0 not null
      , reserv_chg_cnt INTEGER default 0 not null
      , reserv_cd TEXT
      , lock_cd TEXT
      , primary key (serial_no)
        )''');
  }

  for(var i = 1;i <= 2;i++) {
    var j;
    switch (i) {
      case 1:
      // 05_2	実績データログ	c_data_log
        j = "log";
        break;
      case 2:
      // RM3800 フローティング用実績データログ	c_data_log_floating
        j = "log_floating";
        break;
    }
    /// 05_2	実績データログ	c_data_log
    /// RM3800 フローティング用実績データログ	c_data_log_floating
    await db.execute('''create table c_data_$j (
    serial_no TEXT default '0' not null
    , seq_no INTEGER default 0 not null
    , cnct_seq_no INTEGER default 0 not null
    , func_cd INTEGER default 0 not null
    , func_seq_no INTEGER default 0 not null
    , c_data1 TEXT
    , c_data2 TEXT
    , c_data3 TEXT
    , c_data4 TEXT
    , c_data5 TEXT
    , c_data6 TEXT
    , c_data7 TEXT
    , c_data8 TEXT
    , c_data9 TEXT
    , c_data10 TEXT
    , n_data1 REAL default 0 not null
    , n_data2 REAL default 0 not null
    , n_data3 REAL default 0 not null
    , n_data4 REAL default 0 not null
    , n_data5 REAL default 0 not null
    , n_data6 REAL default 0 not null
    , n_data7 REAL default 0 not null
    , n_data8 REAL default 0 not null
    , n_data9 REAL default 0 not null
    , n_data10 REAL default 0 not null
    , n_data11 REAL default 0 not null
    , n_data12 REAL default 0 not null
    , n_data13 REAL default 0 not null
    , n_data14 REAL default 0 not null
    , n_data15 REAL default 0 not null
    , n_data16 REAL default 0 not null
    , n_data17 REAL default 0 not null
    , n_data18 REAL default 0 not null
    , n_data19 REAL default 0 not null
    , n_data20 REAL default 0 not null
    , n_data21 REAL default 0 not null
    , n_data22 REAL default 0 not null
    , n_data23 REAL default 0 not null
    , n_data24 REAL default 0 not null
    , n_data25 REAL default 0 not null
    , n_data26 REAL default 0 not null
    , n_data27 REAL default 0 not null
    , n_data28 REAL default 0 not null
    , n_data29 REAL default 0 not null
    , n_data30 REAL default 0 not null
    , d_data1 TEXT
    , d_data2 TEXT
    , d_data3 TEXT
    , d_data4 TEXT
    , d_data5 TEXT
    , primary key (serial_no, seq_no)
      )''');
  }

  for(var i = 1;i <= 2;i++) {
    var j;
    switch (i) {
      case 1:
      // 05_3	実績ステータスログ	c_status_log
        j = "log";
        break;
      case 2:
      // RM3800 フローティング用実績ステータスログ c_status_log_floating
        j = "log_floating";
        break;
    }
    /// 05_3	実績ステータスログ	c_status_log
    /// RM3800 フローティング用実績ステータスログ c_status_log_floating
    await db.execute('''create table c_status_$j (
      serial_no TEXT default '0' not null
      , seq_no INTEGER not null
      , cnct_seq_no INTEGER default 0 not null
      , func_cd INTEGER default 0 not null
      , func_seq_no INTEGER default 0 not null
      , status_data TEXT
      , primary key (serial_no, seq_no)
        )''');
  }

  /// 05_4	実績ジャーナルデータログ	c_ej_log
  await db.execute('''create table c_ej_log (
      serial_no TEXT default '0' not null
      , comp_cd INTEGER default 0 not null
      , stre_cd INTEGER default 0 not null
      , mac_no INTEGER default 0 not null
      , print_no INTEGER default 0 not null
      , seq_no INTEGER not null
      , receipt_no INTEGER default 0 not null
      , end_rec_flg INTEGER default 0 not null
      , only_ejlog_flg INTEGER default 0 not null
      , cshr_no INTEGER default 0 not null
      , chkr_no INTEGER default 0 not null
      , now_sale_datetime TEXT
      , sale_date TEXT
      , ope_mode_flg INTEGER default 0 not null
      , print_data TEXT
      , sub_only_ejlog_flg INTEGER default 0 not null
      , trankey_search TEXT
      , etckey_search TEXT
      , primary key (serial_no, seq_no)
      )''');

  /// 05_5	訂正確認ログ	c_void_log_01
  await db.execute('''create table c_void_log_01 (
    serial_no TEXT default '0' not null
    , void_serial_no TEXT default '0' not null
    , mac_no INTEGER default 0 not null
    , sale_date TEXT
    , void_sale_date TEXT
    , void_kind INTEGER default 0 not null
    , void_taxfree_no TEXT
    , various_data1 TEXT
    , various_data2 TEXT
    , primary key (serial_no, void_serial_no)
      )''');

  /// 05_6	公共料金_収納ログ	c_pbchg_log
  await db.execute('''create table c_pbchg_log (
    serial_no TEXT default '0' not null
    , seq_no INTEGER not null
    , comp_cd INTEGER default 0 not null
    , stre_cd INTEGER default 0 not null
    , mac_no INTEGER default 0 not null
    , date TEXT
    , time TEXT
    , groupcd INTEGER default 0 not null
    , officecd INTEGER default 0 not null
    , strecd INTEGER default 0 not null
    , termcd INTEGER default 0 not null
    , dealseqno INTEGER default 0 not null
    , servicekind TEXT
    , serviceseqno INTEGER default 0 not null
    , settlestatus INTEGER default 0 not null
    , settlekind INTEGER default 0 not null
    , cashamt INTEGER default 0 not null
    , charge1 INTEGER default 0 not null
    , charge2 INTEGER default 0 not null
    , dealererr INTEGER default 0 not null
    , receipterr INTEGER default 0 not null
    , validdate TEXT
    , barcodekind INTEGER default 0 not null
    , barcode1 TEXT
    , barcode2 TEXT
    , barcode3 TEXT
    , barcode4 TEXT
    , receiptmsgno INTEGER default 0 not null
    , comparestatus INTEGER default 0 not null
    , name TEXT
    , tran_flg INTEGER default 0 not null
    , sub_tran_flg INTEGER default 0 not null
    , receipt_flg INTEGER default 0 not null
    , matching_flg INTEGER default 0 not null
    , check_flg INTEGER default 0 not null
    , fil1 INTEGER default 0 not null
    , fil2 INTEGER default 0 not null
    , primary key (serial_no, seq_no, comp_cd, stre_cd)
      )''');

  /// 05_7	予約ログ	c_reserv_log
  await db.execute('''create table c_reserv_log (
    serial_no TEXT default '0' not null
    , now_sale_datetime TEXT not null
    , void_serial_no TEXT default '0'
    , cust_no TEXT
    , last_name TEXT
    , first_name TEXT
    , tel_no1 TEXT
    , tel_no2 TEXT
    , address1 TEXT
    , address2 TEXT
    , address3 TEXT
    , recept_date TEXT
    , ferry_date TEXT
    , arrival_date TEXT
    , qty INTEGER not null
    , ttl INTEGER not null
    , advance_money INTEGER not null
    , memo1 TEXT
    , memo2 TEXT
    , fil1 INTEGER not null
    , fil2 INTEGER not null
    , fil3 INTEGER not null
    , finish INTEGER not null
    , tran_flg INTEGER not null
    , sub_tran_flg INTEGER not null
    , center_flg INTEGER not null
    , update_flg INTEGER not null
    , primary key (serial_no, now_sale_datetime)
      )''');

  /// 05_8	リカバリー確認用テーブル	c_recover_tbl
  await db.execute('''create table c_recover_tbl (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , sale_date TEXT not null
    , exec_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , primary key (comp_cd, stre_cd, mac_no, sale_date)
      )''');

  /// 公共料金_収納ログ01	c_pbchg_log_01
  await db.execute('''create table c_pbchg_log_01 (
    serial_no TEXT default '0' not null
    , seq_no INTEGER not null
    , comp_cd INTEGER default 0 not null
    , stre_cd INTEGER default 0 not null
    , mac_no INTEGER default 0 not null
    , date TEXT
    , time TEXT
    , groupcd INTEGER default 0 not null
    , officecd INTEGER default 0 not null
    , strecd INTEGER default 0 not null
    , termcd INTEGER default 0 not null
    , dealseqno INTEGER default 0 not null
    , servicekind TEXT
    , serviceseqno INTEGER default 0 not null
    , settlestatus INTEGER default 0 not null
    , settlekind INTEGER default 0 not null
    , cashamt INTEGER default 0 not null
    , charge1 INTEGER default 0 not null
    , charge2 INTEGER default 0 not null
    , dealererr INTEGER default 0 not null
    , receipterr INTEGER default 0 not null
    , validdate TEXT
    , barcodekind INTEGER default 0 not null
    , barcode1 TEXT
    , barcode2 TEXT
    , barcode3 TEXT
    , barcode4 TEXT
    , receiptmsgno INTEGER default 0 not null
    , comparestatus INTEGER default 0 not null
    , name TEXT
    , tran_flg INTEGER default 0 not null
    , sub_tran_flg INTEGER default 0 not null
    , receipt_flg INTEGER default 0 not null
    , matching_flg INTEGER default 0 not null
    , check_flg INTEGER default 0 not null
    , fil1 INTEGER default 0 not null
    , fil2 INTEGER default 0 not null
    , primary key (serial_no, seq_no, comp_cd, stre_cd)
      )''');

  /// 予約ログ01	c_reserv_log_01
  await db.execute('''create table c_reserv_log_01 (
    serial_no TEXT default '0' not null
    , now_sale_datetime TEXT not null
    , void_serial_no TEXT default '0'
    , cust_no TEXT
    , last_name TEXT
    , first_name TEXT
    , tel_no1 TEXT
    , tel_no2 TEXT
    , address1 TEXT
    , address2 TEXT
    , address3 TEXT
    , recept_date TEXT
    , ferry_date TEXT
    , arrival_date TEXT
    , qty INTEGER not null
    , ttl INTEGER not null
    , advance_money INTEGER not null
    , memo1 TEXT
    , memo2 TEXT
    , fil1 INTEGER not null
    , fil2 INTEGER not null
    , fil3 INTEGER not null
    , finish INTEGER not null
    , tran_flg INTEGER not null
    , sub_tran_flg INTEGER not null
    , center_flg INTEGER not null
    , update_flg INTEGER not null
    , primary key (serial_no, now_sale_datetime)
      )''');

  /// ハイタッチ受信ログ c_hitouch_rcv_log
  await db.execute('''CREATE TABLE c_hitouch_rcv_log (
    rcv_datetime TEXT
    , tag_id TEXT
    , plu_cd TEXT
    , upd_flg INTEGER default 0 not null
    , primary key (rcv_datetime, tag_id)
        )''');
  //endregion
  //region 06_ノンプロモーション系
  /// 06_1	企画マスタ	c_plan_mst
  await db.execute('''create table c_plan_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , plan_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , loy_flg INTEGER default 0 not null
    , prom_typ INTEGER not null
    , start_datetime TEXT
    , end_datetime TEXT
    , trends_typ INTEGER default 0 not null
    , poptitle TEXT
    , promo_ext_id TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, plan_cd)
      )''');

  /// 06_2	特売マスタ	s_brgn_mst
  await db.execute('''create table s_brgn_mst (
      comp_cd INTEGER not null
      , stre_cd INTEGER not null
      , plan_cd INTEGER not null
      , brgn_cd INTEGER not null
      , plu_cd TEXT not null
      , showorder INTEGER default 0 not null
      , brgn_typ INTEGER default 0 not null
      , name TEXT
      , short_name TEXT
      , dsc_flg INTEGER default 0 not null
      , svs_typ INTEGER default 0 not null
      , dsc_typ INTEGER default 0 not null
      , start_datetime TEXT
      , end_datetime TEXT
      , timesch_flg INTEGER default 0 not null
      , sun_flg INTEGER default 1 not null
      , mon_flg INTEGER default 1 not null
      , tue_flg INTEGER default 1 not null
      , wed_flg INTEGER default 1 not null
      , thu_flg INTEGER default 1 not null
      , fri_flg INTEGER default 1 not null
      , sat_flg INTEGER default 1 not null
      , trends_typ INTEGER default 0 not null
      , brgn_prc INTEGER default 0 not null
      , brgncust_prc INTEGER default 0 not null
      , brgn_cost REAL default 0 not null
      , consist_val1 INTEGER default 0 not null
      , gram_prc INTEGER default 0 not null
      , markdown_flg INTEGER default 0 not null
      , markdown INTEGER default 0 not null
      , imagedata_cd INTEGER default 0 not null
      , advantize_cd INTEGER default 0 not null
      , labelsize INTEGER default 0 not null
      , auto_order_flg INTEGER default 0 not null
      , div_cd INTEGER default 0 not null
      , promo_ext_id TEXT
      , comment1 TEXT
      , comment2 TEXT
      , memo1 TEXT
      , memo2 TEXT
      , sale_cnt INTEGER default 0 not null
      , sale_unit TEXT
      , limit_info TEXT
      , first_service TEXT
      , card1 INTEGER default 0 not null
      , card2 INTEGER default 0 not null
      , card3 INTEGER default 0 not null
      , card4 INTEGER default 0 not null
      , card5 INTEGER default 0 not null
      , timeprc_dsc_flg INTEGER default 0 not null
      , brgn_div INTEGER default 0 not null
      , brgn_costper REAL default 0 not null
      , notes TEXT
      , qty_flg INTEGER default 0 not null
      , row_order_cnt INTEGER default 0 not null
      , row_order_add_cnt INTEGER default 0 not null
      , stop_flg INTEGER default 0 not null
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , date_flg1 INTEGER default 0 not null
      , date_flg2 INTEGER default 0 not null
      , date_flg3 INTEGER default 0 not null
      , date_flg4 INTEGER default 0 not null
      , date_flg5 INTEGER default 0 not null
      , primary key (comp_cd, stre_cd, plan_cd, brgn_cd, plu_cd)
      )''');

  /// 06_3	バンドルミックスマッチスケジュールマスタ	s_bdlsch_mst
  await db.execute('''create table s_bdlsch_mst (
      comp_cd INTEGER not null
      , stre_cd INTEGER not null
      , plan_cd INTEGER not null
      , bdl_cd INTEGER not null
      , bdl_typ INTEGER default 0 not null
      , name TEXT
      , short_name TEXT
      , start_datetime TEXT
      , end_datetime TEXT
      , timesch_flg INTEGER default 0 not null
      , sun_flg INTEGER default 1 not null
      , mon_flg INTEGER default 1 not null
      , tue_flg INTEGER default 1 not null
      , wed_flg INTEGER default 1 not null
      , thu_flg INTEGER default 1 not null
      , fri_flg INTEGER default 1 not null
      , sat_flg INTEGER default 1 not null
      , trends_typ INTEGER default 0 not null
      , bdl_qty1 INTEGER default 0 not null
      , bdl_qty2 INTEGER default 0 not null
      , bdl_qty3 INTEGER default 0 not null
      , bdl_qty4 INTEGER default 0 not null
      , bdl_qty5 INTEGER default 0 not null
      , bdl_prc1 INTEGER default 0 not null
      , bdl_prc2 INTEGER default 0 not null
      , bdl_prc3 INTEGER default 0 not null
      , bdl_prc4 INTEGER default 0 not null
      , bdl_prc5 INTEGER default 0 not null
      , bdl_avprc INTEGER default 0 not null
      , limit_cnt INTEGER default 0 not null
      , low_limit INTEGER default 0 not null
      , mbdl_prc1 INTEGER default 0 not null
      , mbdl_prc2 INTEGER default 0 not null
      , mbdl_prc3 INTEGER default 0 not null
      , mbdl_prc4 INTEGER default 0 not null
      , mbdl_prc5 INTEGER default 0 not null
      , mbdl_avprc INTEGER default 0 not null
      , stop_flg INTEGER default 0 not null
      , dsc_flg INTEGER default 0 not null
      , div_cd INTEGER default 0 not null
      , avprc_adpt_flg INTEGER default 0 not null
      , avprc_util_flg INTEGER default 0 not null
      , comment1 TEXT
      , comment2 TEXT
      , memo1 TEXT
      , memo2 TEXT
      , sale_unit TEXT
      , limit_info TEXT
      , first_service TEXT
      , card1 INTEGER default 0 not null
      , card2 INTEGER default 0 not null
      , card3 INTEGER default 0 not null
      , card4 INTEGER default 0 not null
      , card5 INTEGER default 0 not null
      , promo_ext_id TEXT
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , date_flg1 INTEGER default 0 not null
      , date_flg2 INTEGER default 0 not null
      , date_flg3 INTEGER default 0 not null
      , date_flg4 INTEGER default 0 not null
      , date_flg5 INTEGER default 0 not null
      , primary key (comp_cd, stre_cd, plan_cd, bdl_cd)
      )''');

  /// 06_4	バンドルミックスマッチ商品マスタ	s_bdlitem_mst
  await db.execute('''create table s_bdlitem_mst (
      comp_cd INTEGER not null
      , stre_cd INTEGER not null
      , plan_cd INTEGER not null
      , bdl_cd INTEGER not null
      , plu_cd TEXT not null
      , showorder INTEGER default 0 not null
      , stop_flg INTEGER default 0 not null
      , promo_ext_id TEXT
      , comment1 TEXT
      , comment2 TEXT
      , memo1 TEXT
      , memo2 TEXT
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , primary key (comp_cd, stre_cd, plan_cd, bdl_cd, plu_cd)
      )''');

  /// 06_5	セットマッチマスタ	s_stmsch_mst
  await db.execute('''create table s_stmsch_mst (
      comp_cd INTEGER not null
      , stre_cd INTEGER not null
      , plan_cd INTEGER not null
      , stm_cd INTEGER not null
      , name TEXT
      , short_name TEXT
      , start_datetime TEXT
      , end_datetime TEXT
      , timesch_flg INTEGER default 0 not null
      , sun_flg INTEGER default 1 not null
      , mon_flg INTEGER default 1 not null
      , tue_flg INTEGER default 1 not null
      , wed_flg INTEGER default 1 not null
      , thu_flg INTEGER default 1 not null
      , fri_flg INTEGER default 1 not null
      , sat_flg INTEGER default 1 not null
      , member_qty INTEGER default 0 not null
      , limit_cnt INTEGER default 0 not null
      , stop_flg INTEGER default 0 not null
      , trends_typ INTEGER default 0 not null
      , dsc_flg INTEGER default 0 not null
      , stm_prc INTEGER default 0 not null
      , stm_prc2 INTEGER default 0 not null
      , stm_prc3 INTEGER default 0 not null
      , stm_prc4 INTEGER default 0 not null
      , stm_prc5 INTEGER default 0 not null
      , mstm_prc INTEGER default 0 not null
      , mstm_prc2 INTEGER default 0 not null
      , mstm_prc3 INTEGER default 0 not null
      , mstm_prc4 INTEGER default 0 not null
      , mstm_prc5 INTEGER default 0 not null
      , div_cd INTEGER default 0 not null
      , promo_ext_id TEXT
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , date_flg1 INTEGER default 0 not null
      , date_flg2 INTEGER default 0 not null
      , date_flg3 INTEGER default 0 not null
      , date_flg4 INTEGER default 0 not null
      , date_flg5 INTEGER default 0 not null
      , primary key (comp_cd, stre_cd, plan_cd, stm_cd)
      )''');

  /// 06_6	セットマッチ商品マスタ	s_stmitem_mst
  await db.execute('''create table s_stmitem_mst (
      comp_cd INTEGER not null
      , stre_cd INTEGER not null
      , plan_cd INTEGER not null
      , stm_cd INTEGER not null
      , plu_cd TEXT not null
      , grpno INTEGER not null
      , stm_qty INTEGER default 0 not null
      , showorder INTEGER not null
      , poppy_flg INTEGER not null
      , stop_flg INTEGER not null
      , promo_ext_id TEXT
      , ins_datetime TEXT
      , upd_datetime TEXT
      , status INTEGER default 0 not null
      , send_flg INTEGER default 0 not null
      , upd_user INTEGER default 0 not null
      , upd_system INTEGER default 0 not null
      , primary key (comp_cd, stre_cd, plan_cd, stm_cd, plu_cd)
      )''');

  /// 06_7	商品加算ポイントマスタ	s_plu_point_mst
  await db.execute('''create table s_plu_point_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , plan_cd INTEGER not null
    , plusch_cd INTEGER not null
    , plu_cd TEXT not null
    , name TEXT
    , short_name TEXT
    , showorder INTEGER default 0 not null
    , point_add INTEGER default 0 not null
    , prom_cd1 INTEGER default 0 not null
    , prom_cd2 INTEGER default 0 not null
    , prom_cd3 INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 1 not null
    , mon_flg INTEGER default 1 not null
    , tue_flg INTEGER default 1 not null
    , wed_flg INTEGER default 1 not null
    , thu_flg INTEGER default 1 not null
    , fri_flg INTEGER default 1 not null
    , sat_flg INTEGER default 1 not null
    , stop_flg INTEGER default 0 not null
    , trends_typ INTEGER default 0 not null
    , acct_cd INTEGER default 0 not null
    , promo_ext_id TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , tnycls_cd INTEGER not null
    , plu_cls_flg INTEGER not null
    , pts_type INTEGER not null
    , pts_rate REAL default 0 not null
    , lrgcls_cd INTEGER not null
    , mdlcls_cd INTEGER not null
    , smlcls_cd INTEGER not null
    , primary key (comp_cd, stre_cd, plan_cd, plusch_cd, plu_cd, tnycls_cd, plu_cls_flg, pts_type, lrgcls_cd, mdlcls_cd, smlcls_cd)
      )''');

  /// 06_8	小計割引スケジュール	s_subtsch_mst
  await db.execute('''create table s_subtsch_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , plan_cd INTEGER not null
    , subt_cd INTEGER not null
    , name TEXT
    , short_name TEXT
    , svs_typ INTEGER default 0 not null
    , dsc_typ INTEGER default 0 not null
    , dsc_prc INTEGER default 0 not null
    , mdsc_prc INTEGER default 0 not null
    , stl_form_amt INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 1 not null
    , mon_flg INTEGER default 1 not null
    , tue_flg INTEGER default 1 not null
    , wed_flg INTEGER default 1 not null
    , thu_flg INTEGER default 1 not null
    , fri_flg INTEGER default 1 not null
    , sat_flg INTEGER default 1 not null
    , trends_typ INTEGER default 0 not null
    , stop_flg INTEGER default 0 not null
    , div_cd INTEGER default 0 not null
    , promo_ext_id TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, plan_cd, subt_cd)
      )''');

  /// 06_9	分類一括割引スケジュール	s_clssch_mst
  await db.execute('''create table s_clssch_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , plan_cd INTEGER not null
    , sch_cd INTEGER not null
    , lrgcls_cd INTEGER not null
    , mdlcls_cd INTEGER not null
    , smlcls_cd INTEGER not null
    , tnycls_cd INTEGER not null
    , svs_class INTEGER default 0 not null
    , name TEXT
    , short_name TEXT
    , svs_typ INTEGER default 0 not null
    , dsc_typ INTEGER default 0 not null
    , dsc_prc INTEGER default 0 not null
    , mdsc_prc INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 1 not null
    , mon_flg INTEGER default 1 not null
    , tue_flg INTEGER default 1 not null
    , wed_flg INTEGER default 1 not null
    , thu_flg INTEGER default 1 not null
    , fri_flg INTEGER default 1 not null
    , sat_flg INTEGER default 1 not null
    , trends_typ INTEGER default 0 not null
    , stop_flg INTEGER default 0 not null
    , div_cd INTEGER default 0 not null
    , promo_ext_id TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, plan_cd, sch_cd, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, svs_class)
      )''');

  /// 06_10	サービス分類スケジュールマスタ	s_svs_sch_mst
  await db.execute('''create table s_svs_sch_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , plan_cd INTEGER not null
    , svs_cls_sch_cd INTEGER not null
    , svs_cls_cd INTEGER not null
    , svs_cls_sch_name TEXT
    , point_add_magn REAL default 0 not null
    , point_add_mem_typ INTEGER default 0 not null
    , f_data1 REAL default 0 not null
    , s_data1 INTEGER default 0 not null
    , s_data2 INTEGER default 0 not null
    , s_data3 INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 1 not null
    , mon_flg INTEGER default 1 not null
    , tue_flg INTEGER default 1 not null
    , wed_flg INTEGER default 1 not null
    , thu_flg INTEGER default 1 not null
    , fri_flg INTEGER default 1 not null
    , sat_flg INTEGER default 1 not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , acct_cd INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, plan_cd, svs_cls_sch_cd, svs_cls_cd)
      )''');
  //endregion
  //region 07_ロイヤリティプロモーション系
  /// 07_1	アカウントマスタ	c_acct_mst
  await db.execute('''create table c_acct_mst (
    acct_cd INTEGER not null
    , mthr_acct_cd INTEGER default 0 not null
    , acct_name TEXT
    , rcpt_prn_flg INTEGER default 0 not null
    , prn_seq_no INTEGER default 0 not null
    , acct_typ INTEGER default 0 not null
    , start_date TEXT
    , end_date TEXT
    , plus_end_date TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , acct_cal_typ INTEGER default 0 not null
    , primary key (acct_cd, comp_cd, stre_cd)
      )''');

  /// 07_2	クーポンヘッダー	c_cpnhdr_mst
  await db.execute('''create table c_cpnhdr_mst (
    cpn_id INTEGER not null
    , comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , prn_stre_name TEXT
    , prn_time TEXT
    , start_date TEXT
    , end_date TEXT
    , template_id TEXT
    , pict_path TEXT
    , notes TEXT
    , line INTEGER default 0 not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , all_cust_flg INTEGER default 0 not null
    , prn_val INTEGER default 0 not null
    , val_flg INTEGER default 0 not null
    , prn_qty INTEGER default 1 not null
    , tran_qty INTEGER default 1 not null
    , day_qty INTEGER default 0 not null
    , ttl_qty INTEGER default 0 not null
    , reward_prom_cd INTEGER default 0 not null
    , linked_prom_cd INTEGER default 0 not null
    , rec_srch_id INTEGER default 0 not null
    , prn_upp_lim INTEGER default 0 not null
    , ref_typ INTEGER default 0 not null
    , stp_acct_cd INTEGER default 0 not null
    , stp_red_amt INTEGER default 0 not null
    , sng_prn_flg INTEGER default 0 not null
    , cust_kind_flg INTEGER default 0 not null
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 0 not null
    , mon_flg INTEGER default 0 not null
    , tue_flg INTEGER default 0 not null
    , wed_flg INTEGER default 0 not null
    , thu_flg INTEGER default 0 not null
    , fri_flg INTEGER default 0 not null
    , sat_flg INTEGER default 0 not null
    , date_flg1 INTEGER default 0 not null
    , date_flg2 INTEGER default 0 not null
    , date_flg3 INTEGER default 0 not null
    , date_flg4 INTEGER default 0 not null
    , date_flg5 INTEGER default 0 not null
    , stp_cpn_id INTEGER
    , cust_kind_trgt TEXT default '{0}' not null
    , ref_typ2 INTEGER default 0 not null
    , cust_card_kind INTEGER default 0 not null
    , n_custom1 INTEGER default 0 not null
    , n_custom2 INTEGER default 0 not null
    , n_custom3 INTEGER default 0 not null
    , n_custom4 INTEGER default 0 not null
    , n_custom5 INTEGER default 0 not null
    , n_custom6 INTEGER default 0 not null
    , n_custom7 INTEGER default 0 not null
    , n_custom8 INTEGER default 0 not null
    , s_custom1 INTEGER default 0 not null
    , s_custom2 INTEGER default 0 not null
    , s_custom3 INTEGER default 0 not null
    , s_custom4 INTEGER default 0 not null
    , s_custom5 INTEGER default 0 not null
    , s_custom6 INTEGER default 0 not null
    , s_custom7 INTEGER default 0 not null
    , s_custom8 INTEGER default 0 not null
    , c_custom1 TEXT
    , c_custom2 TEXT
    , c_custom3 TEXT
    , c_custom4 TEXT
    , d_custom1 TEXT
    , d_custom2 TEXT
    , d_custom3 TEXT
    , d_custom4 TEXT
    , primary key (cpn_id, comp_cd, stre_cd)
      )''');

  /// 07_3	クーポン明細	c_cpnbdy_mst
  await db.execute('''create table c_cpnbdy_mst (
    plan_cd INTEGER not null
    , cpn_id INTEGER
    , cpn_content TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , comp_cd INTEGER not null
    , primary key (plan_cd, comp_cd)
      )''');

  /// 07_4	顧客クーポン印字情報	s_cust_cpn_tbl
  await db.execute('''create table s_cust_cpn_tbl (
    cust_no TEXT not null
    , cpn_id INTEGER not null
    , comp_cd INTEGER not null
    , print_datetime TEXT
    , cpn_data TEXT
    , print_flg TEXT default '{0}' not null
    , stop_flg INTEGER default 0 not null
    , prn_comp_cd INTEGER default 0 not null
    , prn_stre_cd INTEGER default 0 not null
    , prn_mac_no INTEGER default 0 not null
    , prn_staff_cd INTEGER default 0 not null
    , prn_datetime TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , tday_cnt INTEGER default 0 not null
    , total_cnt INTEGER default 0 not null
    , primary key (cust_no, cpn_id, comp_cd)
      )''');

  /// 07_5	クーポン管理マスタ	c_cpn_ctrl_mst
  await db.execute('''create table c_cpn_ctrl_mst (
    cpn_id INTEGER not null
    , name TEXT
    , start_datetime TEXT
    , end_datetime TEXT
    , cpn_start_datetime TEXT
    , cpn_end_datetime TEXT
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , comp_cd INTEGER not null
    , primary key (cpn_id, comp_cd)
      )''');

  /// 07_6	ロイヤリティ企画対象店舗マスタ	c_loystre_mst
  await db.execute('''create table c_loystre_mst (
    cpn_id INTEGER not null
    , comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (cpn_id, comp_cd, stre_cd)
      )''');

  /// 07_7	ロイヤリティ企画マスタ	c_loypln_mst
  await db.execute('''create table c_loypln_mst (
    plan_cd INTEGER not null
    , cpn_id INTEGER
    , all_cust_flg INTEGER default 0 not null
    , all_stre_flg INTEGER default 0 not null
    , prom_name TEXT
    , rcpt_name TEXT
    , svs_class INTEGER default 0 not null
    , svs_typ INTEGER default 0 not null
    , reward_val INTEGER default 0 not null
    , bdl_prc_flg INTEGER default 0 not null
    , bdl_qty TEXT default '{0,0,0,0,0}' not null
    , bdl_prc TEXT default '{0,0,0,0,0}' not null
    , bdl_reward_val TEXT default '{0,0,0,0,0}' not null
    , form_amt INTEGER default 0 not null
    , form_qty INTEGER default 0 not null
    , rec_limit INTEGER default 0 not null
    , day_limit INTEGER default 0 not null
    , max_limit INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , stop_flg INTEGER default 0 not null
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 0 not null
    , mon_flg INTEGER default 0 not null
    , tue_flg INTEGER default 0 not null
    , wed_flg INTEGER default 0 not null
    , thu_flg INTEGER default 0 not null
    , fri_flg INTEGER default 0 not null
    , sat_flg INTEGER default 0 not null
    , acct_cd INTEGER default 0 not null
    , seq_no INTEGER default 0 not null
    , promo_ext_id TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , cpn_kind INTEGER default 0 not null
    , svs_kind INTEGER default 0 not null
    , refer_comp_cd INTEGER default 0 not null
    , comp_cd INTEGER not null
    , mul_val REAL default 0 not null
    , reward_flg INTEGER default 0 not null
    , bcd_all_cust_flg INTEGER default 0 not null
    , loy_bcd TEXT
    , low_lim INTEGER default 0 not null
    , upp_lim INTEGER default 0 not null
    , val_flg INTEGER default 0 not null
    , ref_typ INTEGER default 0 not null
    , apl_cnt INTEGER default 1 not null
    , stp_acct_cd INTEGER default 0 not null
    , stp_red_amt INTEGER default 0 not null
    , cust_kind_flg INTEGER default 0 not null
    , date_flg1 INTEGER default 0 not null
    , date_flg2 INTEGER default 0 not null
    , date_flg3 INTEGER default 0 not null
    , date_flg4 INTEGER default 0 not null
    , date_flg5 INTEGER default 0 not null
    , stp_cpn_id INTEGER
    , svs_content TEXT
    , cust_kind_trgt TEXT default '{0}' not null
    , ref_typ2 INTEGER default 0 not null
    , pay_key_cd INTEGER default 0 not null
    , cust_card_kind INTEGER default 0 not null
    , n_custom1 INTEGER default 0 not null
    , n_custom2 INTEGER default 0 not null
    , n_custom3 INTEGER default 0 not null
    , n_custom4 INTEGER default 0 not null
    , n_custom5 INTEGER default 0 not null
    , n_custom6 INTEGER default 0 not null
    , n_custom7 INTEGER default 0 not null
    , n_custom8 INTEGER default 0 not null
    , s_custom1 INTEGER default 0 not null
    , s_custom2 INTEGER default 0 not null
    , s_custom3 INTEGER default 0 not null
    , s_custom4 INTEGER default 0 not null
    , s_custom5 INTEGER default 0 not null
    , s_custom6 INTEGER default 0 not null
    , s_custom7 INTEGER default 0 not null
    , s_custom8 INTEGER default 0 not null
    , c_custom1 TEXT
    , c_custom2 TEXT
    , c_custom3 TEXT
    , c_custom4 TEXT
    , d_custom1 TEXT
    , d_custom2 TEXT
    , d_custom3 TEXT
    , d_custom4 TEXT
    , primary key (plan_cd, comp_cd)
      )''');

  /// 07_8	ロイヤリティ企画商品マスタ	c_loyplu_mst
  await db.execute('''create table c_loyplu_mst (
    plan_cd INTEGER not null
    , prom_cd TEXT not null
    , cpn_id INTEGER
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , comp_cd INTEGER not null
    , val REAL default 0 not null
    , ref_flg INTEGER not null
    , exclude_flg INTEGER default 0 not null
    , prom_cd2 TEXT default '0' not null
    , sub_cls_cd INTEGER default 0 not null
    , primary key (plan_cd, prom_cd, comp_cd, ref_flg, prom_cd2, sub_cls_cd)
      )''');

  /// 07_9	ロイヤリティ企画メッセージマスタ	c_loytgt_mst
  await db.execute('''create table c_loytgt_mst (
    plan_cd INTEGER not null
    , cpn_id INTEGER
    , title_data TEXT
    , title_col INTEGER default 0 not null
    , title_siz INTEGER default 0 not null
    , message1 TEXT
    , message1_col INTEGER default 0 not null
    , message1_siz INTEGER default 0 not null
    , message2 TEXT
    , message2_col INTEGER default 0 not null
    , message2_siz INTEGER default 0 not null
    , message3 TEXT
    , message3_col INTEGER default 0 not null
    , message3_siz INTEGER default 0 not null
    , message4 TEXT
    , message4_col INTEGER default 0 not null
    , message4_siz INTEGER default 0 not null
    , message5 TEXT
    , message5_col INTEGER default 0 not null
    , message5_siz INTEGER default 0 not null
    , dialog_typ INTEGER default 0 not null
    , dialog_img_cd INTEGER default 0 not null
    , dialog_icon_cd INTEGER default 0 not null
    , dialog_sound_cd INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , comp_cd INTEGER not null
    , primary key (plan_cd, comp_cd)
      )''');

  /// 07_10	顧客プロモーションテーブル	s_cust_loy_tbl
  await db.execute('''create table s_cust_loy_tbl (
    cust_no TEXT not null
    , cpn_id INTEGER not null
    , comp_cd INTEGER not null
    , plan_cd TEXT default '{0}' not null
    , tday_cnt TEXT default '{0}' not null
    , total_cnt TEXT default '{0}' not null
    , last_sellday TEXT
    , prn_seq_no TEXT default '{0}' not null
    , prn_flg TEXT default '{0}' not null
    , target_flg TEXT default '{0}' not null
    , stop_flg TEXT default '{0}' not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (cust_no, cpn_id, comp_cd)
      )''');

  /// 07_11	顧客別累計購買情報テーブル	s_cust_ttl_tbl
  await db.execute('''create table s_cust_ttl_tbl (
    cust_no TEXT not null
    , comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , srch_cust_no TEXT
    , acct_cd_1 INTEGER default 0 not null
    , acct_totalpnt_1 INTEGER default 0 not null
    , acct_totalamt_1 INTEGER default 0 not null
    , acct_totalqty_1 INTEGER default 0 not null
    , acct_cd_2 INTEGER default 0 not null
    , acct_totalpnt_2 INTEGER default 0 not null
    , acct_totalamt_2 INTEGER default 0 not null
    , acct_totalqty_2 INTEGER default 0 not null
    , acct_cd_3 INTEGER default 0 not null
    , acct_totalpnt_3 INTEGER default 0 not null
    , acct_totalamt_3 INTEGER default 0 not null
    , acct_totalqty_3 INTEGER default 0 not null
    , acct_cd_4 INTEGER default 0 not null
    , acct_totalpnt_4 INTEGER default 0 not null
    , acct_totalamt_4 INTEGER default 0 not null
    , acct_totalqty_4 INTEGER default 0 not null
    , acct_cd_5 INTEGER default 0 not null
    , acct_totalpnt_5 INTEGER default 0 not null
    , acct_totalamt_5 INTEGER default 0 not null
    , acct_totalqty_5 INTEGER default 0 not null
    , month_amt_1 INTEGER default 0 not null
    , month_amt_2 INTEGER default 0 not null
    , month_amt_3 INTEGER default 0 not null
    , month_amt_4 INTEGER default 0 not null
    , month_amt_5 INTEGER default 0 not null
    , month_amt_6 INTEGER default 0 not null
    , month_amt_7 INTEGER default 0 not null
    , month_amt_8 INTEGER default 0 not null
    , month_amt_9 INTEGER default 0 not null
    , month_amt_10 INTEGER default 0 not null
    , month_amt_11 INTEGER default 0 not null
    , month_amt_12 INTEGER default 0 not null
    , month_visit_date_1 TEXT
    , month_visit_date_2 TEXT
    , month_visit_date_3 TEXT
    , month_visit_date_4 TEXT
    , month_visit_date_5 TEXT
    , month_visit_date_6 TEXT
    , month_visit_date_7 TEXT
    , month_visit_date_8 TEXT
    , month_visit_date_9 TEXT
    , month_visit_date_10 TEXT
    , month_visit_date_11 TEXT
    , month_visit_date_12 TEXT
    , month_visit_cnt_1 INTEGER default 0 not null
    , month_visit_cnt_2 INTEGER default 0 not null
    , month_visit_cnt_3 INTEGER default 0 not null
    , month_visit_cnt_4 INTEGER default 0 not null
    , month_visit_cnt_5 INTEGER default 0 not null
    , month_visit_cnt_6 INTEGER default 0 not null
    , month_visit_cnt_7 INTEGER default 0 not null
    , month_visit_cnt_8 INTEGER default 0 not null
    , month_visit_cnt_9 INTEGER default 0 not null
    , month_visit_cnt_10 INTEGER default 0 not null
    , month_visit_cnt_11 INTEGER default 0 not null
    , month_visit_cnt_12 INTEGER default 0 not null
    , bnsdsc_amt INTEGER default 0 not null
    , bnsdsc_visit_date TEXT
    , ttl_amt INTEGER default 0 not null
    , delivery_date TEXT
    , last_name TEXT
    , first_name TEXT
    , birth_day TEXT
    , tel_no1 TEXT
    , tel_no2 TEXT
    , last_visit_date TEXT
    , pnt_service_type INTEGER default 0 not null
    , pnt_service_limit INTEGER default 0 not null
    , portal_flg INTEGER default 0 not null
    , enq_comp_cd INTEGER default 0 not null
    , enq_stre_cd INTEGER default 0 not null
    , enq_mac_no INTEGER default 0 not null
    , enq_datetime TEXT
    , cust_status INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , targ_typ INTEGER default 0 not null
    , staff_flg INTEGER default 0 not null
    , cust_prc_type INTEGER default 0 not null
    , sch_acct_cd_1 INTEGER default 0 not null
    , acct_accval_1 INTEGER default 0 not null
    , acct_optotal_1 INTEGER default 0 not null
    , sch_acct_cd_2 INTEGER default 0 not null
    , acct_accval_2 INTEGER default 0 not null
    , acct_optotal_2 INTEGER default 0 not null
    , sch_acct_cd_3 INTEGER default 0 not null
    , acct_accval_3 INTEGER default 0 not null
    , acct_optotal_3 INTEGER default 0 not null
    , sch_acct_cd_4 INTEGER default 0 not null
    , acct_accval_4 INTEGER default 0 not null
    , acct_optotal_4 INTEGER default 0 not null
    , sch_acct_cd_5 INTEGER default 0 not null
    , acct_accval_5 INTEGER default 0 not null
    , acct_optotal_5 INTEGER default 0 not null
    , c_data1 TEXT
    , n_data1 INTEGER default 0 not null
    , n_data2 INTEGER default 0 not null
    , n_data3 INTEGER default 0 not null
    , n_data4 INTEGER default 0 not null
    , n_data5 INTEGER default 0 not null
    , n_data6 INTEGER default 0 not null
    , n_data7 INTEGER default 0 not null
    , n_data8 INTEGER default 0 not null
    , n_data9 INTEGER default 0 not null
    , n_data10 INTEGER default 0 not null
    , n_data11 INTEGER default 0 not null
    , n_data12 INTEGER default 0 not null
    , n_data13 INTEGER default 0 not null
    , n_data14 INTEGER default 0 not null
    , n_data15 INTEGER default 0 not null
    , n_data16 INTEGER default 0 not null
    , s_data1 INTEGER default 0 not null
    , s_data2 INTEGER default 0 not null
    , s_data3 INTEGER default 0 not null
    , d_data1 TEXT
    , d_data2 TEXT
    , d_data3 TEXT
    , d_data4 TEXT
    , d_data5 TEXT
    , d_data6 TEXT
    , d_data7 TEXT
    , d_data8 TEXT
    , d_data9 TEXT
    , d_data10 TEXT
    , primary key (cust_no, comp_cd)
      )''');

  /// 07_12	ランク判定マスタ	c_rank_mst
  await db.execute('''create table c_rank_mst (
    comp_cd INTEGER not null
    , rank_cd INTEGER not null
    , rank_kind INTEGER not null
    , rank_name TEXT
    , reward_typ INTEGER default 0 not null
    , rank_judge_1 INTEGER default 0 not null
    , rank_judge_2 INTEGER default 0 not null
    , rank_judge_3 INTEGER default 0 not null
    , rank_judge_4 INTEGER default 0 not null
    , rank_judge_5 INTEGER default 0 not null
    , rank_judge_6 INTEGER default 0 not null
    , rank_judge_7 INTEGER default 0 not null
    , rank_judge_8 INTEGER default 0 not null
    , rank_judge_9 INTEGER default 0 not null
    , rank_judge_10 INTEGER default 0 not null
    , rank_reward_1 INTEGER default 0 not null
    , rank_reward_2 INTEGER default 0 not null
    , rank_reward_3 INTEGER default 0 not null
    , rank_reward_4 INTEGER default 0 not null
    , rank_reward_5 INTEGER default 0 not null
    , rank_reward_6 INTEGER default 0 not null
    , rank_reward_7 INTEGER default 0 not null
    , rank_reward_8 INTEGER default 0 not null
    , rank_reward_9 INTEGER default 0 not null
    , rank_reward_10 INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 0 not null
    , mon_flg INTEGER default 0 not null
    , tue_flg INTEGER default 0 not null
    , wed_flg INTEGER default 0 not null
    , thu_flg INTEGER default 0 not null
    , fri_flg INTEGER default 0 not null
    , sat_flg INTEGER default 0 not null
    , seq_no INTEGER default 0 not null
    , promo_ext_id TEXT
    , acct_cd INTEGER default 0 not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, rank_cd, rank_kind)
      )''');

  /// 07_13	ターミナル予約マスタ	c_trm_rsrv_mst
  await db.execute('''create table c_trm_rsrv_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , trm_cd INTEGER not null
    , kopt_cd INTEGER not null
    , rsrv_datetime TEXT not null
    , trm_data REAL default 0 not null
    , trm_data_str TEXT
    , trm_data_typ INTEGER default 0 not null
    , trm_ref_flg INTEGER default 0 not null
    , seq_no INTEGER not null
    , promo_ext_id TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , stop_flg INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, trm_cd, kopt_cd, rsrv_datetime)
      )''');

  /// 07_14	ポイントスケジュールマスタ	c_pntsch_mst
  await db.execute('''create table c_pntsch_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , pntsch_cd INTEGER not null
    , name TEXT
    , start_datetime TEXT
    , end_datetime TEXT
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 1 not null
    , mon_flg INTEGER default 1 not null
    , tue_flg INTEGER default 1 not null
    , wed_flg INTEGER default 1 not null
    , thu_flg INTEGER default 1 not null
    , fri_flg INTEGER default 1 not null
    , sat_flg INTEGER default 1 not null
    , stop_flg INTEGER default 0 not null
    , seq_no INTEGER not null
    , promo_ext_id TEXT
    , acct_cd INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, pntsch_cd)
      )''');

  /// 07_15	ポイントスケジュールグループマスタ	c_pntschgrp_mst
  await db.execute('''create table c_pntschgrp_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , pntsch_cd INTEGER not null
    , trm_grp_cd INTEGER not null
    , trm_cd INTEGER not null
    , trm_data REAL default 0 not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , low_lim INTEGER default 0 not null
    , acct_cd INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, pntsch_cd, trm_grp_cd, trm_cd)
      )''');

  /// 07_16	ターミナル企画番号マスタ	c_trm_plan_mst
  await db.execute('''create table c_trm_plan_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , acct_cd INTEGER not null
    , acct_flg INTEGER default 0 not null
    , seq_no INTEGER not null
    , promo_ext_id TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, acct_cd, acct_flg)
      )''');

  /// 07_17	顧客スタンプカードテーブル	s_cust_stp_tbl
  await db.execute('''create table s_cust_stp_tbl (
    cust_no TEXT not null
    , comp_cd INTEGER not null
    , acct_cd INTEGER not null
    , acc_amt INTEGER default 0 not null
    , red_amt INTEGER default 0 not null
    , last_upd_date TEXT
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , cpn_id INTEGER not null
    , tday_acc_amt INTEGER default 0 not null
    , primary key (cust_no, comp_cd, acct_cd, cpn_id)
      )''');

  /// 07_18	スタンプカード企画マスタ	c_stppln_mst
  await db.execute('''create table c_stppln_mst (
    cpn_id INTEGER not null
    , plan_cd INTEGER not null
    , comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , all_cust_flg INTEGER default 0 not null
    , cust_kind_flg INTEGER default 0 not null
    , plan_name TEXT
    , rcpt_name TEXT
    , format_flg INTEGER default 0
    , pict_path TEXT
    , notes TEXT
    , prn_stre_name TEXT
    , prn_time TEXT
    , c_data1 TEXT
    , c_data2 TEXT
    , c_data3 TEXT
    , c_data4 TEXT
    , c_data5 TEXT
    , c_data6 TEXT
    , s_data1 INTEGER default 0
    , s_data2 INTEGER default 0
    , s_data3 INTEGER default 0
    , ref_unit_flg INTEGER default 0 not null
    , cond_class_flg INTEGER default 0 not null
    , low_lim INTEGER default 0 not null
    , upp_lim INTEGER default 0 not null
    , rec_limit INTEGER default 0 not null
    , day_limit INTEGER default 0 not null
    , max_limit INTEGER default 0 not null
    , start_datetime TEXT
    , end_datetime TEXT
    , svs_start_datetime TEXT
    , svs_end_datetime TEXT
    , stop_flg INTEGER default 0 not null
    , timesch_flg INTEGER default 0 not null
    , sun_flg INTEGER default 0 not null
    , mon_flg INTEGER default 0 not null
    , tue_flg INTEGER default 0 not null
    , wed_flg INTEGER default 0 not null
    , thu_flg INTEGER default 0 not null
    , fri_flg INTEGER default 0 not null
    , sat_flg INTEGER default 0 not null
    , date_flg1 INTEGER default 0 not null
    , date_flg2 INTEGER default 0 not null
    , date_flg3 INTEGER default 0 not null
    , date_flg4 INTEGER default 0 not null
    , date_flg5 INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , cust_kind_trgt TEXT default '{0}' not null
    , n_custom1 INTEGER default 0 not null
    , n_custom2 INTEGER default 0 not null
    , n_custom3 INTEGER default 0 not null
    , n_custom4 INTEGER default 0 not null
    , n_custom5 INTEGER default 0 not null
    , n_custom6 INTEGER default 0 not null
    , n_custom7 INTEGER default 0 not null
    , n_custom8 INTEGER default 0 not null
    , s_custom1 INTEGER default 0 not null
    , s_custom2 INTEGER default 0 not null
    , s_custom3 INTEGER default 0 not null
    , s_custom4 INTEGER default 0 not null
    , s_custom5 INTEGER default 0 not null
    , s_custom6 INTEGER default 0 not null
    , s_custom7 INTEGER default 0 not null
    , s_custom8 INTEGER default 0 not null
    , c_custom1 TEXT
    , c_custom2 TEXT
    , c_custom3 TEXT
    , c_custom4 TEXT
    , d_custom1 TEXT
    , d_custom2 TEXT
    , d_custom3 TEXT
    , d_custom4 TEXT
    , primary key (cpn_id, plan_cd, comp_cd, stre_cd)
      )''');
  //endregion
  //region 08_顧客マスタ系
  /// 08_1	顧客マスタ	c_cust_mst
  await db.execute('''create table c_cust_mst (
    cust_no TEXT not null
    , comp_cd INTEGER not null
    , stre_cd INTEGER default 0 not null
    , last_name TEXT
    , first_name TEXT
    , kana_last_name TEXT
    , kana_first_name TEXT
    , birth_day TEXT
    , tel_no1 TEXT
    , tel_no2 TEXT
    , sex INTEGER default 0 not null
    , cust_status INTEGER default 0 not null
    , admission_date TEXT
    , withdraw_date TEXT
    , withdraw_typ INTEGER default 0 not null
    , withdraw_resn TEXT
    , card_clct_typ INTEGER default 0 not null
    , custzone_cd INTEGER default 0 not null
    , post_no TEXT
    , address1 TEXT
    , address2 TEXT
    , address3 TEXT
    , mail_addr TEXT
    , mail_flg INTEGER default 0 not null
    , dm_flg INTEGER default 0 not null
    , password TEXT
    , targ_typ INTEGER default 0 not null
    , attrib1 INTEGER default 0 not null
    , attrib2 INTEGER default 0 not null
    , attrib3 INTEGER default 0 not null
    , attrib4 INTEGER default 0 not null
    , attrib5 INTEGER default 0 not null
    , attrib6 INTEGER default 0 not null
    , attrib7 INTEGER default 0 not null
    , attrib8 INTEGER default 0 not null
    , attrib9 INTEGER default 0 not null
    , attrib10 INTEGER default 0 not null
    , mov_flg INTEGER default 0 not null
    , pre_cust_no TEXT
    , remark TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , svs_cls_cd INTEGER default 999999 not null
    , staff_flg INTEGER default 0 not null
    , cust_prc_type INTEGER default 0 not null
    , address4 TEXT
    , tel_flg INTEGER default 0 not null
    , primary key (cust_no, comp_cd)
      )''');

  /// 08_2	購買履歴確認除外商品テーブル	s_daybook_spplu_tbl
  await db.execute('''create table s_daybook_spplu_tbl (
    plu_cd TEXT not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (plu_cd)
      )''');

  /// 08_3	自店カード判定マスタ	c_cust_jdg_mst
  await db.execute('''create table c_cust_jdg_mst (
    comp_cd INTEGER not null
    , refer_stre_cd INTEGER not null
    , stop_flg INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, refer_stre_cd)
      )''');

  /// 08_4	会員カード判定マスタ	c_mbrcard_mst
  await db.execute('''create table c_mbrcard_mst (
    seq_no INTEGER not null
    , comp_cd INTEGER not null
    , code_from TEXT
    , code_to TEXT
    , c_data1 TEXT
    , c_data2 TEXT
    , c_data3 TEXT
    , s_data1 INTEGER default 0 not null
    , s_data2 INTEGER default 0 not null
    , n_data1 INTEGER default 0 not null
    , n_data2 INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (seq_no, comp_cd)
      )''');

  /// 08_5	会員カードサービス判定マスタ	c_mbrcard_svs_mst
  await db.execute('''create table c_mbrcard_svs_mst (
    rec_id INTEGER not null
    , comp_cd INTEGER not null
    , card_kind INTEGER not null
    , svs_cd INTEGER not null
    , c_data1 TEXT
    , c_data2 TEXT
    , c_data3 TEXT
    , s_data1 INTEGER default 0 not null
    , s_data2 INTEGER default 0 not null
    , n_data1 INTEGER default 0 not null
    , n_data2 INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (rec_id, comp_cd, card_kind, svs_cd)
      )''');
  //endregion
  //region 09_従業員マスタ系
  /// 09_1	従業員マスタ	c_staff_mst
  await db.execute('''create table c_staff_mst (
    comp_cd INTEGER not null
    , staff_cd INTEGER not null
    , stre_cd INTEGER not null
    , name TEXT
    , passwd TEXT
    , auth_lvl INTEGER default 0 not null
    , svr_auth_lvl INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , nochk_overlap INTEGER default 0 not null
    , primary key (comp_cd, staff_cd)
      )''');

  /// 09_2	従業員権限マスタ	c_staffauth_mst
  await db.execute('''create table c_staffauth_mst (
    comp_cd INTEGER not null
    , auth_lvl INTEGER not null
    , auth_name TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, auth_lvl)
      )''');

  /// 09_3	サーバー従業員権限マスタ	s_svr_staffauth_mst
  await db.execute('''create table s_svr_staffauth_mst (
    comp_cd INTEGER not null
    , svr_auth_lvl INTEGER not null
    , svr_auth_name TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, svr_auth_lvl)
      )''');

  /// 09_4	ファンクション操作権限マスタ	c_keyauth_mst
  await db.execute('''create table c_keyauth_mst (
    comp_cd INTEGER not null
    , auth_lvl INTEGER not null
    , fnc_cd INTEGER not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, auth_lvl, fnc_cd)
      )''');

  /// 09_5	レジメニュー操作権限マスタ	c_menuauth_mst
  await db.execute('''create table c_menuauth_mst (
    comp_cd INTEGER not null
    , auth_lvl INTEGER not null
    , appl_grp_cd INTEGER not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , menu_chk_flg INTEGER default 0 not null
    , primary key (comp_cd, auth_lvl, appl_grp_cd)
      )''');

  /// 09_6	従業員オープン情報マスタ	c_staffopen_mst
  await db.execute('''create table c_staffopen_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , chkr_cd TEXT
    , chkr_name TEXT
    , chkr_status INTEGER default 0 not null
    , chkr_open_time TEXT
    , chkr_start_no INTEGER default 0 not null
    , chkr_end_no INTEGER default 0 not null
    , cshr_cd TEXT
    , cshr_name TEXT
    , cshr_status INTEGER default 0 not null
    , cshr_open_time TEXT
    , cshr_start_no INTEGER default 0 not null
    , cshr_end_no INTEGER default 0 not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no)
      )''');

  /// 09_7	特定操作マスタ	c_operation_mst
  await db.execute('''create table c_operation_mst (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , ope_cd INTEGER not null
    , ope_name TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, ope_cd)
      )''');

  /// 09_8	特定操作権限マスタ	c_operationauth_mst
  await db.execute('''create table c_operationauth_mst (
    comp_cd INTEGER not null
    , auth_lvl INTEGER not null
    , ope_cd INTEGER not null
    , ins_datetime TEXT
    , upd_datetime TEXT
    , status INTEGER default 0 not null
    , send_flg INTEGER default 0 not null
    , upd_user INTEGER default 0 not null
    , upd_system INTEGER default 0 not null
    , primary key (comp_cd, auth_lvl, ope_cd)
      )''');
  //endregion
  //region 10_システム系
  /// 10_1	履歴ログ	c_histlog_mst
  await db.execute('''create table c_histlog_mst (
    hist_cd INTEGER not null
    , ins_datetime TEXT
    , comp_cd INTEGER default 0 not null
    , stre_cd INTEGER default 0 not null
    , table_name TEXT
    , mode INTEGER default 0 not null
    , mac_flg INTEGER
    , data1 TEXT
    , data2 TEXT
    , primary key (hist_cd)
      )''');

  /// 10_2	レジ履歴ログカウント	c_histlog_chg_cnt
  await db.execute('''create table c_histlog_chg_cnt (
    counter_cd INTEGER not null
    , hist_cd INTEGER
    , ins_datetime TEXT
    , primary key (counter_cd)
      )''');

  /// 10_3	履歴ログ制御コントロールマスタ	hist_ctrl_mst
  await db.execute('''create table hist_ctrl_mst (
    ctrl_cd INTEGER not null
    , flg1 INTEGER
    , flg2 INTEGER
    , flg3 INTEGER
    , flg4 INTEGER
    , flg5 INTEGER
    , flg6 INTEGER
    , flg7 INTEGER
    , flg8 INTEGER
    , flg9 INTEGER
    , flg10 INTEGER
    , primary key (ctrl_cd)
      )''');

  /// 10_4	履歴ログスキップ番号	histlog_skip_num
  await db.execute('''create table histlog_skip_num (
    hist_cd INTEGER
    , primary key (hist_cd)
      )''');
  //endregion
  //region 13_POS販売実績テーブル
  /// 13_1	レジ・扱者日別取引	rdly_deal
  await db.execute('''create table rdly_deal (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , chkr_no INTEGER default 0 not null
    , cshr_no INTEGER default 0 not null
    , sale_date TEXT not null
    , kind_cd TEXT not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 REAL default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, chkr_no, cshr_no, sale_date, kind_cd, sub)
      )''');

  /// 13_2	レジ・扱者日別取引時間帯	rdly_deal_hour
  await db.execute('''create table rdly_deal_hour (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , chkr_no INTEGER default 0 not null
    , cshr_no INTEGER default 0 not null
    , sale_date TEXT not null
    , date_hour TEXT not null
    , mode INTEGER not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 REAL default 0 not null
    , data11 REAL default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, chkr_no, cshr_no, sale_date, date_hour, mode, sub)
      )''');

  /// 13_3	レジ・扱者日別在高	rdly_flow
  await db.execute('''create table rdly_flow (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , chkr_no INTEGER default 0 not null
    , cshr_no INTEGER default 0 not null
    , sale_date TEXT not null
    , kind INTEGER not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, chkr_no, cshr_no, sale_date, kind, sub)
      )''');

  /// 13_4	レジ日別釣銭機	rdly_acr
  await db.execute('''create table rdly_acr (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , sale_date TEXT not null
    , acr_1_sht INTEGER default 0 not null
    , acr_5_sht INTEGER default 0 not null
    , acr_10_sht INTEGER default 0 not null
    , acr_50_sht INTEGER default 0 not null
    , acr_100_sht INTEGER default 0 not null
    , acr_500_sht INTEGER default 0 not null
    , acb_1000_sht INTEGER default 0 not null
    , acb_2000_sht INTEGER default 0 not null
    , acb_5000_sht INTEGER default 0 not null
    , acb_10000_sht INTEGER default 0 not null
    , acr_1_pol_sht INTEGER default 0 not null
    , acr_5_pol_sht INTEGER default 0 not null
    , acr_10_pol_sht INTEGER default 0 not null
    , acr_50_pol_sht INTEGER default 0 not null
    , acr_100_pol_sht INTEGER default 0 not null
    , acr_500_pol_sht INTEGER default 0 not null
    , acr_oth_pol_sht INTEGER default 0 not null
    , acb_1000_pol_sht INTEGER default 0 not null
    , acb_2000_pol_sht INTEGER default 0 not null
    , acb_5000_pol_sht INTEGER default 0 not null
    , acb_10000_pol_sht INTEGER default 0 not null
    , acb_fill_pol_sht INTEGER default 0 not null
    , acb_reject_cnt INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, sale_date)
      )''');

  /// 13_5	レジ日別分類	rdly_class
  await db.execute('''create table rdly_class (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , lgpcls_cd INTEGER not null
    , grpcls_cd INTEGER not null
    , lrgcls_cd INTEGER not null
    , mdlcls_cd INTEGER not null
    , smlcls_cd INTEGER not null
    , tnycls_cd INTEGER not null
    , sale_date TEXT not null
    , mode INTEGER not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 INTEGER default 0 not null
    , data11 INTEGER default 0 not null
    , data12 INTEGER default 0 not null
    , data13 INTEGER default 0 not null
    , data14 INTEGER default 0 not null
    , data15 INTEGER default 0 not null
    , data16 INTEGER default 0 not null
    , data17 INTEGER default 0 not null
    , data18 INTEGER default 0 not null
    , data19 INTEGER default 0 not null
    , data20 REAL default 0 not null
    , data21 REAL default 0 not null
    , data22 TEXT
    , primary key (comp_cd, stre_cd, mac_no, lgpcls_cd, grpcls_cd, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, sale_date, mode, sub)
      )''');

  /// 13_6	レジ日別分類時間帯	rdly_class_hour
  await db.execute('''create table rdly_class_hour (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , lgpcls_cd INTEGER not null
    , grpcls_cd INTEGER not null
    , lrgcls_cd INTEGER not null
    , mdlcls_cd INTEGER not null
    , smlcls_cd INTEGER not null
    , tnycls_cd INTEGER not null
    , sale_date TEXT not null
    , date_hour TEXT not null
    , mode INTEGER not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 INTEGER default 0 not null
    , data11 INTEGER default 0 not null
    , data12 INTEGER default 0 not null
    , data13 INTEGER default 0 not null
    , data14 INTEGER default 0 not null
    , data15 INTEGER default 0 not null
    , data16 INTEGER default 0 not null
    , data17 INTEGER default 0 not null
    , data18 INTEGER default 0 not null
    , data19 INTEGER default 0 not null
    , data20 REAL default 0 not null
    , data21 REAL default 0 not null
    , data22 TEXT
    , primary key (comp_cd, stre_cd, mac_no, lgpcls_cd, grpcls_cd, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, sale_date, date_hour, mode, sub)
      )''');

  /// 13_7	レジ日別商品	rdly_plu
  await db.execute('''create table rdly_plu (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , plu_cd TEXT not null
    , smlcls_cd INTEGER not null
    , sale_date TEXT not null
    , mode INTEGER not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 INTEGER default 0 not null
    , data11 INTEGER default 0 not null
    , data12 INTEGER default 0 not null
    , data13 INTEGER default 0 not null
    , data14 INTEGER default 0 not null
    , data15 INTEGER default 0 not null
    , data16 INTEGER default 0 not null
    , data17 INTEGER default 0 not null
    , data18 INTEGER default 0 not null
    , data19 INTEGER default 0 not null
    , data20 REAL default 0 not null
    , data21 REAL default 0 not null
    , data22 TEXT
    , primary key (comp_cd, stre_cd, mac_no, plu_cd, smlcls_cd, sale_date, mode, sub)
      )''');

  /// 13_8	レジ日別商品時間帯	rdly_plu_hour
  await db.execute('''create table rdly_plu_hour (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , plu_cd TEXT not null
    , smlcls_cd INTEGER not null
    , sale_date TEXT not null
    , date_hour TEXT not null
    , mode INTEGER not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 INTEGER default 0 not null
    , data11 INTEGER default 0 not null
    , data12 INTEGER default 0 not null
    , data13 INTEGER default 0 not null
    , data14 INTEGER default 0 not null
    , data15 INTEGER default 0 not null
    , data16 INTEGER default 0 not null
    , data17 INTEGER default 0 not null
    , data18 INTEGER default 0 not null
    , data19 INTEGER default 0 not null
    , data20 REAL default 0 not null
    , data21 REAL default 0 not null
    , data22 TEXT
    , primary key (comp_cd, stre_cd, mac_no, plu_cd, smlcls_cd, sale_date, date_hour, mode, sub)
      )''');

  /// 13_9	レジ日別値下	rdly_dsc
  await db.execute('''create table rdly_dsc (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , plu_cd TEXT not null
    , smlcls_cd INTEGER not null
    , sale_date TEXT not null
    , mode INTEGER not null
    , kind INTEGER not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, plu_cd, smlcls_cd, sale_date, mode, kind, sub)
      )''');

  /// 13_10	レジ日別プロモーション	rdly_prom
  await db.execute('''create table rdly_prom (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , sch_cd INTEGER not null
    , plu_cd TEXT not null
    , cls_cd INTEGER not null
    , sale_date TEXT not null
    , mode INTEGER not null
    , prom_typ INTEGER not null
    , sch_typ INTEGER not null
    , kind INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, sch_cd, plu_cd, cls_cd, sale_date, mode, prom_typ, sch_typ, kind)
      )''');

  /// 13_11	会員日別実績	rdly_cust
  await db.execute('''create table rdly_cust (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , cust_no TEXT not null
    , custzone_cd INTEGER default 0 not null
    , svs_cls_cd INTEGER default 999999 not null
    , sale_date TEXT not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 INTEGER default 0 not null
    , data11 INTEGER default 0 not null
    , data12 INTEGER default 0 not null
    , data13 INTEGER default 0 not null
    , data14 INTEGER default 0 not null
    , data15 INTEGER default 0 not null
    , data16 INTEGER default 0 not null
    , data17 INTEGER default 0 not null
    , data18 INTEGER default 0 not null
    , data19 INTEGER default 0 not null
    , data20 INTEGER default 0 not null
    , data21 INTEGER default 0 not null
    , data22 INTEGER default 0 not null
    , data23 INTEGER default 0 not null
    , data24 INTEGER default 0 not null
    , data25 REAL default 0 not null
    , primary key (comp_cd, stre_cd, cust_no, custzone_cd, svs_cls_cd, sale_date, sub)
      )''');

  /// 13_12	サービス分類日別実績	rdly_svs
  await db.execute('''create table rdly_svs (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , svs_cls_cd INTEGER default 999999 not null
    , sale_date TEXT not null
    , sub INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 INTEGER default 0 not null
    , data11 INTEGER default 0 not null
    , data12 INTEGER default 0 not null
    , data13 INTEGER default 0 not null
    , data14 INTEGER default 0 not null
    , data15 INTEGER default 0 not null
    , data16 INTEGER default 0 not null
    , data17 INTEGER default 0 not null
    , data18 INTEGER default 0 not null
    , data19 INTEGER default 0 not null
    , data20 INTEGER default 0 not null
    , data21 INTEGER default 0 not null
    , data22 INTEGER default 0 not null
    , data23 INTEGER default 0 not null
    , data24 INTEGER default 0 not null
    , data25 REAL default 0 not null
    , primary key (comp_cd, stre_cd, svs_cls_cd, sale_date, sub)
      )''');

  /// 13_13	レジ・扱者日別コード決済在高	rdly_cdpayflow
  await db.execute('''create table rdly_cdpayflow (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , chkr_no INTEGER default 0 not null
    , cshr_no INTEGER default 0 not null
    , sale_date TEXT not null
    , kind INTEGER not null
    , sub INTEGER not null
    , payopera_cd INTEGER default 0 not null
    , payopera_typ TEXT not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, chkr_no, cshr_no, sale_date, kind, sub, payopera_cd, payopera_typ)
      )''');

  /// 13_14	レジ・扱者日別税別明細	rdly_tax_deal
  await db.execute('''create table rdly_tax_deal (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , chkr_no INTEGER not null
    , cshr_no INTEGER not null
    , sale_date TEXT not null
    , mode INTEGER not null
    , kind INTEGER not null
    , sub INTEGER not null
    , func_cd INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 INTEGER default 0 not null
    , data11 INTEGER default 0 not null
    , data12 INTEGER default 0 not null
    , data13 INTEGER default 0 not null
    , data14 INTEGER default 0 not null
    , data15 INTEGER default 0 not null
    , data16 INTEGER default 0 not null
    , data17 INTEGER default 0 not null
    , data18 INTEGER default 0 not null
    , data19 INTEGER default 0 not null
    , data20 REAL default 0 not null
    , data21 REAL default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, chkr_no, cshr_no, sale_date, mode, kind, sub, func_cd)
      )''');

  /// 13_15	レジ・扱者日別時間帯税明細	rdly_tax_deal_hour
  await db.execute('''create table rdly_tax_deal_hour (
    comp_cd INTEGER not null
    , stre_cd INTEGER not null
    , mac_no INTEGER not null
    , chkr_no INTEGER not null
    , cshr_no INTEGER not null
    , sale_date TEXT not null
    , date_hour TEXT not null
    , mode INTEGER not null
    , kind INTEGER not null
    , sub INTEGER not null
    , func_cd INTEGER not null
    , data1 INTEGER default 0 not null
    , data2 INTEGER default 0 not null
    , data3 INTEGER default 0 not null
    , data4 INTEGER default 0 not null
    , data5 INTEGER default 0 not null
    , data6 INTEGER default 0 not null
    , data7 INTEGER default 0 not null
    , data8 INTEGER default 0 not null
    , data9 INTEGER default 0 not null
    , data10 INTEGER default 0 not null
    , data11 INTEGER default 0 not null
    , data12 INTEGER default 0 not null
    , data13 INTEGER default 0 not null
    , data14 INTEGER default 0 not null
    , data15 INTEGER default 0 not null
    , data16 INTEGER default 0 not null
    , data17 INTEGER default 0 not null
    , data18 INTEGER default 0 not null
    , data19 INTEGER default 0 not null
    , data20 REAL default 0 not null
    , data21 REAL default 0 not null
    , primary key (comp_cd, stre_cd, mac_no, chkr_no, cshr_no, sale_date, date_hour, mode, kind, sub, func_cd)
      )''');

  /// 13_16	実績ワーク	wk_que
  await db.execute('''create table wk_que (
    serial_no TEXT
    , pid INTEGER
    , wk_step INTEGER
    , endtime TEXT
    , primary key (serial_no)
      )''');
  //endregion
  //region 実績データログ 日付別
  for (var i = 1; i <= 33; i++) {
    var j;
    switch(i){
      case 32:
        //c_data_log_reserv	実績データログ予約
        j = "reserv";
        break;
      case 33:
        //c_data_log_reserv_01	実績データログ予約01
        j = "reserv_01";
        break;
      default:
        //c_data_log_XX	実績データログXX(01-31)
        j = i.toString().padLeft(2,"0");
        break;
    }
    await db.execute('''create table c_data_log_$j (
    serial_no TEXT default '0' not null
    , seq_no INTEGER default 0 not null
    , cnct_seq_no INTEGER default 0 not null
    , func_cd INTEGER default 0 not null
    , func_seq_no INTEGER default 0 not null
    , c_data1 TEXT
    , c_data2 TEXT
    , c_data3 TEXT
    , c_data4 TEXT
    , c_data5 TEXT
    , c_data6 TEXT
    , c_data7 TEXT
    , c_data8 TEXT
    , c_data9 TEXT
    , c_data10 TEXT
    , n_data1 REAL default 0 not null
    , n_data2 REAL default 0 not null
    , n_data3 REAL default 0 not null
    , n_data4 REAL default 0 not null
    , n_data5 REAL default 0 not null
    , n_data6 REAL default 0 not null
    , n_data7 REAL default 0 not null
    , n_data8 REAL default 0 not null
    , n_data9 REAL default 0 not null
    , n_data10 REAL default 0 not null
    , n_data11 REAL default 0 not null
    , n_data12 REAL default 0 not null
    , n_data13 REAL default 0 not null
    , n_data14 REAL default 0 not null
    , n_data15 REAL default 0 not null
    , n_data16 REAL default 0 not null
    , n_data17 REAL default 0 not null
    , n_data18 REAL default 0 not null
    , n_data19 REAL default 0 not null
    , n_data20 REAL default 0 not null
    , n_data21 REAL default 0 not null
    , n_data22 REAL default 0 not null
    , n_data23 REAL default 0 not null
    , n_data24 REAL default 0 not null
    , n_data25 REAL default 0 not null
    , n_data26 REAL default 0 not null
    , n_data27 REAL default 0 not null
    , n_data28 REAL default 0 not null
    , n_data29 REAL default 0 not null
    , n_data30 REAL default 0 not null
    , d_data1 TEXT
    , d_data2 TEXT
    , d_data3 TEXT
    , d_data4 TEXT
    , d_data5 TEXT
    , primary key (serial_no, seq_no)
      )''');
  }
  //endregion
  //region 実績ヘッダログ 日付別
  for (var i = 1; i <= 33; i++) {
    var j;
    switch (i) {
      case 32:
      //c_header_log_reserv	実績ヘッダログ予約
        j = "reserv";
        break;
      case 33:
      //c_header_log_reserv_01	実績ヘッダログ予約01
        j = "reserv_01";
        break;
      default:
      //c_header_log_XX	実績ヘッダログXX(01-31)
        j = i.toString().padLeft(2, "0");
        break;
    }
    await db.execute('''create table c_header_log_$j (
    serial_no TEXT default 0 not null
    , comp_cd INTEGER default 0 not null
    , stre_cd INTEGER default 0 not null
    , mac_no INTEGER default 0 not null
    , receipt_no INTEGER default 0 not null
    , print_no INTEGER default 0 not null
    , cshr_no INTEGER default 0 not null
    , chkr_no INTEGER default 0 not null
    , cust_no TEXT
    , sale_date TEXT
    , starttime TEXT
    , endtime TEXT
    , ope_mode_flg INTEGER default 0 not null
    , inout_flg INTEGER default 0 not null
    , prn_typ INTEGER default 0 not null
    , void_serial_no TEXT default 0 not null
    , qc_serial_no TEXT default 0 not null
    , void_kind INTEGER default 0 not null
    , void_sale_date TEXT
    , data_log_cnt INTEGER default 0 not null
    , ej_log_cnt INTEGER default 0 not null
    , status_log_cnt INTEGER default 0 not null
    , tran_flg INTEGER default 0 not null
    , sub_tran_flg INTEGER default 0 not null
    , off_entry_flg INTEGER default 0 not null
    , various_flg_1 INTEGER default 0 not null
    , various_flg_2 INTEGER default 0 not null
    , various_flg_3 INTEGER default 0 not null
    , various_num_1 INTEGER default 0 not null
    , various_num_2 INTEGER default 0 not null
    , various_num_3 INTEGER default 0 not null
    , various_data TEXT
    , various_flg_4 INTEGER default 0 not null
    , various_flg_5 INTEGER default 0 not null
    , various_flg_6 INTEGER default 0 not null
    , various_flg_7 INTEGER default 0 not null
    , various_flg_8 INTEGER default 0 not null
    , various_flg_9 INTEGER default 0 not null
    , various_flg_10 INTEGER default 0 not null
    , various_flg_11 INTEGER default 0 not null
    , various_flg_12 INTEGER default 0 not null
    , various_flg_13 INTEGER default 0 not null
    , reserv_flg INTEGER default 0 not null
    , reserv_stre_cd INTEGER default 0 not null
    , reserv_status INTEGER default 0 not null
    , reserv_chg_cnt INTEGER default 0 not null
    , reserv_cd TEXT
    , lock_cd TEXT
    , primary key (serial_no)
      )''');
  }
  //endregion
  //region 実績ステータスログ 日付別
  for (var i = 1; i <= 33; i++) {
    var j;
    switch (i) {
      case 32:
      //c_status_log_reserv	実績ステータスログ予約
        j = "reserv";
        break;
      case 33:
      //c_status_log_reserv_01	実績ステータスログ予約01
        j = "reserv_01";
        break;
      default:
      //c_status_log_XX	実績ステータスログXX(01-31)
        j = i.toString().padLeft(2, "0");
        break;
    }
    await db.execute('''create table c_status_log_$j (
    serial_no TEXT default '0' not null
    , seq_no INTEGER not null
    , cnct_seq_no INTEGER default 0 not null
    , func_cd INTEGER default 0 not null
    , func_seq_no INTEGER default 0 not null
    , status_data TEXT
    , primary key (serial_no, seq_no)
      )''');
  }
  //endregion
  //region 実績ジャーナルデータログ 日付別
  for (var i = 1; i <= 31; i++) {
    //c_ej_log_XX	実績ジャーナルデータログXX(01-31)
    var j = i.toString().padLeft(2, "0");

    await db.execute('''create table c_ej_log_$j (
    serial_no TEXT default 0 not null
    , comp_cd INTEGER default 0 not null
    , stre_cd INTEGER default 0 not null
    , mac_no INTEGER default 0 not null
    , print_no INTEGER default 0 not null
    , seq_no INTEGER not null
    , receipt_no INTEGER default 0 not null
    , end_rec_flg INTEGER default 0 not null
    , only_ejlog_flg INTEGER default 0 not null
    , cshr_no INTEGER default 0 not null
    , chkr_no INTEGER default 0 not null
    , now_sale_datetime TEXT
    , sale_date TEXT
    , ope_mode_flg INTEGER default 0 not null
    , print_data TEXT
    , sub_only_ejlog_flg INTEGER default 0 not null
    , trankey_search TEXT
    , etckey_search TEXT
    , primary key (serial_no, seq_no)
      )''');
  }
  //endregion
  //region flutter_pos追加テーブル
  /// Add_1	多言語ラベル管理マスタ	languages_mst
  await db.execute('''create table languages_mst ( 
    multilingual_key TEXT not null
    , country_division INTEGER not null
    , label_name TEXT
    , ins_datetime TEXT
    , upd_datetime TEXT
    , upd_user TEXT
    , primary key (multilingual_key, country_division)
      )''');
  //endregion

  //region index
  await db.execute('''CREATE INDEX p_promsch_mst_idx ON p_promsch_mst(start_datetime, end_datetime, stop_flg, sch_typ, item_cd, timesch_flg)''');
  await db.execute('''CREATE INDEX p_promitem_mst_idx ON p_promitem_mst(prom_typ)''');
  //endregion

  //region TRIGGER
  String tr1 =  r''' CREATE TRIGGER fnc_bdlitem_prom_ins BEFORE INSERT ON s_bdlitem_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promitem_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			prom_typ, item_cd, item_cd2, grp_cd, stop_flg,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
		)	
		SELECT	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.bdl_cd,
			2, new.plu_cd, '', 0, new.stop_flg,
      new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system
    WHERE new.bdl_cd NOT IN (SELECT prom_cd FROM p_promitem_mst WHERE
      comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.bdl_cd AND
      item_cd = new.plu_cd AND item_cd2 = '' AND grp_cd=0);
	END;		
        ''';
  String tr2 =  r''' CREATE TRIGGER fnc_bdlitem_prom_upd BEFORE UPDATE ON s_bdlitem_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promitem_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.bdl_cd,
			prom_typ = 2, item_cd = new.plu_cd, item_cd2 = '', grp_cd = 0, stop_flg = new.stop_flg,
      ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime,
      status = new.status, send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system
    WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.bdl_cd AND
    item_cd = old.plu_cd AND item_cd2 = '' AND grp_cd=0;
	END;		
        ''';
  String tr3 =  r''' CREATE TRIGGER fnc_bdlitem_prom_del BEFORE DELETE ON s_bdlitem_mst FOR EACH ROW		
	BEGIN	
		DELETE FROM p_promitem_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.bdl_cd AND 
		item_cd = old.plu_cd AND item_cd2 = '' AND prom_typ=2;
  END;

  ''';
  String tr4 =  r''' CREATE TRIGGER fnc_stmitem_prom_ins BEFORE INSERT ON s_stmitem_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promitem_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			prom_typ, item_cd, item_cd2, grp_cd, set_qty, stop_flg,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
		)	
		SELECT	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.stm_cd,
			3, new.plu_cd, '', new.grpno, new.stm_qty, new.stop_flg,
      new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system
    WHERE new.stm_cd NOT IN (SELECT prom_cd FROM p_promitem_mst WHERE
      comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.stm_cd AND
      item_cd = new.plu_cd AND item_cd2 = '' AND grp_cd = new.grpno);
	END;		
        ''';
  String tr5 =  r''' CREATE TRIGGER fnc_stmitem_prom_upd BEFORE UPDATE ON s_stmitem_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promitem_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.stm_cd,
			prom_typ=3, item_cd = new.plu_cd, item_cd2 = '', grp_cd = new.grpno, set_qty = new.stm_qty, stop_flg = new.stop_flg,
      ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime,
      status = new.status, send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system
    WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.stm_cd AND
      item_cd = old.plu_cd AND item_cd2 = '' AND grp_cd = old.grpno;
	END;		
        ''';
  String tr6 =  r''' CREATE TRIGGER fnc_stmitem_prom_del BEFORE DELETE ON s_stmitem_mst FOR EACH ROW			
	BEGIN		
		DELETE FROM p_promitem_mst WHERE 	
			comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.stm_cd AND
			item_cd = old.plu_cd AND item_cd2 = '' AND grp_cd = old.grpno AND prom_typ = 3;
  END;
        ''';
  String tr7 =  r''' CREATE TRIGGER fnc_bdlsch_prom_ins BEFORE INSERT ON s_bdlsch_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promsch_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			prom_typ, sch_typ, prom_name,
			start_datetime, end_datetime, timesch_flg,
			sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, trends_typ,
			form_qty1, form_qty2, form_qty3, form_qty4, form_qty5,
			form_prc1, form_prc2, form_prc3, form_prc4, form_prc5,
			av_prc, rec_limit, low_limit,
			cust_form_prc1, cust_form_prc2, cust_form_prc3, cust_form_prc4, cust_form_prc5,
			cust_av_prc, stop_flg, div_cd,
			avprc_adpt_flg, avprc_util_flg, promo_ext_id, item_cd,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
			date_flg1, date_flg2, date_flg3, date_flg4, date_flg5
		)	
		SELECT 	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.bdl_cd,
			2, new.bdl_typ, new.name,
			new.start_datetime, new.end_datetime, new.timesch_flg,
			new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.trends_typ,
			new.bdl_qty1, new.bdl_qty2, new.bdl_qty3, new.bdl_qty4, new.bdl_qty5,
			new.bdl_prc1, new.bdl_prc2, new.bdl_prc3, new.bdl_prc4, new.bdl_prc5,
			new.bdl_avprc, new.limit_cnt, new.low_limit,
			new.mbdl_prc1, new.mbdl_prc2, new.mbdl_prc3, new.mbdl_prc4, new.mbdl_prc5,
			new.mbdl_avprc, new.stop_flg, new.div_cd,
			new.avprc_adpt_flg, new.avprc_util_flg, new.promo_ext_id, '',
      new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
      new.date_flg1, new.date_flg2, new.date_flg3, new.date_flg4, new.date_flg5
    WHERE new.bdl_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE
      comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.bdl_cd
      AND prom_typ=2 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0);
	END;
        ''';
  String tr8 =  r''' CREATE TRIGGER fnc_bdlsch_prom_upd BEFORE UPDATE ON s_bdlsch_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promsch_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.bdl_cd,
			prom_typ = 2, sch_typ = new.bdl_typ, prom_name = new.name,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, trends_typ = new.trends_typ,
			form_qty1 = new.bdl_qty1, form_qty2 = new.bdl_qty2, form_qty3 = new.bdl_qty3,
			form_qty4 = new.bdl_qty4, form_qty5 = new.bdl_qty5,
			form_prc1 = new.bdl_prc1, form_prc2 = new.bdl_prc2, form_prc3 = new.bdl_prc3,
			form_prc4 = new.bdl_prc4, form_prc5 = new.bdl_prc5,
			av_prc = new.bdl_avprc, rec_limit = new.limit_cnt, low_limit = new.low_limit,
			cust_form_prc1 = new.mbdl_prc1, cust_form_prc2 = new.mbdl_prc2, cust_form_prc3 = new.mbdl_prc3,
			cust_form_prc4 = new.mbdl_prc4, cust_form_prc5 = new.mbdl_prc5,
			cust_av_prc = new.mbdl_avprc, stop_flg = new.stop_flg, div_cd = new.div_cd,
			avprc_adpt_flg = new.avprc_adpt_flg, avprc_util_flg = new.avprc_util_flg,
			promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system,
			date_flg1 = new.date_flg1, date_flg2 = new.date_flg2, date_flg3 = new.date_flg3,
			date_flg4 = new.date_flg4, date_flg5 = new.date_flg5
		WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.bdl_cd	
			AND prom_typ=2 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;		
        ''';
  String tr9 =  r''' CREATE TRIGGER fnc_bdlsch_prom_del BEFORE DELETE ON s_bdlsch_mst FOR EACH ROW		
	BEGIN	
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.bdl_cd AND prom_typ=2 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;	
        ''';
  String tr10 =  r''' CREATE TRIGGER fnc_brgn_prom_ins BEFORE INSERT ON s_brgn_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promsch_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			prom_typ, item_cd, sch_typ, prom_name, svs_typ, dsc_typ,
			start_datetime, end_datetime, timesch_flg,
			sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, trends_typ, 
			dsc_val, cust_dsc_val, cost, low_limit, div_cd, promo_ext_id, cost_per, stop_flg,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
			date_flg1, date_flg2, date_flg3, date_flg4, date_flg5
		)	
		 SELECT	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.brgn_cd,
			1, new.plu_cd, new.brgn_typ, new.name, new.svs_typ, new.dsc_typ,
			new.start_datetime, new.end_datetime, new.timesch_flg,
			new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.trends_typ,
			new.brgn_prc, new.brgncust_prc, new.brgn_cost, new.consist_val1, new.div_cd, new.promo_ext_id, new.brgn_costper, new.stop_flg,
			new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
			new.date_flg1, new.date_flg2, new.date_flg3, new.date_flg4, new.date_flg5
		WHERE new.brgn_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE	
			comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.brgn_cd
			AND prom_typ=1 AND item_cd = new.plu_cd AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0);
	END;		
        ''';
  String tr11 =  r''' CREATE TRIGGER fnc_brgn_prom_upd BEFORE UPDATE ON s_brgn_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promsch_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.brgn_cd,
			prom_typ = 1, item_cd = new.plu_cd, sch_typ = new.brgn_typ, prom_name = new.name,
			svs_typ = new.svs_typ, dsc_typ = new.dsc_typ,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, trends_typ = new.trends_typ,
			dsc_val = new.brgn_prc, cust_dsc_val = new.brgncust_prc, cost = new.brgn_cost,
			low_limit = new.consist_val1, div_cd = new.div_cd,
			promo_ext_id = new.promo_ext_id, cost_per = new.brgn_costper, stop_flg = new.stop_flg,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime,
			status = new.status, send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system,
			date_flg1 = new.date_flg1, date_flg2 = new.date_flg2, date_flg3 = new.date_flg3,
			date_flg4 = new.date_flg4, date_flg5 = new.date_flg5
		WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.brgn_cd	
			AND prom_typ=1 AND item_cd = old.plu_cd AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;		
        ''';
  String tr12 =  r''' CREATE TRIGGER fnc_brgn_prom_del BEFORE DELETE ON s_brgn_mst FOR EACH ROW		
	BEGIN	
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.brgn_cd AND prom_typ=1 AND item_cd = old.plu_cd AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;	
        ''';
  String tr13 =  r''' CREATE TRIGGER fnc_clssch_prom_ins BEFORE INSERT ON s_clssch_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promsch_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd,
			prom_typ, sch_typ, prom_name,
			svs_typ, dsc_typ, dsc_val, cust_dsc_val,
			start_datetime, end_datetime, timesch_flg,
			sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, trends_typ,
			stop_flg, div_cd, promo_ext_id, item_cd,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
		)	
		SELECT 	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.sch_cd,
			new.lrgcls_cd, new.mdlcls_cd, new.smlcls_cd, new.tnycls_cd,
			4, new.svs_class, new.name,
			new.svs_typ, new.dsc_typ, new.dsc_prc, new.mdsc_prc,
			new.start_datetime, new.end_datetime, new.timesch_flg,
			new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.trends_typ,
			new.stop_flg, new.div_cd, new.promo_ext_id, '',
			new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system
		WHERE new.sch_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE	
			comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.sch_cd
			AND prom_typ=4 AND item_cd='' AND lrgcls_cd=new.lrgcls_cd AND mdlcls_cd=new.mdlcls_cd AND smlcls_cd=new.smlcls_cd AND tnycls_cd=new.tnycls_cd);
	END;		
        ''';
  String tr14 =  r''' CREATE TRIGGER fnc_clssch_prom_upd BEFORE UPDATE ON s_clssch_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promsch_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.sch_cd,
			lrgcls_cd = new.lrgcls_cd, mdlcls_cd = new.mdlcls_cd, smlcls_cd = new.smlcls_cd, tnycls_cd = new.tnycls_cd,
			prom_typ = 4, sch_typ = new.svs_class, prom_name = new.name,
			svs_typ = new.svs_typ, dsc_typ = new.dsc_typ, dsc_val = new.dsc_prc, cust_dsc_val = new.mdsc_prc,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, trends_typ = new.trends_typ,
			stop_flg = new.stop_flg, div_cd = new.div_cd, promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system
		WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.sch_cd	
			AND prom_typ=4 AND item_cd='' AND lrgcls_cd=old.lrgcls_cd AND mdlcls_cd=old.mdlcls_cd AND smlcls_cd=old.smlcls_cd AND tnycls_cd=old.tnycls_cd;
	END;		
        ''';
  String tr15 =  r''' CREATE TRIGGER fnc_clssch_prom_del BEFORE DELETE ON s_clssch_mst FOR EACH ROW		
	BEGIN	
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.sch_cd AND prom_typ=4 AND item_cd='' AND lrgcls_cd=old.lrgcls_cd AND mdlcls_cd=old.mdlcls_cd AND smlcls_cd=old.smlcls_cd AND tnycls_cd=old.tnycls_cd;
	END;	
        ''';
  String tr16 =  r''' CREATE TRIGGER fnc_custsvs_prom_ins BEFORE INSERT ON s_svs_sch_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promsch_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			prom_typ, item_cd, prom_name,
			point_add_magn, point_add_mem_typ, svs_cls_f_data1, svs_cls_s_data1, svs_cls_s_data2, svs_cls_s_data3,
			start_datetime, end_datetime, timesch_flg,
			sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, stop_flg,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
			acct_cd)
		SELECT	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.svs_cls_sch_cd,
			8, CAST(new.svs_cls_cd AS TEXT), new.svs_cls_sch_name,
			new.point_add_magn, new.point_add_mem_typ, new.f_data1, new.s_data1, new.s_data2, new.s_data3,
			new.start_datetime, new.end_datetime, new.timesch_flg,
			new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.stop_flg,
			new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
			new.acct_cd
		WHERE new.svs_cls_sch_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE	
			comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.svs_cls_sch_cd
			AND prom_typ=8 AND item_cd = CAST(new.svs_cls_cd AS TEXT) AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0);
	END;		
        ''';
  String tr17 =  r''' CREATE TRIGGER fnc_custsvs_prom_upd BEFORE UPDATE ON s_svs_sch_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promsch_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.svs_cls_sch_cd,
			prom_typ = 8, item_cd = CAST(new.svs_cls_cd AS TEXT), prom_name = new.svs_cls_sch_name,
			point_add_magn = new.point_add_magn, point_add_mem_typ = new.point_add_mem_typ,
			svs_cls_f_data1 = new.f_data1, svs_cls_s_data1 = new.s_data1, svs_cls_s_data2 = new.s_data2, svs_cls_s_data3 = new.s_data3,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, stop_flg = new.stop_flg,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system, acct_cd = new.acct_cd
		WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.svs_cls_sch_cd	
			AND prom_typ=8 AND item_cd = CAST(old.svs_cls_cd AS TEXT) AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;		
        ''';
  String tr18 =  r''' CREATE TRIGGER fnc_custsvs_prom_del BEFORE UPDATE ON s_svs_sch_mst FOR EACH ROW			
	BEGIN		
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT)	
			AND prom_cd = old.svs_cls_sch_cd AND prom_typ=8 AND item_cd = CAST(old.svs_cls_cd AS TEXT)
			AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;		
        ''';
  String tr19 =  r''' CREATE TRIGGER fnc_plu_point_prom_ins BEFORE INSERT ON s_plu_point_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promsch_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			prom_typ, item_cd, prom_name, reward_val,
			start_datetime, end_datetime, timesch_flg,
			sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, stop_flg, trends_typ,
			acct_cd, promo_ext_id,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
			lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, sch_typ, plupts_rate
		)	
		SELECT 	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.plusch_cd,
			(CASE WHEN new.pts_type = 0 THEN 6 ELSE 9 END), new.plu_cd, new.name, new.point_add,
			new.start_datetime, new.end_datetime, new.timesch_flg,
			new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.stop_flg, new.trends_typ,
			new.acct_cd, new.promo_ext_id,
			new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
			new.lrgcls_cd, new.mdlcls_cd, new.smlcls_cd, new.tnycls_cd, new.plu_cls_flg, new.pts_rate
		WHERE new.plusch_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE	
			comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.plusch_cd
			AND item_cd = new.plu_cd AND lrgcls_cd = new.lrgcls_cd AND mdlcls_cd = new.mdlcls_cd
			AND smlcls_cd = new.smlcls_cd AND tnycls_cd = new.tnycls_cd AND sch_typ = new.plu_cls_flg
			AND prom_typ = (CASE WHEN new.pts_type = 0 THEN 6 ELSE 9 END));
	END;		
        ''';
  String tr20 =  r''' CREATE TRIGGER fnc_plu_point_prom_upd BEFORE UPDATE ON s_plu_point_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promsch_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.plusch_cd,
			prom_typ = (CASE WHEN new.pts_type = 0 THEN 6 ELSE 9 END),
			item_cd = new.plu_cd, prom_name = new.name, reward_val = new.point_add,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, stop_flg = new.stop_flg, trends_typ = new.trends_typ,
			acct_cd = new.acct_cd, promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system,
			lrgcls_cd = new.lrgcls_cd, mdlcls_cd = new.mdlcls_cd, smlcls_cd = new.smlcls_cd, tnycls_cd = new.tnycls_cd,
			sch_typ = new.plu_cls_flg, plupts_rate = new.pts_rate
		WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.plusch_cd	
			AND item_cd = old.plu_cd AND lrgcls_cd = old.lrgcls_cd AND mdlcls_cd = old.mdlcls_cd
			AND smlcls_cd = old.smlcls_cd AND tnycls_cd = old.tnycls_cd AND sch_typ = old.plu_cls_flg
			AND prom_typ = (CASE WHEN old.pts_type = 0 THEN 6 ELSE 9 END);
	END;		
        ''';
  String tr21 =  r''' CREATE TRIGGER fnc_plu_point_prom_del BEFORE DELETE ON s_plu_point_mst FOR EACH ROW		
	BEGIN	
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.plusch_cd AND item_cd = old.plu_cd AND lrgcls_cd = old.lrgcls_cd AND mdlcls_cd = old.mdlcls_cd AND smlcls_cd = old.smlcls_cd AND tnycls_cd = old.tnycls_cd AND sch_typ = old.plu_cls_flg AND prom_typ = (CASE WHEN old.pts_type = 0 THEN 6 ELSE 9 END);
	END;	
        ''';
  String tr22 =  r''' CREATE TRIGGER fnc_stmsch_prom_ins BEFORE INSERT ON s_stmsch_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promsch_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			prom_typ, prom_name,
			start_datetime, end_datetime, timesch_flg,
			sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg,
			member_qty, rec_limit, stop_flg, trends_typ,
			sch_typ,
			form_prc1, form_prc2, form_prc3, form_prc4, form_prc5,
			cust_form_prc1, cust_form_prc2, cust_form_prc3, cust_form_prc4, cust_form_prc5,
			div_cd, promo_ext_id, item_cd,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
			date_flg1, date_flg2, date_flg3, date_flg4, date_flg5
		)	
		SELECT 	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.stm_cd,
			3, new.name,
			new.start_datetime, new.end_datetime, new.timesch_flg,
			new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg,
			new.member_qty, new.limit_cnt, new.stop_flg, new.trends_typ,
			new.dsc_flg,
			new.stm_prc, new.stm_prc2, new.stm_prc3, new.stm_prc4, new.stm_prc5,
			new.mstm_prc, new.mstm_prc2, new.mstm_prc3, new.mstm_prc4, new.mstm_prc5,
			new.div_cd, new.promo_ext_id, '',
			new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
			new.date_flg1, new.date_flg2, new.date_flg3, new.date_flg4, new.date_flg5
		WHERE new.stm_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE	
			comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.stm_cd
			AND prom_typ=3 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0);
	END;		
        ''';
  String tr23 =  r''' CREATE TRIGGER fnc_stmsch_prom_upd BEFORE UPDATE ON s_stmsch_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promsch_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.stm_cd,
			prom_typ = 3, prom_name = new.name,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg,
			member_qty = new.member_qty, rec_limit = new.limit_cnt, stop_flg = new.stop_flg, trends_typ = new.trends_typ,
			sch_typ = new.dsc_flg,
			form_prc1 = new.stm_prc, form_prc2 = new.stm_prc2, form_prc3 = new.stm_prc3,
			form_prc4 = new.stm_prc4, form_prc5 = new.stm_prc5,
			cust_form_prc1 = new.mstm_prc, cust_form_prc2 = new.mstm_prc2, cust_form_prc3 = new.mstm_prc3,
			cust_form_prc4 = new.mstm_prc4, cust_form_prc5 = new.mstm_prc5,
			div_cd = new.div_cd, promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system,
			date_flg1 = new.date_flg1, date_flg2 = new.date_flg2, date_flg3 = new.date_flg3,
			date_flg4 = new.date_flg4, date_flg5 = new.date_flg5
		WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.stm_cd	
			AND prom_typ=3 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;		
        ''';
  String tr24 =  r''' CREATE TRIGGER fnc_stmsch_prom_del BEFORE DELETE ON s_stmsch_mst FOR EACH ROW		
	BEGIN	
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.stm_cd AND prom_typ=3 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;	
        ''';
  String tr25 =  r''' CREATE TRIGGER fnc_subtsch_prom_ins BEFORE INSERT ON s_subtsch_mst FOR EACH ROW			
	BEGIN		
		INSERT INTO p_promsch_mst (	
			comp_cd, stre_cd, plan_cd, prom_cd,
			prom_typ, sch_typ, prom_name,
			svs_typ, dsc_typ, dsc_val, cust_dsc_val, low_limit,
			start_datetime, end_datetime, timesch_flg,
			sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, trends_typ,
			stop_flg, div_cd, promo_ext_id, item_cd,
			ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
		)	
		SELECT 	
			new.comp_cd, new.stre_cd, CAST(new.plan_cd AS TEXT), new.subt_cd,
			7, 1, new.name,
			new.svs_typ, new.dsc_typ, new.dsc_prc, new.mdsc_prc, new.stl_form_amt,
			new.start_datetime, new.end_datetime, new.timesch_flg,
			new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.trends_typ,
			new.stop_flg, new.div_cd, new.promo_ext_id, '',
			new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system
		WHERE new.subt_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE	
			comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = CAST(new.plan_cd AS TEXT) AND prom_cd = new.subt_cd
			AND prom_typ=7 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0);
	END;		
        ''';
  String tr26 =  r''' CREATE TRIGGER fnc_subtsch_prom_upd BEFORE UPDATE ON s_subtsch_mst FOR EACH ROW			
	BEGIN		
		UPDATE p_promsch_mst SET	
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = CAST(new.plan_cd AS TEXT), prom_cd = new.subt_cd,
			prom_typ = 7, sch_typ = 1, prom_name = new.name,
			svs_typ = new.svs_typ, dsc_typ = new.dsc_typ, dsc_val = new.dsc_prc, cust_dsc_val = new.mdsc_prc,
			low_limit = new.stl_form_amt,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, trends_typ = new.trends_typ,
			stop_flg = new.stop_flg, div_cd = new.div_cd, promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system
		WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.subt_cd	
			AND prom_typ=7 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;		
        ''';
  String tr27 =  r''' CREATE TRIGGER fnc_subtsch_prom_del BEFORE DELETE ON s_subtsch_mst FOR EACH ROW		
	BEGIN	
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = CAST(old.plan_cd AS TEXT) AND prom_cd = old.subt_cd AND prom_typ=7 AND item_cd='' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
	END;	
        ''';
  String tr28 =  r''' CREATE TRIGGER fnc_pbchg_log_i AFTER INSERT ON c_pbchg_log_01 FOR EACH ROW			
	WHEN new.settlestatus = '0'		
	BEGIN		
		UPDATE p_pbchg_balance_tbl SET	
			now_balance = (CASE WHEN now_balance is NULL THEN -(new.cashamt + new.charge1) ELSE now_balance - (new.cashamt + new.charge1) END),
			pay_amt = (CASE WHEN now_balance is NULL THEN new.cashamt + new.charge1 ELSE pay_amt + new.cashamt + new.charge1 END),
			settle_flg = 0
		WHERE stre_cd = new.stre_cd AND groupcd = new.groupcd AND officecd = new.officecd;	
	END;		
        ''';
  await db.execute(tr1);
  await db.execute(tr2);
  await db.execute(tr3);
  await db.execute(tr4);
  await db.execute(tr5);
  await db.execute(tr6);
  await db.execute(tr7);
  await db.execute(tr8);
  await db.execute(tr9);
  await db.execute(tr10);
  await db.execute(tr11);
  await db.execute(tr12);
  await db.execute(tr13);
  await db.execute(tr14);
  await db.execute(tr15);
  await db.execute(tr16);
  await db.execute(tr17);
  await db.execute(tr18);
  await db.execute(tr19);
  await db.execute(tr20);
  await db.execute(tr21);
  await db.execute(tr22);
  await db.execute(tr23);
  await db.execute(tr24);
  await db.execute(tr25);
  await db.execute(tr26);
  await db.execute(tr27);
  await db.execute(tr28);
  for (var i = 1; i <= 31; i++) {
    var j = i.toString().padLeft(2, "0");
    await db.execute(''' CREATE TRIGGER fnc_header_log_ins_$j BEFORE INSERT ON c_header_log_$j FOR EACH ROW			
	BEGIN		
		INSERT INTO wk_que(serial_no, pid, wk_step, endtime)	
			SELECT new.serial_no, 0, 0, new.endtime;
	END;		
        ''');
  }
  //endregion

  //region TEMPLATE 末尾の)が必要か確認せよ
  // await db.execute('''
  //     )''');
  //endregion

  //初期データコール
  await _initData(db, value);


  /// 設定ファイル取得クラスインスタンス(MACINFO)
  Mac_infoJsonFile mac_infojson = Mac_infoJsonFile();
  await mac_infojson.load();
  int comp_init = mac_infojson.system.crpno;
  int stre_init = mac_infojson.system.shpno;
  int macno_init= mac_infojson.system.macno;

  await _initDataMm(db,value,comp_init,stre_init,macno_init);
  await _initDataMs(db,value,comp_init,stre_init,macno_init);

  debugPrint('_onCreateがコールされました');
}