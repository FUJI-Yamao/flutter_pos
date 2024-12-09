/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';

Future _mm_fmttyp(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, format_typ, disp_flg, format_typ_name';
  String cmn_set = 'CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'select format_typ FROM c_fmttyp_mst WHERE format_typ = ';

  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '1', '0', \'１３/１２桁NON-PLU' WHERE NOT EXISTS ($sub_query '1');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '2', '0', \'８桁NON-PLU' WHERE NOT EXISTS ($sub_query '2');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '3', '0', \'会員' WHERE NOT EXISTS ($sub_query '3');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '4', '0', \'従業員' WHERE NOT EXISTS ($sub_query '4');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '5', '0', \'重量' WHERE NOT EXISTS ($sub_query '5');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '6', '0', \'雑誌' WHERE NOT EXISTS ($sub_query '6');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '7', '0', \'書籍2段目' WHERE NOT EXISTS ($sub_query '7');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '8', '1', \'クーポン' WHERE NOT EXISTS ($sub_query '8');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '9', '0', \'値下ﾊﾞｰｺｰﾄﾞ1段目' WHERE NOT EXISTS ($sub_query '9');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '10', '0', \'値下ﾊﾞｰｺｰﾄﾞ2段目' WHERE NOT EXISTS ($sub_query '10');''');
  //await db.execute('''--INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '11', '0', \'取引ﾚｼｰﾄ管理ﾊﾞｰｺｰﾄﾞ1段目' WHERE NOT EXISTS ($sub_query '11');''');
  //await db.execute('''--INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '12', '0', \'取引ﾚｼｰﾄ管理ﾊﾞｰｺｰﾄﾞ2段目' WHERE NOT EXISTS ($sub_query '12');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '13', '1', \'プロモーションバーコード' WHERE NOT EXISTS ($sub_query '13');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '14', '0', \'書籍1段目' WHERE NOT EXISTS ($sub_query '14');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '15', '1', \'クーポンバーコード' WHERE NOT EXISTS ($sub_query '15');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '16', '0', \'衣料ﾊﾞｰｺｰﾄﾞ1段目' WHERE NOT EXISTS ($sub_query '16');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '17', '0', \'衣料ﾊﾞｰｺｰﾄﾞ2段目' WHERE NOT EXISTS ($sub_query '17');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '18', '0', \'生産者' WHERE NOT EXISTS ($sub_query '18');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '19', '1', \'モバイル呼出バーコード' WHERE NOT EXISTS ($sub_query '19');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '20', '0', \'定期刊行物バーコード' WHERE NOT EXISTS ($sub_query '20');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '21', '0', \'カタリナクーポンバーコード' WHERE NOT EXISTS ($sub_query '21');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '22', '0', \'カタリナメーカークーポンバーコード' WHERE NOT EXISTS ($sub_query '22');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '23', '0', \'ITFバーコード' WHERE NOT EXISTS ($sub_query '23');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '24', '1', \'GramXバーコード' WHERE NOT EXISTS ($sub_query '24');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '25', '1', \'値札バーコード1段目' WHERE NOT EXISTS ($sub_query '25');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '26', '1', \'値札バーコード2段目' WHERE NOT EXISTS ($sub_query '26');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '27', '1', \'ギフトバーコード1段目' WHERE NOT EXISTS ($sub_query '27');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '28', '1', \'ギフトバーコード2段目' WHERE NOT EXISTS ($sub_query '28');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '29', '1', \'プリセットバーコード' WHERE NOT EXISTS ($sub_query '29');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '30', '1', \'クーポンバーコード' WHERE NOT EXISTS ($sub_query '30');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '31', '1', \'生鮮13桁NON-PLU' WHERE NOT EXISTS ($sub_query '31');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '32', '0', \'証紙発行番号バーコード' WHERE NOT EXISTS ($sub_query '32');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '33', '0', \'販売期限バーコード1段目' WHERE NOT EXISTS ($sub_query '33');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '34', '0', \'販売期限バーコード2段目' WHERE NOT EXISTS ($sub_query '34');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '35', '0', \'ファンクションキーバーコード' WHERE NOT EXISTS ($sub_query '35');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '36', '1', \'ポイントチケットバーコード' WHERE NOT EXISTS ($sub_query '36');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '37', '1', \'改正薬事法バーコード(説明済み)' WHERE NOT EXISTS ($sub_query '37');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '38', '1', \'改正薬事法バーコード(説明不要)' WHERE NOT EXISTS ($sub_query '38');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '39', '1', \'ポイントチケット値下バーコード' WHERE NOT EXISTS ($sub_query '39');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '40', '0', \'ﾎﾟｲﾝﾄ移行ﾊﾞｰｺｰﾄﾞ1段目' WHERE NOT EXISTS ($sub_query '40');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '41', '0', \'ﾎﾟｲﾝﾄ移行ﾊﾞｰｺｰﾄﾞ2段目' WHERE NOT EXISTS ($sub_query '41');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '42', '0', \'生産者除外ﾊﾞｰｺｰﾄﾞ　' WHERE NOT EXISTS ($sub_query '42');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '43', '0', \'特典クーポンバーコード' WHERE NOT EXISTS ($sub_query '43');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '44', '0', \'カード忘れクーポンバーコード１段目' WHERE NOT EXISTS ($sub_query '44');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '45', '0', \'カード忘れクーポンバーコード2段目' WHERE NOT EXISTS ($sub_query '45');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '46', '1', \'ｺﾒﾘｷﾞﾌﾄｶｰﾄﾞ' WHERE NOT EXISTS ($sub_query '46');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '47', '1', \'ｺﾒﾘｶｰﾄﾞ（仮ｶｰﾄﾞ）' WHERE NOT EXISTS ($sub_query '47');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '48', '1', \'部門nonPLU' WHERE NOT EXISTS ($sub_query '48');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '49', '1', \'ｸﾗｽnonPLU' WHERE NOT EXISTS ($sub_query '49');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '50', '1', \'名札ﾊﾞｰｺｰﾄﾞ' WHERE NOT EXISTS ($sub_query '50');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '51', '1', \'ﾄﾞｯﾄｺﾑ注文番号' WHERE NOT EXISTS ($sub_query '51');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '52', '1', \'お買い物割引券' WHERE NOT EXISTS ($sub_query '52');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '53', '1', \'社割券' WHERE NOT EXISTS ($sub_query '53');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '54', '1', \'品番バーコード' WHERE NOT EXISTS ($sub_query '54');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '55', '1', \'ギフトバーコード' WHERE NOT EXISTS ($sub_query '55');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '56', '1', \'赤札/値札バーコード1段目' WHERE NOT EXISTS ($sub_query '56');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '57', '1', \'赤札/値札バーコード2段目' WHERE NOT EXISTS ($sub_query '57');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '58', '0', \'予約バーコード' WHERE NOT EXISTS ($sub_query '58');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '59', '0', \'カスタマーカードバーコード' WHERE NOT EXISTS ($sub_query '59');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '60', '0', \'QCashier　商品追加バーコード' WHERE NOT EXISTS ($sub_query '60');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '61', '1', \'クーポン値引（従業員値引）' WHERE NOT EXISTS ($sub_query '61');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '62', '1', \'販売メンテナンスバーコード' WHERE NOT EXISTS ($sub_query '62');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '63', '1', \'サービス券対応バーコード１段目' WHERE NOT EXISTS ($sub_query '63');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '64', '1', \'サービス券対応バーコード２段目' WHERE NOT EXISTS ($sub_query '64');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '67', '0', \'入出金指示バーコード' WHERE NOT EXISTS ($sub_query '67');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '68', '0', \'部門変換用JAN（中分類）' WHERE NOT EXISTS ($sub_query '68');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '69', '0', \'従業員割引バーコード' WHERE NOT EXISTS ($sub_query '69');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '70', '1', \'プレゼントポイントバーコード' WHERE NOT EXISTS ($sub_query '70');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '71', '0', \'販売期限バーコード26桁' WHERE NOT EXISTS ($sub_query '71');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '72', '0', \' Tポイントクーポンバーコード' WHERE NOT EXISTS ($sub_query '72');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '73', '0', \'品券バーコード' WHERE NOT EXISTS ($sub_query '73');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '74', '0', \'企画バーコード' WHERE NOT EXISTS ($sub_query '74');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '75', '0', \'お買物券管理バーコード１段目' WHERE NOT EXISTS ($sub_query '75');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '76', '0', \'お買物券管理バーコード２段目' WHERE NOT EXISTS ($sub_query '76');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '81', '0', \'ZFSP生鮮バーコード' WHERE NOT EXISTS ($sub_query '81');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '87', '0', \'取引ﾚｼｰﾄ管理ﾊﾞｰｺｰﾄﾞ' WHERE NOT EXISTS ($sub_query '87');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '89', '0', \'One to One バーコード' WHERE NOT EXISTS ($sub_query '89');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '90', '0', \'サービス券バーコード' WHERE NOT EXISTS ($sub_query '90');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '91', '0', \'貸瓶付き商品バーコード' WHERE NOT EXISTS ($sub_query '91');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '92', '0', \'貸瓶管理バーコード' WHERE NOT EXISTS ($sub_query '92');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '93', '0', \'掛売バーコード' WHERE NOT EXISTS ($sub_query '93');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '94', '0', \'生産者バーコード２段目' WHERE NOT EXISTS ($sub_query '94');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '97', '0', \'一般売掛バーコード' WHERE NOT EXISTS ($sub_query '97');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '98', '0', \'メンテナンスバーコード' WHERE NOT EXISTS ($sub_query '98');''');
  await db.execute('''INSERT INTO c_fmttyp_mst ($insert_field) SELECT $cmn_set, '99', '0', \'カード忘れバーコード' WHERE NOT EXISTS ($sub_query '99');''');
}
Future _mm_barfmt(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, disp_flg, cls_flg, format_no, format_typ, format, flg_num, format_num';
  //設定画面に表示させるレコード(標準)
  String cmn_set = 'CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'0\' , \'0\'';
  String cmn_set3 = 'CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'0\' , \'1\'';
  //設定画面に表示させないレコード(特注など)
  String cmn_set2 = 'CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'1\', \'0\'';
  //cmn_setとcmn_set2の違いは, 設定画面へ表示するかの制御用
  String sub_query = 'select format_no FROM c_barfmt_mst WHERE ';

  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '1', '1', \'FF IIIII PC/D PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '1' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '2', '1', \'F IIIIII PC/D PPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '2' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '3', '1', \'FF IIIII 0 PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '3' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '4', '1', \'FF IIIIII PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '4' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '5', '1', \'FF IIIII PPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '5' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '6', '1', \'F IIIIII PPPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '6' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '7', '1', \'F IIIII PPPPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '7' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '9', '1', \'FF IIII PPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '9' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '13', '1', \'FF IIII PC/D PPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '13' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '14', '1', \'F X IIIIII PPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '14' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '15', '1', \'F X IIIII PC/D PPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '15' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '16', '1', \'F IIIII PC/D PPPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '16' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '20', '1', \'F IIIIIII PPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '20' AND format_typ = '1' );''');
  //await db.execute('''--INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '133', '1', \'F IIIII PC/D PPPP C/D', '1', '12' WHERE NOT EXISTS ($sub_query format_no = '133' AND format_typ = '1' );''');
  //await db.execute('''--INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '134', '1', \'F JJJJJJJJJJ C/D', '1', '12' WHERE NOT EXISTS ($sub_query format_no = '134' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '137', '1', \'FF MWIIII PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '137' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '12', '2', \'F II PPPP C/D', '1', '8' WHERE NOT EXISTS ($sub_query format_no = '12' AND format_typ = '2' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '10', '3', \'FF NNNNN C/D', '2', '8' WHERE NOT EXISTS ($sub_query format_no = '10' AND format_typ = '3' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '11', '3', \'F NNNNNN C/D', '1', '8' WHERE NOT EXISTS ($sub_query format_no = '11' AND format_typ = '3' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '135', '3', \'FF ?? NNNNNNNN C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '135' AND format_typ = '3' );''');
  //await db.execute('''--INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '136', '4', \'FF ????IIIIII C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '136' AND format_typ = '4' ); -- 329があるため''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '21', '5', \'FF IIIII WC/D WWWW C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '21' AND format_typ = '5' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '23', '5', \'FF IIIII 0 WWWW C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '23' AND format_typ = '5' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '24', '5', \'FF IIIIII WWWW C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '24' AND format_typ = '5' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '25', '5', \'FF IIIII WWWWW C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '25' AND format_typ = '5' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '33', '5', \'FF IIII WC/D WWWWW C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '33' AND format_typ = '5' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '26', '5', \'F IIIIII WWWWW C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '26' AND format_typ = '5' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '102', '6', \'FF MMMMM VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '102' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '103', '6', \'FF 0 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '103' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '106', '6', \'FF 1 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '106' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '104', '6', \'FF 0 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '104' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '107', '6', \'FF 1 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '107' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '105', '6', \'FF 0 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '105' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '108', '6', \'FF 1 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '108' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '109', '6', \'FF 2 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '109' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '112', '6', \'FF 3 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '112' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '110', '6', \'FF 2 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '110' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '113', '6', \'FF 3 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '113' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '111', '6', \'FF 2 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '111' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '114', '6', \'FF 3 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '114' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '115', '6', \'FF 4 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '115' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '118', '6', \'FF 5 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '118' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '116', '6', \'FF 4 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '116' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '119', '6', \'FF 5 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '119' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '117', '6', \'FF 4 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '117' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '120', '6', \'FF 5 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '120' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '121', '6', \'FF 6 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '121' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '122', '6', \'FF 6 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '122' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '123', '6', \'FF 6 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '123' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '124', '6', \'FF 7 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '124' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '125', '6', \'FF 7 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '125' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '126', '6', \'FF 7 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '126' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '127', '6', \'FF 8 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '127' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '128', '6', \'FF 8 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '128' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '129', '6', \'FF 8 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '129' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '130', '6', \'FF 9 IIII VV PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '130' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '131', '6', \'FF 9 IIII 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '131' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '132', '6', \'FF 9 III W 00 PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '132' AND format_typ = '6' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '144', '14', \'FFF IIIIIIIII C/D', '3', '13' WHERE NOT EXISTS ($sub_query format_no = '144' AND format_typ = '14' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '101', '7', \'FFF CCCC PPPPP C/D', '3', '13' WHERE NOT EXISTS ($sub_query format_no = '101' AND format_typ = '7' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '222', '23', \'F IIIIIIIIIIII C/D', '1', '14' WHERE NOT EXISTS ($sub_query format_no = '222' AND format_typ = '23' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '223', '23', \'FFF IIIIIIIIIIII C/D', '3', '16' WHERE NOT EXISTS ($sub_query format_no = '223' AND format_typ = '23' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '138', '8', \'FF CCCCC III PP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '138' AND format_typ = '8' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '145', '8', \'FF CCCCC II PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '145' AND format_typ = '8' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '139', '9', \'FF IIIIIIIIII C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '139' AND format_typ = '9' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '140', '10', \'FF III 0 N PPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '140' AND format_typ = '10' );''');
  //await db.execute('''--INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '141', '11', \'FF YYMMDD rrrr C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '141' AND format_typ = '11' );''');
  //await db.execute('''--INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '142', '12', \'FF RRRRRR pppp C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '142' AND format_typ = '12' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '143', '13', \'FF 0000 CCCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '143' AND format_typ = '13' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '90', '13', \'FF CC000N PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '90' AND format_typ = '13' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '146', '16', \'FF SSSSSSSSSS C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '146' AND format_typ = '16' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '147', '16', \'FF DDSSSSSSSS C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '147' AND format_typ = '16' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '148', '16', \'FF DDDSSSSSSS C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '148' AND format_typ = '16' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '149', '16', \'FF DDDDSSSSSS C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '149' AND format_typ = '16' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '150', '16', \'FF DDDDDSSSSS C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '150' AND format_typ = '16' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '151', '16', \'FF DDDDDDSSSS C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '151' AND format_typ = '16' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '145', '16', \'FF III 0000000 C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '145' AND format_typ = '16' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '152', '17', \'FF SSSSSSPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '152' AND format_typ = '17' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '153', '17', \'FF SSSSSPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '153' AND format_typ = '17' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '154', '17', \'FF SSSSPPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '154' AND format_typ = '17' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '155', '17', \'FF SSSPPPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '155' AND format_typ = '17' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '156', '17', \'FFFF SSPPPPPP C/D', '4', '13' WHERE NOT EXISTS ($sub_query format_no = '156' AND format_typ = '17' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '157', '18', \'FF IIIIIC PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '157' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '158', '18', \'FF IIIICC PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '158' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '159', '18', \'FF IIICCC PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '159' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '160', '18', \'FF IICCCC PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '160' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '161', '18', \'FF ICCCCC PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '161' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '198', '18', \'F IIIICCC PPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '198' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '199', '18', \'F IIICCCC PPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '199' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '200', '18', \'F IIICCC PPPPP C/D', '1', '13' WHERE NOT EXISTS ($sub_query format_no = '200' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '162', '19', \'FF 00IIIXXIII C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '162' AND format_typ = '19' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '163', '20', \'FFF S 0 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '163' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '164', '20', \'FFF S 0 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '164' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '165', '20', \'FFF S 1 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '165' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '166', '20', \'FFF S 1 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '166' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '167', '20', \'FFF S 2 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '167' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '168', '20', \'FFF S 2 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '168' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '169', '20', \'FFF S 3 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '169' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '170', '20', \'FFF S 3 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '170' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '171', '20', \'FFF S 4 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '171' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '172', '20', \'FFF S 4 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '172' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '173', '20', \'FFF S 5 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '173' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '174', '20', \'FFF S 5 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '174' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '175', '20', \'FFF S 6 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '175' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '176', '20', \'FFF S 6 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '176' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '177', '20', \'FFF S 7 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '177' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '178', '20', \'FFF S 7 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '178' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '179', '20', \'FFF S 8 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '179' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '180', '20', \'FFF S 8 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '180' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '181', '20', \'FFF S 9 IIII VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '181' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set3, '182', '20', \'FFF S 9 III W VV Y C/D S PPPP', '3', '18' WHERE NOT EXISTS ($sub_query format_no = '182' AND format_typ = '20' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '183', '21', \'FFFF NNNNN VVV C/D', '4', '13' WHERE NOT EXISTS ($sub_query format_no = '183' AND format_typ = '21' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '184', '22', \'FFFF NNNNN VVV C/D ', '4', '13' WHERE NOT EXISTS ($sub_query format_no = '184' AND format_typ = '22' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '206', '23', \'F CCCCCC PPPPP WWWWW C/D', '1', '18' WHERE NOT EXISTS ($sub_query format_no = '206' AND format_typ = '23' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '221', '23', \'F CCCCCC WWWWW PPPPP C/D', '1', '18' WHERE NOT EXISTS ($sub_query format_no = '221' AND format_typ = '23' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '185', '24', \'FF XXXXXXXXXX C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '185' AND format_typ = '24' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '186', '25', \'FF IIII IIII II C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '186' AND format_typ = '25' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '187', '26', \'FF PPPPPPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '187' AND format_typ = '26' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '188', '27', \'FF IIII IIII II C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '188' AND format_typ = '27' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '189', '28', \'FF IIII PPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '189' AND format_typ = '28' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '190', '29', \'FF IIII IIII II C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '190' AND format_typ = '29' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '191', '30', \'FF XXXXXXX PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '191' AND format_typ = '30' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '74', '30', \'FF C YYMMDD XXX C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '74' AND format_typ = '30' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '195', '30', \'FF MMMM PPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '195' AND format_typ = '30' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '4', '31', \'FF IIIIII PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '4' AND format_typ = '31' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '192', '32', \'FF 000000 CCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '192' AND format_typ = '32' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '300', '33', \'FF D IIII PPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '300' AND format_typ = '33' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '301', '34', \'FF MMDDHH M SSS C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '301' AND format_typ = '34' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '193', '35', \'FF CCCC SSSSSS C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '193' AND format_typ = '35' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '7100', '37', \'FF CCCCOOOOOO C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '7100' AND format_typ = '37' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '7101', '38', \'FF CCCCOOOOOO C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '7101' AND format_typ = '38' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '194', '36', \'FF SSS RR rrrr P C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '194' AND format_typ = '36' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '194', '39', \'FF SSS RR rrrr P C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '194' AND format_typ = '39' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '196', '40', \'FF 1 IIIIIIIII C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '196' AND format_typ = '40' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '197', '41', \'FF 2 S 000 PPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '197' AND format_typ = '41' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '80', '42', \'FF CCCCCCCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '80' AND format_typ = '42' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '83', '43', \'FF SSS I CCC PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '83' AND format_typ = '43' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '84', '44', \'FF SSS PPP MMDD C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '84' AND format_typ = '44' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '85', '45', \'FF RRRRRR rrr C/D', '2', '12' WHERE NOT EXISTS ($sub_query format_no = '85' AND format_typ = '45' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '60', '46', \'FF NNNNNN PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '60' AND format_typ = '46' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '61', '47', \'FF IIIIIIIIII C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '61' AND format_typ = '47' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '62', '48', \'FF II 000 PPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '62' AND format_typ = '48' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '63', '49', \'FF IIII PPPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '63' AND format_typ = '49' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '320', '49', \'F II PPPP C/D', '1', '8' WHERE NOT EXISTS ($sub_query format_no = '320' AND format_typ = '49' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '64', '50', \'FF IIIIIIIIII C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '64' AND format_typ = '50' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '65', '51', \'FF NNNNNNNNNN C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '65' AND format_typ = '51' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '66', '52', \'FF SSSS NNNN PP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '66' AND format_typ = '52' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '67', '53', \'FF SSSS NNNN PP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '67' AND format_typ = '53' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '73', '54', \'FF CCC CCCC CCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '73' AND format_typ = '54' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '68', '55', \'FF 000 CCCCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '68' AND format_typ = '55' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '69', '56', \'FF CCC CCCC CCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '69' AND format_typ = '56' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '70', '57', \'FF I 00 PPPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '70' AND format_typ = '57' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '75', '58', \'FF IIIIIIIIII C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '75' AND format_typ = '58' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '251', '59', \'FF 000000000 CCCCCC C/D', '2', '18' WHERE NOT EXISTS ($sub_query format_no = '251' AND format_typ = '59' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '86', '60', \'FF JJJJJJJJJJJ C/D', '2', '14' WHERE NOT EXISTS ($sub_query format_no = '86' AND format_typ = '60' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '79', '61', \'FF 0000000 DDD C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '79' AND format_typ = '61' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '7102', '62', \'FF NNNNNNN K 00 C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '7102' AND format_typ = '62' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '77', '63', \'FF SSS YYMMDD 0 C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '77' AND format_typ = '63' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '78', '64', \'FF RRRR CCC PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '78' AND format_typ = '64' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '256', '67', \'FF NNNNNNNNNN T OOOOOO HHMMSS IIIIII C/D', '2', '32' WHERE NOT EXISTS ($sub_query format_no = '256' AND format_typ = '67' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '87', '68', \'FF NNNN PPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '87' AND format_typ = '68' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '88', '69', \'FF ???? NNNNNN C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '88' AND format_typ = '69' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '89', '70', \'FF XXXXXX PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '89' AND format_typ = '70' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '302', '71', \'FF IIIII PPPPP C/D MMDDHH 00 SSSSS C/D', '2', '27' WHERE NOT EXISTS ($sub_query format_no = '302' AND format_typ = '71' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '96', '72', \'FF XXXXXXXXXX C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '96' AND format_typ = '72' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '97', '73', \'FF XXXXXXX PPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '97' AND format_typ = '73' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '98', '74', \'FF X CCCCCCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '98' AND format_typ = '74' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '321', '75', \'FF NNNNNNNNNN C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '321' AND format_typ = '75' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '322', '76', \'FF YMMDD RR NNN C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '322' AND format_typ = '76' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '329', '4', \'FF XXXXXXXXXX C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '329' AND format_typ = '4' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set2, '255', '81', \'FF 0 IIIIIIIIIIIII NNNNNNNNNNNNNNNN', '2', '32' WHERE NOT EXISTS ($sub_query format_no = '255' AND format_typ = '81' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '259', '87', \'FF YYMMDD rrrr 000 RRRRRR pppp C/D', '2', '26' WHERE NOT EXISTS ($sub_query format_no = '259' AND format_typ = '87' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '341', '89', \'FF IIIIIIIIII C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '341' AND format_typ = '89' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '52', '1', \'FF III PPPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '52' AND format_typ = '1' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '260', '90', \'FF IIIIIIIIIIIII YYMMDD C/D', '2', '22' WHERE NOT EXISTS ($sub_query format_no = '260' AND format_typ = '90' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '342', '16', \'FF DDDD 000000 C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '342' AND format_typ = '16' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '343', '17', \'FF 0000 PPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '343' AND format_typ = '17' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '344', '18', \'FF IIIIII CCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '344' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '345', '18', \'FF IIIII CCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '345' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '346', '18', \'FF IIII CCCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '346' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '347', '18', \'FF CCC III PPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '347' AND format_typ = '18' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '348', '91', \'FF CCCCCCCCCCCCC II C/D', '2', '18' WHERE NOT EXISTS ($sub_query format_no = '348' AND format_typ = '91' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '350', '92', \'FF ???? CCCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '350' AND format_typ = '92' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '325', '93', \'FF NNNNNNNNNN C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '325' AND format_typ = '93' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '349', '94', \'FF CC 00 PPPPPP C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '349' AND format_typ = '94' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '354', '97', \'FF CCCCCCCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '354' AND format_typ = '97' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '355', '98', \'FF CCCCCCCCCC C/D', '2', '13' WHERE NOT EXISTS ($sub_query format_no = '355' AND format_typ = '98' );''');
  await db.execute('''INSERT INTO c_barfmt_mst ($insert_field) SELECT $cmn_set, '261', '99', \'FF 0 SSSS MMMM RRRR JJJJ PPPPPP C/D', '2', '26' WHERE NOT EXISTS ($sub_query format_no = '261' AND format_typ = '99' );''');
}
Future _mm_ctrl(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, ctrl_cd, ctrl_data, data_typ';
  String cmn_set = ' $COMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT ctrl_cd FROM c_ctrl_mst WHERE comp_cd = $COMP ';

  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '1', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '1');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '2', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '2');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '3', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '3');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '4', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '4');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '5', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '5');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '6', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '6');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '7', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '7');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '8', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '8');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '9', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '9');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '10', '0', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '10');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '11', '0', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '11');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '12', '0', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '12');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '13', '0', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '13');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '14', '0', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '14');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '15', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '15');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '16', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '16');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '17', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '17');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '18', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '18');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '19', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '19');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '20', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '20');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '21', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '21');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '22', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '22');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '23', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '23');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '24', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '24');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '25', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '25');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '26', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '26');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '27', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '27');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '28', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '28');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '29', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '29');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '30', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '30');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '31', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '31');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '32', '20', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '32');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '33', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '33');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '34', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '34');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '35', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '35');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '36', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '36');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '37', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '37');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '38', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '38');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '39', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '39');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '40', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '40');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '41', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '41');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '42', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '42');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '43', '2', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '43');''');
  await db.execute('''INSERT INTO c_ctrl_mst ($insert_field) SELECT $cmn_set, '44', '0', '0' WHERE NOT EXISTS ($sub_query AND ctrl_cd = '44');''');
}
Future _mm_set_ctrl(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field_set = 'ctrl_cd, ctrl_name, ctrl_dsp_cond, ctrl_inp_cond, ctrl_limit_max, ctrl_limit_min, ctrl_digits, ctrl_zero_typ, ctrl_btn_color, ctrl_info_comment, ctrl_info_pic, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system';
  String insert_field_sub = 'ctrl_cd, ctrl_ordr, ctrl_data, ctrl_comment, ctrl_btn_color, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system';
  String cmn_set = 'CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\'';
  String sub_query_1 = 'SELECT * FROM c_ctrl_set_mst WHERE ctrl_cd ';
  String sub_query_2 = 'SELECT * FROM c_ctrl_sub_mst WHERE ctrl_cd ';

//cost_per_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '1', \'原価率使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '1', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '1' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '1', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '1' AND ctrl_ordr = '2');''');
//
//nonact_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '2', \'一括削除禁止フラグ階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '2');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '2', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '2' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '2', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '2' AND ctrl_ordr = '2');''');
//
//dsc_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '3', \'一括値引/割引使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '3');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '3', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '3' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '3', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '3' AND ctrl_ordr = '2');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '3', '3', '3', \'クラス', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '3' AND ctrl_ordr = '3');''');
//
//rbt_cls_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '4', \'割戻対象商品使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '4');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '4', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '4' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '4', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '4' AND ctrl_ordr = '2');''');
//
//prcchg_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '5', \'売価変更許可', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '5');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '5', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '5' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '5', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '5' AND ctrl_ordr = '2');''');
//
//stldsc_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '6', \'小計値引/割引使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '6');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '6', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '6' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '6', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '6' AND ctrl_ordr = '2');''');
//
//regsale_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '7', \'部門外売/通常売使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '7');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '7', '1', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '7' AND ctrl_ordr = '1');''');
//
//taxtbl_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '8', \'税テーブル使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '8');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '8', '1', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '8' AND ctrl_ordr = '1');''');
//
//treat_cls_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '9', \'登録時取扱分類', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '9');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '9', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '9' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '9', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '9' AND ctrl_ordr = '2');''');
//
//wgh_cd_base_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '11', \'重量バーコード　値段計算単位\n０：１［ｇ］　１：１０［ｇ］', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '11');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '11', '1', '0', \'1g', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '11' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '11', '2', '1', \'10g', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '11' AND ctrl_ordr = '2');''');
//
//wgh_cd_rnd_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '12', \'重量バーコード　まるめ', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '12');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '12', '1', '0', \'四捨五入', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '12' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '12', '2', '1', \'切り上げ', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '12' AND ctrl_ordr = '2');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '12', '3', '2', \'切り捨て', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '12' AND ctrl_ordr = '3');''');
//
//udt_both_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '13', \'２人制時、売り上げを両方の従業員に加算', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '13');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '13', '1', '0', \'しない', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '13' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '13', '2', '1', \'する', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '13' AND ctrl_ordr = '2');''');
//
//reg_tenant_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '14', \'レジテナントフラグ\n（レジでの従業員速報のみ有効なフラグ）', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '14');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '14', '1', '0', \'しない', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '14' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '14', '2', '1', \'する', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '14' AND ctrl_ordr = '2');''');
//
//multprc_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '15', \'複数売価使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '15');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '15', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '15' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '15', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '15' AND ctrl_ordr = '2');''');
//
//preset_img_cls_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '16', \'画像分類階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '16');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '16', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '16' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '16', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '16' AND ctrl_ordr = '2');''');
//
//stlplus_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '17', \'小計割増使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '17');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '17', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '17' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '17', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '17' AND ctrl_ordr = '2');''');
//
//pctr_tckt_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '18', \'単品値下商品フラグ階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '18');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '18', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '18' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '18', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '18' AND ctrl_ordr = '2');''');
//
//clothing_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '19', \'衣料対象商品フラグ階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '19');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '19', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '19' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '19', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '19' AND ctrl_ordr = '2');''');
//
//alert_cls (FIL3)
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '20', \'警告商品使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '20');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '20', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '20' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '20', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '20' AND ctrl_ordr = '2');''');
//
//chg_ckt_cls (FIL4)
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '21', \'引換券発券商品使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '21');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '21', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '21' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '21', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '21' AND ctrl_ordr = '2');''');
//
//kitchen_prn_cls (FIL4)
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '22', \'キッチンプリンタ印字対象フラグ', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '22');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '22', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '22' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '22', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '22' AND ctrl_ordr = '2');''');
//
//pricing_cls (FIL5)
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '23', \'値付けラベル使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '23');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '23', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '23' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '23', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '23' AND ctrl_ordr = '2');''');
//
//coupon_cls (FIL5)
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '24', \'大感謝クーポン対象使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '24');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '24', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '24' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '24', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '24' AND ctrl_ordr = '2');''');
//
//self_weight_cls (FIL6)
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '25', \'セルフ重量チェック使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '25');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '25', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '25' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '25', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '25' AND ctrl_ordr = '2');''');
//
//msg_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '26', \'メッセージ名称使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '26');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '26', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '26' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '26', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '26' AND ctrl_ordr = '2');''');
//
//pop_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '27', \'ポップアップ名称使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '27');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '27', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '27' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '27', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '27' AND ctrl_ordr = '2');''');
//
//cust_detail_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '28', \'会員明細使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '28');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '28', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '28' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '28', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '28' AND ctrl_ordr = '2');''');
//
//magazine_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '29', \'雑誌部門登録使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '29');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '29', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '29' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '29', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '29' AND ctrl_ordr = '2');''');
//
//tax_exemption_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '30', \'免税フラグ使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '30');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '30', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '30' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '30', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '30' AND ctrl_ordr = '2');''');
//
//book_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '31', \'書籍部門登録使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '31');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '31', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '31' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '31', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '31' AND ctrl_ordr = '2');''');
//
//cust_unlock
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '32', \'会員情報　自動ロック解除時間 [分]', '0', '0', '99', '1', '2', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '32');''');
//
//cls_points_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '33', \'分類対象ポイント使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '33');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '33', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '33' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '33', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '33' AND ctrl_ordr = '2');''');
//
//sub1_points_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '34', \'サブ1分類対象ポイント使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '34');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '34', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '34' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '34', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '34' AND ctrl_ordr = '2');''');
//
//sub1_stldsc_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '35', \'サブ1小計値引/割引使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '35');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '35', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '35' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '35', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '35' AND ctrl_ordr = '2');''');
//
//sub1_stlplus_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '36', \'サブ1小計割増使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '36');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '36', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '36' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '36', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '36' AND ctrl_ordr = '2');''');
//
//sub1_pctr_tckt_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '37', \'サブ1単品値下商品フラグ階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '37');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '37', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '37' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '37', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '37' AND ctrl_ordr = '2');''');
//
//sub2_points_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '38', \'サブ2分類対象ポイント使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '38');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '38', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '38' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '38', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '38' AND ctrl_ordr = '2');''');
//
//sub2_stldsc_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '39', \'サブ2小計値引/割引使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '39');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '39', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '39' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '39', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '39' AND ctrl_ordr = '2');''');
//
//sub2_stlplus_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '40', \'サブ2小計割増使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '40');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '40', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '40' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '40', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '40' AND ctrl_ordr = '2');''');
//
//sub2_pctr_tckt_cls
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '41', \'サブ2単品値下商品フラグ階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '41');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '41', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '41' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '41', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '41' AND ctrl_ordr = '2');''');
//
//dpnt_add_cls_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '42', \'分類対象dポイントフラグ使用階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '42');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '42', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '42' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '42', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '42' AND ctrl_ordr = '2');''');
//
//dpnt_use_cls_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '43', \'分類対象dポイント利用フラグ階層', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '43');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '43', '1', '1', \'中分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '43' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '43', '2', '2', \'小分類', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '43' AND ctrl_ordr = '2');''');
//
//scalerm_vol_cd_rnd_flg
  await db.execute('''INSERT INTO c_ctrl_set_mst ($insert_field_set) SELECT '44', \'体積バーコード　まるめ', '0', '3', '0', '0', '0', '0', '5', \'', '0', $cmn_set WHERE NOT EXISTS ($sub_query_1 = '44');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '44', '1', '0', \'四捨五入', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '44' AND ctrl_ordr = '1');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '44', '2', '1', \'切り上げ', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '44' AND ctrl_ordr = '2');''');
  await db.execute('''INSERT INTO c_ctrl_sub_mst ($insert_field_sub) SELECT '44', '3', '2', \'切り捨て', '5', $cmn_set WHERE NOT EXISTS ($sub_query_2 = '44' AND ctrl_ordr = '3');''');
}
Future _mm_trm_chk(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'trm_chk_grp_cd, trm_cd, trm_data, trm_chk_eq_flg ';
  String sub_query = 'SELECT * FROM c_trm_chk_mst WHERE ';

  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '1', '42', '1.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '1' AND trm_cd = '42');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '2', '42', '2.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '2' AND trm_cd = '42');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '3', '195', '1.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '3' AND trm_cd = '195');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '4', '127', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '4' AND trm_cd = '127');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '5', '127', '1.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '5' AND trm_cd = '127');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '6', '594', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '6' AND trm_cd = '594');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '7', '594', '1.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '7' AND trm_cd = '594');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '8', '533', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '8' AND trm_cd = '533');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '9', '533', '1.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '9' AND trm_cd = '533');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '10', '75', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '10' AND trm_cd = '75'); -- 案分''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '11', '75', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '11' AND trm_cd = '75'); -- 非案分''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '12', '567', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '12' AND trm_cd = '567');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '13', '567', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '13' AND trm_cd = '567');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '14', '218', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '14' AND trm_cd = '218');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '15', '218', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '15' AND trm_cd = '218');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '16', '369', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '16' AND trm_cd = '369');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '17', '369', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '17' AND trm_cd = '369');''');
//-- ターミナル590は、コープさっぽろ特注(cm_RainbowCard_system)のため削除された
  //await db.execute('''-- INSERT INTO c_trm_chk_mst ($insert_field) SELECT '18', '590', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '18' AND trm_cd = '590');''');
  //await db.execute('''-- INSERT INTO c_trm_chk_mst ($insert_field) SELECT '19', '590', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '19' AND trm_cd = '590');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '20', '602', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '20' AND trm_cd = '602');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '21', '602', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '21' AND trm_cd = '602');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '22', '603', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '22' AND trm_cd = '603');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '23', '603', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '23' AND trm_cd = '603');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '24', '604', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '24' AND trm_cd = '604');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '25', '604', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '25' AND trm_cd = '604');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '26', '605', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '26' AND trm_cd = '605');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '27', '605', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '27' AND trm_cd = '605');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '28', '533', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '28' AND trm_cd = '533');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '28', '567', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '28' AND trm_cd = '567');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '29', '75', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '29' AND trm_cd = '75');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '29', '218', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '29' AND trm_cd = '218');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '30', '75', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '30' AND trm_cd = '75');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '30', '218', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '30' AND trm_cd = '218');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '31', '289', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '31' AND trm_cd = '289');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '32', '691', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '32' AND trm_cd = '691');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '33', '42', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '33' AND trm_cd = '42');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '34', '1145', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '34' AND trm_cd = '1145');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '35', '1145', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '35' AND trm_cd = '1145');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '36', '603', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '36' AND trm_cd = '603');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '37', '603', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '37' AND trm_cd = '603');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '37', '1145', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '37' AND trm_cd = '1145');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '38', '603', '2.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '38' AND trm_cd = '603');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '39', '603', '3.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '39' AND trm_cd = '603');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '40', '766', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '40' AND trm_cd = '766');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '41', '289', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '41' AND trm_cd = '289');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '41', '602', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '41' AND trm_cd = '602');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '42', '444', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '42' AND trm_cd = '444');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '43', '75', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '43' AND trm_cd = '75');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '43', '444', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '43' AND trm_cd = '444');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '44', '75', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '44' AND trm_cd = '75');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '44', '444', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '44' AND trm_cd = '444');''');
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '45', '1197', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '45' AND trm_cd = '1197');''');// 粗利印字：する
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '46', '247', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '46' AND trm_cd = '247');''');// 会員売上金額印字：税込合計
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '47', '247', '0.00', '1' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '47' AND trm_cd = '247');''');// 会員売上金額印字：純売上金額
  await db.execute('''INSERT INTO c_trm_chk_mst ($insert_field) SELECT '48', '1355', '0.00', '0' WHERE NOT EXISTS ($sub_query trm_chk_grp_cd = '48' AND trm_cd = '1355');''');// 過不足印字：する
}
Future _mm_stropncls(db, value,int COMP,int STRE,int MACNO,int GRP) async {
  String insert_field = 'comp_cd, stre_cd, stropncls_grp, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, stropncls_cd, stropncls_data, data_typ';
  String cmn_set = ' $COMP, $STRE, $GRP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT stropncls_cd FROM c_stropncls_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND stropncls_grp = $GRP';

//グループ１(自動開閉店しない)
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '100', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '100');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '200', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '200');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '300', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '300');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '400', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '400');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '500', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '500');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '600', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '600');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '700', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '700');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '800', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '800');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '810', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '810');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '900', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '900');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1000', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1000');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1100', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1100');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1200', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1200');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1250', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1250');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1300', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1300');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1400', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1400');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1500', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1500');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1600', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1600');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1700', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1700');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1800', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1800');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '1900', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '1900');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2000', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2000');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2100', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2100');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2200', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2200');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2300', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2300');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2350', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2350');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2370', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2370');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2371', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2371');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2372', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2372');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2400', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2400');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2500', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2500');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2600', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2600');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2700', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2700');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2800', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2800');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '2900', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '2900');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3000', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3000');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3100', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3100');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3150', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3150');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3200', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3200');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3300', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3300');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3400', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3400');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3500', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3500');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3550', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3550');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3600', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3600');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3650', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3650');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3700', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3700');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3800', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3800');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '3900', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '3900');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4000', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4000');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4100', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4100');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4200', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4200');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4300', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4300');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4400', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4400');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4500', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4500');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4600', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4600');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4700', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4700');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4800', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4800');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '4900', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '4900');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '5000', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '5000');''');
//
//
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '10000', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '10000');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '20000', '1', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '20000');''');
  await db.execute('''INSERT INTO c_stropncls_mst ($insert_field) SELECT $cmn_set, '21000', '0', '0' WHERE NOT EXISTS ($sub_query AND stropncls_cd = '21000');''');
}
Future _mm_set_stropncls(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field_set = ' ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, stropncls_cd, stropncls_name, stropncls_dsp_cond, stropncls_inp_cond, stropncls_limit_max, stropncls_limit_min, stropncls_digits, stropncls_zero_typ, stropncls_btn_color, stropncls_info_comment, stropncls_info_pic';
  String insert_field_sub = ' ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, stropncls_cd, stropncls_ordr, stropncls_data, stropncls_comment, stropncls_btn_color';
  String cmn_set = 'CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\'';
  String sub_query_set = 'SELECT * FROM c_stropncls_set_mst WHERE stropncls_cd ';
  String sub_query_sub = 'SELECT * FROM c_stropncls_sub_mst WHERE stropncls_cd ';

//stre open
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1', \'開店準備自動化', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '1' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '1' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '100', \'開設処理実行の待ち時間（１～10分）\n 0:手動', '0', '0', '10', '0', '2', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '100');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '200', \'開店時チェッカー従業員のログイン', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '200');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '200', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '200' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '200', '2', '1', \'手動', '5' WHERE NOT EXISTS ($sub_query_sub = '200' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '200', '3', '2', \'自動', '5' WHERE NOT EXISTS ($sub_query_sub = '200' AND stropncls_ordr = '3');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '300', \'開店時キャッシャー従業員のログイン', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '300');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '300', '1', '0', \'手動', '5' WHERE NOT EXISTS ($sub_query_sub = '300' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '300', '2', '1', \'自動', '5' WHERE NOT EXISTS ($sub_query_sub = '300' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '400', \'釣準備', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '400');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '400', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '400' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '400', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '400' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '500', \'釣機参照', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '500');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '500', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '500' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '500', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '500' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '600', \'開店差異チェック', '1', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '600');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '600', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '600' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '600', '2', '1', \'手動', '5' WHERE NOT EXISTS ($sub_query_sub = '600' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '600', '3', '2', \'ドロア過不足なし時自動', '5' WHERE NOT EXISTS ($sub_query_sub = '600' AND stropncls_ordr = '3');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '600', '4', '3', \'自動', '5' WHERE NOT EXISTS ($sub_query_sub = '600' AND stropncls_ordr = '4');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '700', \'開店差異チェックレポート印字', '1', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '700');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '700', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '700' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '700', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '700' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '700', '3', '2', \'過不足あり時のみ', '5' WHERE NOT EXISTS ($sub_query_sub = '700' AND stropncls_ordr = '3');''');
//
//stre close
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '800', \'精算業務', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '800');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '800', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '800' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '800', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '800' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '810', \'アシストモニター精算業務指示ダイアログ表示時間\n（0～99分）(0:即時実行）', '0', '0', '99', '0', '2', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '810');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '900', \'精算単体実行', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '900');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '900', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '900' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '900', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '900' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1000', \'精算業務ボタン押下時パスワード入力', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1000');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1000', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '1000' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1000', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '1000' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1100', \'在高確定時の釣機再精査(ECS接続時のみ)', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1100');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1100', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '1100' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1100', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '1100' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1200', \'釣機再精査レポート印字', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1200');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1200', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '1200' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1200', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '1200' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1200', '3', '2', \'変動あり時のみ', '5' WHERE NOT EXISTS ($sub_query_sub = '1200' AND stropncls_ordr = '3');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1250', \'RT-300釣機在高不確定解除処理', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1250');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1250', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '1250' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1250', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '1250' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1300', \'精算前予約レポート印字', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1300');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1300', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '1300' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1300', '2', '1', \'選択番号のみ', '5' WHERE NOT EXISTS ($sub_query_sub = '1300' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '1300', '3', '2', \'全選択', '5' WHERE NOT EXISTS ($sub_query_sub = '1300' AND stropncls_ordr = '3');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1400', \'精算前出力予約レポート１', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1400');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1500', \'精算前出力予約レポート２', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1500');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1600', \'精算前出力予約レポート３', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1600');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1700', \'精算前出力予約レポート４', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1700');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1800', \'精算前出力予約レポート５', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1800');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '1900', \'精算前出力予約レポート６', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '1900');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2000', \'精算前出力予約レポート７', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2000');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2100', \'精算前出力予約レポート８', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2100');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2200', \'精算前出力予約レポート９', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2200');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2300', \'精算前予約レポート自動発行', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2300');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2300', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2300' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2300', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '2300' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2350', \'精算時キャッシャー従業員のログイン', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2350');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2350', '1', '0', \'手動', '5' WHERE NOT EXISTS ($sub_query_sub = '2350' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2350', '2', '1', \'自動', '5' WHERE NOT EXISTS ($sub_query_sub = '2350' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2370', \'ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2370');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2370', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2370' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2370', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '2370' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2371', \'ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ印字', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2371');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2371', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2371' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2371', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '2371' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2372', \'ｵｰﾊﾞｰﾌﾛｰ庫硬貨が釣銭機に収納可能な場合は補充', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2372');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2372', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2372' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2372', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '2372' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2400', \'精算差異チェック', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2400');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2400', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2400' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2400', '2', '1', \'手動', '5' WHERE NOT EXISTS ($sub_query_sub = '2400' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2400', '3', '2', \'ドロア過不足なし時自動', '5' WHERE NOT EXISTS ($sub_query_sub = '2400' AND stropncls_ordr = '3');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2400', '4', '3', \'自動', '5' WHERE NOT EXISTS ($sub_query_sub = '2400' AND stropncls_ordr = '4');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2500', \'精算差異チェックレポート印字', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2500');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2500', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2500' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2500', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '2500' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2500', '3', '2', \'過不足あり時のみ', '5' WHERE NOT EXISTS ($sub_query_sub = '2500' AND stropncls_ordr = '3');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2600', \'売上回収', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2600');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2600', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2600' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2600', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '2600' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2700', \'差異チェックから売上回収に引継ぐデータ（ドロア紙幣）', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2700');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2700', '1', '0', \'反映しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2700' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2700', '2', '1', \'反映する', '5' WHERE NOT EXISTS ($sub_query_sub = '2700' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2700', '3', '2', \'万券のみ', '5' WHERE NOT EXISTS ($sub_query_sub = '2700' AND stropncls_ordr = '3');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2800', \'差異チェックから売上回収に引継ぐデータ（ドロア硬貨）', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2800');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2800', '1', '0', \'反映しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2800' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2800', '2', '1', \'反映する', '5' WHERE NOT EXISTS ($sub_query_sub = '2800' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '2900', \'差異チェックから売上回収に引継ぐデータ（品券／会計）', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '2900');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2900', '1', '0', \'反映しない', '5' WHERE NOT EXISTS ($sub_query_sub = '2900' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '2900', '2', '1', \'反映する', '5' WHERE NOT EXISTS ($sub_query_sub = '2900' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3000', \'差異チェックから売上回収に引継ぐデータ（釣機紙幣）', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3000');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3000', '1', '0', \'反映しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3000' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3000', '2', '1', \'反映する', '5' WHERE NOT EXISTS ($sub_query_sub = '3000' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3000', '3', '2', \'万券のみ', '5' WHERE NOT EXISTS ($sub_query_sub = '3000' AND stropncls_ordr = '3');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3100', \'差異チェックから売上回収に引継ぐデータ（釣機硬貨）', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3100');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3100', '1', '0', \'反映しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3100' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3100', '2', '1', \'反映する', '5' WHERE NOT EXISTS ($sub_query_sub = '3100' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3150', \'従業員精算処理', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3150');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3150', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3150' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3150', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '3150' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3200', \'差異チェックデータ引継ぐ時売上回収自動実行', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3200');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3200', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3200' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3200', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '3200' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3300', \'売上回収レポート印字', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3300');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3300', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3300' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3300', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '3300' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3400', \'上位サーバー接続時キャッシュリサイクル実行', '1', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3400');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3400', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3400' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3400', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '3400' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3500', \'釣機回収', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3500');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3500', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3500' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3500', '2', '1', \'自動選択(残置回収)', '5' WHERE NOT EXISTS ($sub_query_sub = '3500' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3500', '3', '2', \'手動選択(複数回可)', '5' WHERE NOT EXISTS ($sub_query_sub = '3500' AND stropncls_ordr = '3');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3500', '4', '3', \'自動選択(全回収)', '5' WHERE NOT EXISTS ($sub_query_sub = '3500' AND stropncls_ordr = '4');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3500', '5', '4', \'する(複数回可)', '5' WHERE NOT EXISTS ($sub_query_sub = '3500' AND stropncls_ordr = '5');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3550', \'釣機回収スキップ操作', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3550');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3550', '1', '0', \'可能', '5' WHERE NOT EXISTS ($sub_query_sub = '3550' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3550', '2', '1', \'禁止', '5' WHERE NOT EXISTS ($sub_query_sub = '3550' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3600', \'釣機回収レポート印字', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3600');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3600', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3600' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3600', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '3600' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3650', \'釣機回収硬貨搬送先', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3650');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3650', '1', '0', \'出金口', '5' WHERE NOT EXISTS ($sub_query_sub = '3650' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3650', '2', '1', \'ｵｰﾊﾞｰﾌﾛｰ庫', '5' WHERE NOT EXISTS ($sub_query_sub = '3650' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3700', \'精算後予約レポート印字', '0', '1', '2', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3700');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3700', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '3700' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3700', '2', '1', \'選択番号のみ', '5' WHERE NOT EXISTS ($sub_query_sub = '3700' AND stropncls_ordr = '2');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '3700', '3', '2', \'全選択', '5' WHERE NOT EXISTS ($sub_query_sub = '3700' AND stropncls_ordr = '3');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3800', \'精算後出力予約レポート１', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3800');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '3900', \'精算後出力予約レポート２', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '3900');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4000', \'精算後出力予約レポート３', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4000');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4100', \'精算後出力予約レポート４', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4100');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4200', \'精算後出力予約レポート５', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4200');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4300', \'精算後出力予約レポート６', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4300');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4400', \'精算後出力予約レポート７', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4400');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4500', \'精算後出力予約レポート８', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4500');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4600', \'精算後出力予約レポート９', '0', '0', '9999', '0', '4', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4600');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4700', \'精算後予約レポート自動発行', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4700');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '4700', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '4700' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '4700', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '4700' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4800', \'閉設時精算レポート出力', '1', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4900');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '4800', '1', '0', \'しない', '5' WHERE NOT EXISTS ($sub_query_sub = '4800' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '4800', '2', '1', \'する', '5' WHERE NOT EXISTS ($sub_query_sub = '4800' AND stropncls_ordr = '2');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '4900', \'閉設処理実行の待ち時間（１～10分）\n 0:閉設処理行わない', '0', '0', '10', '0', '2', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '4900');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '5000', \'閉設処理実行時間', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '5000');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '5000', '1', '0', \'待ち時間', '5' WHERE NOT EXISTS ($sub_query_sub = '5000' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '5000', '2', '1', \'指定時刻', '5' WHERE NOT EXISTS ($sub_query_sub = '5000' AND stropncls_ordr = '2');''');
//
//
//
//
//強制閉設
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '10000', \'開閉設手動操作', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '10000');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '10000', '1', '0', \'許可', '5' WHERE NOT EXISTS ($sub_query_sub = '10000' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '10000', '2', '1', \'禁止', '5' WHERE NOT EXISTS ($sub_query_sub = '10000' AND stropncls_ordr = '2');''');
//
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '20000', \'強制閉設ダイアログ表示時間（１～99分）', '0', '0', '99', '1', '2', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '20000');''');
//
  await db.execute('''INSERT INTO c_stropncls_set_mst ($insert_field_set) SELECT $cmn_set, '21000', \'強制閉設複数回実行', '0', '1', '1', '0', '0', '0', '5', '', '0' WHERE NOT EXISTS ($sub_query_set = '21000');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '21000', '1', '0', \'禁止', '5' WHERE NOT EXISTS ($sub_query_sub = '21000' AND stropncls_ordr = '1');''');
  await db.execute('''INSERT INTO c_stropncls_sub_mst ($insert_field_sub) SELECT $cmn_set, '21000', '2', '1', \'許可', '5' WHERE NOT EXISTS ($sub_query_sub = '21000' AND stropncls_ordr = '2');''');
}
Future _mm_operation(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, stre_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, ope_cd, ope_name';
  String cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT ope_cd FROM c_operation_mst WHERE comp_cd = $COMP AND stre_cd = $STRE ';
  String insert_field_auth = 'comp_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, ope_cd, auth_lvl';
  String cmn_set_auth = ' $COMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query_auth = 'SELECT ope_cd, auth_lvl FROM c_operationauth_mst WHERE comp_cd = $COMP ';

  await db.execute('''insert into c_operation_mst ($insert_field) SELECT $cmn_set, '1', \'販売注意' WHERE NOT EXISTS ($sub_query AND ope_cd = '1');''');
  await db.execute('''insert into c_operation_mst ($insert_field) SELECT $cmn_set, '2', \'販売不可' WHERE NOT EXISTS ($sub_query AND ope_cd = '2');''');
  await db.execute('''insert into c_operation_mst ($insert_field) SELECT $cmn_set, '3', \'ﾊﾟｽﾜｰﾄﾞ確認' WHERE NOT EXISTS ($sub_query AND ope_cd = '3');''');
  await db.execute('''insert into c_operation_mst ($insert_field) SELECT $cmn_set, '4', \'酒税設定変更' WHERE NOT EXISTS ($sub_query AND ope_cd = '4');''');
//
//
//c_operationauth_mst
  await db.execute('''insert into c_operationauth_mst ($insert_field_auth) SELECT $cmn_set_auth, '4', '1' WHERE NOT EXISTS ($sub_query_auth AND ope_cd = '4' AND auth_lvl = '1');''');
  await db.execute('''insert into c_operationauth_mst ($insert_field_auth) SELECT $cmn_set_auth, '4', '2' WHERE NOT EXISTS ($sub_query_auth AND ope_cd = '4' AND auth_lvl = '2');''');
  await db.execute('''insert into c_operationauth_mst ($insert_field_auth) SELECT $cmn_set_auth, '4', '3' WHERE NOT EXISTS ($sub_query_auth AND ope_cd = '4' AND auth_lvl = '3');''');
}
Future _mm_menuobj(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, stre_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, proc, win_name, page, btn_pos_x, btn_pos_y, btn_width, btn_height, object_div, appl_grp_cd, btn_color, img_name, pass_chk_flg ';
  String cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'syst\', \'mainmenu\', \'1\' ';
  String sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'syst\' AND win_name = \'mainmenu\' AND page = \'1\' ';

  await db.execute('''DELETE FROM c_menu_obj_mst WHERE win_name <> 'mainmenu' AND win_name <> 'favorite' AND comp_cd = $COMP AND stre_cd = $STRE;''');
//-- 0-6:（釣機再精査）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '1', '7', '1', '1', '0', '127', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '1' AND btn_pos_y = '7');''');
//
//-- 1-1:「登録」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '101', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「オープン／クローズ」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '102', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「訂正」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '103', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「訓練」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '104', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「廃棄」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '105', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「売上速報」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '107', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「売上点検」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '108', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「売上精算」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '109', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '2816', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「売価変更」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '112', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「予約レポート出力」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '113', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「ユーザーセットアップ」
//   await db.execute('''-- insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '4352', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8'); appl_grp_cd=116を作成''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '116', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「閉設処理」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '117', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//-- 3-1:（切替）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '3', '1', '1', '0', '121', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '3');''');
//-- 3-2:（音量調整）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '2', '1', '1', '0', '122', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '2');''');
//-- 3-3:（即時受信）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '6', '1', '1', '0', '123', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '6');''');
//-- 3-4:（電源）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '10', '1', '1', '0', '124', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '10');''');
//-- 3-5:（常駐メモ）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '4', '1', '1', '0', '125', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '4');''');
//-- 3-6:（連絡メモ）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '5', '1', '1', '0', '126', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '5');''');
//
//--[for Favorite]
//--1ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'syst\', \'favorite\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'syst\' AND win_name = \'favorite\' AND page = \'1\' ';
//
//-- 0-6:（釣機再精査）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '1', '7', '1', '1', '0', '127', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '1' AND btn_pos_y = '7');''');
//
//-- 1-1:「登録」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '101', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:（「オープン／クローズ」）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '102', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「訂正」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '103', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「訓練」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '104', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「廃棄」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '105', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「売上速報」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '107', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「売上点検」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '108', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「売上精算」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '109', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '2816', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「売価変更」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '112', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「予約レポート出力」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '113', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「ユーザーセットアップ」
//   await db.execute('''-- insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '4352', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8'); appl_grp_cd=116を作成''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '116', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「閉設処理」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '117', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//-- 3-1:（切替）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '3', '1', '1', '0', '121', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '3');''');
//-- 3-2:（音量調整）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '2', '1', '1', '0', '122', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '2');''');
//-- 3-3:（即時受信）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '6', '1', '1', '0', '123', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '6');''');
//-- 3-4:（電源）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '10', '1', '1', '0', '124', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '10');''');
//-- 3-5:（常駐メモ）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '4', '1', '1', '0', '125', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '4');''');
//-- 3-6:（連絡メモ）
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '12', '5', '1', '1', '0', '126', '1', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '12' AND btn_pos_y = '5');''');
//
//メニューオブジェクト割り当て割り当てマスタ【設定メイン画面用】
//--[for PmodMain]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'pmodmain\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'pmodmain\' AND page = \'1\' ';
//
//--1ページ目
//-- 1-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '201', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '202', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '203', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '204', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '205', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '206', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '207', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '208', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '209', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '210', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '211', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '212', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '213', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '214', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '215', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '216', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '290', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '218', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--2ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'pmodmain\', \'2\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'pmodmain\' AND page = \'2\' ';
//-- 1-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '221', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '222', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '223', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '224', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '225', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '226', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '227', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '228', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '229', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '230', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '231', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '233', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「自動開閉店」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '291', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「区分」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '292', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '236', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '237', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '238', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--3ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'pmodmain\', \'3\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'pmodmain\' AND page = \'3\' ';
//-- 1-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '241', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '242', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '243', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '244', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '245', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '246', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '247', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '248', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '249', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '250', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '251', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '253', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '254', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '255', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '257', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '258', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '259', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--4ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'pmodmain\', \'4\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'pmodmain\' AND page = \'4\' ';
//-- 1-1:「ユーサーメニュー設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '271', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「店舗情報」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '273', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「ダイアログ」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '274', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「コード決済事業者」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '382', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「生産者品目設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '272', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「酒品目」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '341', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「酒税」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '342', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '261', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--[for PresetMain]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'presetmain\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'presetmain\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '301', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '307', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '302', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '322', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:（ブランク（））
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '328', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '306', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '308', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '309', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '310', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '320', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '321', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「キーレイアウト設定:3800a卓上 35ｷｰ」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '329', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--[for PresetSub_Ext]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'presetsub_ext\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'presetsub_ext\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「商品明細（登録）プリセット設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '323', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「商品明細（小計）プリセット設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '324', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「商品登録補助プリセット設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '325', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「登録補助プリセット設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '326', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「決済プリセット設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '327', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//
//--[for staff]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'staff\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'staff\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:従業員設定
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '350', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:従業員権限設定
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '351', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:従業員バーコード印字
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '352', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//
//--[for divide]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'divide\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'divide\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:入金
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '330', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:出金
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '331', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:掛売相手先
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '332', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:決済種選択
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '338', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:釣銭決済種選択
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '339', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:値引理由
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '333', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:割引理由
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '334', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:返品理由
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '335', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:取消理由
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '336', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:訂正理由
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '337', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:廃棄理由
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '340', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:売変理由
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '595', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:両替理由
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '596', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'divide\', \'2\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'divide\' AND page = \'2\' ';
//--2ページ目
//-- 3-1:金種商品品券
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '560', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 3-2:金種商品品券
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '561', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 3-3:金種商品品券
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '562', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 3-4:金種商品品券
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '563', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 3-5:金種商品品券
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '564', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 3-6:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '565', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 3-7:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '566', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 3-8:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '567', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 3-9:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '568', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 4-1:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '569', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 4-2:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '570', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 4-3:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '571', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 4-4:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '572', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 4-5:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '573', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 4-6:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '574', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 4-7:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '575', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 4-8:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '576', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 4-9:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '577', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'divide\', \'3\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'divide\' AND page = \'3\' ';
//--2ページ目
//-- 5-1:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '578', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 5-2:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '579', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 5-3:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '580', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 5-4:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '581', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 5-5:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '582', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 5-6:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '583', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 5-7:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '584', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 5-8:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '585', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 5-9:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '586', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 6-1:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '587', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 6-2:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '588', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 6-3:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '589', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 6-4:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '590', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 6-5:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '591', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 6-6:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '592', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 6-7:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '593', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 6-8:金種商品会計
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '594', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 6-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//
//--[for customer menu]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'custmenu\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'custmenu\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「顧客設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '390', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「ポイント倍スケジュール」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '392', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「サービス分類スケジュール」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '393', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「ロイヤリティ設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '394', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「クーポン設定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '395', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「購買履歴確認除外商品」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '391', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「商品ポイントスケジュール」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '232', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//
//--[for message]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'message\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'message\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:メッセージマスタ
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '360', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:メッセージレイアウト
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '361', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「メッセージスケジュール」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '362', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--[for image/function]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'imagefunc\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'imagefunc\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:イメージ
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '370', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:ファンクション
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '371', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//
//--[for キャッシュリサイクル関連]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'pmod\', \'cashrecyclefunc\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'pmod\' AND win_name = \'cashrecyclefunc\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:キャッシュリサイクル
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '380', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:キャッシュリサイクル管理
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '381', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//
//メニューオブジェクト割り当て割り当てマスタ【売上速報メニュー画面用】
//--[for sale_com_mm]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'sale_com_mm_0\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'sale_com_mm_0\' AND page = \'1\' ';
//【速報】
//--1ページ目
//-- 1-1:「中分類」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '401', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「小分類」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '402', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「商品」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '403', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「レジ別」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '404', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「従業員別」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '405', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「特売」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '406', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（M）レジ別釣銭機」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '526', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（S）レジ別釣銭機」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '527', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--2ページ目
//--[for sale_com_mm]
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'sale_com_mm_0\', \'2\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'sale_com_mm_0\' AND page = \'2\' ';
//-- 1-1:「会員合計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '411', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「会員情報」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '414', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//【点検】
//--1ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'sale_com_mm_1\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'sale_com_mm_1\' AND page = \'1\' ';
//-- 1-1:「レジ日計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '415', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「電子ジャーナル」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '416', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「店舗日計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '421', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「店舗累計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '422', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「一覧」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '423', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「会員関連」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '600', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 1-10:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--2ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'sale_com_mm_1\', \'2\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'sale_com_mm_1\' AND page = \'2\' ';
//-- 1-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「精算レポート(日計)」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '529', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「お会計券未清算」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '524', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「稼動時間帯」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「ブランク」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「再精査」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '523', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「リサイクル入出金明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '431', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「リサイクル入出金履歴」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '432', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「精算情報」　(予約レポート設定のみ)
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '528', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//【精算】
//--1ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'sale_com_mm_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'sale_com_mm_2\' AND page = \'1\' ';
//-- 1-1:「レジ日計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '1415', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「実績再集計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「電子ジャーナル」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '1416', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「ログ関連」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '1418', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「店舗日計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '1421', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「店舗累計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '1422', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「一覧」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '1423', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「会員関連」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '1600', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--2ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'sale_com_mm_2\', \'2\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'sale_com_mm_2\' AND page = \'2\' ';
//-- 1-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「精算レポート(日計)」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '1529', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「お会計券未清算」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '1524', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「稼動時間帯」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「再精査」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '1523', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「リサイクル入出金明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '1431', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「リサイクル入出金履歴」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '1432', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「途中精算」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '1530', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「ＲＭ関連」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '1700', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「精算情報」 (予約レポート設定のみ)
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '1528', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/レジ日計メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'regist_day_acnt\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'regist_day_acnt\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「レジ取引明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '434', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「レジ大分類別売上」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '435', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「レジ中分類別売上」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '436', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「レジ小分類別売上」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '437', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「レジクラス別売上」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '438', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「レジ売上キー」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '439', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「レジ入出金」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '440', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「レジ在高」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '441', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「レジ釣銭機明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '442', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「一括点検」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '443', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「レジ従業員別簡易取引明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '525', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「メディア情報」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '445', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「クレジット控え」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '446', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「シベール日計レポート」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '447', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「クレジット会社別」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '448', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「セルフ稼働時間」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '449', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「セルフ時間帯」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '450', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「領収書控え」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '451', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//-- メニューオブジェクト割り当て割り当てマスタ【売上点検/レジ日計メニュー画面用(P2)】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'regist_day_acnt\', \'2\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'regist_day_acnt\' AND page = \'2\' ';
//--1ページ目
//-- 1-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「精算レポート」 WS様向け
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '555', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//-- メニューオブジェクト割り当て割り当てマスタ【売上精算/レジ日計メニュー画面用(P2)】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'regist_day_acnt_2\', \'2\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'regist_day_acnt_2\' AND page = \'2\' ';
//--1ページ目
//-- 1-1:「レジ会計別税明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '1526', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「精算レポート」 WS様向け
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '1555', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/レジ日計メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'regist_day_acnt_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'regist_day_acnt_2\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「レジ取引明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '1434', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「レジ大分類別売上」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '1435', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「レジ中分類別売上」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1436', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「レジ小分類別売上」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '1437', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「レジクラス別売上」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '1438', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「レジ売上キー」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '1439', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「レジ入出金」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '1440', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「レジ在高」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '1441', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「レジ釣銭機明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '1442', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「一括点検」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '1443', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「レジ従業員別簡易取引明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '1525', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「メディア情報」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '1445', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「クレジット控え」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '1446', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「シベール日計レポート」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '1447', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「クレジット会社別」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '1448', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「セルフ稼働時間」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '1449', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「セルフ時間帯」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '1450', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「領収書控え」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '1451', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗日計メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_acnt\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_acnt\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '419', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 取引明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '427', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '420', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 分類別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '425', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 商品別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '426', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- スケジュール別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '428', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 釣銭機明細''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗日計/取引明細メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_deal\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_deal\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '452', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 店舗取引明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '459', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 店舗時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '453', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 売計キー''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '454', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 入出金''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '455', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- 在高''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '456', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 従業員別取引明細''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗日計/分類別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_cls\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_cls\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '457', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 中分類別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '460', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 中分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '463', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 中分類別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '464', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 中分類別粗利順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '458', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4'); -- 小分類別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '461', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5'); -- 小分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '465', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6'); -- 小分類別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '466', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7'); -- 小分類別粗利順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗日計/商品別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_plu\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_plu\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '470', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 商品別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '462', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 商品別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '471', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 商品別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '472', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 商品別数量順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '475', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 商品別値下売上''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗日計/スケジュール別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_sch\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_sch\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '477', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- スケジュール別特売商品''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '478', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- ミックスマッチ''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '479', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- セットマッチ''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗日計/時間帯メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_time\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_time\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '459', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 店舗時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '460', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 中分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '461', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 小分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '462', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- 商品別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '468', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- セルフ時間帯''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗日計/釣銭機明細メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_chg\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_chg\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '476', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- レジ別釣銭機明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗日計メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_acnt_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_acnt_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1419', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 取引明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '1427', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '1420', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 分類別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '1425', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 商品別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '1426', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- スケジュール別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '1428', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 釣銭機明細''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗日計/取引明細メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_deal_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_deal_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1452', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 店舗取引明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '1459', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 店舗時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '1453', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 売計キー''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '1454', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 入出金''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '1455', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- 在高''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '1456', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 従業員別取引明細''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '1560', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4'); -- 会計別税明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗日計/分類別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_cls_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_cls_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1457', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 中分類別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '1460', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 中分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '1463', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 中分類別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '1464', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 中分類別粗利順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '1458', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4'); -- 小分類別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '1461', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5'); -- 小分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '1465', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6'); -- 小分類別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '1466', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7'); -- 小分類別粗利順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗日計/商品別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_plu_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_plu_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1470', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 商品別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '1462', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 商品別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '1471', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 商品別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '1472', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 商品別数量順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '1475', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 商品別値下売上''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗日計/スケジュール別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_sch_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_sch_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1477', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- スケジュール別特売商品''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '1478', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- ミックスマッチ''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '1479', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- セットマッチ''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗日計/時間帯メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_time_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_time_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1459', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 店舗時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '1460', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 中分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '1461', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 小分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '1462', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- 商品別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '1468', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- セルフ時間帯''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗日計/釣銭機明細メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_day_chg_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_day_chg_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1476', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- レジ別釣銭機明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗累計メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '2419', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 取引明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '2427', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '2420', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 分類別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '2425', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 商品別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '2426', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- スケジュール別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); --''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗累計/取引明細メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_deal\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_deal\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '2452', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 店舗取引明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '2459', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 店舗時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '2453', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 売計キー''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '2454', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 入出金''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '2455', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- 在高''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '2456', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 従業員別取引明細''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗累計/分類別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_cls\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_cls\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '2457', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 中分類別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '2460', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 中分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '2463', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 中分類別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '2464', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 中分類別粗利順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '2458', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4'); -- 小分類別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '2461', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5'); -- 小分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '2465', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6'); -- 小分類別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '2466', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7'); -- 小分類別粗利順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗累計/商品別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_plu\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_plu\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '2470', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 商品別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '2462', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 商品別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '2471', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 商品別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '2472', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 商品別数量順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '2475', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 商品別値下売上''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗累計/スケジュール別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_sch\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_sch\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '2477', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- スケジュール別特売商品''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '2478', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- ミックスマッチ''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '2479', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- セットマッチ''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/店舗累計/時間帯メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_time\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_time\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '2459', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 店舗時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '2460', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 中分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '2461', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 小分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '2462', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- 商品別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '2468', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- セルフ時間帯''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗累計メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '3419', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 取引明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '3427', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '3420', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 分類別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '3425', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 商品別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '3426', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- スケジュール別''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); --''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗累計/取引明細メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_deal_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_deal_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '3452', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 店舗取引明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '3459', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 店舗時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '3453', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 売計キー''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '3454', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 入出金''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '3455', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- 在高''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '3456', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 従業員別取引明細''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '3560', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4'); -- 会計別税明細''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗累計/分類別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_cls_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_cls_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '3457', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 中分類別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '3460', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 中分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '3463', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 中分類別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '3464', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 中分類別粗利順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '3458', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4'); -- 小分類別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '3461', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5'); -- 小分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '3465', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6'); -- 小分類別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '3466', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7'); -- 小分類別粗利順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗累計/商品別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_plu_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_plu_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '3470', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 商品別売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '3462', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5'); -- 商品別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '3471', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 商品別金額順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '3472', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 商品別数量順売上''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '3475', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- 商品別値下売上''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗累計/スケジュール別メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_sch_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_sch_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '3477', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- スケジュール別特売商品''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '3478', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- ミックスマッチ''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '3479', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- セットマッチ''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/店舗累計/時間帯メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'store_total_time_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'store_total_time_2\' AND page = \'1\' ';
//--1ページ目
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '3459', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4'); -- 店舗時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '3460', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6'); -- 中分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '3461', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7'); -- 小分類別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '3462', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8'); -- 商品別時間帯''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '3468', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10'); -- セルフ時間帯''');
//
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '30', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【ログ関連メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'log_menu\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'log_menu\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「強制Ｅｄｙログ送信」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '481', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「強制Ｍカード実績ログ送信」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '482', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【テキスト関連メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'txt_menu\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'txt_menu\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「テキストデータ保存」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '483', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「テキストデータ再送信」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '484', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「テキストデータ訂正送信」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '485', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「生産者実績データ再送信」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '486', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「Ｔｕｏテキストデータ再送信」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '487', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「棚卸データ送信」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '488', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「テキストデータ読込」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '489', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//--2ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'txt_menu\', \'2\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'txt_menu\' AND page = \'2\' ';
//-- 1-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「税種変換 テキストデータ復帰」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '490', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「テキストデータ復帰」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '491', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/一覧メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'list\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'list\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「緊急メンテナンス商品」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '492', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「ノンアクト商品」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '493', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「商品台帳」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '494', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/一覧メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'list_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'list_2\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「緊急メンテナンス商品」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '1492', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「ノンアクト商品」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '1493', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「商品台帳」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '1494', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【会員日計メニュー画面用】
//--1ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'member_day_acnt\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'member_day_acnt\' AND page = \'1\' ';
//-- 1-1:「会員合計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '495', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//-- メニューオブジェクト割り当て割り当てマスタ【会員累計メニュー画面用】
//----1ページ目
//----
//cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'member_total\', \'1\' ';
//sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'member_total\' AND page = \'1\' ';
//---- 1-1:「顧客合計」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '1495', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//---- 1-2:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//---- 1-3:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//---- 1-4:「会員情報」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '1502', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//---- 1-5:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//---- 1-6:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//---- 1-7:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//---- 1-8:「（ブランク）」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//---- 1-9:「（ブランク）」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//---- 2-1:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//---- 2-2:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//---- 2-3:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//---- 2-4:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//---- 2-5:「別」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//---- 2-6:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//---- 2-7:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//---- 2-8:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//---- 2-9:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【会員日計メニュー画面用】
//--1ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'member_day_acnt_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'member_day_acnt_2\' AND page = \'1\' ';
//-- 1-1:「会員合計」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '2495', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//-- メニューオブジェクト割り当て割り当てマスタ【会員累計メニュー画面用】
//----1ページ目
//----
//cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'member_total_2\', \'1\' ';
//sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'member_total_2\' AND page = \'1\' ';
//---- 1-1:「会員合計」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '3495', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//---- 1-2:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//---- 1-3:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//---- 1-4:「会員情報」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '3502', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//---- 1-5:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//---- 1-6:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//---- 1-7:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//---- 1-8:「（ブランク）」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//---- 1-9:「（ブランク）」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//---- 2-1:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//---- 2-2:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//---- 2-3:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//---- 2-4:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//---- 2-5:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//---- 2-6:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//---- 2-7:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//---- 2-8:「」
  //await db.execute('''----insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//---- 2-9:「」
  //await db.execute('''--insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【会員一覧メニュー画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'member_list\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'member_list\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「買上ゼロ」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '511', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「記念日」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '513', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「会員売価商品」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '514', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「会員台帳」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '515', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「顧客履歴」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '516', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「顧客検索」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '517', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【会員精算メニュー画面用】
