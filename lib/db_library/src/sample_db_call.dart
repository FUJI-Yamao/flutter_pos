/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:flutter/material.dart';

import 'db_manipulation.dart';
import '../../app/inc/sys/tpr_log.dart';

/// このファイルはライブラリではありません。
/// ライブラリを使う場合の例として作っていますので呼び出し方の参考にしてください。
///　またDBライブラリの制作に伴って梶原が更新していくので、このファイルの修正はしないでください。

sampleDBCall() async {
  var dbAccess1 = DbManipulation();

  //★insert例1
  //企業マスタに１つレコード追加
  debugPrint('★insertの呼び方');
  //別名を使って設定用テーブルクラスのインスタンスを作成
  CCompMst comp = CCompMst();
  comp.comp_typ = 100;
  // comp.name = "SQNY";
  // comp.post_no = "1400014";
  comp.name = "SONY";
  comp.post_no = "1234567";

  await dbAccess1.insert(comp);

  //★insert例2
  //実績ジャーナルデータログクラスの全データ取得後、そのレコード数を使って1つレコード追加
  debugPrint('★selectAllDataで行数取得後に、insertを呼ぶ');
  CEjLog ejLog = CEjLog();
  List<CEjLogColumns> ejLogAllRtn = await dbAccess1.selectAllData(ejLog);
  ejLog.print_data = 'Sample1';
  //ここのseq_noを毎回変えないとエラーになります！(キーの一部なので)
  ejLog.seq_no = ejLogAllRtn.length + 1;

  await dbAccess1.insert(ejLog);

  // 確認
  // await dbAccess1.transaction(
  //     dbAccess1.selectAllData(journal);
  // );

  //await dbAccess1.transaction((string s) => print(s);)

  //★selectDataByPrimaryKeyの呼び方例
  //企業マスタのインスタンスにキー値を入れて、キーによるレコード取得を行う
  debugPrint('★selectDataByPrimaryKeyの呼び方例');
  CCompMst compMst = CCompMst();
  //Keyの値を設定する
  compMst.comp_cd = 1;
  //キーを指定して取得するテーブルクラスのインスタンスを入れる。
  CCompMstColumns? compMstRtn = await dbAccess1.selectDataByPrimaryKey(compMst);
  //取得行がない場合、nullが帰ってきます
  if (compMstRtn == null) {
    debugPrint('企業マスタのcomp_cd = 1での取得レコードなし');
  } else {
    //中身の取り出し例
    debugPrint('キーで指定して取得した企業マスタのcomp_cdの中身は${compMstRtn.comp_cd}');
    debugPrint('キーで指定して取得した企業マスタのcomp_typの中身は${compMstRtn.comp_typ}');
    debugPrint('キーで指定して取得した企業マスタのrtr_idの中身は${compMstRtn.rtr_id}');
    debugPrint('キーで指定して取得した企業マスタのnameの中身は${compMstRtn.name}');
  }

  //★selectAllDataの呼び方例
  //企業マスタのインスタンスを渡して全データ取得を行う
  debugPrint('★selectAllDataの呼び方例');
  CCompMst compMstAll = CCompMst();
  //全取得したいテーブルクラスのインスタンスを入れる。
  List<CCompMstColumns> compMstAllRtn =
      await dbAccess1.selectAllData(compMstAll);
  //中身の取り出し例
  if (compMstAllRtn.isEmpty) {
    debugPrint('企業マスタは空');
  }
  // この形で取得すると、compMstAllRtn.isEmpty　がtrueの時、compMstAllRtn.lengthが0なので中のdebugPrintが実行されません
  for (int i = 0; i < compMstAllRtn.length; i++) {
    debugPrint('取得した企業マスタのcomp_cdの$i番目の中身は${compMstAllRtn[i].comp_cd}');
    debugPrint('取得した企業マスタのcomp_typの$i番目の中身は${compMstAllRtn[i].comp_typ}');
    debugPrint('取得した企業マスタのrtr_idの$i番目の中身は${compMstAllRtn[i].rtr_id}');
    debugPrint('取得した企業マスタのnameの$i番目の中身は${compMstAllRtn[i].name}');
  }

  //★selectAllDataの呼び方例2
  //実績ジャーナルデータログのインスタンスを渡して全データ取得を行う
  debugPrint('★selectAllDataの呼び方例2');
  CEjLog ejLog2 = CEjLog();
  List<CEjLogColumns> ejLogAllRtn2 = await dbAccess1.selectAllData(ejLog2);
  //中身の取り出し例
  for (int i = 0; i < ejLogAllRtn2.length; i++) {
    debugPrint('取得した実績ジャーナルデータログのcomp_cdの$i番目の中身は${ejLogAllRtn2[i].comp_cd}');
    debugPrint(
        '取得した実績ジャーナルデータログのserial_noの$i番目の中身は${ejLogAllRtn2[i].serial_no}');
    debugPrint('取得した実績ジャーナルデータログのseq_noの$i番目の中身は${ejLogAllRtn2[i].seq_no}');
    debugPrint(
        '取得した実績ジャーナルデータログのprint_dataの$i番目の中身は${ejLogAllRtn2[i].print_data}');
  }

  //★selectDataByPrimaryKeyの呼び方例2
  //プリセットキーマスタのインスタンスにキー値を入れて、キーによるレコード取得を行う
  debugPrint('★selectDataByPrimaryKeyの呼び方例2');
  CPresetMst presetMst = CPresetMst();
  // 複合キーの場合、すべてのキーに値を入れること！
  presetMst.comp_cd = 1;
  presetMst.stre_cd = 2;
  presetMst.preset_grp_cd = 3;
  presetMst.preset_cd = 4;
  presetMst.preset_no = 5;
  CPresetMstColumns? presetMstRtn =
      await dbAccess1.selectDataByPrimaryKey(presetMst);
  if (presetMstRtn == null) {
    debugPrint('取得レコードなし');
  } else {
    debugPrint('取得したプリセットマスタのレコードは${presetMstRtn.comp_cd}');
  }

  //★selectAllDataの呼び方例3
  //プリセットキーマスタのインスタンスを渡して全データ取得を行う
  debugPrint('★selectAllDataの呼び方例3');
  List<CPresetMstColumns> presetMstAllRtn =
      await dbAccess1.selectAllData(presetMst);
  //中身の取り出し例
  if (presetMstAllRtn.isEmpty) {
    debugPrint('プリセットマスタは空');
  }
  for (int i = 0; i < presetMstAllRtn.length; i++) {
    debugPrint('取得したプリセットマスタのcomp_cdの$i番目の中身は${presetMstAllRtn[i].comp_cd}');
    debugPrint('取得したプリセットマスタのimg_numの$i番目の中身は${presetMstAllRtn[i].img_num}');
  }

  //★selectDataWithWhereClauseの呼び方(where句だけを使う場合)
  //企業マスタのインスタンスとWhere文の条件を渡して、レコード取得を行う
  debugPrint('★selectDataWithWhereClauseの呼び方(where句だけを使う場合)');
  CCompMst compMst1 = CCompMst();
  String whereClause1 = "name = 'SQNY' AND post_no = '1400014'";
  List<CCompMstColumns> compMstRtn1 =
      await dbAccess1.selectDataWithWhereClause(compMst1, whereClause1);
  for (int i = 0; i < compMstRtn1.length; i++) {
    debugPrint('取得した企業マスタのcomp_cdの$i番目の中身は${compMstRtn1[i].comp_cd}');
    debugPrint('取得した企業マスタのcomp_typの$i番目の中身は${compMstRtn1[i].comp_typ}');
    debugPrint('取得した企業マスタのrtr_idの$i番目の中身は${compMstRtn1[i].rtr_id}');
    debugPrint('取得した企業マスタのnameの$i番目の中身は${compMstRtn1[i].name}');
  }

  //★selectDataWithWhereClauseの呼び方(where句とwhereArgsを使う場合)
  //企業マスタのインスタンスとWhere文の条件とwhereArgsを渡して、レコード取得を行う
  debugPrint('★selectDataWithWhereClauseの呼び方(where句とwhereArgsを使う場合)');
  CCompMst compMst2 = CCompMst();
  String whereClause2 = "name = ? AND post_no = ?";
  List argsList = [];
  argsList.add('SONY');
  argsList.add('1234567');
  List<CCompMstColumns> compMstRtn2 = await dbAccess1
      .selectDataWithWhereClause(compMst2, whereClause2, whereArgs: argsList);
  for (int i = 0; i < compMstRtn2.length; i++) {
    debugPrint('取得した企業マスタのcomp_cdの$i番目の中身は${compMstRtn2[i].comp_cd}');
    debugPrint('取得した企業マスタのcomp_typの$i番目の中身は${compMstRtn2[i].comp_typ}');
    debugPrint('取得した企業マスタのrtr_idの$i番目の中身は${compMstRtn2[i].rtr_id}');
    debugPrint('取得した企業マスタのnameの$i番目の中身は${compMstRtn2[i].name}');
  }

  //★update例1
  //企業マスタのレコードを更新
  debugPrint('★updateの呼び方(where句だけを使う場合)');
  //別名を使って設定用テーブルクラスのインスタンスを作成
  CCompMst compMst3 = CCompMst();
  //SET xxに当たる部分。
  Map<String, Object?> map = {};
  map[CCompMstField.comp_typ] = 100;
  map[CCompMstField.name] = "SQNY";
  map[CCompMstField.post_no] = "1400014";
  //Where文にあたる部分
  String whereClause3 = "name = 'SONY' AND post_no = '1234567'";
  await dbAccess1.update(compMst3, map, whereClause: whereClause3);

  //★update例2
  //プリセットマスタのレコードを更新
  debugPrint('★updateの呼び方(where句とwhereArgsを使う場合)');
  //別名を使って設定用テーブルクラスのインスタンスを作成
  CPresetMst presetMst4 = CPresetMst();
  //SET xxに当たる部分。
  Map<String, Object?> map4 = {};
  map4[CPresetMstField.presetcolor] = 100;
  //Where文にあたる部分
  String whereClause4 = "stre_cd IN (?,?,?)";
  //WhereArgsにあたる部分
  List argsList4 = [];
  argsList4.add('1');
  argsList4.add('2');
  argsList4.add('3');
  await dbAccess1.update(presetMst4, map4,
      whereClause: whereClause4, whereArgs: argsList4);

  //★update例3
  //実績ジャーナルデータログのレコードを更新
  debugPrint('★updateの呼び方(テーブル名のみを使う場合)');
  //別名を使って設定用テーブルクラスのインスタンスを作成
  CEjLog ejLog5 = CEjLog();
  //SET xxに当たる部分。
  Map<String, Object?> map5 = {};
  map5[CEjLogField.sale_date] = "20221102";
  await dbAccess1.update(ejLog5, map5);

  //★delete例1
  //企業マスタのレコードを削除
  debugPrint('★deleteの呼び方(where句だけを使う場合)');
  //別名を使って設定用テーブルクラスのインスタンスを作成
  CCompMst compMst5 = CCompMst();
  String whereClause5 = "name = 'SONY' AND post_no = '1234567'";
  await dbAccess1.delete(compMst5, whereClause: whereClause5);

  //★delete例2
  //プリセットマスタのレコードを削除
  debugPrint('★deleteの呼び方(where句とwhereArgsを使う場合)');
  //別名を使って設定用テーブルクラスのインスタンスを作成
  CPresetMst presetMst3 = CPresetMst();
  String whereClause6 = "stre_cd = ? AND preset_no = ?";
  List argsList6 = [];
  argsList6.add('2');
  argsList6.add('5');
  await dbAccess1.delete(presetMst3,
      whereClause: whereClause6, whereArgs: argsList6);

  //★delete例3
  //実績ジャーナルデータログのレコードを削除
  debugPrint('★deleteの呼び方(テーブル名のみを使う場合)');
  //別名を使って設定用テーブルクラスのインスタンスを作成
  CEjLog ejLog7 = CEjLog();
  await dbAccess1.delete(ejLog7);

  //await dbAccess1.closeDB();
}

