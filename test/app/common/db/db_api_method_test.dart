/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import '../cls_conf/unitTestParts.dart';
import 'package:flutter_pos/db_library/src/db_manipulation.dart';

/*
本テストでは、db_apiのmethodを対象にする
 */
Future<void> main() async{
  await other_table_test();
}

Future<void> other_table_test() async
{
  TestWidgetsFlutterBinding.ensureInitialized();

  var db = DbManipulation();

  group('other_table',()
  {
    setUpAll(() async{
      PathProviderPlatform.instance = MockPathProviderPlatform();
      await db.openDB();
    });
    setUp(() async{
    });

    // 各テストの事後処理
    tearDown(() async{
    });

    tearDownAll(() async{
      await db.closeDB();
    });

    // ********************************************************
    // テストmethod001 : transaction
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method001_transaction_01', () async {
      print('\n********** テスト実行：method001_transaction_01 **********');
      await db.makeTransaction((txn) async{
        CStatusLog ins01 = CStatusLog();
        ins01.serial_no = 'ser01';
        ins01.seq_no = 2;
        ins01.status_data = 'STATUS';
        //txnを使ったinsertを実施
        await db.insert(ins01,txn: txn);
        //txnを使って入れたものをselectDataByPrimaryKey
        CStatusLog sel01 = CStatusLog();
        sel01.serial_no = 'ser01';
        sel01.seq_no = 2;
        CStatusLog? sel02 = await db.selectDataByPrimaryKey(sel01,txn: txn);
        expect(sel02?.status_data,'STATUS');
        //txnを使ってupdate
        CStatusLog upd01 = CStatusLog();
        Map<String, Object?> map = {};
        map[CStatusLogField.seq_no] = 4;
        await db.update(upd01,map,txn: txn);
        //txnを使ってdelete
        await db.delete(upd01,txn: txn);
      });
      CStatusLog out01 = CStatusLog();
      List<CStatusLog> rtn01 = await db.selectAllData(out01);
      if(rtn01.isEmpty){
        print('正常：CStatusLogは空');
      }
      print('********** テスト終了：method001_transaction_01 **********\n\n');
    });

    // ********************************************************
    // テストmethod002 : rollback
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method002_rollback_01', () async {
      print('\n********** テスト実行：method002_rollback_01 **********');
      //selectKeyを使ってデータがあるか確認
      CAcctMst int02 = CAcctMst();
      int02.acct_cd = 89;
      int02.mthr_acct_cd = 90;
      int02.comp_cd = 15;
      int02.stre_cd = 16;
      CAcctMst? sel02 = await db.selectDataByPrimaryKey(int02);
      if(sel02 == null){
        print('初期データなし');
      }
      //txnを使ったinsertを実施
      await db.makeTransaction((txn) async{
        CAcctMst txn02 = CAcctMst();
        txn02.acct_cd = 89;
        txn02.mthr_acct_cd = 90;
        txn02.comp_cd = 15;
        txn02.stre_cd = 16;
        db.insert(txn02,txn: txn);
        //txnを使ったrollbackを実施
        db.rollback();
      });
      //selectKeyを使ってデータがあるか確認
      CAcctMst? sel02_2 = await db.selectDataByPrimaryKey(int02);
      expect(sel02_2,null);
      print('********** テスト終了：method002_rollback_01 **********\n\n');
    });

    // ********************************************************
    // テストmethod003 : insert_txn
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method003_insert_txn_01', () async {
      print('\n********** テスト実行：method003_insert_txn_01 **********');

      CKeykindMst ins01 = CKeykindMst();
      ins01.key_kind_cd = 109;
      ins01.kind_name = 'method003';
      CKeykindMst sel02 = CKeykindMst();
      sel02.key_kind_cd = 109;
      await db.makeTransaction((txn) async{
        //txnを使ったinsertを実施
        await db.insert(ins01,txn:txn);
        //selectKeyを使ってデータがあるか確認
        CKeykindMst? rtn03 = await db.selectDataByPrimaryKey(sel02,txn:txn);
        //取得行がない場合、nullが返ってきます
        if (rtn03 == null) {
          print('\n********** 異常発生：method003_insert_txn_01 **********');
        } else {
          //insertで入れたデータを期待値とし照合
          expect(rtn03?.key_kind_cd,109);
          expect(rtn03?.kind_name,'method003');
        }
        //await db.delete(sel02,txn:txn);
      });
      print('********** テスト終了：method003_insert_txn_01 **********\n\n');
    });

    // ********************************************************
    // テストmethod004 : update
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method004_update_01', () async {
      print('\n********** テスト実行：method004_update_01 **********');
      CKeykindMst upd01 = CKeykindMst();
      String whereClause01 = "key_kind_cd = 109";
      //selectDataWithWhereClauseでデータ確認
      List<CKeykindMst> sel02 = await db.selectDataWithWhereClause(upd01, whereClause01);
      print('取得したsel02の中身は${sel02[0].key_kind_cd}と${sel02[0].kind_name}');
      //引数tcとmapでupdate
      CKeykindMst upd03 = CKeykindMst();
      Map<String, Object?> map = {};
      map[CKeykindMstField.kind_name] = 'method004_update';
      await db.update(upd03,map);
      //selectDataWithWhereClauseを使って変化したデータがあるか確認
      List<CKeykindMst> sel04 = await db.selectDataWithWhereClause(upd01, whereClause01);
      print('取得したsel04の中身は${sel04[0].key_kind_cd}と${sel04[0].kind_name}');
      expect(sel04[0].kind_name,'method004_update');
      print('********** テスト終了：method004_update_01 **********\n\n');

      print('\n********** テスト実行：method004_update_02 **********');
      CKeykindMst upd05 = CKeykindMst();
      String whereClause05 = "key_kind_cd = 109";
      //selectDataWithWhereClauseでデータ確認
      List<CKeykindMst> sel06 = await db.selectDataWithWhereClause(upd05, whereClause05);
      print('取得したsel06の中身は${sel06[0].key_kind_cd}と${sel06[0].kind_name}');
      //引数tcとmapでupdate
      CKeykindMst upd07 = CKeykindMst();
      Map<String, Object?> map7 = {};
      map7[CKeykindMstField.kind_name] = 'method004_update_02';
      String whereClause07 = "key_kind_cd = 109";
      await db.update(upd07,map7,whereClause: whereClause07);
      //selectDataWithWhereClauseを使って変化したデータがあるか確認
      List<CKeykindMst> sel08 = await db.selectDataWithWhereClause(upd05, whereClause05);
      print('取得したsel08の中身は${sel08[0].key_kind_cd}と${sel08[0].kind_name}');
      expect(sel08[0].kind_name,'method004_update_02');
      print('********** テスト終了：method004_update_02 **********\n\n');

      print('\n********** テスト実行：method004_update_03 **********');
      CKeykindMst upd09 = CKeykindMst();
      String whereClause09 = "key_kind_cd = 109";
      //selectDataWithWhereClauseでデータ確認
      List<CKeykindMst> sel10 = await db.selectDataWithWhereClause(upd09, whereClause09);
      print('取得したsel10の中身は${sel10[0].key_kind_cd}と${sel10[0].kind_name}');
      //引数tcとmapとwhereClauseとwhereArgsでupdate
      CKeykindMst upd11 = CKeykindMst();
      Map<String, Object?> map11 = {};
      map11[CKeykindMstField.kind_name] = 'method004_update_03';
      String whereClause11 = "key_kind_cd = ?";
      List argsList11 = [];
      argsList11.add('109');
      await db.update(upd11,map11,whereClause: whereClause11,whereArgs: argsList11);
      //selectDataWithWhereClauseでデータ確認
      List<CKeykindMst> sel12 = await db.selectDataWithWhereClause(upd09, whereClause09);
      print('取得したsel12の中身は${sel12[0].key_kind_cd}と${sel12[0].kind_name}');
      expect(sel12[0].kind_name,'method004_update_03');
      print('********** テスト終了：method004_update_03 **********\n\n');
    });

    // ********************************************************
    // テストmethod005 : update_txn
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method005_update_txn_01', () async {
      print('\n********** テスト実行：method005_update_01 **********');
      CKeykindMst upd01 = CKeykindMst();
      String whereClause01 = "key_kind_cd = 109";
      //selectDataWithWhereClauseでデータ確認
      await db.makeTransaction((txn) async{
        List<CKeykindMst> sel02 = await db.selectDataWithWhereClause(upd01, whereClause01,txn:txn);
        print('取得したsel02の中身は${sel02[0].key_kind_cd}と${sel02[0].kind_name}');
        //引数tcとmapでupdate
        CKeykindMst upd03 = CKeykindMst();
        Map<String, Object?> map = {};
        map[CKeykindMstField.kind_name] = 'method005_update';
        await db.update(upd03,map,txn:txn);
        //selectDataWithWhereClauseを使って変化したデータがあるか確認
        List<CKeykindMst> sel04 = await db.selectDataWithWhereClause(upd01, whereClause01,txn:txn);
        print('取得したsel04の中身は${sel04[0].key_kind_cd}と${sel04[0].kind_name}');
        expect(sel04[0].kind_name,'method005_update');
      });
      print('********** テスト終了：method005_update_txn_01 **********\n\n');

      print('\n********** テスト実行：method005_update_txn_02 **********');
      CKeykindMst upd05 = CKeykindMst();
      String whereClause05 = "key_kind_cd = 109";
      //selectDataWithWhereClauseでデータ確認
      await db.makeTransaction((txn) async{
        List<CKeykindMst> sel06 = await db.selectDataWithWhereClause(upd05, whereClause05,txn:txn);
        print('取得したsel06の中身は${sel06[0].key_kind_cd}と${sel06[0].kind_name}');
        //引数tcとmapでupdate
        CKeykindMst upd07 = CKeykindMst();
        Map<String, Object?> map7 = {};
        map7[CKeykindMstField.kind_name] = 'method005_update_02';
        String whereClause07 = "key_kind_cd = 109";
        await db.update(upd07,map7,whereClause: whereClause07,txn:txn);
        //selectDataWithWhereClauseを使って変化したデータがあるか確認
        List<CKeykindMst> sel08 = await db.selectDataWithWhereClause(upd05, whereClause05,txn:txn);
        print('取得したsel08の中身は${sel08[0].key_kind_cd}と${sel08[0].kind_name}');
        expect(sel08[0].kind_name,'method005_update_02');
      });
      print('********** テスト終了：method005_update_txn_02 **********\n\n');

      print('\n********** テスト実行：method005_update_txn_03 **********');
      //selectDataWithWhereClauseでデータ確認
      CKeykindMst upd09 = CKeykindMst();
      String whereClause09 = "key_kind_cd = 109";
      //selectDataWithWhereClauseでデータ確認
      await db.makeTransaction((txn) async{
        List<CKeykindMst> sel10 = await db.selectDataWithWhereClause(upd09, whereClause09,txn:txn);
        print('取得したsel10の中身は${sel10[0].key_kind_cd}と${sel10[0].kind_name}');
        //引数tcとmapとwhereClauseとwhereArgsでupdate
        CKeykindMst upd11 = CKeykindMst();
        Map<String, Object?> map11 = {};
        map11[CKeykindMstField.kind_name] = 'method004_update_03';
        String whereClause11 = "key_kind_cd = ?";
        List argsList11 = [];
        argsList11.add('109');
        await db.update(upd11,map11,whereClause: whereClause11,whereArgs: argsList11,txn:txn);
        //selectDataWithWhereClauseでデータ確認
        List<CKeykindMst> sel12 = await db.selectDataWithWhereClause(upd09, whereClause09,txn:txn);
        print('取得したsel12の中身は${sel12[0].key_kind_cd}と${sel12[0].kind_name}');
        expect(sel12[0].kind_name,'method004_update_03');
      });
      print('********** テスト終了：method005_update_txn_03 **********\n\n');
    });

    // ********************************************************
    // テストmethod006 : delete
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method006_delete_01', () async {
      print('\n********** テスト実行：method006_delete_01 **********');
      //selectDataWithWhereClauseでデータ確認
      CKeykindMst del01 = CKeykindMst();
      String whereClause1 = "key_kind_cd = 109";
      List<CKeykindMst> sel02 = await db.selectDataWithWhereClause(del01, whereClause1);
      print('CKeykindMstテーブルのレコードが、${sel02.length}レコード存在する');
      expect(sel02.length,1);
      //引数tcとmapでdelete
      await db.delete(del01);
      //selectDataWithWhereClauseを使ってデータが削除されたか確認
      List<CKeykindMst> sel03 = await db.selectDataWithWhereClause(del01, whereClause1);
      print('CKeykindMstテーブルのレコードが、${sel03.length}レコード存在する');
      expect(sel03.length,0);
      print('********** テスト終了：method006_delete_01 **********\n\n');

      print('\n********** テスト実行：method006_delete_02 **********');
      CFinitGrpMst ins04 = CFinitGrpMst();
      ins04.finit_grp_cd = 211;
      ins04.finit_grp_name = 'method06';
      CFinitGrpMst ins05 = CFinitGrpMst();
      ins05.finit_grp_cd = 212;
      ins05.finit_grp_name = 'method06_02';
      await db.insert(ins04);
      await db.insert(ins05);
      //selectDataWithWhereClauseでデータ確認
      CFinitGrpMst del06 = CFinitGrpMst();
      String whereClause06 = "finit_grp_name = 'method06'";
      List<CFinitGrpMst> sel07 = await db.selectDataWithWhereClause(del06, whereClause06);
      print('CFinitGrpMstテーブルのレコードが、${sel07.length}レコード存在する');
      expect(sel07.length,1);
      //引数tcとmapとwhereClauseでdelete
      await db.delete(del06,whereClause: whereClause06);
      //selectDataWithWhereClauseを使ってデータが削除されたか確認
      List<CFinitGrpMst> sel08 = await db.selectDataWithWhereClause(del06, whereClause06);
      print('CFinitGrpMstテーブルのレコードが、${sel08.length}レコード存在する');
      expect(sel08.length,0);
      print('********** テスト終了：method006_delete_02 **********\n\n');

      print('\n********** テスト実行：method006_delete_03 **********');
      CFinitGrpMst del09 = CFinitGrpMst();
      String whereClause09 = "finit_grp_name = 'method06_02'";
      List argsList09 = [];
      argsList09.add('method06_02');
      List<CFinitGrpMst> sel10 = await db.selectDataWithWhereClause(del09, whereClause09);
      print('CFinitGrpMstテーブルのレコードが、${sel10.length}レコード存在する');
      expect(sel10.length,1);
      //引数tcとmapとwhereClauseでdelete
      String whereClause09_2 = "finit_grp_name = ?";
      await db.delete(del09,whereClause: whereClause09_2,whereArgs: argsList09);
      //selectDataWithWhereClauseを使ってデータが削除されたか確認
      List<CFinitGrpMst> sel11 = await db.selectDataWithWhereClause(del09, whereClause09);
      print('CFinitGrpMstテーブルのレコードが、${sel11.length}レコード存在する');
      expect(sel11.length,0);
      print('********** テスト終了：method006_update_03 **********\n\n');
    });

    // ********************************************************
    // テストmethod007 : delete_txn
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method007_delete_txn_01', () async {
      print('\n********** テスト実行：method007_delete_txn_01 **********');
      //selectDataWithWhereClauseでデータ確認
      CKeykindMst del01 = CKeykindMst();
      String whereClause1 = "key_kind_cd = 109";
      await db.makeTransaction((txn) async{
        List<CKeykindMst> sel02 = await db.selectDataWithWhereClause(del01, whereClause1,txn: txn);
        print('CKeykindMstテーブルのレコードが、${sel02.length}レコード存在する');
        expect(sel02.length,0);
        //引数tcとmapでdelete
        await db.delete(del01,txn: txn);
        //selectDataWithWhereClauseを使ってデータが削除されたか確認
        List<CKeykindMst> sel03 = await db.selectDataWithWhereClause(del01, whereClause1,txn: txn);
        print('CKeykindMstテーブルのレコードが、${sel03.length}レコード存在する');
        expect(sel03.length,0);
      });
      print('********** テスト終了：method007_delete_txn_01 **********\n\n');
      print('\n********** テスト実行：method007_delete_txn_02 **********');
      await db.makeTransaction((txn) async{
        CFinitGrpMst ins04 = CFinitGrpMst();
        ins04.finit_grp_cd = 211;
        ins04.finit_grp_name = 'method07';
        CFinitGrpMst ins05 = CFinitGrpMst();
        ins05.finit_grp_cd = 212;
        ins05.finit_grp_name = 'method07_02';
        await db.insert(ins04,txn: txn);
        await db.insert(ins05,txn: txn);
        //selectDataWithWhereClauseでデータ確認
        CFinitGrpMst del06 = CFinitGrpMst();
        String whereClause06 = "finit_grp_name = 'method07'";
        List<CFinitGrpMst> sel07 = await db.selectDataWithWhereClause(del06, whereClause06,txn: txn);
        print('CFinitGrpMstテーブルのレコードが、${sel07.length}レコード存在する');
        expect(sel07.length,1);
        //引数tcとmapとwhereClauseでdelete
        await db.delete(del06,whereClause: whereClause06,txn: txn);
        //selectDataWithWhereClauseを使ってデータが削除されたか確認
        List<CFinitGrpMst> sel08 = await db.selectDataWithWhereClause(del06, whereClause06,txn: txn);
        print('CFinitGrpMstテーブルのレコードが、${sel08.length}レコード存在する');
        expect(sel08.length,0);
      });
      print('********** テスト終了：method007_delete_txn_02 **********\n\n');
      print('\n********** テスト実行：method007_delete_txn_03 **********');
      await db.makeTransaction((txn) async{
        CFinitGrpMst del09 = CFinitGrpMst();
        String whereClause09 = "finit_grp_name = 'method07_02'";
        List argsList09 = [];
        argsList09.add('method07_02');
        List<CFinitGrpMst> sel10 = await db.selectDataWithWhereClause(del09, whereClause09,txn: txn);
        print('CFinitGrpMstテーブルのレコードが、${sel10.length}レコード存在する');
        expect(sel10.length,1);
        //引数tcとmapとwhereClauseでdelete
        String whereClause09_2 = "finit_grp_name = ?";
        await db.delete(del09,whereClause: whereClause09_2,whereArgs: argsList09,txn: txn);
        //selectDataWithWhereClauseを使ってデータが削除されたか確認
        List<CFinitGrpMst> sel11 = await db.selectDataWithWhereClause(del09, whereClause09,txn: txn);
        print('CFinitGrpMstテーブルのレコードが、${sel11.length}レコード存在する');
        expect(sel11.length,0);
      });
      print('********** テスト終了：method007_update_txn_03 **********\n\n');
    });

    // ********************************************************
    // テストmethod008 : selectAllData
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method008_selectAllData_01', () async {
      print('\n********** テスト実行：method008_selectAllData_01 **********');
      CHistlogChgCnt ins01 = CHistlogChgCnt();
      ins01.counter_cd = 345;
      ins01.hist_cd = 34;
      ins01.ins_datetime = '2023/04/28';
      db.insert(ins01);
      CHistlogChgCnt ins02 = CHistlogChgCnt();
      ins02.counter_cd = 346;
      ins02.hist_cd = 34;
      ins02.ins_datetime = '2023/04/29';
      db.insert(ins02);
      //selectAllDataを実施
      CHistlogChgCnt sel03 = CHistlogChgCnt();
      List<CHistlogChgCnt> sel04 = await db.selectAllData(sel03);
      if(sel04.isEmpty){
        print('異常：CHistlogChgCntは空');
      }else{
        for(int i=0; i < sel04.length;i++){
          print(sel04[i].counter_cd);
          print(sel04[i].hist_cd);
          print(sel04[i].ins_datetime);
        }
        expect(sel04.length,2);
      }
      print('********** テスト終了：method008_selectAllData_01 **********\n\n');
    });

    // ********************************************************
    // テストmethod009 : selectAllData_txn
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method009_selectAllData_txn_01', () async {
      print('\n********** テスト実行：method009_selectAllData_txn_01 **********');
      await db.makeTransaction((txn) async{
        //selectAllDataを実施
        CHistlogChgCnt sel03 = CHistlogChgCnt();
        List<CHistlogChgCnt> sel04 = await db.selectAllData(sel03,txn: txn);
        if(sel04.isEmpty){
          print('異常：CHistlogChgCntは空');
        }else{
          for(int i=0; i < sel04.length;i++){
            print(sel04[i].counter_cd);
            print(sel04[i].hist_cd);
            print(sel04[i].ins_datetime);
          }
          expect(sel04.length,2);
        }
        await db.delete(sel03,txn: txn);
      });

      print('********** テスト終了：method009_selectAllData_txn_01 **********\n\n');
    });

    // ********************************************************
    // テストmethod010 : selectDataWithWhereClause
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method010_selectDataWithWhereClause_01', () async {
      print('\n********** テスト実行：method010_selectDataWithWhereClause_01 **********');
      //引数tc,whereClauseでselectDataWithWhereClauseを実施
      CKeykindMst mst10 = CKeykindMst();
      mst10.key_kind_cd = 88;
      mst10.kind_name = 'mst10_test';
      await db.insert(mst10);
      CKeykindMst sel10 = CKeykindMst();
      String whereClause10_1 = "kind_name = 'mst10_test'";
      List<CKeykindMst> rtn10 = await db.selectDataWithWhereClause(sel10,whereClause10_1);
      if(rtn10.isEmpty){
        print('異常：CKeykindMstは空');
      }else{
        for(int i=0; i < rtn10.length;i++){
          print(rtn10[i].key_kind_cd);
          print(rtn10[i].kind_name);
          expect(rtn10[i].key_kind_cd,88);
          expect(rtn10[i].kind_name,'mst10_test');
        }
      }
      print('********** テスト終了：method010_selectDataWithWhereClause_01 **********\n\n');
      print('\n********** テスト実行：method010_selectDataWithWhereClause_02 **********');
      //引数tc,whereClause,whereArgsでselectDataWithWhereClauseを実施
      CKeykindMst mst10_2 = CKeykindMst();
      mst10_2.key_kind_cd = 99;
      mst10_2.kind_name = 'mst10_test2';
      await db.insert(mst10_2);
      CKeykindMst sel10_2 = CKeykindMst();
      String whereClause10_2 = "kind_name = ?";
      List argsList10_2 = [];
      argsList10_2.add('mst10_test2');
      List<CKeykindMst> rtn10_2 = await db.selectDataWithWhereClause(sel10_2,whereClause10_2,whereArgs: argsList10_2);
      if(rtn10_2.isEmpty){
        print('異常：CKeykindMstは空');
      }else{
        for(int i=0; i < rtn10_2.length;i++){
          print(rtn10_2[i].key_kind_cd);
          print(rtn10_2[i].kind_name);
          expect(rtn10_2[i].key_kind_cd,99);
          expect(rtn10_2[i].kind_name,'mst10_test2');
        }
      }
      print('********** テスト終了：method010_selectDataWithWhereClause_02 **********\n\n');
    });

    // ********************************************************
    // テストmethod011 : selectDataWithWhereClause_txn
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method011_selectDataWithWhereClause_txn_01', () async {
      print('\n********** テスト実行：method011_selectDataWithWhereClause_txn_01 **********');
      //引数tc,whereClauseでselectDataWithWhereClauseを実施
      CKeykindMst sel10 = CKeykindMst();
      String whereClause10_1 = "kind_name = 'mst10_test'";
      await db.makeTransaction((txn) async{
        List<CKeykindMst> rtn10 = await db.selectDataWithWhereClause(sel10,whereClause10_1,txn: txn);
        if(rtn10.isEmpty){
          print('異常：CKeykindMstは空');
        }else{
          for(int i=0; i < rtn10.length;i++){
            print(rtn10[i].key_kind_cd);
            print(rtn10[i].kind_name);
            expect(rtn10[i].key_kind_cd,88);
            expect(rtn10[i].kind_name,'mst10_test');
          }
        }
      });
      print('********** テスト終了：method011_selectDataWithWhereClause_txn_01 **********\n\n');
      print('\n********** テスト実行：method011_selectDataWithWhereClause_txn_02 **********');
      //引数tc,whereClause,whereArgsでselectDataWithWhereClauseを実施
      CKeykindMst sel10_2 = CKeykindMst();
      String whereClause10_2 = "kind_name = ?";
      List argsList10_2 = [];
      argsList10_2.add('mst10_test2');
      await db.makeTransaction((txn) async{
        List<CKeykindMst> rtn10_2 = await db.selectDataWithWhereClause(sel10_2,whereClause10_2,whereArgs: argsList10_2,txn: txn);
        if(rtn10_2.isEmpty){
          print('異常：CKeykindMstは空');
        }else{
          for(int i=0; i < rtn10_2.length;i++){
            print(rtn10_2[i].key_kind_cd);
            print(rtn10_2[i].kind_name);
            expect(rtn10_2[i].key_kind_cd,99);
            expect(rtn10_2[i].kind_name,'mst10_test2');
          }
        }
        await db.delete(sel10,txn: txn);
      });
      print('********** テスト終了：method011_selectDataWithWhereClause_txn_02 **********\n\n');
    });

    // ********************************************************
    // テストmethod012 : cloneRecord
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method012_cloneRecord_01', () async {
      print('\n********** テスト実行：method012_cloneRecord_01 **********');
      //1レコード準備する
      CReportAttrSubMst pre12 = CReportAttrSubMst();
      pre12.attr_sub_cd = 1;
      pre12.attr_sub_ordr = 2;
      pre12.img_cd = 3;
      pre12.repo_sql_cd = 4;
      //cloneRecord
      CReportAttrSubMst pre12_copy = db.cloneRecord(pre12);
      //作ったものと元のレコードの各要素を比較
      expect(pre12.attr_sub_cd,pre12_copy.attr_sub_cd);
      expect(pre12.attr_sub_ordr,pre12_copy.attr_sub_ordr);
      expect(pre12.img_cd,pre12_copy.img_cd);
      expect(pre12.repo_sql_cd,pre12_copy.repo_sql_cd);
      print('********** テスト終了：method012_cloneRecord_01 **********\n\n');
    });

    // ********************************************************
    // テストmethod013 : cloneRecordList
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①transaction中にinsert,select,insertをするので、それを確認できること
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('method013_cloneRecordList_01', () async {
      print('\n********** テスト実行：method013_cloneRecordList_01 **********');
      //複数レコード準備する
      WkQue wk01 = WkQue();
      wk01.serial_no = 'test13';
      wk01.pid = 13;
      wk01.wk_step = 14;
      wk01.endtime = '2023/05/01';
      WkQue wk02 = WkQue();
      wk02.serial_no = 'test13_2';
      wk02.pid = 13;
      wk02.wk_step = 15;
      wk02.endtime = '2023/05/02';
      db.insert(wk01);
      db.insert(wk02);
      WkQue wk03 = WkQue();
      String whereClause13 = "pid = 13";
      List<WkQue> rtn = await db.selectDataWithWhereClause(wk03, whereClause13);

      //cloneRecordList
      List<WkQue> rtn_clone = db.cloneRecordList(rtn);
      //作ったものと元のレコードの各要素を比較
      if(rtn.isEmpty){
        print('異常：WkQueは空');
      }else {
        for (int i = 0; i < rtn.length; i++) {
          expect(rtn[i].serial_no,rtn_clone[i].serial_no);
          expect(rtn[i].pid,rtn_clone[i].pid);
          expect(rtn[i].wk_step,rtn_clone[i].wk_step);
          expect(rtn[i].endtime,rtn_clone[i].endtime);
        }
      }
      await db.delete(wk01);
      print('********** テスト終了：method013_cloneRecordList_01 **********\n\n');
    });
  });
}