//--1ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'member_adj\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'member_adj\' AND page = \'1\' ';
//
//-- 1-1:「顧客問い合わせテーブルクリア」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '518', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「カード切替」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '519', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「ＦＳＰレベル決定」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '520', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「確定ポイント割戻」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '521', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「顧客抽出」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '522', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//-- メニューオブジェクト割り当てマスタ【売上点検/精算レポート(日計)画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'regist_acnt_adjustmnt_rept\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'regist_acnt_adjustmnt_rept\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「レジ途中取引明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '550', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//-- メニューオブジェクト割り当てマスタ【売上精算/精算レポート(日計)画面用】
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'regist_acnt_adjustmnt_rept_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'regist_acnt_adjustmnt_rept_2\' AND page = \'1\' ';
//--1ページ目
//-- 1-1:「レジ途中取引明細」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '1550', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「（ブランク）」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//
//メニューオブジェクト割り当て割り当てマスタ【売上点検/会員関連メニュー画面用】
//--1ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'member_relation\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'member_relation\' AND page = \'1\' ';
//-- 1-1:「会員情報」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '502', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
//
//メニューオブジェクト割り当て割り当てマスタ【売上精算/会員関連メニュー画面用】
//--1ページ目
//--
  cmn_set = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', \'sale_com_mm\', \'member_relation_2\', \'1\' ';
  sub_query = 'SELECT proc FROM c_menu_obj_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND proc = \'sale_com_mm\' AND win_name = \'member_relation_2\' AND page = \'1\' ';