sampleDBCall2() async{
  var dbAccess2 = DbManipulation();
  //await dbAccess2.openDB();   //2回目呼んでも問題はない

  debugPrint('★sampleDBCall2の呼び方例');
  //★selectAllDataの呼び方例
  //企業マスタのインスタンスを渡して全データ取得を行う
  debugPrint('★sampleDBCall2★selectAllDataの呼び方例');
  CCompMst compMstAll = CCompMst();
  //全取得したいテーブルクラスのインスタンスを入れる。
  List<CCompMstColumns> compMstAllRtn =
      await dbAccess2.selectAllData(compMstAll);
  //中身の取り出し例
  if (compMstAllRtn.isEmpty) {
    debugPrint('★sampleDBCall2企業マスタは空');
  }
  // この形で取得すると、compMstAllRtn.isEmpty　がtrueの時、compMstAllRtn.lengthが0なので中のdebugPrintが実行されません
  for (int i = 0; i < compMstAllRtn.length; i++) {
    debugPrint('★sampleDBCall2取得した企業マスタのcomp_cdの$i番目の中身は${compMstAllRtn[i].comp_cd}');
    debugPrint('★sampleDBCall2取得した企業マスタのcomp_typの$i番目の中身は${compMstAllRtn[i].comp_typ}');
    debugPrint('★sampleDBCall2取得した企業マスタのrtr_idの$i番目の中身は${compMstAllRtn[i].rtr_id}');
    debugPrint('★sampleDBCall2取得した企業マスタのnameの$i番目の中身は${compMstAllRtn[i].name}');
  }
}

