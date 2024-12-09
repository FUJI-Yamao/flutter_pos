/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';

FutureOr _initDataMs(db, value,int COMP,int STRE,int MACNO) async {
  await _ms_auth(db,value,COMP,STRE,MACNO);
  await _ms_cls(db,value,COMP,STRE,MACNO);
  await _ms_instre(db,value,COMP,STRE,MACNO);
  await _ms_mbrcard(db,value,COMP,STRE,MACNO);
  await _ms_staff(db,value,COMP,STRE,MACNO);
}
Future _ms_auth(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, auth_lvl, auth_name';
  String cmn_set = ' $COMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT * FROM c_staffauth_mst WHERE comp_cd = $COMP ';

//c_staffauth_mst 従業員権限レベル
  await db.execute('''INSERT INTO c_staffauth_mst ($insert_field) SELECT $cmn_set, 1, '店舗従業員1' WHERE NOT EXISTS ($sub_query AND auth_lvl = '1');''');
  await db.execute('''INSERT INTO c_staffauth_mst ($insert_field) SELECT $cmn_set, 2, '店舗従業員2' WHERE NOT EXISTS ($sub_query AND auth_lvl = '2');''');
  await db.execute('''INSERT INTO c_staffauth_mst ($insert_field) SELECT $cmn_set, 3, '店舗従業員3' WHERE NOT EXISTS ($sub_query AND auth_lvl = '3');''');
  await db.execute('''INSERT INTO c_staffauth_mst ($insert_field) SELECT $cmn_set, 9, '店舗従業員9' WHERE NOT EXISTS ($sub_query AND auth_lvl = '9');''');
  await db.execute('''INSERT INTO c_staffauth_mst ($insert_field) SELECT $cmn_set, 999, '保守員' WHERE NOT EXISTS ($sub_query AND auth_lvl = '999');''');
}
Future _ms_cls(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, stre_cd, cls_flg, tax_cd1, tax_cd2, tax_cd3, tax_cd4, name, short_name, kana_name, margin_flg, regsale_flg, clothdeal_flg, dfltcls_cd, msg_name, pop_msg, nonact_flg, max_prc, min_prc, cost_per, loss_per, rbtpremium_per, prc_chg_flg, rbttarget_flg, stl_dsc_flg, labeldept_cd, multprc_flg, multprc_per, sch_flg, stlplus_flg, pctr_tckt_flg, clothing_flg, spclsdsc_flg, bdl_dsc_flg, self_alert_flg, chg_ckt_flg, self_weight_flg, msg_flg, pop_msg_flg, itemstock_flg, orderpatrn_flg, orderbook_flg, safestock_per, autoorder_typ, casecntup_typ, producer_cd, cust_dtl_flg, coupon_flg, kitchen_prn_flg, pricing_flg, user_val_1, user_val_2, user_val_3, user_val_4, user_val_5, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, dpnt_rbttarget_flg, dpnt_usetarget_flg,  cls_typ, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, plu_cd';
  String cmn_set1 = ' $COMP, $STRE, \'1\', \'1\', \'0\', \'0\', \'0\', \'その他\', \'\', \'\'';
  String cmn_set2 = ' \'0\', \'0\', \'0\', \'999999\', \'\', \'\', \'2\', \'0\', \'0\', \'0.00\'';
  String cmn_set3 = ' \'0.00\', \'1.00\', \'2\', \'2\', \'0\', \'0\', \'2\', \'0.00\', \'0\', \'0\'';
  String cmn_set4 = ' \'2\', \'2\', \'1\', \'1\', \'0\', \'0\', \'1\',  \'2\', \'2\', \'0\'';
  String cmn_set5 = ' \'0\', \'0\', \'0\', \'0\', \'0\', \'0\', \'0\', \'2\', \'0\', \'0\'';
  String cmn_set6 = ' \'0\', \'0\', \'0\', \'0\', \'0\', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'1\', \'1\'';
  String sub_query = 'SELECT * FROM c_cls_mst WHERE comp_cd = $COMP AND stre_cd = $STRE ';

//大分類
  await db.execute('''INSERT INTO c_cls_mst ($insert_field) SELECT $cmn_set1, $cmn_set2, $cmn_set3, $cmn_set4, $cmn_set5, $cmn_set6, '1', '999999', '0', '0', '0', '' WHERE NOT EXISTS ($sub_query AND cls_typ = 1 AND lrgcls_cd = 999999 AND mdlcls_cd = 0 AND smlcls_cd = 0 AND tnycls_cd = 0);''');
//
//中分類
  await db.execute('''INSERT INTO c_cls_mst ($insert_field) SELECT $cmn_set1, $cmn_set2, $cmn_set3, $cmn_set4, $cmn_set5, $cmn_set6, '2', '999999', '999999', '0', '0', '' WHERE NOT EXISTS ($sub_query AND cls_typ = 2 AND lrgcls_cd = 999999 AND mdlcls_cd = 999999 AND smlcls_cd = 0 AND tnycls_cd = 0);''');
//
//小分類
  await db.execute('''INSERT INTO c_cls_mst ($insert_field) SELECT $cmn_set1, $cmn_set2, $cmn_set3, $cmn_set4, $cmn_set5, $cmn_set6, '3', '999999', '999999', '999999', '0', '' WHERE NOT EXISTS ($sub_query AND cls_typ = 3 AND lrgcls_cd = 999999 AND mdlcls_cd = 999999 AND smlcls_cd = 999999 AND tnycls_cd = 0);''');
//
//クラス
  await db.execute('''INSERT INTO c_cls_mst ($insert_field) SELECT $cmn_set1, $cmn_set2, $cmn_set3, $cmn_set4, $cmn_set5, $cmn_set6, '4', '999999', '999999', '999999', '999999', '' WHERE NOT EXISTS ($sub_query AND cls_typ = 4 AND lrgcls_cd = 999999 AND mdlcls_cd = 999999 AND smlcls_cd = 999999 AND tnycls_cd = 999999);''');
}
Future _ms_instre(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, instre_flg, format_no, format_typ, cls_code ' ;
  String cmn_set = ' $COMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT * FROM c_instre_mst WHERE comp_cd = $COMP ';

//-- 13桁NON-PLU
  await db.execute('''INSERT INTO c_instre_mst ($insert_field) SELECT $cmn_set, '02', '1', '1', '0' WHERE NOT EXISTS ($sub_query AND instre_flg = '02' AND format_no = '1' AND format_typ = '1');''');
//-- 8桁NON-PLU
  await db.execute('''INSERT INTO c_instre_mst ($insert_field) SELECT $cmn_set, '2', '12', '2', '0' WHERE NOT EXISTS ($sub_query AND instre_flg = '2' AND format_no = '12' AND format_typ = '2');''');
}
Future _ms_mbrcard(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, seq_no, code_from, code_to, s_data1';
  String cmn_set = ' $COMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT * FROM c_mbrcard_mst WHERE comp_cd = $COMP ';

//c_mbrcard_mst 会員カードの種別
  await db.execute('''INSERT INTO c_mbrcard_mst ($insert_field) SELECT $cmn_set, 1, '0000000000000', '9999999999999', 1 WHERE NOT EXISTS ($sub_query AND seq_no = '1');''');
}
Future _ms_staff(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, stre_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, staff_cd, name, passwd, auth_lvl, svr_auth_lvl, nochk_overlap ';
  String cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT * FROM c_staff_mst WHERE comp_cd = $COMP AND stre_cd = $STRE ';

//c_staff_mst
  await db.execute('''INSERT INTO c_staff_mst ($insert_field) SELECT $cmn_set, '999999', 'ﾒﾝﾃﾅﾝｽ', '12345678', '999', '999', '1' WHERE NOT EXISTS ($sub_query AND staff_cd = '999999');''');
}