//-- 1-1:「会員情報」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '2', '5', '1', '0', '1502', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '2');''');
//-- 1-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '3');''');
//-- 1-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '4');''');
//-- 1-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '5');''');
//-- 1-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '6');''');
//-- 1-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '7');''');
//-- 1-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '8');''');
//-- 1-8:「顧客履歴」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '9', '5', '1', '0', '516', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '9');''');
//-- 1-9:「顧客検索」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '2', '10', '5', '1', '0', '517', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '2' AND btn_pos_y = '10');''');
//-- 2-1:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '2', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '2');''');
//-- 2-2:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '3', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '3');''');
//-- 2-3:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '4', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '4');''');
//-- 2-4:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '5', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '5');''');
//-- 2-5:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '6', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '6');''');
//-- 2-6:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '7', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '7');''');
//-- 2-7:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '8', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '8');''');
//-- 2-8:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '9', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '9');''');
//-- 2-9:「」
  await db.execute('''insert into c_menu_obj_mst ($insert_field) SELECT $cmn_set, '7', '10', '5', '1', '0', '0', '5', '', '1' WHERE NOT EXISTS ($sub_query AND btn_pos_x = '7' AND btn_pos_y = '10');''');
}
Future _mm_triggerkey(db, value,int COMP,int STRE,int MACNO) async {
  await db.execute('''DELETE FROM  p_trigger_key_mst;''');
  String insert_field = 'proc, win_name, trigger_key, call_type, target_code, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system';
  String cmn_set = ' CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT * FROM p_trigger_key_mst WHERE ';

//--[for mainmenu]
  await db.execute('''insert into p_trigger_key_mst ($insert_field) SELECT 'syst', 'mainmenu', '3752', '1', '26112', $cmn_set WHERE NOT EXISTS ($sub_query proc = 'syst' AND win_name = 'mainmenu' AND trigger_key = '3752');''');
  await db.execute('''insert into p_trigger_key_mst ($insert_field) SELECT 'syst', 'mainmenu', '0337520893', '1', '119', $cmn_set WHERE NOT EXISTS ($sub_query proc = 'syst' AND win_name = 'mainmenu' AND trigger_key = '0337520893');''');
  await db.execute('''insert into p_trigger_key_mst ($insert_field) SELECT 'syst', 'mainmenu', '9999', '1', '120', $cmn_set WHERE NOT EXISTS ($sub_query proc = 'syst' AND win_name = 'mainmenu' AND trigger_key = '9999');''');
//
//--[for favorite]
  await db.execute('''insert into p_trigger_key_mst ($insert_field) SELECT 'syst', 'favorite', '3752', '1', '26112', $cmn_set WHERE NOT EXISTS ($sub_query proc = 'syst' AND win_name = 'favorite' AND trigger_key = '3752');''');
  await db.execute('''insert into p_trigger_key_mst ($insert_field) SELECT 'syst', 'favorite', '0337520893', '1', '119', $cmn_set WHERE NOT EXISTS ($sub_query proc = 'syst' AND win_name = 'favorite' AND trigger_key = '0337520893');''');
  await db.execute('''insert into p_trigger_key_mst ($insert_field) SELECT 'syst', 'favorite', '9999', '1', '120', $cmn_set WHERE NOT EXISTS ($sub_query proc = 'syst' AND win_name = 'favorite' AND trigger_key = '9999');''');
//
//--[for mainmenu]
  await db.execute('''insert into p_trigger_key_mst ($insert_field) SELECT 'pmod', 'presetmain', '3752', '1', '311', $cmn_set WHERE NOT EXISTS ($sub_query proc = 'pmod' AND win_name = 'presetmain' AND trigger_key = '3752');''');
}
Future _mm_appgrpmst(db, value,int COMP,int STRE,int MACNO) async {
  //バージョンアップにてz_initializeが消されないよう制御
  await db.execute('''DELETE FROM c_appl_grp_mst WHERE comp_cd = :COMP AND stre_cd = :STRE AND appl_grp_cd <> '56912111';''');

  String insert_field = 'comp_cd, stre_cd, cond_trm_cd, recog_grp_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, appl_grp_cd, appl_name, cond_con_typ, menu_chk_flg, flg_1, flg_2, flg_3, flg_4 ';
  String insert_field2 = 'comp_cd, stre_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, appl_grp_cd, appl_name, cond_con_typ, cond_trm_cd, recog_grp_cd, menu_chk_flg, flg_1, flg_2, flg_3, flg_4 ';
  String cmn_set = ' $COMP, $STRE, \'0\', \'0\', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String cmn_set2 = ' $COMP, $STRE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'SELECT appl_grp_cd FROM c_appl_grp_mst WHERE comp_cd = $COMP AND stre_cd = $STRE ';

//proc_con
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1', \'regs', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2', \'regs_opt', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3', \'regs_opt_dual', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '4', \'stropncls', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '4');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '5', \'retotal', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '5');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '6', \'menu', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '6');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '7', \'startup', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '7');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '8', \'simple2stf', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '8');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '9', \'simple2stf_dual', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '9');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '10', \'bank_prg', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '10');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '11', \'FenceOver', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '11');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '12', \'EjConf', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '12');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '13', \'CashRecycle', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '13');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '14', \'HistoryGet', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '14');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '15', \'ファイルリクエスト', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '15');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '16', \'CustEnqClr', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '16');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '17', \'Resimslog', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '17');''');
//
//メインメニュー
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '101', \'登録', '111111', '1', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '101');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '102', \'オープン／クローズ', '111111', '0', '0', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '102');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '103', \'訂正', '111111', '1', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '103');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '104', \'訓練', '111111', '1', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '104');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '105', \'廃棄', '111111', '1', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '105');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '107', \'売上速報', '011111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '107');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '108', \'売上点検', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '108');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '109', \'売上精算', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '109');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '112', \'売価変更', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '112');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '113', \'予約レポート出力', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '113');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '114', \'ファイルリクエスト', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '114');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '116', \'ユーザーセットアップ', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '116');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '117', \'閉設処理', '111111', '2', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '117');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '119', \'キャリブレーション設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '119');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '120', \'隠しボタン表示化', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '120');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '121', \'切替', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '121');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '122', \'音の設定', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '122');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '123', \'即時受信', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '123');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '125', \'メモ', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '125');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '126', \'連絡', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '126');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '127', \'釣機精査', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '127');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '128', \'棚卸', '111111', '1', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '128');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '129', \'生産', '111111', '1', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '129');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '130', \'発注', '111111', '1', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '130');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '131', \'収納業務', '111111', '1', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '131');''');
  // await db.execute('''--insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '199', \'売上速報', '111111', '0', '1', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '199');''');