sampleDBCall3() async{
  var dbAccess3 = DbManipulation();

  //企業マスタをクローン確認
  // TprLog().logAdd(0, LogLevelDefine.normal, 'update()で更新対象のデータは${map.toString()}');
  TprLog().logAdd(0, LogLevelDefine.normal, 'クローンメソッド確認');
  //別名を使って設定用テーブルクラスのインスタンスを作成
  CCompMst comp = CCompMst();
  comp.comp_typ = 100;
  // comp.name = "SQNY";
  // comp.post_no = "1400014";
  comp.name = "SONY";
  comp.post_no = "1234567";

  CCompMst? compClone;
  compClone = dbAccess3.cloneRecord(comp);

  if (compClone == null) {
    debugPrint('compCloneなし');
  } else {
    //中身の取り出し例
    debugPrint('compCloneのcomp_cdの中身は${compClone.comp_cd}');
    debugPrint('compCloneのcomp_typの中身は${compClone.comp_typ}');
    debugPrint('compCloneのrtr_idの中身は${compClone.rtr_id}');
    debugPrint('compCloneのnameの中身は${compClone.name}');
  }


}

sampleDBCall4() async{
  var dbAccess4 = DbManipulation();
  TprLog().logAdd(0, LogLevelDefine.normal, 'クローンリストメソッド確認');

  CCompMst comp = CCompMst();
  comp.comp_typ = 100;
  // comp.name = "SQNY";
  // comp.post_no = "1400014";
  comp.name = "SONY";
  comp.post_no = "1234567";

  CCompMst comp2 = CCompMst();
  comp2.comp_typ = 200;
  // comp.name = "SQNY";
  // comp.post_no = "1400014";
  comp2.name = "SQNY";
  comp2.post_no = "2234567";

  List<CCompMst> lccm = <CCompMst>[];
  lccm.add(comp);
  lccm.add(comp2);

  List<CCompMst>? compCloneList;
  compCloneList = dbAccess4.cloneRecordList(lccm);

  for (int i = 0; i < compCloneList.length; i++) {
    debugPrint('compCloneListのcomp_cdの中身は${compCloneList[i].comp_cd}');
    debugPrint('compCloneListのcomp_typの中身は${compCloneList[i].comp_typ}');
    debugPrint('compCloneListのrtr_idの中身は${compCloneList[i].rtr_id}');
    debugPrint('compCloneListのnameの中身は${compCloneList[i].name}');
  }
  debugPrint('lccmのhashは${lccm.hashCode}');
  debugPrint('compCloneListのhashは${compCloneList.hashCode}');
}