//
//設定
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '201', \'商品', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '201');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '202', \'特売', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '202');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '203', \'ﾐｯｸｽﾏｯﾁ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '203');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '204', \'ｾｯﾄﾏｯﾁ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '204');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '205', \'ﾌﾟﾘｾｯﾄ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '205');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '206', \'中分類', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '206');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '207', \'小分類', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '207');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '208', \'ｶﾃｺﾞﾘｰ値引', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '208');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '209', \'従業員', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '209');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '210', \'地区', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '210');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '211', \'会員関連', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '211');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '212', \'記念日種別', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '212');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '213', \'ｻｰﾋﾞｽ分類', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '213');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '214', \'画像分類変更', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '214');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '215', \'分類値下スケジュール', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '215');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '216', \'小分類値下スケジュール', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '216');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '217', \'FSPスケジュール', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '217');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '218', \'予約ﾚﾎﾟｰﾄ', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '218');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '221', \'ﾀｰﾐﾅﾙ', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '221');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '222', \'ｷｰｵﾌﾟｼｮﾝ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '222');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '223', \'共通ｺﾝﾄﾛｰﾙ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '223');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '224', \'ｲﾝｽﾄｱﾏｰｷﾝｸﾞ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '224');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '225', \'ﾚｼﾞｺﾝﾄﾛｰﾙ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '225');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '226', \'ｲﾒｰｼﾞ/ﾌｧﾝｸｼｮﾝ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '226');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '227', \'税金', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '227');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '228', \'メッセージ関連', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '228');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '229', \'日付＆時刻', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '229');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '231', \'ｽｷｬﾆﾝｸﾞPLU', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '231');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '232', \'商品ポイントスケジュール', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '232');''');
  // await db.execute('''--insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '233', \'郵便番号', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '233');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '233', \'郵便番号', '000110', '0', '1', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '233');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '234', \'確定割戻率', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '234');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '235', \'速報送信時刻', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '235');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '236', \'マスタ受信時刻', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '236');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '237', \'会員自動生成', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '237');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '238', \'会員番号変更', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '238');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '241', \'伝票プリンタフォーマット', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '241');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '242', \'税種変更', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '242');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '243', \'Ｍカード', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '243');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '244', \'取引明細\nフリーフォーマット', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '244');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '245', \'クレジット会社\n請求テーブル', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '245');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '246', \'NON-PLU税種変更', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '246');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '247', \'みなし内税', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '247');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '248', \'客側表示メッセージ', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '248');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '249', \'レシートメッセージ\nスケジュール', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '249');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '250', \'客側表示\nメッセージスケジュール', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '250');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '251', \'産地・メーカー', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '251');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '252', \'(3-12)', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '252');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '253', \'商品プロモーション', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '253');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '254', \'音選択', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '254');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '255', \'キャッシュリサイクル関連', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '255');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '257', \'生産者一括', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '257');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '258', \'メモ（常駐）', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '258');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '259', \'メモ（連絡）', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '259');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '261', \'税種予約変更', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '261');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '271', \'メインメニュー設定', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '271');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '272', \'生産者品目マスタ', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '272');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '273', \'店舗情報', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '273');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '274', \'ダイアログ設定', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '274');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '281', \'ﾌｧｲﾙ\n確認', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '281');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '282', \'件数\n確認', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '282');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '290', \'小計値下スケジュール', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '290');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '291', \'自動開閉店', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '291');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '292', \'区分', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '292');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '301', \'登録プリセットキー設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '301');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '302', \'小計プリセット設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '302');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '303', \'小計プリセット(5.7inch)設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '303');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '304', \'キーレイアウト設定:タワーキー', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '304');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '305', \'キーレイアウト設定:卓上キー', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '305');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '306', \'キーレイアウト設定:Prime卓上', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '306');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '307', \'登録共通プリセットキー設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '307');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '308', \'キーレイアウト設定:2800i卓上', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '308');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '309', \'キーレイアウト設定:2800a卓上', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '309');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '310', \'キーレイアウト設定:2800タワー', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '310');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '320', \'キーレイアウト設定:SpeezaSL C', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '320');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '321', \'キーレイアウト設定:SpeezaSL W', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '321');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '322', \'拡張プリセット設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '322');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '323', \'商品明細(登録)プリセット設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '323');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '324', \'商品明細(小計)プリセット設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '324');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '325', \'商品登録補助プリセット設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '325');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '326', \'登録補助プリセット設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '326');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '327', \'決済プリセット設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '327');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '328', \'セルフメンテプリセット設定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '328');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '329', \'キーレイアウト設定:3800a 35ｷｰ', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '329');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '330', \'入金', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '330');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '331', \'出金', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '331');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '332', \'掛売相手先', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '332');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '333', \'値引理由', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '333');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '334', \'割引理由', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '334');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '335', \'返品理由', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '335');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '336', \'取消理由', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '336');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '337', \'訂正理由', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '337');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '338', \'決済種選択', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '338');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '339', \'釣銭決済種選択', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '339');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '340', \'廃棄理由', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '340');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '341', \'酒品目', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '341');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '342', \'酒税', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '342');''');
//
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '560', \'金種商品品券1', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '560');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '561', \'金種商品品券2', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '561');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '562', \'金種商品品券3', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '562');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '563', \'金種商品品券4', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '563');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '564', \'金種商品品券5', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '564');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '565', \'金種商品会計1', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '565');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '566', \'金種商品会計2', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '566');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '567', \'金種商品会計3', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '567');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '568', \'金種商品会計4', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '568');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '569', \'金種商品会計5', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '569');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '570', \'金種商品会計6', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '570');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '571', \'金種商品会計7', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '571');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '572', \'金種商品会計8', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '572');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '573', \'金種商品会計9', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '573');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '574', \'金種商品会計10', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '574');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '575', \'金種商品会計11', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '575');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '576', \'金種商品会計12', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '576');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '577', \'金種商品会計13', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '577');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '578', \'金種商品会計14', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '578');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '579', \'金種商品会計15', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '579');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '580', \'金種商品会計16', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '580');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '581', \'金種商品会計17', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '581');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '582', \'金種商品会計18', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '582');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '583', \'金種商品会計19', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '583');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '584', \'金種商品会計20', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '584');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '585', \'金種商品会計21', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '585');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '586', \'金種商品会計22', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '586');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '587', \'金種商品会計23', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '587');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '588', \'金種商品会計24', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '588');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '589', \'金種商品会計25', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '589');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '590', \'金種商品会計26', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '590');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '591', \'金種商品会計27', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '591');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '592', \'金種商品会計28', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '592');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '593', \'金種商品会計29', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '593');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '594', \'金種商品会計30', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '594');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '595', \'売変理由', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '595');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '596', \'両替理由', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '596');''');
//
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '350', \'従業員設定', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '350');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '351', \'従業員権限設定', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '351');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '352', \'従業員バーコード印字', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '352');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '360', \'メッセージマスタ', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '360');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '361', \'メッセージレイアウト', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '361');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '362', \'メッセージスケジュール', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '362');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '370', \'イメージ', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '370');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '371', \'ファンクション', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '371');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '380', \'設定マスタ', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '380');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '381', \'レジ情報管理', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '381');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '382', \'コード決済事業者', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '382');''');
  // await db.execute('''--insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '390', \'会員設定', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '390');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '390', \'会員設定', '000111', '0', '1', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '390');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '391', \'購買履歴確認除外商品', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '391');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '392', \'ポイント倍スケジュール', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '392');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '393', \'サービス分類スケジュール', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '393');''');
  // await db.execute('''--insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '394', \'ロイヤリティ設定', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '394');''');
  // await db.execute('''--insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '395', \'クーポン設定', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '395');''');
//
//売上速報
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '401', \'中分類', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '401');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '402', \'小分類', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '402');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '403', \'商品', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '403');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '404', \'レジ別', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '404');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '405', \'従業員別', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '405');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '406', \'特売', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '406');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '411', \'会員合計', '000111', '0', '1', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '411');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '414', \'会員情報', '000111', '0', '1', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '414');''');
//
//売上点検
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '415', \'レジ日計', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '415');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '416', \'電子ジャーナル', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '416');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '421', \'店舗日計', '101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '421');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '422', \'店舗累計', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '422');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '423', \'一覧', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '423');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '431', \'リサイクル入出金明細', '101110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '431');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '432', \'リサイクル入出金履歴', '101110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '432');''');
  // await db.execute('''--insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '433', \'税率変更日付設定', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '433'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '434', \'レジ取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '434');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '435', \'レジ大分類別売上', '100000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '435');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '436', \'レジ中分類別売上', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '436');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '437', \'レジ小分類別売上', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '437');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '438', \'レジクラス別売上', '100000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '438');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '439', \'レジ売上キー', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '439');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '440', \'レジ入出金', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '440');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '441', \'レジ在高', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '441');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '442', \'レジ釣銭機明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '442');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '443', \'一括点検', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '443'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '444', \'レジ従業員別簡易取引明細', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '444'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '445', \'メディア情報', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '445'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '446', \'クレジット控え', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '446'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '447', \'シベール日計レポート', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '447'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '448', \'クレジット会社別', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '448'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '449', \'セルフ稼働時間', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '449'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '450', \'セルフ時間帯', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '450');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '451', \'領収書控え', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '451');''');
//
//売上点検 - 店舗日計
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '452', \'店舗取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '452');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '453', \'売計キー', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '453');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '454', \'入出金', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '454');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '455', \'在高', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '455');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '456', \'従業員別取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '456');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '457', \'中分類別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '457');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '458', \'小分類別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '458');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '459', \'店舗時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '459');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '460', \'中分類別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '460');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '461', \'小分類別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '461');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '462', \'商品別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '462');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '463', \'中分類別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '463');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '464', \'中分類別粗利順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '464');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '465', \'小分類別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '465');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '466', \'小分類別粗利順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '466');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '468', \'セルフ時間帯', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '468');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '469', \'簡易従業員取引明細', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '469'); -- 未使用''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '470', \'商品別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '470');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '471', \'商品別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '471');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '472', \'商品別数量順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '472');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '475', \'商品別値下売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '475');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '476', \'レジ別釣銭機明細', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '476');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '477', \'スケジュール別特売商品', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '477');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '478', \'ミックスマッチ', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '478');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '479', \'セットマッチ', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '479');''');
//
//
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '481', \'強制Ｅｄｙログ送信', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '481');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '482', \'強制Ｍカード実績ログ送信', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '482');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '483', \'テキストデータ保存', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '483');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '484', \'テキストデータ再送信', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '484');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '485', \'テキストデータ訂正送信', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '485');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '486', \'生産者実績データ再送信', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '486');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '487', \'Ｔｕｏテキストデータ再送信', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '487');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '488', \'棚卸データ送信', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '488');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '489', \'テキストデータ読込', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '489');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '490', \'税種変換 テキストデータ復帰', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '490');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '491', \'テキストデータ復帰', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '491');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '492', \'緊急メンテナンス商品', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '492');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '493', \'ノンアクト商品', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '493');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '494', \'商品台帳', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '494');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '495', \'会員合計', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '495');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '502', \'会員情報', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '502');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '511', \'買上ゼロ', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '511');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '513', \'記念日', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '513');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '514', \'会員売価商品', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '514');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '515', \'会員台帳', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '515');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '516', \'会員履歴', '111111', '0', '21', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '516');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '517', \'会員検索', '111111', '0', '21', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '517');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '518', \'会員問い合わせテーブルクリア', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '518');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '519', \'カード切替', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '519');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '520', \'ＦＳＰレベル決定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '520');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '521', \'確定ポイント割戻', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '521');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '522', \'会員抽出', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '522');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '523', \'釣機再精査', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '523');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '524', \'お会計券未精算', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '524');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '525', \'レジ従業員精算', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '525');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '526', \'（M）レジ別釣銭機', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '526');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '527', \'（S）レジ別釣銭機', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '527');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '528', \'精算情報', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '528');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '529', \'精算レポート(日計)', '000010', '0', '10', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '529');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '550', \'レジ途中取引明細', '000010', '0', '10', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '550');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '600', \'会員関連', '001111', '0', '1', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '600');''');
//
//売上点検 - 店舗日計
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '419', \'取引明細','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '419');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '420', \'分類別', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '420');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '425', \'商品別','001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '425');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '426', \'スケジュール別', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '426');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '427', \'時間帯','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '427');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '428', \'釣銭機明細','001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '428');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '429', \'セルフ','001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '429');''');
//
//売上点検 - 店舗累計
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2419', \'取引明細', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2419');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2420', \'分類別', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2420');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2425', \'商品別','001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2425');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2426', \'スケジュール別','001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2426');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2427', \'時間帯','001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2427');''');
  // await db.execute('''-- insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2428', \'釣銭機明細','001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2428'); -- 累計では不必要''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2429', \'セルフ','001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2429');''');
//
//売上精算 - 店舗日計
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1419', \'取引明細','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1419');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1420', \'分類別', '101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1420');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1425', \'商品別','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1425');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1426', \'スケジュール別','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1426');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1427', \'時間帯','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1427');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1428', \'釣銭機明細','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1428');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1429', \'セルフ','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1429');''');
//
//売上精算 - 店舗累計
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3419', \'取引明細','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3419');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3420', \'分類別','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3420');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3425', \'商品別','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3425');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3426', \'スケジュール別','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3426');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3427', \'時間帯','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3427');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3429', \'セルフ','101111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3429');''');
//
//売上精算
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1401', \'中分類', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1401');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1402', \'小分類', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1402');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1403', \'商品', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1403');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1404', \'レジ別', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1404');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1405', \'従業員別', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1405');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1406', \'特売', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1406');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1415', \'レジ日計', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1415');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1416', \'電子ジャーナル', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1416');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1418', \'ログ関連', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1418');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1421', \'店舗日計', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1421');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1422', \'店舗累計', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1422');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1423', \'一覧', '000111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1423');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1431', \'リサイクル入出金明細', '101110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1431');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1432', \'リサイクル入出金履歴', '101110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1432');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1433', \'税率変更日付設定', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1433');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1434', \'レジ取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1434');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1435', \'レジ大分類別売上', '100000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1435');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1436', \'レジ中分類別売上', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1436');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1437', \'レジ小分類別売上', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1437');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1438', \'レジクラス別売上', '100000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1438');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1439', \'レジ売上キー', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1439');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1440', \'レジ入出金', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1440');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1441', \'レジ在高', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1441');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1442', \'レジ釣銭機明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1442');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1443', \'一括点検', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1443');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1444', \'レジ従業員別簡易取引明細', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1444');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1445', \'メディア情報', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1445');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1446', \'クレジット控え', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1446');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1447', \'シベール日計レポート', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1447');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1448', \'クレジット会社別', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1448');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1449', \'セルフ稼働時間', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1449');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1450', \'セルフ時間帯', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1450');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1451', \'領収書控え', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1451');''');
//
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1526', \'会計別税明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1526'); -- 売上精算/レジ日計''');
//
//WS様専用レポート
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '555', \'精算レポート', '111111', '0', '51', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '555'); -- 売上点検''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '1555', \'精算レポート', '111111', '0', '51', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1555'); -- 売上精算''');
//
//売上精算-店舗日計
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1452', \'店舗取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1452');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1453', \'売計キー', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1453');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1454', \'入出金', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1454');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1455', \'在高', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1455');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1456', \'従業員別取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1456');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1457', \'中分類別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1457');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1458', \'小分類別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1458');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1459', \'店舗時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1459');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1460', \'中分類別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1460');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1461', \'小分類別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1461');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1462', \'商品別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1462');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1463', \'中分類別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1463');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1464', \'中分類別粗利順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1464');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1465', \'小分類別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1465');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1466', \'小分類別粗利順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1466');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1468', \'セルフ時間帯', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1468');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1469', \'簡易従業員取引明細', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1469');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1470', \'商品別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1470');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1471', \'商品別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1471');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1472', \'商品別数量順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1472');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1475', \'商品別値下売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1475');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1476', \'レジ別釣銭機明細', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1476');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1477', \'スケジュール別特売商品', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1477');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1478', \'ミックスマッチ', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1478');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1479', \'セットマッチ', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1479');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1481', \'強制Ｅｄｙログ送信', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1481');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1482', \'強制Ｍカード実績ログ送信', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1482');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1483', \'テキストデータ保存', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1483');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1484', \'テキストデータ再送信', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1484');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1485', \'テキストデータ訂正送信', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1485');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1486', \'生産者実績データ再送信', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1486');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1487', \'Ｔｕｏテキストデータ再送信', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1487');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1488', \'棚卸データ送信', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1488');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1489', \'テキストデータ読込', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1489');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1490', \'税種変換 テキストデータ復帰', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1490');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1491', \'テキストデータ復帰', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1491');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1492', \'緊急メンテナンス商品', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1492');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1493', \'ノンアクト商品', '000110', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1493');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1494', \'商品台帳', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1494');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1495', \'会員合計', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1495');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1502', \'会員情報', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1502');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1511', \'買上ゼロ', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1511');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1513', \'記念日', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1513');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1514', \'会員売価商品', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1514');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1515', \'会員台帳', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1515');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '1516', \'会員履歴', '111111', '0', '31', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1516');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '1517', \'会員検索', '111111', '0', '21', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1517');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1518', \'会員問い合わせテーブルクリア', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1518');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1519', \'カード切替', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1519');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1520', \'ＦＳＰレベル決定', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1520');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1521', \'確定ポイント割戻', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1521');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1522', \'会員抽出', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1522');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1523', \'釣機再精査', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1523');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1524', \'お会計券未精算', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1524');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1525', \'レジ従業員精算', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1525');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1528', \'精算情報', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1528');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '1529', \'精算レポート(日計)', '000010', '0', '10', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1529');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '1530', \'途中精算', '000010', '0', '10', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1530');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '1550', \'レジ途中取引明細', '000010', '0', '10', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1550');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field2) SELECT $cmn_set2, '1600', \'会員関連', '001111', '0', '1', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1600');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1560', \'会計別税明細', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1560'); -- 売上精算/店舗日計''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '1700', \'加算情報クリア(RM関連)', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '1700');''');
//
//その他
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2816', \'設定', '111111', '0', '1', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2816');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '4352', \'ユーザーセットアップ', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '4352');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '26112', \'メンテナンス', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '26112');''');
//
//売上点検-店舗累計
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2452', \'店舗取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2452');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2453', \'売計キー', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2453');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2454', \'入出金', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2454');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2455', \'在高', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2455');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2456', \'従業員別取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2456');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2457', \'中分類別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2457');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2458', \'小分類別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2458');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2459', \'店舗時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2459');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2460', \'中分類別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2460');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2461', \'小分類別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2461');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2462', \'商品別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2462');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2463', \'中分類別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2463');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2464', \'中分類別粗利順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2464');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2465', \'小分類別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2465');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2466', \'小分類別粗利順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2466');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2468', \'セルフ時間帯', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2468');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2469', \'簡易従業員取引明細', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2469');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2470', \'商品別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2470');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2471', \'商品別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2471');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2472', \'商品別数量順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2472');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2475', \'商品別値下売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2475');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2476', \'レジ別釣銭機明細', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2476');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2477', \'スケジュール別特売商品', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2477');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2478', \'ミックスマッチ', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2478');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2479', \'セットマッチ', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2479');''');
//
//売上精算-店舗累計
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3452', \'店舗取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3452');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3453', \'売計キー', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3453');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3454', \'入出金', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3454');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3455', \'在高', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3455');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3456', \'従業員別取引明細', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3456');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3457', \'中分類別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3457');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3458', \'小分類別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3458');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3459', \'店舗時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3459');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3460', \'中分類別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3460');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3461', \'小分類別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3461');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3462', \'商品別時間帯', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3462');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3463', \'中分類別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3463');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3464', \'中分類別粗利順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3464');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3465', \'小分類別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3465');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3466', \'小分類別粗利順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3466');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3468', \'セルフ時間帯', '111111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3468');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3469', \'簡易従業員取引明細', '000000', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3469');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3470', \'商品別売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3470');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3471', \'商品別金額順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3471');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3472', \'商品別数量順売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3472');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3475', \'商品別値下売上', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3475');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3476', \'レジ別釣銭機明細', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3476');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3477', \'スケジュール別特売商品', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3477');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3478', \'ミックスマッチ', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3478');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3479', \'セットマッチ', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3479');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3560', \'会計別税明細', '011111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3560'); -- 売上精算/店舗累計''');
//
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '2495', \'会員合計', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '2495');''');
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '3495', \'会員合計', '001111', '0', '0', '0', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '3495');''');
//
//-- cond_trm_cd を 246 で設定
  cmn_set = ' $COMP, $STRE, \'246\', \'0\', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  await db.execute('''insert into c_appl_grp_mst ($insert_field) SELECT $cmn_set, '124', '電源', '111111', '0', '0', '1', '0', '0' WHERE NOT EXISTS($sub_query AND appl_grp_cd = '124');''');
}
Future _mm_appmst(db, value,int COMP,int STRE,int MACNO) async {
  await db.execute('''DELETE FROM p_appl_mst;''');

  String insert_field = 'appl_grp_cd, appl_cd, call_type, name, position, param1, param2, param3, param4, param5, recog_grp_cd, pause_flg';
  String sub_query = 'SELECT * FROM p_appl_mst WHERE ';

//アプリマスタ
//for 「regs」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1', '1', '1', 'print', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1', '2', '1', 'drw', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1' AND appl_cd = '2');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1', '3', '1', 'print', '/apl', '#TPRX_HOME#', '2', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1' AND appl_cd = '3');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1', '4', '1', 'print', '/apl', '#TPRX_HOME#', '3', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1' AND appl_cd = '4');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1', '6', '1', 'print', '/apl', '#TPRX_HOME#', '5', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1' AND appl_cd = '6');''');
//
//
//for 「regs_opt_dual」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '1', '1', 'spool', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '2', '1', 'acx', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '2');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '3', '1', 'jpo', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '3');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '4', '1', 'scl', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '4');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '5', '1', 'rwc', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '5');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '6', '1', 'sgscl1', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '6');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '7', '1', 'sgscl2', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '7');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '8', '1', 's2pr', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '8');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '9', '1', 'stpr2', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '9');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '10', '1', 'fb_SelfMovie', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '10');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '11', '1', 'mp1', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '11');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '12', '1', 'multi', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '12');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '13', '1', 'fb_Movie', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '13');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '14', '1', 'custreal', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '14');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '15', '1', 'custreal2', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '15');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '16', '1', 'custreal_netdoa', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '16');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '17', '1', 'qcConnect', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '17');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '18', '1', 'credit', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '18');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '19', '1', 'nttd_preca', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '19');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '20', '1', 'sqrc', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '20');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '21', '1', 'trk_preca', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '21');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '22', '1', 'repica', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '22');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '23', '1', 'custreal2_pa', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '23');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '24', '1', 'custreal_odbc', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '24');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '25', '1', 'cogca', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '25');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '27', '1', 'vega3000', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '27');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '28', '1', 'dpoint', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '28');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '29', '1', 'ajs_emoney', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '29');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '30', '1', 'valuecard', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '30');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '31', '1', 'rpoint', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '31');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '32', '1', 'tpoint', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '32');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2', '33', '1', 'tomoIF', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2' AND appl_cd = '33');''');
//
//for 「stropncls」(開設処理用)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '4', '1', '1', 'stropncls', '/apl', '#TPRX_HOME#', '3', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '4' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '4', '2', '1', 'jpo', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '4' AND appl_cd = '2');''');
//
//for 「retotal」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '5', '1', '1', 'retotal', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '5' AND appl_cd = '1');''');
//
//for 「menu」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '6', '1', '1', 'acxreal', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '6' AND appl_cd = '1');''');
//
//for 「startup」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '1', '1', 'csvsend', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '2', '1', 'iis', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '2');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '3', '1', 'tprapl_reglog', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '3');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '4', '1', 'mobile', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '4');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '5', '1', 'stpr', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '5');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '6', '1', 'pmod', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '6');''');
  //await db.execute('''--INSERT INTO p_appl_mst ($insert_field) SELECT '7', '7', '1', 'sale_com_mm', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '7');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '8', '1', 'menteserver', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '8');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '9', '1', 'menteclient', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '9');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '10', '1', 'sound_con', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '10');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '11', '1', 'mcftp', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '11');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '12', '1', 'upd_con', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '12');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '13', '1', 'ecoaserver', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '13');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '14', '1', 'kill_proc', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '14');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '15', '1', 'keyb', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '15');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '16', '1', 'multi', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '16');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '17', '1', 'icc', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '17');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '18', '1', 'drugrevs', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '18');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '19', '1', 'tprapl_tprt', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '19');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '20', '1', 'jpo', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '20');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '21', '1', 'pbchg_log_send', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '21');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '22', '1', 'ftp', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '22');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '23', '1', 'spqcs', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '23');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '24', '1', 'spqcc', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '24');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '25', '1', 'pbchg_test_server', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '25');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '26', '1', 'WizS', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '26');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '27', '1', 'qcSelectServer', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '27');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '28', '1', 'moviesend', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '28');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '29', '1', 'credit', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '29');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '30', '1', 'qcConnectServer', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '30');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '31', '1', 'custreal_nec', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '31');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '32', '1', 'masr', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '32');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '33', '1', 'multi_tmn', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '33');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '34', '1', 'multi_glory', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '34');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '35', '1', 'suica', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '35');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '36', '1', 'netdoa_pqs', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '36');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '37', '1', 'tpoint_ftp', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '37');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '38', '1', 'print_com', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '38');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '39', '1', 'report', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '39');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '40', '1', 'colordsp_msg', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '40');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '41', '1', 'loop_cnct', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '41');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '42', '1', 'barcode_pay', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '42');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '43', '1', 'taxfree', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '43');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '44', '1', 'mail_sender', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '44');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '45', '1', 'multi_tmn_vega3000', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '45');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '46', '1', 'updzip', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '46');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '47', '1', 'basket_server', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '47');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '48', '1', 'floating_staff', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '48');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '49', '1', 'net_receipt', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '49');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '50', '1', 'hi_touch_rcv', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '50');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '7', '51', '1', 'acttrigger', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '7' AND appl_cd = '51');''');
//
//for 「simple2stf」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '8', '1', '1', 'spool', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '8' AND appl_cd = '1');''');
  //await db.execute('''--INSERT INTO p_appl_mst ($insert_field) SELECT '8', '2', '1', 'cashier', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '8' AND appl_cd = '2');''');
//
//for 「simple2stf_dual」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '9', '1', '1', 'spool', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '9' AND appl_cd = '1');''');
//
//for 「bank_prg」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '10', '1', '1', 'bankprg', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '10' AND appl_cd = '1');''');
//
//for 「FenceOver」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '1', '1', 'custd_srch', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '2', '1', 'custd_hist', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '2');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '3', '1', 'custd_mtg', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '3');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '4', '1', 'prg_cust_popup', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '4');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '5', '1', 'cd_contents', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '5');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '6', '1', 'reserv_conf', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '6');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '7', '1', 'chprice', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '7');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '8', '1', 'autotest', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '8');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '9', '1', 'pbchg_util', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '9');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '10', '1', 'Cons', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '10');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '11', '1', 'DSft', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '11');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '12', '1', 'FMente', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '12');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '13', '1', 'acx_recalc_g', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '13');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '11', '14', '1', 'acx_recalc', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '11' AND appl_cd = '14');''');
//
//for 「EjConf」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '12', '1', '1', 'fb_Movie', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '12' AND appl_cd = '1');''');
//
//for 「CashRecycle」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '13', '1', '1', 'cash_recycle', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '13' AND appl_cd = '1');''');
//
//for 「stropncls」(閉設処理用)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '14', '1', '1', 'stropncls', '/apl', '#TPRX_HOME#', '5', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '14' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '14', '2', '1', 'jpo', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '14' AND appl_cd = '2');''');
//
//for 「another1」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '15', '1', '1', 'history_get', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '15' AND appl_cd = '1');''');
//
//for 「another2」
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '16', '1', '1', 'freq', '/apl', '#TPRX_HOME#', '#DEV_ID#', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '16' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '17', '1', '1', 'cust_enq_clr', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '17' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '18', '1', '1', 'resimslog', '/apl', '#TPRX_HOME#', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '18' AND appl_cd = '1');''');
//
//(メインメニュー/お気に入り画面用)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '101', '1', '2', 'maincb_1_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '101' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '121', '1', '2', 'maincb_sw_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '121' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '122', '1', '2', 'DispSoundCtlDlg', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '122' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '123', '1', '2', 'maincb_27_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '123' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '124', '1', '2', 'DispPowerCtlDlg', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '124' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '125', '1', '2', 'Memo_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '125' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '126', '1', '2', 'TMemo_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '126' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '127', '1', '2', 'maincb_34_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '127' AND appl_cd = '1');''');
//
//--maincb_2_clicked (opncls_main(), TPRTST_STATUS02, 0x0200)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '102', '1', '2', 'maincb_2_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '102' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '103', '1', '2', 'maincb_3_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '103' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '104', '1', '2', 'maincb_4_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '104' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '105', '1', '2', 'maincb_5_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '105' AND appl_cd = '1');''');
//
//-- sale_com_mmの画面起動は関数(sale_clicked())を使用する：モジュール自体はスタートアップ時に起動されて待機状態にある
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '107', '1', '2', 'maincb_7_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '107' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '108', '1', '2', 'maincb_8_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '108' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '109', '1', '2', 'maincb_9_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '109' AND appl_cd = '1');''');
//
//-- pmodの画面起動は関数(maincb_11_clicked()、pmod_clicked())を使用する：モジュール自体はスタートアップ時に起動されて待機状態にある
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2816', '1', '2', 'maincb_11_clicked', 'syst', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2816' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '112', '1', '2', 'maincb_12_clicked', 'syst', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '112' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '113', '1', '2', 'maincb_13_clicked', 'syst', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '113' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '4352', '1', '1', 'mente', '/apl', '#TPRX_HOME#', '#DEV_ID#', 'usetup', '#FNC_CODE#', NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '4352' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '116', '1', '2', 'maincb_16_clicked', 'syst', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '116' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '117', '1', '2', 'maincb_17_clicked', 'syst', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '117' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '26112', '1', '2', 'mente', '/apl', '#TPRX_HOME#', '#DEV_ID#', 'mente', '#FNC_CODE#', NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '26112' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '119', '1', '2', 'Calibration', 'syst', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '119' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '120', '1', '2', 'ShowHiddenBtn', 'syst', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '120' AND appl_cd = '1');''');
//
//棚卸, 生産, 発注モード用
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '128', '1', '2', 'bmodecb_2_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '128' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '129', '1', '2', 'bmodecb_3_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '129' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '130', '1', '2', 'bmodecb_10_clicked', '', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '130' AND appl_cd = '1');''');
//
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '131', '1', '2', 'maincb_14_clicked', 'syst', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '131' AND appl_cd = '1');''');
//
//アプリマスタ【設定メイン画面用
//
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '201', '1', '2', 'prg_plu_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '201' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '202', '1', '2', 'prg_plan_sp_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '202' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '203', '1', '2', 'prg_plan_mm_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '203' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '204', '1', '2', 'prg_plan_sm_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '204' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '205', '1', '2', 'prg_preset_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '205' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '206', '1', '2', 'prg_mdl_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '206' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '207', '1', '2', 'prg_sml_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '207' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '208', '1', '2', 'prg_catdsc_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '208' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '209', '1', '2', 'prg_staff_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '209' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '210', '1', '2', 'prg_zone_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '210' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '211', '1', '2', 'prg_cust_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '211' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '212', '1', '2', 'prg_anvkind_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '212' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '213', '1', '2', 'prg_svscls_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '213' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '214', '1', '2', 'prg_ImgClsChg_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '214' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '215', '1', '2', 'prg_plan_mdl_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '215' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '216', '1', '2', 'prg_plan_sml_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '216' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '217', '1', '2', 'prg_fspsch_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '217' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '218', '1', '2', 'sale_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '218' AND appl_cd = '1');''');
//
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '221', '1', '2', 'set_trm_clicked', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '221' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '222', '1', '2', 'prg_kopt_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '222' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '223', '1', '2', 'prg_ctrl_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '223' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '224', '1', '2', 'prg_instre_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '224' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '225', '1', '1', 'pmod_regctrl', '/apl', '#TPRX_HOME#', '#DEV_ID#', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '225' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '226', '1', '2', 'prg_img_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '226' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '227', '1', '2', 'prg_tax_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '227' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '228', '1', '2', 'prg_message_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '228' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '229', '1', '2', 'prg_datetime_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '229' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '230', '1', '2', 'prg_cust_trm_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '230' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '231', '1', '2', 'prg_scanplu_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '231' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '232', '1', '2', 'prg_plan_point_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '232' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '233', '1', '2', 'prg_post_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '233' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '234', '1', '2', 'prg_decrbt_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '234' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '235', '1', '2', 'prg_hqftptime_0_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '235' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '236', '1', '2', 'prg_hqftptime_1_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '236' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '237', '1', '2', 'prg_cust_auto_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '237' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '238', '1', '2', 'prg_cust_chg_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '238' AND appl_cd = '1');''');
//
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '241', '1', '2', 'prg_sprk_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '241' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '242', '1', '2', 'prg_taxchg_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '242' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '243', '1', '2', 'prg_mcardmain_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '243' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '244', '1', '2', 'prg_netwlpr_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '244' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '245', '1', '2', 'prg_crdt_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '245' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '246', '1', '2', 'prg_taxchg_nonplu_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '246' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '247', '1', '2', 'prg_intax_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '247' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '248', '1', '2', 'prg_fipmsg_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '248' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '249', '1', '2', 'prg_plan_msg_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '249' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '250', '1', '2', 'prg_plan_fip_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '250' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '251', '1', '2', 'prg_maker_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '251' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '252', '1', '2', 'prg_prom_sch_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '252' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '253', '1', '2', 'prg_prom_item_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '253' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '254', '1', '2', 'prg_WavSel_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '254' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '255', '1', '2', 'prg_cash_recycle_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '255' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '257', '1', '2', 'prg_jabar_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '257' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '258', '1', '2', 'prg_memo_regident_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '258' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '259', '1', '2', 'prg_memo_contact_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '259' AND appl_cd = '1');''');
//
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '261', '1', '2', 'prg_taxchg_reserve_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '261' AND appl_cd = '1');''');
//
//(ユーザーメニュー設定関連)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '271', '1', '2', 'usermenu_set', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '271' AND appl_cd = '1');''');
//
//(生産者品目マスタ設定)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '272', '1', '2', 'prg_producer_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '272' AND appl_cd = '1');''');
//
//(店舗情報)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '273', '1', '2', 'prg_stre_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '273' AND appl_cd = '1');''');
//
//(ダイアログ)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '274', '1', '2', 'prg_dialog', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '274' AND appl_cd = '1');''');
//
//(ファイル確認)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '281', '1', '1', 'fcon', '/apl', '#TPRX_HOME#', '#DEV_ID#', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '281' AND appl_cd = '1');''');
//
//(件数確認)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '282', '1', '1', 'tcount', '/apl', '#TPRX_HOME#', '#DEV_ID#', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '282' AND appl_cd = '1');''');
//
//(小計値下スケジュール)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '290', '1', '2', 'prg_plan_subtsch_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '290' AND appl_cd = '1');''');
//
//(自動開閉店)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '291', '1', '2', 'prg_auto_stropncls_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '291' AND appl_cd = '1');''');
//
//(区分)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '292', '1', '2', 'prg_divide_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '292' AND appl_cd = '1');''');
//
//(酒品目)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '341', '1', '2', 'prg_liqritem_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '341' AND appl_cd = '1');''');
//
//(酒税)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '342', '1', '2', 'prg_liqrtax_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '342' AND appl_cd = '1');''');
//
//(店舗情報)
//(店舗情報)
//アプリマスタ【プリセット設定メニュー画面用
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '301', '1', '2', 'preset_104reg_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '301' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '302', '1', '2', 'preset_104stl_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '302' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '303', '1', '2', 'preset_57stl_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '303' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '304', '1', '2', 'preset_tower_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '304' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '305', '1', '2', 'preset_desk_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '305' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '306', '1', '2', 'preset_jrdesk_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '306' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '307', '1', '2', 'preset_com_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '307' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '308', '1', '2', 'preset_2800i_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '308' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '309', '1', '2', 'preset_2800im_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '309' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '310', '1', '2', 'preset_2800tower_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '310' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '320', '1', '2', 'preset_52desk_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '320' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '321', '1', '2', 'preset_52tower_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '321' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '322', '1', '2', 'preset_ext_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '322' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '323', '1', '2', 'preset_ext_itm_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '323' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '324', '1', '2', 'preset_ext_stl_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '324' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '325', '1', '2', 'preset_ext_reg_assist_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '325' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '326', '1', '2', 'preset_ext_assist_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '326' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '327', '1', '2', 'preset_ext_payment_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '327' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '328', '1', '2', 'preset_selfmente_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '328' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '329', '1', '2', 'preset_35desk_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '329' AND appl_cd = '1');''');
//
//(トリガーキー3752)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '311', '1', '2', 'PresetMente', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '311' AND appl_cd = '1');''');
//
//(区分設定)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '330', '1', '2', 'devide_receive', 'pmod', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '330' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '331', '1', '2', 'devide_pay', 'pmod', '2', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '331' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '332', '1', '2', 'devide_creditSale', 'pmod', '3', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '332' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '333', '1', '2', 'devide_priceCut', 'pmod', '4', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '333' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '334', '1', '2', 'devide_discount', 'pmod', '5', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '334' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '335', '1', '2', 'devide_return', 'pmod', '6', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '335' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '336', '1', '2', 'devide_cancel', 'pmod', '7', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '336' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '337', '1', '2', 'devide_revice', 'pmod', '8', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '337' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '338', '1', '2', 'devide_closing', 'pmod', '9', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '338' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '339', '1', '2', 'devide_changerClosing', 'pmod', '10', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '339' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '340', '1', '2', 'devide_scrap', 'pmod', '11', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '340' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '560', '1', '2', 'devide_notechk1', 'pmod', '12', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '560' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '561', '1', '2', 'devide_notechk2', 'pmod', '13', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '561' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '562', '1', '2', 'devide_notechk3', 'pmod', '14', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '562' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '563', '1', '2', 'devide_notechk4', 'pmod', '15', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '563' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '564', '1', '2', 'devide_notechk5', 'pmod', '16', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '564' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '565', '1', '2', 'devide_notecha1', 'pmod', '17', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '565' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '566', '1', '2', 'devide_notecha2', 'pmod', '18', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '566' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '567', '1', '2', 'devide_notecha3', 'pmod', '19', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '567' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '568', '1', '2', 'devide_notecha4', 'pmod', '20', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '568' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '569', '1', '2', 'devide_notecha5', 'pmod', '21', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '569' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '570', '1', '2', 'devide_notecha6', 'pmod', '22', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '570' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '571', '1', '2', 'devide_notecha7', 'pmod', '23', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '571' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '572', '1', '2', 'devide_notecha8', 'pmod', '24', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '572' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '573', '1', '2', 'devide_notecha9', 'pmod', '25', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '573' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '574', '1', '2', 'devide_notecha10', 'pmod', '26', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '574' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '575', '1', '2', 'devide_notecha11', 'pmod', '27', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '575' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '576', '1', '2', 'devide_notecha12', 'pmod', '28', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '576' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '577', '1', '2', 'devide_notecha13', 'pmod', '29', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '577' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '578', '1', '2', 'devide_notecha14', 'pmod', '30', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '578' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '579', '1', '2', 'devide_notecha15', 'pmod', '31', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '579' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '580', '1', '2', 'devide_notecha16', 'pmod', '32', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '580' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '581', '1', '2', 'devide_notecha17', 'pmod', '33', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '581' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '582', '1', '2', 'devide_notecha18', 'pmod', '34', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '582' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '583', '1', '2', 'devide_notecha19', 'pmod', '35', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '583' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '584', '1', '2', 'devide_notecha20', 'pmod', '36', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '584' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '585', '1', '2', 'devide_notecha21', 'pmod', '37', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '585' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '586', '1', '2', 'devide_notecha22', 'pmod', '38', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '586' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '587', '1', '2', 'devide_notecha23', 'pmod', '39', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '587' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '588', '1', '2', 'devide_notecha24', 'pmod', '40', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '588' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '589', '1', '2', 'devide_notecha25', 'pmod', '41', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '589' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '590', '1', '2', 'devide_notechk26', 'pmod', '42', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '590' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '591', '1', '2', 'devide_notechk27', 'pmod', '43', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '591' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '592', '1', '2', 'devide_notechk28', 'pmod', '44', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '592' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '593', '1', '2', 'devide_notechk29', 'pmod', '45', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '593' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '594', '1', '2', 'devide_notechk30', 'pmod', '46', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '594' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '595', '1', '2', 'devide_prcchg', 'pmod', '47', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '595' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '596', '1', '2', 'devide_drw', 'pmod', '48', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '596' AND appl_cd = '1');''');
//
//(従業員設定)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '350', '1', '2', 'staff_set', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '350' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '351', '1', '2', 'staff_auth_set', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '351' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '352', '1', '2', 'staff_barcd_prn', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '352' AND appl_cd = '1');''');
//
//(顧客関連設定)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '390', '1', '2', 'cust_customer', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '390' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '391', '1', '2', 'cust_nologplu', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '391' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '392', '1', '2', 'cust_point_xtimes', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '392' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '393', '1', '2', 'cust_service', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '393' AND appl_cd = '1');''');
  //await db.execute('''--INSERT INTO p_appl_mst ($insert_field) SELECT '394', '1', '2', 'cust_loyalty', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '394' AND appl_cd = '1');''');
  //await db.execute('''--INSERT INTO p_appl_mst ($insert_field) SELECT '395', '1', '2', 'cust_coupon', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '395' AND appl_cd = '1');''');
//
//(メッセージ)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '360', '1', '2', 'message_master', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '360' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '361', '1', '2', 'message_layout', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '361' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '362', '1', '2', 'message_schedule', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '362' AND appl_cd = '1');''');
//
//(ｲﾒｰｼﾞ/ファンクション)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '370', '1', '2', 'imgfnc_image', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '370' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '371', '1', '2', 'imgfnc_funtion', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '371' AND appl_cd = '1');''');
//
//(キャッシュリサイクル関連)
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '380', '1', '2', 'cashrecycle_set', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '380' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '381', '1', '2', 'cashrecycle_mng', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '381' AND appl_cd = '1');''');
//
//コード決済実績分け
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '382', '1', '2', 'prg_cdpay_fnc', 'pmod', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '382' AND appl_cd = '1');''');
//
//アプリマスタ【速報点検精算メイン画面用
//【売上速報】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '401', '1', '2', 'bult_mcls_main_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '401' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '402', '1', '2', 'scls_main_mm_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '402' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '403', '1', '2', 'bult_plu_main_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '403' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '404', '1', '2', 'bult_reg_main_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '404' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '405', '1', '2', 'bult_staff_main_mm_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '405' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '406', '1', '2', 'bult_brgn_main_mm_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '406' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '526', '1', '2', 'acr_reg_main_mm_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '526' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '527', '1', '2', 'acx_reg_main_mm_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '527' AND appl_cd = '1');''');
//--2ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '411', '1', '2', 'bult_mbrttl_main_mm_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '411' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '414', '1', '2', 'bult_cust_main_mm_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '414' AND appl_cd = '1');''');
//
//--
//【売上点検】
//--1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '415', '1', '2', 'regist_day_acnt_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '415' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '416', '1', '2', 'mm_ejconf_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '416' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '421', '1', '2', 'store_day_acnt_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '421' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '422', '1', '2', 'store_total_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '422' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '423', '1', '2', 'list_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '423' AND appl_cd = '1');''');
//
//売上点検 > 店舗日計
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '419', '1', '2', 'store_day_deal_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '419' AND appl_cd = '1'); -- 取引明細関連''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '420', '1', '2', 'store_day_cls_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '420' AND appl_cd = '1'); -- 分類別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '425', '1', '2', 'store_day_plu_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '425' AND appl_cd = '1'); -- 商品別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '426', '1', '2', 'store_day_sch_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '426' AND appl_cd = '1'); -- スケジュール別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '427', '1', '2', 'store_day_time_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '427' AND appl_cd = '1'); -- 時間帯''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '428', '1', '2', 'store_day_chg_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '428' AND appl_cd = '1'); -- 釣銭明細''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '429', '1', '2', 'store_day_self_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '429' AND appl_cd = '1'); -- セルフ''');
//
//売上点検 > 店舗累計
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2419', '1', '2', 'store_total_deal_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2419' AND appl_cd = '1'); -- 取引明細関連''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2420', '1', '2', 'store_total_cls_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2420' AND appl_cd = '1'); -- 中分類別''');
  //await db.execute('''--INSERT INTO p_appl_mst ($insert_field) SELECT '2424', '1', '2', 'store_total_smlcls_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2424' AND appl_cd = '1'); -- 小分類別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2425', '1', '2', 'store_total_plu_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2425' AND appl_cd = '1'); -- 商品別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2426', '1', '2', 'store_total_sch_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2426' AND appl_cd = '1'); -- スケジュール別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2427', '1', '2', 'store_total_time_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2427' AND appl_cd = '1'); -- 時間帯''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2429', '1', '2', 'store_total_self_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2429' AND appl_cd = '1'); -- セルフ''');
//
//売上精算 > 店舗日計
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1419', '1', '2', 'store_day_deal_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1419' AND appl_cd = '1'); -- 取引明細関連''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1420', '1', '2', 'store_day_cls_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1420' AND appl_cd = '1'); -- 中分類別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1425', '1', '2', 'store_day_plu_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1425' AND appl_cd = '1'); -- 商品別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1426', '1', '2', 'store_day_sch_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1426' AND appl_cd = '1'); -- スケジュール別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1427', '1', '2', 'store_day_time_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1427' AND appl_cd = '1'); -- 時間帯''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1428', '1', '2', 'store_day_chg_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1428' AND appl_cd = '1'); -- 釣銭明細''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1429', '1', '2', 'store_day_self_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1429' AND appl_cd = '1'); -- セルフ''');
//
//売上精算 > 店舗累計
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3419', '1', '2', 'store_total_deal_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3419' AND appl_cd = '1'); -- 取引明細関連''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3420', '1', '2', 'store_total_cls_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3420' AND appl_cd = '1'); -- 中分類別''');
  //await db.execute('''--INSERT INTO p_appl_mst ($insert_field) SELECT '3424', '1', '2', 'store_total_smlcls_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3424' AND appl_cd = '1'); -- 小分類別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3425', '1', '2', 'store_total_plu_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3425' AND appl_cd = '1'); -- 商品別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3426', '1', '2', 'store_total_sch_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3426' AND appl_cd = '1'); -- スケジュール別''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3427', '1', '2', 'store_total_time_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3427' AND appl_cd = '1'); -- 時間帯''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3429', '1', '2', 'store_total_self_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3429' AND appl_cd = '1'); -- セルフ''');
//
//顧客関連
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '600', '1', '2', 'member_relation_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '600' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1600', '1', '2', 'member_relation_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1600' AND appl_cd = '1');''');
//
//
//--2ページ目
  //await db.execute('''--INSERT INTO p_appl_mst ($insert_field) SELECT '430', '1', '2', 'mm_rept77dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '430' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '431', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '4', '78', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '431' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '432', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '4', '79', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '432' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '433', '1', '2', 'mm_rept193_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '433' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '523', '1', '2', 'mm_rept32dsp_fnc', 'sale_com_mm', '1', '0', '32', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '523' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '524', '1', '2', 'mm_rept76dsp_fnc', 'sale_com_mm', '1', '0', '76', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '524' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '528', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '34', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '528' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '529', '1', '2', 'regist_acnt_adjustmnt_rept_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '529' AND appl_cd = '1');''');
//
//--
//アプリマスタ【レジ日計メニュー】画面用
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '434', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '1', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '434' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '435', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '70', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '435' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '436', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '7', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '436' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '437', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '10', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '437' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '438', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '71', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '438' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '439', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '2', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '439' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '440', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '3', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '440' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '441', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '4', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '441' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '442', '1', '2', 'sale_changerdsp_fnc', 'sale_com_mm', '1', '0', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '442' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '443', '1', '2', 'sale_smlclsdsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '443' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '444', '1', '2', 'sale_RegStaffSalesDisp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '444' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '445', '1', '2', 'sale_RegMediaDisp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '445' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '446', '1', '2', 'sale_crdt_dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '446' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '447', '1', '2', 'sale_cybele_dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '447' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '448', '1', '2', 'mm_rept94dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '448' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '449', '1', '2', 'mm_rept31dailyttl_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '449' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '450', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '30', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '450' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '451', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '95', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '451' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '525', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '88', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '525' AND appl_cd = '1');''');
//
//アプリマスタ【売上点検-店舗日計メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '452', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '1', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '452' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '453', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '2', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '453' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '454', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '3', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '454' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '455', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '4', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '455' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '456', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '5', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '456' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '457', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '7', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '457' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '458', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '10', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '458' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '459', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '13', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '459' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '460', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '14', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '460' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '461', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '15', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '461' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '462', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '16', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '462' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '463', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '8', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '463' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '464', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '9', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '464' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '465', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '11', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '465' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '466', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '12', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '466' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '468', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '30', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '468' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '469', '1', '2', 'mm_rept90dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '469' AND appl_cd = '1');''');
//
//-- 2ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '470', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '17', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '470' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '471', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '18', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '471' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '472', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '19', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '472' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '475', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '22', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '475' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '476', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '6', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '476' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '477', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '23', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '477' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '478', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '24', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '478' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '479', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '25', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '479' AND appl_cd = '1');''');
//
//アプリマスタ【売上点検-店舗累計メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2452', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '1', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2452' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2453', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '2', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2453' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2454', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '3', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2454' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2455', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '4', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2455' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2456', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '5', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2456' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2457', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '7', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2457' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2458', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '10', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2458' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2459', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '13', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2459' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2460', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '14', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2460' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2461', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '15', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2461' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2462', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '16', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2462' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2463', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '8', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2463' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2464', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '9', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2464' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2465', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '11', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2465' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2466', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '12', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2466' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2468', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '30', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2468' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2469', '1', '2', 'mm_rept90dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2469' AND appl_cd = '1');''');
//
//-- 2ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2470', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '17', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2470' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2471', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '18', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2471' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2472', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '19', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2472' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2475', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '22', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2475' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2476', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '6', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2476' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2477', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '23', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2477' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2478', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '24', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2478' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2479', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '25', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2479' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2480', '1', '2', 'mm_rept26dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2480' AND appl_cd = '1');''');
//
//-- アプリマスタ【売上点検-精算レポート(日計)メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '550', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '9', '35', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '550' AND appl_cd = '1');''');
//
//
//アプリマスタ【ログ関連メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '481', '1', '2', 'edylog_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '481' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '482', '1', '2', 'mclog_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '482' AND appl_cd = '1');''');
//
//アプリマスタ【テキスト関連メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '483', '1', '2', 'mm_txtbkup_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '483' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '484', '1', '2', 'rept_resend_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '484' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '485', '1', '2', 'rept_resend_fnc', 'sale_com_mm', '2', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '485' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '486', '1', '2', 'rept_resend_prod_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '486' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '487', '1', '2', 'rept_resend_tuo_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '487' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '488', '1', '2', 'rept_resend_business_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '488' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '489', '1', '2', 'rept_read_fnc', 'sale_com_mm', '0', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '489' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '490', '1', '2', 'rept_read_fnc', 'sale_com_mm', '2', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '490' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '491', '1', '2', 'rept_read_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '491' AND appl_cd = '1');''');
//
//アプリマスタ【一覧メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '492', '1', '2', 'rept_main_fnc', 'sale_com_mm', 1, 3, 27, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '492' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '493', '1', '2', 'mm_rept28dsp_fnc', 'sale_com_mm', '1', '3', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '493' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '494', '1', '2', 'mm_rept29dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '494' AND appl_cd = '1');''');
//
//アプリマスタ【会員日計メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '495', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '1', '40', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '495' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1495', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '40', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1495' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '2495', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '2', '40', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '2495' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3495', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '40', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3495' AND appl_cd = '1');''');
//
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '501', '1', '2', 'mm_rept_fspdsp_fnc', 'sale_com_mm', '3', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '501' AND appl_cd = '1');''');
//
//アプリマスタ【会員累計メニュー画面用】
//-- 1ページ目
//
//「会員合計」
//「地区」
//「サービス分類」
//は会員日計メニューと同じものを使用
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '502', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '7', '58', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '502' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1502', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '7', '58', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1502' AND appl_cd = '1');''');
//
//
//アプリマスタ【会員一覧メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '511', '1', '2', 'mm_rept47dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '511' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '513', '1', '2', 'mm_rept48dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '513' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '514', '1', '2', 'mm_rept49dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '514' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '515', '1', '2', 'mm_rept59dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '515' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '516', '1', '2', 'cust_hist_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '516' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '517', '1', '2', 'cust_srch_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '517' AND appl_cd = '1');''');
//
//アプリマスタ【会員精算メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '518', '1', '2', 'cust_enq_clr_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '518' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '519', '1', '2', 'mm_reptcardchg_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '519' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '520', '1', '2', 'mm_reptlv_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '520' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '521', '1', '2', 'mm_reptrbt_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '521' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '522', '1', '2', 'mm_reptcustslct_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '522' AND appl_cd = '1');''');
//
//
//--
//【売上精算】
//--1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1415', '1', '2', 'regist_day_acnt_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1415' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1416', '1', '2', 'mm_ejconf_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1416' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1418', '1', '2', 'log_menu_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1418' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1421', '1', '2', 'store_day_acnt_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1421' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1422', '1', '2', 'store_total_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1422' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1423', '1', '2', 'list_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1423' AND appl_cd = '1');''');
//
//--2ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1431', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '4', '78', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1431' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1432', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '4', '79', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1432' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1433', '1', '2', 'mm_rept193_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1433' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1523', '1', '2', 'mm_rept32dsp_fnc', 'sale_com_mm', '2', '0', '32', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1523' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1524', '1', '2', 'mm_rept76dsp_fnc', 'sale_com_mm', '2', '0', '76', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1524' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1528', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '34', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1528' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1529', '1', '2', 'regist_acnt_adjustmnt_rept_2_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1529' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1530', '1', '2', 'regist_halfway_adjustmnt_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1530' AND appl_cd = '1');''');
//
//--
//アプリマスタ【レジ日計メニュー】画面用
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1434', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '1', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1434' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1435', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '70', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1435' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1436', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '7', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1436' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1437', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '10', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1437' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1438', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '71', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1438' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1439', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '2', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1439' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1440', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '3', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1440' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1441', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '4', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1441' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1442', '1', '2', 'sale_changerdsp_fnc', 'sale_com_mm', '2', '0', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1442' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1443', '1', '2', 'sale_smlclsdsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1443' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1444', '1', '2', 'sale_RegStaffSalesDisp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1444' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1445', '1', '2', 'sale_RegMediaDisp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1445' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1446', '1', '2', 'sale_crdt_dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1446' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1447', '1', '2', 'sale_cybele_dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1447' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1448', '1', '2', 'mm_rept94dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1448' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1449', '1', '2', 'mm_rept31dailyttl_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1449' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1450', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '30', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1450' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1451', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '95', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1451' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1525', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '88', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1525' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1526', '1', '2', 'mm_rept34dailyttl_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1526' AND appl_cd = '1');''');
//
//WS様専用レポート
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '555', '1', '2', 'rept_main_fnc', 'sale_com_mm', '1', '0', '37', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '555' AND appl_cd = '1'); -- 売上点検''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1555', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '0', '37', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1555' AND appl_cd = '1'); -- 売上精算''');
//
//アプリマスタ【売上精算-店舗日計メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1452', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '1', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1452' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1453', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '2', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1453' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1454', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '3', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1454' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1455', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '4', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1455' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1456', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '5', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1456' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1457', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '7', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1457' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1458', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '10', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1458' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1459', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '13', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1459' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1460', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '14', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1460' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1461', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '15', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1461' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1462', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '16', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1462' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1463', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '8', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1463' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1464', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '9', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1464' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1465', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '11', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1465' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1466', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '12', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1466' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1468', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '30', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1468' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1469', '1', '2', 'mm_rept90dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1469' AND appl_cd = '1');''');
//
//-- 2ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1470', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '17', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1470' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1471', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '18', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1471' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1472', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '19', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1472' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1475', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '22', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1475' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1476', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '6', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1476' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1477', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '23', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1477' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1478', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '24', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1478' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1479', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '1', '25', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1479' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1560', '1', '2', 'mm_rept34dsp_fnc', 'sale_com_mm', '2', '1', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1560' AND appl_cd = '1'); -- 会計別税明細''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1700', '1', '2', 'rm59_floating_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1700' AND appl_cd = '1'); -- 加算クリア''');
//
//アプリマスタ【売上精算-店舗累計メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3452', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '1', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3452' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3453', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '2', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3453' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3454', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '3', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3454' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3455', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '4', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3455' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3456', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '5', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3456' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3457', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '7', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3457' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3458', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '10', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3458' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3459', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '13', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3459' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3460', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '14', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3460' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3461', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '15', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3461' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3462', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '16', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3462' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3463', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '8', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3463' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3464', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '9', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3464' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3465', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '11', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3465' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3466', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '12', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3466' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3468', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '30', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3468' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3469', '1', '2', 'mm_rept90dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3469' AND appl_cd = '1');''');
//
//-- 2ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3470', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '17', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3470' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3471', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '18', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3471' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3472', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '19', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3472' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3475', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '22', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3475' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3476', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '6', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3476' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3477', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '23', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3477' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3478', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '24', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3478' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3479', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '2', '25', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3479' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '3560', '1', '2', 'mm_rept34dsp_fnc', 'sale_com_mm', '2', '2', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '3560' AND appl_cd = '1'); -- 会計別税明細''');
//
//-- アプリマスタ【売上精算-精算レポート(日計)メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1550', '1', '2', 'rept_main_fnc', 'sale_com_mm', '2', '9', '35', NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1550' AND appl_cd = '1');''');
//
//
//アプリマスタ【ログ関連メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1481', '1', '2', 'edylog_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1481' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1482', '1', '2', 'mclog_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1482' AND appl_cd = '1');''');
//
//アプリマスタ【テキスト関連メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1483', '1', '2', 'mm_txtbkup_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1483' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1484', '1', '2', 'rept_resend_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1484' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1485', '1', '2', 'rept_resend_fnc', 'sale_com_mm', '2', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1485' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1486', '1', '2', 'rept_resend_prod_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1486' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1487', '1', '2', 'rept_resend_tuo_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1487' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1488', '1', '2', 'rept_resend_business_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1488' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1489', '1', '2', 'rept_read_fnc', 'sale_com_mm', '0', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1489' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1490', '1', '2', 'rept_read_fnc', 'sale_com_mm', '2', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1490' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1491', '1', '2', 'rept_read_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1491' AND appl_cd = '1');''');
//
//アプリマスタ【一覧メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1492', '1', '2', 'rept_main_fnc', 'sale_com_mm', 2, 3, 27, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1492' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1493', '1', '2', 'mm_rept28dsp_fnc', 'sale_com_mm', '2', '3', NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1493' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1494', '1', '2', 'mm_rept29dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1494' AND appl_cd = '1');''');
//
//アプリマスタ【会員一覧メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1511', '1', '2', 'mm_rept47dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1511' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1513', '1', '2', 'mm_rept48dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1513' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1514', '1', '2', 'mm_rept49dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1514' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1515', '1', '2', 'mm_rept59dsp_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1515' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1516', '1', '2', 'cust_hist_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1516' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1517', '1', '2', 'cust_srch_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1517' AND appl_cd = '1');''');
//
//アプリマスタ【会員精算メニュー画面用】
//-- 1ページ目
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1518', '1', '2', 'cust_enq_clr_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1518' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1519', '1', '2', 'mm_reptcardchg_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1519' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1520', '1', '2', 'mm_reptlv_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1520' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1521', '1', '2', 'mm_reptrbt_fnc', 'sale_com_mm', '1', NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1521' AND appl_cd = '1');''');
  await db.execute('''INSERT INTO p_appl_mst ($insert_field) SELECT '1522', '1', '2', 'mm_reptcustslct_fnc', 'sale_com_mm', NULL, NULL, NULL, NULL, NULL, '0', '0' WHERE NOT EXISTS ($sub_query appl_grp_cd = '1522' AND appl_cd = '1');''');
}
Future _mm_recoggrpmst(db, value,int COMP,int STRE,int MACNO) async {
  await db.execute('''DELETE FROM c_recog_grp_mst;''');

  String insert_field = 'recog_grp_cd, recog_sub_grp_cd, page, posi, recog_flg, ins_datetime, upd_datetime, status, send_flg, upd_user,   upd_system';
  String cmn_set = ' CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = "";

  //承認キー(1ページ)の判断
  sub_query =  'SELECT * FROM c_recog_grp_mst WHERE recog_grp_cd = \'101\' AND recog_sub_grp_cd = \'1\' AND page = \'1\' ';
  await db.execute('''insert into c_recog_grp_mst ($insert_field) SELECT '1', '1', '1', '1', '1', $cmn_set WHERE NOT EXISTS ($sub_query AND posi = '1');''');
//
//-- 承認キー(4ページ)の判断
  sub_query =  'SELECT * FROM c_recog_grp_mst WHERE recog_grp_cd = \'10\' AND recog_sub_grp_cd = \'1\' AND page = \'4\' ';
  await db.execute('''insert into c_recog_grp_mst ($insert_field) SELECT '10', '1', '4', '11', '1', $cmn_set WHERE NOT EXISTS ($sub_query AND posi = '11');''');
//
//-- 承認キー(5ページ)の判断
  sub_query =  'SELECT * FROM c_recog_grp_mst WHERE recog_grp_cd = \'101\' AND recog_sub_grp_cd = \'1\' AND page = \'5\' ';
  await db.execute('''insert into c_recog_grp_mst ($insert_field) SELECT '101', '1', '5', '2', '1', $cmn_set WHERE NOT EXISTS ($sub_query AND posi = '2');''');
//
//-- 承認キー(3ページ)の判断：顧客明細仕様
  sub_query =  'SELECT * FROM c_recog_grp_mst WHERE recog_grp_cd = \'21\' AND recog_sub_grp_cd = \'1\' AND page = \'3\' ';
  await db.execute('''insert into c_recog_grp_mst ($insert_field) SELECT '21', '1', '3', '10', '1', $cmn_set WHERE NOT EXISTS ($sub_query AND posi = '10');''');
//
//-- 承認キー(1ページ)の判断：顧客仕様
  sub_query =  'SELECT * FROM c_recog_grp_mst WHERE recog_grp_cd = \'41\' AND recog_sub_grp_cd = \'1\' AND page = \'1\' ';
  await db.execute('''insert into c_recog_grp_mst ($insert_field) SELECT '41', '1', '1', '1', '1', $cmn_set WHERE NOT EXISTS ($sub_query AND posi = '1');''');
//-- 承認キー(7ページ)の判断：ダイレクト顧客仕様が無効
  sub_query =  'SELECT * FROM c_recog_grp_mst WHERE recog_grp_cd = \'41\' AND recog_sub_grp_cd = \'1\' AND page = \'7\' ';
  await db.execute('''insert into c_recog_grp_mst ($insert_field) SELECT '41', '2', '7', '12', '0', $cmn_set WHERE NOT EXISTS ($sub_query AND posi = '12');''');
//
//-- 承認キー(17ページ)の判断：特定WS仕様が有効
  sub_query =  'SELECT * FROM c_recog_grp_mst WHERE recog_grp_cd = \'51\' AND recog_sub_grp_cd = \'1\' AND page = \'17\' ';
  await db.execute('''insert into c_recog_grp_mst ($insert_field) SELECT '51', '1', '17', '15', '1', $cmn_set WHERE NOT EXISTS ($sub_query AND posi = '15');''');
//
//-- 承認キー(18ページ)の判断：TS設定個別変更仕様が有効
  sub_query =  'SELECT * FROM c_recog_grp_mst WHERE recog_grp_cd = \'61\' AND recog_sub_grp_cd = \'1\' AND page = \'18\' ';
  await db.execute('''insert into c_recog_grp_mst ($insert_field) SELECT '61', '1', '18', '11', '1', $cmn_set WHERE NOT EXISTS ($sub_query AND posi = '11');''');

}
Future _mm_recogmst(db, value,int COMP,int STRE,int MACNO) async {
  await db.execute('''DELETE FROM p_recog_mst;''');
  String insert_field = 'page, posi, recog_name, recog_set_flg';
  String sub_query = 'SELECT * FROM p_recog_mst WHERE ';

  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '1', \'顧客ﾎﾟｲﾝﾄ+FSP仕様', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '2', \'クレジット仕様', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '3', \'特別領収書仕様(ﾀｰﾐﾅﾙ設定で変更必要)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '4', \'値引バーコード仕様', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '5', \'OKIリライト仕様(DB V6以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '6', \'セルフシステム仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '7', \'24時間仕様(DB V4,V6以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '8', \'ビスマック仕様(DB V7以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '9', \'netDoA仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '10', \'特定ＦＴＰ送信仕様(DB V7以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '11', \'プロモーション仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '12', \'Ｅｄｙ仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '13', \'生鮮ＩＤ仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '14', \'金券チケット仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '15', \'へそくり仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '16', \'ﾋﾞｽﾏｯｸ+ｸﾞﾘｰﾝｽﾀﾝﾌﾟ仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '17', \'ﾋﾞｽﾏｯｸ特定処理仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '18', \'ﾎﾟｲﾝﾄｶｰﾄﾞ仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '19', \'顧客ﾎﾟｲﾝﾄ仕様', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '19');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '1', '20', \'顧客FSP仕様', '0' WHERE NOT EXISTS ($sub_query page = '1' AND posi = '20');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '1', \'モバイルＰＯＳ仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '2', \'CSS店舗間通信仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '3', \'ﾚｼﾞ接続数基準以上仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '4', \'衣料バーコード仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '5', \'特定衣料FTP送信仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '6', \'Mｶｰﾄﾞ仕様(特定 V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '7', \'ﾌﾟﾘﾝﾀ+CDﾊﾞｯｸｱｯﾌﾟ仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '8', \'POPPY接続仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '9', \'棚札ﾌﾟﾘﾝﾀ接続仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '10', \'TAURUS接続仕様(DB V8以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '11', \'Pastel Port接続仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '12', \'イートイン仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '13', \'モバイルＰＯＳ精算仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '14', \'定期刊行物コード仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '15', \'本部接続リアル通信あり(現在未対応)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '16', \'PW410接続仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '2', '17', \'NSCｸﾚｼﾞｯﾄ仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '2' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '1', \'生産者実績送信仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '2', \'FeliCa仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '3', \'ﾌﾟﾘﾍﾟｰﾄﾞｶｰﾄﾞ仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '4', \'NTT東+ﾋﾞｼﾞｺﾑ接続仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '5', \'カタリナクーポン仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '6', \'ﾌﾟﾗｲｽﾁｪｯｶｰ接続仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '7', \'皿勘定システム仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '8', \'ITFバーコード仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '9', \'特定FTP-ACT仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '10', \'顧客明細仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '11', \'顧客リアル問合せ仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '12', \'Suica決済［CAT接続］(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '13', \'Yomoca接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '14', \'Smartplus接続仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '14');''');
  //await db.execute('''--2021/07/21 INSERT INTO p_recog_mst ($insert_field) SELECT '3', '15', \'勤怠管理仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '16', \'ECOA接続仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '17', \'Suica決済［CAT非接続］(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '3', '18', \'引換券印字仕様 (DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '3' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '1', \'QUICPay接続仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '2', \'iD接続仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '3', \'特殊レイアウト仕様(DB V9以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '4', \'Quick Self仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '5', \'Quick Self切替仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '6', \'Assist Monitor接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '7', \'値付けﾌﾟﾘﾝﾀ接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '8', \'リアル明細送信仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '9', \'ﾚｲﾝﾎﾞｰｶｰﾄﾞ仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '10', \'GramX接続仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '11', \'途中精算仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '12', \'ｶｰﾄﾞ決済機ﾎﾟｲﾝﾄ仕様(DB V10以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '13', \'タグ読込仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '14', \'百貨店仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '15', \'Ｅｄｙ番号顧客仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '16', \'FCFカード顧客仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '17', \'ﾊﾟﾅｺｰﾄﾞ顧客ﾎﾟｲﾝﾄ仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '4', '18', \'LANDISK接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '4' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '1', \'PiTaPa接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '2', \'TuoCard仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '3', \'販売期限バーコード仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '4', \'業務モード仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '5', \'MCP200接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '6', \'VisaTouch仕様 [FCL] (DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '7', \'ﾘﾓｰﾄﾒﾝﾃﾅﾝｽ仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '8', \'発注モード仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '9', \'JREM製マルチ端末仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '10', \'メディア情報仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '11', \'GS1バーコード仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '12', \'詰合仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '13', \'ｾﾝﾀｰｻｰﾊﾞｰ接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '14', \'予約仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '15', \'改正薬事法仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '16', \'銀聯接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '17', \'QUICPay仕様 [FCL] (DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '5', '18', \'Edy仕様 [FCL] (DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '5' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '1', \'CAPS[CAFIS]接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '2', \'iD仕様 [FCL] (DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '3', \'ﾎﾟｲﾝﾄﾁｹｯﾄ発券仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '4', \'ABS-S31Kﾌﾟﾘﾍﾟｲﾄﾞ仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '5', \'生産者商品登録時作成(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '6', \'生産者ITFﾊﾞｰｺｰﾄﾞ仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '7', \'特殊ｸｰﾎﾟﾝ券仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '8', \'ﾌﾞﾙｰﾁｯﾌﾟｻｰﾊﾞｰ接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '9', \'日立ﾌﾞﾙｰﾁｯﾌﾟ接続仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '10', \'CSS[Proxy]通信仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '11', \'ＱＣａｓｈｉｅｒ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '12', \'レシートＱＲコード印字仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '13', \'VisaTouch仕様 [INFOX] (DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '14', \'収納代行仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '15', \'特定ＨＣ１仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '17', \'ﾘﾓｰﾄ監視ｻｰﾊﾞｰ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '6', '18', \'他社ｶｰﾄﾞ ﾊﾟﾅｺｰﾄﾞ仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '6' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '1', \'特定百貨店仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '2', \'明細送信小数点送信仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '3', \'Wizマスタ管理仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '4', \'ABS-V31ﾘﾗｲﾄｶｰﾄﾞ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '5', \'複数ＱＲコード仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '6', \'ｎｅｔＤｏＡ予約仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '7', \'個別精算仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '8', \'顧客ﾘｱﾙ[Webｻｰﾋﾞｽ]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '9', \'Wiz精算仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '10', \'顧客ﾘｱﾙ[UID]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '11', \'明細送信ﾐｯｸｽﾏｯﾁ仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '12', \'ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様(DB V11以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '13', \'UT接続仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '14', \'CAPS[P-QVIC]接続仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '15', \'ﾔﾏﾄ電子ﾏﾈｰ決済端末仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '16', \'標準CAPS[CAFIS]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '17', \'PastelPort プリカ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '7', '18', \'USBカメラ接続仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '7' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '1', \'特定ﾄﾞﾗｯｸﾞｽﾄｱ仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '2', \'顧客ﾘｱﾙ[NEC]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '3', \'顧客ﾘｱﾙ[OPｶｰﾄﾞ]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '4', \'ｸﾚｼﾞｯﾄ仕様[ﾀﾞﾐ-ｼｽﾃﾑ](ﾃﾞﾓ / ﾄﾚｰﾆﾝｸﾞ専用)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '5', \'特定ＨＣ２仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '6', \'音声合成[ｿﾌﾄ対応]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '7', \'プリカ仕様[ﾀﾞﾐｰｼｽﾃﾑ](ﾃﾞﾓ / ﾄﾚｰﾆﾝｸﾞ専用)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '8', \'精算監視仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '9', \'ﾏﾙﾁ決済端末仕様:J-Mups(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '10', \'QUICPay仕様 [UT1] (DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '11', \'iD仕様 [UT1] (DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '12', \'ﾌｧｲﾙ共有仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '13', \'PiTaPa仕様 [PFM] (DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '14', \'交通系IC仕様 [PFM] (DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '15', \'売掛伝票印字仕様 (DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '16', \'交通系ICﾁｬｰｼﾞ仕様[PFM](DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '17', \'単品値下げｸｰﾎﾟﾝ券仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '8', '18', \'ｶｰﾄﾞ決済機/J-Mups併用(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '8' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '9', '1', \'SQRCﾁｹｯﾄ発券ｼｽﾃﾑ(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '9' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '9', '2', \'CCT基本連動仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '9' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '9', '3', \'CCT電子ﾏﾈｰ決済仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '9' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '9', '4', \'ﾃｯｸCCT電子ﾏﾈｰ決済仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '9' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '9', '5', \'生産者商品ｾﾞﾛﾌﾗｸﾞ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '9' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '1', \'対面セルフシステム(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '2', \'寺岡プリペイド仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '3', \'卓上ﾚｼﾞ専用ﾏﾙﾁ登録仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '4', \'Suicaﾁｬｰｼﾞ[CAT非接続](DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '5', \'nimocaﾎﾟｲﾝﾄ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '6', \'顧客ﾘｱﾙ[Pｱｰﾃｨｽﾄ]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '7', \'特定交通系１仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '8', \'免税仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '9', \'レピカ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '10', \'標準CAPS[CARDNET]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '11', \'ゆめｶｰﾄﾞ決済機接続仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '12', \'交通系IC仕様[ﾀﾞﾐｰｼｽﾃﾑ](ﾄﾚｰﾆﾝｸﾞ専用)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '13', \'支払機ﾏﾈｰｼﾞｬ接続仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '14', \'Tポイント仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '15', \'特定SM1仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '16', \'明細送信商品区分仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '17', \'ゆめｶｰﾄﾞﾚｼﾞ直仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '10', '18', \'CoGCa仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '10' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '1', \'顧客リアル[HPS]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '2', \'特定SM2仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '3', \'特定ＨＣ３仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '4', \'特定SM3仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '5', \'ｷｯﾁﾝﾌﾟﾘﾝﾀ接続仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '6', \'ﾐｯｸｽﾏｯﾁ複数選択仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '7', \'販売期限ﾊﾞｰｺｰﾄﾞ26桁(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '8', \'特定買上ﾁｹｯﾄ発券仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '9', \'顧客リアル[ﾕﾆｼｽ]仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '10', \'EJ動画サーバー接続仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '11', \'バリューカード仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '12', \'特定SM4仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '13', \'特定SM5仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '14', \'JET-S ﾎﾟｲﾝﾄ決済仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '11', '15', \'特定VC仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '11' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '12', '7', \'楽天ﾎﾟｲﾝﾄ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '12' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '12', '9', \'Verifone接続仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '12' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '12', '17', \'電子マネー[FIP]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '12' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '13', '5', \'特定SM16仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '13' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '13', '11', \'明細送信[INFOX]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '13' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '13', '16', \'ｾﾙﾌﾒﾃﾞｨｹｰｼｮﾝ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '13' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '13', '18', \'特定SM20仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '13' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '14', '14', \'WAON仕様 [Panasonic](現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '14' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '14', '15', \'Onepay仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '14' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '14', '16', \'HappySelf仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '14' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '14', '17', \'HappySelf[対面ｾﾙﾌ用](DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '14' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '15', '3', \'LINE Pay仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '15' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '15', '4', \'従業員権限解除仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '15' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '15', '7', \'理由選択仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '15' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '15', '9', \'WIZ-BASE仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '15' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '15', '10', \'Pack On Time仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '15' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '16', '4', \'Shop&Go仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '16' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '16', '9', \'特定社員証1仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '16' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '16', '14', \'特定SM33仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '16' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '16', '16', \'特定DS2仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '16' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '16', '13', \'旅券読取内蔵免税仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '16' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '2', \'特定SM36仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '3', \'CR5.0接続仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '5', \'特定ｸﾗｽ衣料ﾊﾞｰｺｰﾄﾞ仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '6', \'ｄポイント仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '7', \'顧客ﾘｱﾙ仕様[ﾀﾞﾐｰｼｽﾃﾑ](現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '10', \'JPQR決済仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '11', \'顧客ﾘｱﾙ[PT]仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '12', \'特定CR3接続仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '13', \'特定遊技機用印字仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '14', \'CCTコード払い決済仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '15', \'特定WS仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '16', \'顧客リアル[PI]仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '17', \'特定TOY仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '17', '18', \'ｺｰﾄﾞ決済[CANALPay]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '17' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '4', \'VEGA3000電子ﾏﾈｰ仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '5', \'特定DP1仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '6', \'特定SM41仕様(DB V12)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '7', \'特定SM42仕様(DB V14)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '9', \'特定公共料金仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '11', \'TS設定個別変更仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '12', \'特定SM44仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '14', \'stera terminal仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '16', \'レピカポイント仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '15', \'特定SM45仕様(Ver12以降)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '18', '18', \'ｺｰﾄﾞ決済[FIP]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '18' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '19', '4', \'免税電子化仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '19' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '19', '7', \'社員証決済仕様[売店](DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '19' AND posi = '7');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '19', '8', \'ﾛｸﾞﾉｰﾄ電子ﾚｼｰﾄ仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '19' AND posi = '8');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '19', '10', \'特定SM49仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '19' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '19', '15', \'特定公共料金2仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '19' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '19', '16', \'Onepay複数ブランド仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '19' AND posi = '16');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '19', '17', \'特定SM52仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '19' AND posi = '17');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '19', '18', \'特定公共料金3仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '19' AND posi = '18');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '20', '2', \'ｻｰﾋﾞｽ分類別割引2仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '20' AND posi = '2');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '20', '9', \'特定SM55仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '20' AND posi = '9');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '20', '10', \'ﾚｼｰﾄﾒｰﾙ送信仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '20' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '20', '11', \'ｺｰﾄﾞ決済[Netstars]仕様(DB V12以降)', '0' WHERE NOT EXISTS ($sub_query page = '20' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '20', '12', \'特定SM56仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '20' AND posi = '12');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '20', '15', \'特定HYS1仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '20' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '3', \'酒税免税仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '3');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '4', \'顧客リアル[SM56]仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '5', \'特定SM59仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '6', \'分類別明細非印字仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '6');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '10', \'特定SM61仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '10');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '11', \'特定百貨店2仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '13', \'顧客ﾘｱﾙ[CP]仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '14', \'特定HC12仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '21', '15', \'特定SM62仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '21' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '22', '1', \'特定SM65仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '22' AND posi = '1');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '22', '4', \'友の会仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '22' AND posi = '4');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '22', '5', \'特定SM66仕様(現在未使用)', '0' WHERE NOT EXISTS ($sub_query page = '22' AND posi = '5');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '22', '11', \'特定公共料金4仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '22' AND posi = '11');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '22', '13', \'特定SM71仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '22' AND posi = '13');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '22', '14', \'ｷｯﾁﾝﾌﾟﾘﾝﾀﾚｼｰﾄ印字仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '22' AND posi = '14');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '22', '15', \'特定地公体2仕様(DB V14以降)', '0' WHERE NOT EXISTS ($sub_query page = '22' AND posi = '15');''');
  await db.execute('''INSERT INTO p_recog_mst ($insert_field) SELECT '22', '16', \'特定QR読込1仕様(DB V1以降)', '0' WHERE NOT EXISTS ($sub_query page = '22' AND posi = '16');''');
}
Future _mm_recoginfomst(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'comp_cd, stre_cd, mac_no, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, page, password, fcode, qcjc_type, emergency_type, emergency_date';
  String cmn_set = ' $COMP, $STRE, $MACNO, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\' ';
  String sub_query = 'select page FROM c_recoginfo_mst WHERE comp_cd = $COMP AND stre_cd = $STRE AND mac_no=$MACNO';

  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '1', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '1');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '2', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '2');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '3', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '3');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '4', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '4');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '5', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '5');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '6', '', '', '000000000012000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '6');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '7', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '7');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '8', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '8');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '9', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '9');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '10', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '10');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '11', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '11');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '12', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '12');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '13', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '13');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '14', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '14');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '15', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '15');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '16', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '16');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '17', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '17');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '18', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '18');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '19', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '19');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '20', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '20');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '21', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '21');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '22', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '22');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '23', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '23');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '24', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '24');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '25', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '25');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '26', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '26');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '27', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '27');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '28', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '28');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '29', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '29');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '30', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '30');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '31', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '31');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '32', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '32');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '33', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '33');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '34', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '34');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '35', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '35');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '36', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '36');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '37', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '37');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '38', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '38');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '39', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '39');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '40', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '40');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '41', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '41');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '42', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '42');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '43', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '43');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '44', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '44');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '45', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '45');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '46', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '46');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '47', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '47');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '48', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '48');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '49', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '49');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '50', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '50');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '51', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '51');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '52', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '52');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '53', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '53');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '54', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '54');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '55', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '55');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '56', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '56');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '57', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '57');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '58', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '58');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '59', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '59');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '60', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '60');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '61', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '61');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '62', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '62');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '63', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '63');''');
  await db.execute('''insert into c_recoginfo_mst ($insert_field) SELECT $cmn_set, '64', '', '', '000000000000000000', '000000000000000000', NULL WHERE NOT EXISTS ($sub_query AND page = '64');''');
}
Future _mm_acctmst(db, value,int COMP,int STRE,int MACNO) async {
  String insert_field = 'start_date, end_date, plus_end_date, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, comp_cd, stre_cd, acct_cd, mthr_acct_cd, acct_name, rcpt_prn_flg, prn_seq_no, acct_typ, acct_cal_typ';
  String cmn_set = ' \'2018-01-01 00:00:00\', \'2099-12-31 23:59:59\', \'2099-12-31 23:59:59\', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'0\', \'0\', \'999999\', \'2\', $COMP, $STRE ';
  String sub_query = 'SELECT acct_cd FROM c_acct_mst WHERE comp_cd = $COMP AND stre_cd = $STRE ';

//-- 標準顧客・自社ポイント用[末尾0:##0]
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '100', '800', \'今回発生ポイント', '1', '0', '1', '1' WHERE NOT EXISTS ($sub_query AND acct_cd = '100');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '200', '800', \'商品加算ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '200');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '300', '800', \'月間購買累計金額', '1', '0', '2', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '300');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '450', '800', \'来店ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '450');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '600', '800', \'スタンプポイント1', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '600');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '610', '800', \'スタンプポイント2', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '610');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '620', '800', \'スタンプポイント3', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '620');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '630', '800', \'スタンプポイント4', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '630');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '640', '800', \'スタンプポイント5', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '640');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '650', '800', \'ボーナスポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '650');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '700', '800', \'曜日倍ポイント', '1', '0', '1', '2' WHERE NOT EXISTS ($sub_query AND acct_cd = '700');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '710', '800', \'商品倍ポイント', '1', '0', '1', '3' WHERE NOT EXISTS ($sub_query AND acct_cd = '710');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '720', '800', \'サービス分類ポイント', '1', '0', '1', '2' WHERE NOT EXISTS ($sub_query AND acct_cd = '720');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '730', '800', \'支払倍ポイント', '1', '0', '1', '4' WHERE NOT EXISTS ($sub_query AND acct_cd = '730');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '740', '800', \'全体倍ポイント', '1', '0', '1', '2' WHERE NOT EXISTS ($sub_query AND acct_cd = '740');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '750', '800', \'新規会員ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '750');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '800', '0', \'累計ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '800');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '900', '800', \'アンケート謝礼ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '900');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '950', '800', \'メーカークーポンポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '950');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '980', '800', \'生鮮ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '980');''');
//
//-- 楽天ポイント用[末尾:##1]
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '101', '801', \'通常ﾎﾟｲﾝﾄ', '1', '0', '1', '1' WHERE NOT EXISTS ($sub_query AND acct_cd = '101');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '201', '801', \'商品加算ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '201');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '301', '801', \'ﾎﾟｲﾝﾄ対象金額', '1', '0', '2', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '301');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '711', '801', \'商品倍ポイント', '1', '0', '1', '3' WHERE NOT EXISTS ($sub_query AND acct_cd = '711');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '721', '801', \'サービス分類ポイント', '1', '0', '1', '2' WHERE NOT EXISTS ($sub_query AND acct_cd = '721');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '741', '801', \'全体倍ポイント', '1', '0', '1', '2' WHERE NOT EXISTS ($sub_query AND acct_cd = '741');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '801', '0', \'獲得予定ﾎﾟｲﾝﾄ', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '801');''');
//
//-- Tポイント用[末尾:##2]
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '102', '802', \'通常付与ﾎﾟｲﾝﾄ', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '102');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '202', '802', \'商品加算ﾎﾟｲﾝﾄ', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '202');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '302', '802', \'ﾎﾟｲﾝﾄ付与対象', '1', '0', '2', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '302');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '452', '802', \'全体加算ﾎﾟｲﾝﾄ', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '452');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '712', '802', \'商品倍ﾎﾟｲﾝﾄ', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '712');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '732', '802', \'支払倍ﾎﾟｲﾝﾄ', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '732');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '742', '802', \'全体倍ﾎﾟｲﾝﾄ', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '742');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '802', '0', \'付与ﾎﾟｲﾝﾄ合計', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '802');''');
//
//-- dポイント用[末尾:##3]
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '103', '803', \'通常進呈ﾎﾟｲﾝﾄ', '0', '0', '1', '1' WHERE NOT EXISTS ($sub_query AND acct_cd = '103');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '303', '803', \'ﾎﾟｲﾝﾄ対象金額', '0', '0', '2', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '303');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '803', '0', \'進呈ﾎﾟｲﾝﾄ', '0', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '803');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '999993', '803', \'ﾎﾟｲﾝﾄ修正', '0', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '999993');''');
//
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '2000', '0', \'ボーナス値引', '0', '0', '2', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '2000');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '999998', '800', \'買上追加ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '999998');''');
  await db.execute('''INSERT INTO c_acct_mst ($insert_field) SELECT $cmn_set, '210', '800', \'ＭＭ加算ポイント', '1', '0', '1', '0' WHERE NOT EXISTS ($sub_query AND acct_cd = '210');''');
}
Future _mm_tcountmst(db, value,int COMP,int STRE,int MACNO) async {
  await db.execute('''DELETE FROM c_tcount_mst;''');
  String insert_field = 'tcount_cd, set_tbl_name,set_tbl_typ, file_dir, dat_div, recog_grp_cd';
  String sub_query = 'SELECT * FROM c_tcount_mst WHERE ';

  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1', 'c_acct_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '2', 'c_appl_grp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '2');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '3', 'p_appl_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '3');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '4', 'c_img_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '4');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '5', 'c_instre_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '5');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '6', 'c_caldr_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '6');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '7', 'c_keyopt_sub_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '7');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '8', 'c_keyopt_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '8');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '9', 'c_keyopt_set_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '9');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '10', 'c_keykind_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '10');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '11', 'c_keykind_grp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '11');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '12', 'c_cpnhdr_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '12');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '13', 'c_cpn_ctrl_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '13');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '14', 'c_cpnbdy_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '14');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '16', 'c_crdt_demand_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '16');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '17', 'c_caseitem_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '17');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '18', 's_svr_staffauth_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '18');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '21', 'c_scanplu_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '21');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '22', 'c_setitem_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '22');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '23', 's_stmitem_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '23');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '24', 's_stmsch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '24');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '25', 'c_trm_sub_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '25');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '26', 'c_trm_tag_grp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '26');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '27', 'c_trm_chk_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '27');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '28', 'c_trm_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '28');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '29', 'c_trm_menu_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '29');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '30', 'c_trm_plan_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '30');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '31', 'c_trm_set_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '31');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '32', 'c_trm_rsrv_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '32');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '33', 'c_dialog_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '33');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '34', 'c_dialog_ex_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '34');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '35', 'c_set_tbl_name_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '35');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '36', 'p_trigger_key_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '36');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '37', 'c_barfmt_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '37');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '38', 'c_finit_grp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '38');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '39', 'c_finit_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '39');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '40', 'c_keyfnc_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '40');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '41', 'c_keyauth_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '41');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '42', 'c_fmttyp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '42');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '43', 'c_preset_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '43');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '44', 'p_promsch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '44');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '45', 'p_promitem_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '45');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '46', 'c_pntschgrp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '46');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '47', 'c_pntsch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '47');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '48', 's_plu_point_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '48');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '49', 's_bdlsch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '49');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '50', 's_bdlitem_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '50');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '51', 'c_msgsch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '51');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '52', 'c_msgsch_layout_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '52');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '53', 'c_msg_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '53');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '54', 'c_msglayout_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '54');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '55', 'c_menu_obj_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '55');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '56', 'c_rank_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '56');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '60', 'rdly_flow', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '60');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '61', 'rdly_deal', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '61');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '62', 'rdly_deal_hour', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '62');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '64', 'c_menuauth_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '64');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '65', 'c_memo_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '65');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '66', 'c_memosnd_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '66');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '67', 'c_openclose_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '67');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '68', 'c_reginfo_grp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '68');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '69', 'c_reginfo_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '69');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '70', 'c_regcnct_sio_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '70');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '71', 'rdly_prom', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '71');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '72', 'rdly_plu', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '72');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '73', 'rdly_plu_hour', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '73');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '74', 'rdly_acr', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '74');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '75', 'rdly_class', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '75');''');
  // await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '76', 'rdly_class_hour', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '76');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '77', 'c_histlog_chg_cnt', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '77');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '78', 'c_report_cnt', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '78');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '79', 'c_loypln_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '79');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '80', 'c_loytgt_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '80');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '81', 'c_loyplu_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '81');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '82', 'c_loystre_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '82');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '84', 'c_tmp_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '84');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '85', 'c_preset_img_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '85');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '91', 'c_plan_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '91');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '93', 'c_comp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '93');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '94', 'c_ctrl_sub_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '94');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '95', 'c_ctrl_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '95');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '96', 'c_ctrl_set_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '96');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '97', 'c_divide_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '97');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '98', 'c_tcount_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '98');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '99', 'c_cust_data_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '99');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '100', 'c_cust_header_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '100');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '101', 'c_cust_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '101');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '102', 'c_custd_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '102');''');
  //await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '104', 'c_custd_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '104');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '103', 'p_brgnsch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '103');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '104', 'p_brgnitem_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '104');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '105', 'c_maker_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '105');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '106', 's_brgn_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '106');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '107', 'p_pbchg_balance_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '107');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '108', 'c_ej_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '108');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '109', 'c_status_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '109');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '110', 'c_status_log_reserv', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '110');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '111', 'c_data_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '111');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '112', 'c_header_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '112');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '113', 'c_liqrcls_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '113');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '114', 'c_pbchg_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '114');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '115', 'p_pbchg_corp_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '115');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '116', 'c_staffopen_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '116');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '117', 'c_staff_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '117');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '118', 'c_staffauth_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '118');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '119', 's_nathldy_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '119');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '121', 'c_plu_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '121');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '123', 's_subtsch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '123');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '125', 'c_recog_grp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '125');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '126', 'p_recog_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '126');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '127', 'c_recoginfo_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '127');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '128', 'c_producer_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '128');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '129', 'c_tax_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '129');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '130', 'c_attrib_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '130');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '131', 'c_attribitem_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '131');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '134', 'p_pbchg_ncorp_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '134');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '138', 'c_report_sql_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '138');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '139', 'c_report_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '139');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '140', 'c_report_cond_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '140');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '141', 'c_report_attr_sub_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '141');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '142', 'c_report_attr_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '142');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '143', 'c_stre_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '143');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '144', 'p_pbchg_stre_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '144');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '145', 'c_connect_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '145');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '147', 'c_prcchg_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '147');''');
  //await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '148', 'p_prcchg_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '148');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '150', 'c_grp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '150');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '151', 'c_cls_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '151');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '152', 's_clssch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '152');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '154', 'c_zipcode_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '154');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '155', 'c_reserv_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '155');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '156', 'c_batrepo_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '156');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '157', 'c_reserv_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '157');''');
  //await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '159', 'p_prcchg_sch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '159');''');
  //await db.execute('''--INSERT INTO c_tcount_mst ($insert_field) SELECT '160', 'p_prcchg_item_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '160');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '161', 'c_histlog_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '161');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '162', 'hist_ctrl_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '162');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '164', 'p_pbchg_ntte_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '164');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '165', 'c_sio_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '165');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '166', 'c_stropncls_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '166');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '167', 'c_stropncls_set_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '167');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '168', 'c_stropncls_sub_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '168');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '169', 'c_header_log_reserv', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '169');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '170', 'c_data_log_reserv', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '170');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '171', 'histlog_skip_num', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '171');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '172', 'c_cust_jdg_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '172'); --@@@''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '173', 'rdly_deal', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '173');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '174', 'rdly_deal_hour', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '174');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '175', 'rdly_flow', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '175');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '176', 'rdly_acr', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '176');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '177', 'rdly_class', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '177');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '178', 'rdly_class_hour', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '178');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '179', 'rdly_plu', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '179');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '180', 'rdly_plu_hour', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '180');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '181', 'rdly_dsc', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '181');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '182', 'rdly_prom', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '182');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '183', 's_backyard_grp_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '183');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '184', 'c_wiz_inf_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '184');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '185', 'rdly_cust', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '185');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '186', 'rdly_svs', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '186');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '187', 's_cust_ttl_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '187');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '188', 's_cust_loy_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '188');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '189', 's_cust_cpn_tbl', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '189');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '190', 's_svs_sch_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '190');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '191', 'c_sub1_cls_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '191');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '192', 'c_sub2_cls_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '192');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '193', 'c_mbrcard_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '193');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '194', 'c_mbrcard_svs_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '194');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '195', 'c_operationauth_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '195');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '196', 'c_operation_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '196');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '197', 'c_payoperator_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '197');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '198', 'rdly_cdpayflow', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '198');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '199', 'rdly_tax_deal', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '199');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '200', 'rdly_tax_deal_hour', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '200');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '201', 'c_liqritem_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '201');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '202', 'c_liqrtax_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '202');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '203', 'c_batprcchg_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '203');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '204', 'c_header_log_floating', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '204');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '205', 'c_data_log_floating', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '205');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '206', 'c_status_log_floating', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '206');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '207', 'c_divide2_mst', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '207');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '208', 'c_hitouch_rcv_log', '0', '', '0', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '208');''');
//
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1000', 'c_void_log_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1000');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1001', 'c_reserv_log_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1001');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1002', 'c_pbchg_log_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1002');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1003', 'c_header_log_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1003');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1004', 'c_header_log_02', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1004');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1005', 'c_header_log_03', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1005');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1006', 'c_header_log_04', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1006');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1007', 'c_header_log_05', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1007');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1008', 'c_header_log_06', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1008');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1009', 'c_header_log_07', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1009');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1010', 'c_header_log_08', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1010');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1011', 'c_header_log_09', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1011');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1012', 'c_header_log_10', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1012');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1013', 'c_header_log_11', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1013');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1014', 'c_header_log_12', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1014');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1015', 'c_header_log_13', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1015');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1016', 'c_header_log_14', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1016');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1017', 'c_header_log_15', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1017');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1018', 'c_header_log_16', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1018');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1019', 'c_header_log_17', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1019');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1020', 'c_header_log_18', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1020');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1021', 'c_header_log_19', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1021');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1022', 'c_header_log_20', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1022');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1023', 'c_header_log_21', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1023');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1024', 'c_header_log_22', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1024');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1025', 'c_header_log_23', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1025');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1026', 'c_header_log_24', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1026');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1027', 'c_header_log_25', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1027');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1028', 'c_header_log_26', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1028');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1029', 'c_header_log_27', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1029');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1030', 'c_header_log_28', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1030');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1031', 'c_header_log_29', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1031');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1032', 'c_header_log_30', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1032');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1033', 'c_header_log_31', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1033');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1034', 'c_data_log_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1034');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1035', 'c_data_log_02', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1035');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1036', 'c_data_log_03', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1036');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1037', 'c_data_log_04', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1037');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1038', 'c_data_log_05', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1038');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1039', 'c_data_log_06', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1039');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1040', 'c_data_log_07', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1040');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1041', 'c_data_log_08', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1041');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1042', 'c_data_log_09', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1042');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1043', 'c_data_log_10', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1043');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1044', 'c_data_log_11', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1044');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1045', 'c_data_log_12', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1045');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1046', 'c_data_log_13', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1046');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1047', 'c_data_log_14', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1047');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1048', 'c_data_log_15', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1048');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1049', 'c_data_log_16', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1049');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1050', 'c_data_log_17', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1050');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1051', 'c_data_log_18', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1051');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1052', 'c_data_log_19', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1052');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1053', 'c_data_log_20', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1053');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1054', 'c_data_log_21', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1054');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1055', 'c_data_log_22', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1055');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1056', 'c_data_log_23', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1056');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1057', 'c_data_log_24', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1057');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1058', 'c_data_log_25', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1058');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1059', 'c_data_log_26', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1059');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1060', 'c_data_log_27', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1060');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1061', 'c_data_log_28', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1061');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1062', 'c_data_log_29', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1062');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1063', 'c_data_log_30', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1063');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1064', 'c_data_log_31', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1064');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1065', 'c_status_log_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1065');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1066', 'c_status_log_02', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1066');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1067', 'c_status_log_03', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1067');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1068', 'c_status_log_04', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1068');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1069', 'c_status_log_05', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1069');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1070', 'c_status_log_06', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1070');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1071', 'c_status_log_07', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1071');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1072', 'c_status_log_08', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1072');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1073', 'c_status_log_09', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1073');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1074', 'c_status_log_10', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1074');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1075', 'c_status_log_11', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1075');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1076', 'c_status_log_12', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1076');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1077', 'c_status_log_13', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1077');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1078', 'c_status_log_14', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1078');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1079', 'c_status_log_15', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1079');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1080', 'c_status_log_16', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1080');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1081', 'c_status_log_17', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1081');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1082', 'c_status_log_18', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1082');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1083', 'c_status_log_19', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1083');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1084', 'c_status_log_20', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1084');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1085', 'c_status_log_21', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1085');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1086', 'c_status_log_22', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1086');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1087', 'c_status_log_23', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1087');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1088', 'c_status_log_24', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1088');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1089', 'c_status_log_25', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1089');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1090', 'c_status_log_26', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1090');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1091', 'c_status_log_27', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1091');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1092', 'c_status_log_28', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1092');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1093', 'c_status_log_29', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1093');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1094', 'c_status_log_30', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1094');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1095', 'c_status_log_31', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1095');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1096', 'c_ej_log_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1096');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1097', 'c_ej_log_02', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1097');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1098', 'c_ej_log_03', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1098');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1099', 'c_ej_log_04', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1099');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1100', 'c_ej_log_05', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1100');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1101', 'c_ej_log_06', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1101');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1102', 'c_ej_log_07', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1102');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1103', 'c_ej_log_08', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1103');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1104', 'c_ej_log_09', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1104');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1105', 'c_ej_log_10', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1105');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1106', 'c_ej_log_11', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1106');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1107', 'c_ej_log_12', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1107');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1108', 'c_ej_log_13', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1108');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1109', 'c_ej_log_14', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1109');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1110', 'c_ej_log_15', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1110');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1111', 'c_ej_log_16', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1111');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1112', 'c_ej_log_17', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1112');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1113', 'c_ej_log_18', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1113');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1114', 'c_ej_log_19', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1114');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1115', 'c_ej_log_20', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1115');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1116', 'c_ej_log_21', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1116');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1117', 'c_ej_log_22', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1117');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1118', 'c_ej_log_23', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1118');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1119', 'c_ej_log_24', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1119');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1120', 'c_ej_log_25', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1120');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1121', 'c_ej_log_26', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1121');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1122', 'c_ej_log_27', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1122');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1123', 'c_ej_log_28', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1123');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1124', 'c_ej_log_29', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1124');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1125', 'c_ej_log_30', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1125');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1126', 'c_ej_log_31', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1126');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1127', 'c_header_log_reserv_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1127');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1128', 'c_data_log_reserv_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1128');''');
  await db.execute('''INSERT INTO c_tcount_mst ($insert_field) SELECT '1129', 'c_status_log_reserv_01', '0', '', '1', '0' WHERE NOT EXISTS ($sub_query tcount_cd = '1129');''');
}
