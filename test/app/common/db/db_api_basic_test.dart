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
本テストでは、以下の90tablesを対象にする
basic_table_access.dart 01_基本マスタ系 11tables
sale_table_access.dart 02_販売マスタ系 11tables
pos_basic_table_access.dart 03_POS基本マスタ系 68tables
 */
Future<void> main() async{
  await basic_table_test();
}

Future<void> basic_table_test() async
{
  TestWidgetsFlutterBinding.ensureInitialized();

  var db = DbManipulation();

  group('basic_table',()
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
    // テスト00001 : CCompMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00001_CCompMst_01', () async {
      print('\n********** テスト実行：00001_CCompMst_01 **********');
      CCompMst Test00001_1 = CCompMst();
      Test00001_1.comp_cd = 9912;
      Test00001_1.comp_typ = 9913;
      Test00001_1.rtr_id = 9914;
      Test00001_1.name = 'abc15';
      Test00001_1.short_name = 'abc16';
      Test00001_1.kana_name = 'abc17';
      Test00001_1.post_no = 'abc18';
      Test00001_1.adress1 = 'abc19';
      Test00001_1.adress2 = 'abc20';
      Test00001_1.adress3 = 'abc21';
      Test00001_1.telno1 = 'abc22';
      Test00001_1.telno2 = 'abc23';
      Test00001_1.srch_telno1 = 'abc24';
      Test00001_1.srch_telno2 = 'abc25';
      Test00001_1.ins_datetime = 'abc26';
      Test00001_1.upd_datetime = 'abc27';
      Test00001_1.status = 9928;
      Test00001_1.send_flg = 9929;
      Test00001_1.upd_user = 9930;
      Test00001_1.upd_system = 9931;

      //selectAllDataをして件数取得。
      List<CCompMst> Test00001_AllRtn = await db.selectAllData(Test00001_1);
      int count = Test00001_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00001_1);

      //データ取得に必要なオブジェクトを用意
      CCompMst Test00001_2 = CCompMst();
      //Keyの値を設定する
      Test00001_2.comp_cd = 9912;
      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCompMst? Test00001_Rtn = await db.selectDataByPrimaryKey(Test00001_2);
      //取得行がない場合、nullが返ってきます
      if (Test00001_Rtn == null) {
        print('\n********** 異常発生：00001_CCompMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00001_Rtn?.comp_cd,9912);
        expect(Test00001_Rtn?.comp_typ,9913);
        expect(Test00001_Rtn?.rtr_id,9914);
        expect(Test00001_Rtn?.name,'abc15');
        expect(Test00001_Rtn?.short_name,'abc16');
        expect(Test00001_Rtn?.kana_name,'abc17');
        expect(Test00001_Rtn?.post_no,'abc18');
        expect(Test00001_Rtn?.adress1,'abc19');
        expect(Test00001_Rtn?.adress2,'abc20');
        expect(Test00001_Rtn?.adress3,'abc21');
        expect(Test00001_Rtn?.telno1,'abc22');
        expect(Test00001_Rtn?.telno2,'abc23');
        expect(Test00001_Rtn?.srch_telno1,'abc24');
        expect(Test00001_Rtn?.srch_telno2,'abc25');
        expect(Test00001_Rtn?.ins_datetime,'abc26');
        expect(Test00001_Rtn?.upd_datetime,'abc27');
        expect(Test00001_Rtn?.status,9928);
        expect(Test00001_Rtn?.send_flg,9929);
        expect(Test00001_Rtn?.upd_user,9930);
        expect(Test00001_Rtn?.upd_system,9931);
      }

      //selectAllDataをして件数取得。
      List<CCompMst> Test00001_AllRtn2 = await db.selectAllData(Test00001_1);
      int count2 = Test00001_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00001_1);

      print('********** テスト終了：00001_CCompMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00002 : CStreMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00002_CStreMst_01', () async {
      print('\n********** テスト実行：00002_CStreMst_01 **********');
      CStreMst Test00002_1 = CStreMst();
      Test00002_1.stre_cd = 9912;
      Test00002_1.comp_cd = 9913;
      Test00002_1.zone_cd = 9914;
      Test00002_1.bsct_cd = 9915;
      Test00002_1.name = 'abc16';
      Test00002_1.short_name = 'abc17';
      Test00002_1.kana_name = 'abc18';
      Test00002_1.post_no = 'abc19';
      Test00002_1.adress1 = 'abc20';
      Test00002_1.adress2 = 'abc21';
      Test00002_1.adress3 = 'abc22';
      Test00002_1.telno1 = 'abc23';
      Test00002_1.telno2 = 'abc24';
      Test00002_1.srch_telno1 = 'abc25';
      Test00002_1.srch_telno2 = 'abc26';
      Test00002_1.ip_addr = 'abc27';
      Test00002_1.trends_typ = 9928;
      Test00002_1.stre_typ = 9929;
      Test00002_1.flg_shp = 9930;
      Test00002_1.business_typ1 = 9931;
      Test00002_1.business_typ2 = 9932;
      Test00002_1.chain_other_flg = 9933;
      Test00002_1.locate_typ = 9934;
      Test00002_1.openclose_flg = 9935;
      Test00002_1.opentime = 'abc36';
      Test00002_1.closetime = 'abc37';
      Test00002_1.floorspace = 1.238;
      Test00002_1.today = 'abc39';
      Test00002_1.bfrday = 'abc40';
      Test00002_1.twodaybfr = 'abc41';
      Test00002_1.nextday = 'abc42';
      Test00002_1.sysflg_base = 9943;
      Test00002_1.sysflg_sale = 9944;
      Test00002_1.sysflg_purchs = 9945;
      Test00002_1.sysflg_order = 9946;
      Test00002_1.sysflg_invtry = 9947;
      Test00002_1.sysflg_cust = 9948;
      Test00002_1.sysflg_poppy = 9949;
      Test00002_1.sysflg_elslbl = 9950;
      Test00002_1.sysflg_fresh = 9951;
      Test00002_1.sysflg_wdslbl = 9952;
      Test00002_1.sysflg_24hour = 9953;
      Test00002_1.showorder = 9954;
      Test00002_1.opendate = 'abc55';
      Test00002_1.stre_ver_flg = 9956;
      Test00002_1.sunday_off_flg = 9957;
      Test00002_1.monday_off_flg = 9958;
      Test00002_1.tuesday_off_flg = 9959;
      Test00002_1.wednesday_off_flg = 9960;
      Test00002_1.thursday_off_flg = 9961;
      Test00002_1.friday_off_flg = 9962;
      Test00002_1.saturday_off_flg = 9963;
      Test00002_1.itemstock_flg = 9964;
      Test00002_1.wait_time = 'abc65';
      Test00002_1.ins_datetime = 'abc66';
      Test00002_1.upd_datetime = 'abc67';
      Test00002_1.status = 9968;
      Test00002_1.send_flg = 9969;
      Test00002_1.upd_user = 9970;
      Test00002_1.upd_system = 9971;
      Test00002_1.entry_no = 'abc72';






      //selectAllDataをして件数取得。
      List<CStreMst> Test00002_AllRtn = await db.selectAllData(Test00002_1);
      int count = Test00002_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00002_1);

      //データ取得に必要なオブジェクトを用意
      CStreMst Test00002_2 = CStreMst();
      //Keyの値を設定する
      Test00002_2.stre_cd = 9912;
      Test00002_2.comp_cd = 9913;




      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStreMst? Test00002_Rtn = await db.selectDataByPrimaryKey(Test00002_2);
      //取得行がない場合、nullが返ってきます
      if (Test00002_Rtn == null) {
        print('\n********** 異常発生：00002_CStreMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00002_Rtn?.stre_cd,9912);
        expect(Test00002_Rtn?.comp_cd,9913);
        expect(Test00002_Rtn?.zone_cd,9914);
        expect(Test00002_Rtn?.bsct_cd,9915);
        expect(Test00002_Rtn?.name,'abc16');
        expect(Test00002_Rtn?.short_name,'abc17');
        expect(Test00002_Rtn?.kana_name,'abc18');
        expect(Test00002_Rtn?.post_no,'abc19');
        expect(Test00002_Rtn?.adress1,'abc20');
        expect(Test00002_Rtn?.adress2,'abc21');
        expect(Test00002_Rtn?.adress3,'abc22');
        expect(Test00002_Rtn?.telno1,'abc23');
        expect(Test00002_Rtn?.telno2,'abc24');
        expect(Test00002_Rtn?.srch_telno1,'abc25');
        expect(Test00002_Rtn?.srch_telno2,'abc26');
        expect(Test00002_Rtn?.ip_addr,'abc27');
        expect(Test00002_Rtn?.trends_typ,9928);
        expect(Test00002_Rtn?.stre_typ,9929);
        expect(Test00002_Rtn?.flg_shp,9930);
        expect(Test00002_Rtn?.business_typ1,9931);
        expect(Test00002_Rtn?.business_typ2,9932);
        expect(Test00002_Rtn?.chain_other_flg,9933);
        expect(Test00002_Rtn?.locate_typ,9934);
        expect(Test00002_Rtn?.openclose_flg,9935);
        expect(Test00002_Rtn?.opentime,'abc36');
        expect(Test00002_Rtn?.closetime,'abc37');
        expect(Test00002_Rtn?.floorspace,1.238);
        expect(Test00002_Rtn?.today,'abc39');
        expect(Test00002_Rtn?.bfrday,'abc40');
        expect(Test00002_Rtn?.twodaybfr,'abc41');
        expect(Test00002_Rtn?.nextday,'abc42');
        expect(Test00002_Rtn?.sysflg_base,9943);
        expect(Test00002_Rtn?.sysflg_sale,9944);
        expect(Test00002_Rtn?.sysflg_purchs,9945);
        expect(Test00002_Rtn?.sysflg_order,9946);
        expect(Test00002_Rtn?.sysflg_invtry,9947);
        expect(Test00002_Rtn?.sysflg_cust,9948);
        expect(Test00002_Rtn?.sysflg_poppy,9949);
        expect(Test00002_Rtn?.sysflg_elslbl,9950);
        expect(Test00002_Rtn?.sysflg_fresh,9951);
        expect(Test00002_Rtn?.sysflg_wdslbl,9952);
        expect(Test00002_Rtn?.sysflg_24hour,9953);
        expect(Test00002_Rtn?.showorder,9954);
        expect(Test00002_Rtn?.opendate,'abc55');
        expect(Test00002_Rtn?.stre_ver_flg,9956);
        expect(Test00002_Rtn?.sunday_off_flg,9957);
        expect(Test00002_Rtn?.monday_off_flg,9958);
        expect(Test00002_Rtn?.tuesday_off_flg,9959);
        expect(Test00002_Rtn?.wednesday_off_flg,9960);
        expect(Test00002_Rtn?.thursday_off_flg,9961);
        expect(Test00002_Rtn?.friday_off_flg,9962);
        expect(Test00002_Rtn?.saturday_off_flg,9963);
        expect(Test00002_Rtn?.itemstock_flg,9964);
        expect(Test00002_Rtn?.wait_time,'abc65');
        expect(Test00002_Rtn?.ins_datetime,'abc66');
        expect(Test00002_Rtn?.upd_datetime,'abc67');
        expect(Test00002_Rtn?.status,9968);
        expect(Test00002_Rtn?.send_flg,9969);
        expect(Test00002_Rtn?.upd_user,9970);
        expect(Test00002_Rtn?.upd_system,9971);
        expect(Test00002_Rtn?.entry_no,'abc72');





      }

      //selectAllDataをして件数取得。
      List<CStreMst> Test00002_AllRtn2 = await db.selectAllData(Test00002_1);
      int count2 = Test00002_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00002_1);
      print('********** テスト終了：00002_CStreMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00003 : CConnectMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00003_CConnectMst_01', () async {
      print('\n********** テスト実行：00003_CConnectMst_01 **********');
      CConnectMst Test00003_1 = CConnectMst();
      Test00003_1.comp_cd = 9912;
      Test00003_1.stre_cd = 9913;
      Test00003_1.connect_cd = 9914;
      Test00003_1.connect_typ = 9915;
      Test00003_1.name = 'abc16';
      Test00003_1.short_name = 'abc17';
      Test00003_1.kana_name = 'abc18';
      Test00003_1.host_name = 'abc19';
      Test00003_1.opentime = 'abc20';
      Test00003_1.closetime = 'abc21';
      Test00003_1.format_typ = 9922;
      Test00003_1.network_typ = 9923;
      Test00003_1.telno1 = 'abc24';
      Test00003_1.telno2 = 'abc25';
      Test00003_1.srch_telno1 = 'abc26';
      Test00003_1.srch_telno2 = 'abc27';
      Test00003_1.ip_addr = 'abc28';
      Test00003_1.retry_cnt = 9929;
      Test00003_1.retry_time = 9930;
      Test00003_1.time_out = 9931;
      Test00003_1.ftp_put_dir = 'abc32';
      Test00003_1.ftp_get_dir = 'abc33';
      Test00003_1.connect_time1 = 9934;
      Test00003_1.connect_time2 = 9935;
      Test00003_1.cnt_usr = 'abc36';
      Test00003_1.cnt_pwd = 'abc37';
      Test00003_1.wait_time1 = 9938;
      Test00003_1.wait_time2 = 9939;
      Test00003_1.cnt_interval1 = 9940;
      Test00003_1.cnt_interval2 = 9941;
      Test00003_1.stre_chk_dgt = 9942;
      Test00003_1.ins_datetime = 'abc43';
      Test00003_1.upd_datetime = 'abc44';
      Test00003_1.status = 9945;
      Test00003_1.send_flg = 9946;
      Test00003_1.upd_user = 9947;
      Test00003_1.upd_system = 9948;

      //selectAllDataをして件数取得。
      List<CConnectMst> Test00003_AllRtn = await db.selectAllData(Test00003_1);
      int count = Test00003_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00003_1);

      //データ取得に必要なオブジェクトを用意
      CConnectMst Test00003_2 = CConnectMst();
      //Keyの値を設定する
      Test00003_2.comp_cd = 9912;
      Test00003_2.stre_cd = 9913;
      Test00003_2.connect_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CConnectMst? Test00003_Rtn = await db.selectDataByPrimaryKey(Test00003_2);
      //取得行がない場合、nullが返ってきます
      if (Test00003_Rtn == null) {
        print('\n********** 異常発生：00003_CConnectMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00003_Rtn?.comp_cd,9912);
        expect(Test00003_Rtn?.stre_cd,9913);
        expect(Test00003_Rtn?.connect_cd,9914);
        expect(Test00003_Rtn?.connect_typ,9915);
        expect(Test00003_Rtn?.name,'abc16');
        expect(Test00003_Rtn?.short_name,'abc17');
        expect(Test00003_Rtn?.kana_name,'abc18');
        expect(Test00003_Rtn?.host_name,'abc19');
        expect(Test00003_Rtn?.opentime,'abc20');
        expect(Test00003_Rtn?.closetime,'abc21');
        expect(Test00003_Rtn?.format_typ,9922);
        expect(Test00003_Rtn?.network_typ,9923);
        expect(Test00003_Rtn?.telno1,'abc24');
        expect(Test00003_Rtn?.telno2,'abc25');
        expect(Test00003_Rtn?.srch_telno1,'abc26');
        expect(Test00003_Rtn?.srch_telno2,'abc27');
        expect(Test00003_Rtn?.ip_addr,'abc28');
        expect(Test00003_Rtn?.retry_cnt,9929);
        expect(Test00003_Rtn?.retry_time,9930);
        expect(Test00003_Rtn?.time_out,9931);
        expect(Test00003_Rtn?.ftp_put_dir,'abc32');
        expect(Test00003_Rtn?.ftp_get_dir,'abc33');
        expect(Test00003_Rtn?.connect_time1,9934);
        expect(Test00003_Rtn?.connect_time2,9935);
        expect(Test00003_Rtn?.cnt_usr,'abc36');
        expect(Test00003_Rtn?.cnt_pwd,'abc37');
        expect(Test00003_Rtn?.wait_time1,9938);
        expect(Test00003_Rtn?.wait_time2,9939);
        expect(Test00003_Rtn?.cnt_interval1,9940);
        expect(Test00003_Rtn?.cnt_interval2,9941);
        expect(Test00003_Rtn?.stre_chk_dgt,9942);
        expect(Test00003_Rtn?.ins_datetime,'abc43');
        expect(Test00003_Rtn?.upd_datetime,'abc44');
        expect(Test00003_Rtn?.status,9945);
        expect(Test00003_Rtn?.send_flg,9946);
        expect(Test00003_Rtn?.upd_user,9947);
        expect(Test00003_Rtn?.upd_system,9948);
      }

      //selectAllDataをして件数取得。
      List<CConnectMst> Test00003_AllRtn2 = await db.selectAllData(Test00003_1);
      int count2 = Test00003_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00003_1);
      print('********** テスト終了：00003_CConnectMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00004 : CClsMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00004_CClsMst_01', () async {
      print('\n********** テスト実行：00004_CClsMst_01 **********');
      CClsMst Test00004_1 = CClsMst();
      Test00004_1.comp_cd = 9912;
      Test00004_1.stre_cd = 9913;
      Test00004_1.cls_typ = 9914;
      Test00004_1.lrgcls_cd = 9915;
      Test00004_1.mdlcls_cd = 9916;
      Test00004_1.smlcls_cd = 9917;
      Test00004_1.tnycls_cd = 9918;
      Test00004_1.plu_cd = 'abc19';
      Test00004_1.cls_flg = 9920;
      Test00004_1.tax_cd1 = 9921;
      Test00004_1.tax_cd2 = 9922;
      Test00004_1.tax_cd3 = 9923;
      Test00004_1.tax_cd4 = 9924;
      Test00004_1.name = 'abc25';
      Test00004_1.short_name = 'abc26';
      Test00004_1.kana_name = 'abc27';
      Test00004_1.margin_flg = 9928;
      Test00004_1.regsale_flg = 9929;
      Test00004_1.clothdeal_flg = 9930;
      Test00004_1.dfltcls_cd = 9931;
      Test00004_1.msg_name = 'abc32';
      Test00004_1.pop_msg = 'abc33';
      Test00004_1.nonact_flg = 9934;
      Test00004_1.max_prc = 9935;
      Test00004_1.min_prc = 9936;
      Test00004_1.cost_per = 1.237;
      Test00004_1.loss_per = 1.238;
      Test00004_1.rbtpremium_per = 1.239;
      Test00004_1.prc_chg_flg = 9940;
      Test00004_1.rbttarget_flg = 9941;
      Test00004_1.stl_dsc_flg = 9942;
      Test00004_1.labeldept_cd = 9943;
      Test00004_1.multprc_flg = 9944;
      Test00004_1.multprc_per = 1.245;
      Test00004_1.sch_flg = 9946;
      Test00004_1.stlplus_flg = 9947;
      Test00004_1.pctr_tckt_flg = 9948;
      Test00004_1.clothing_flg = 9949;
      Test00004_1.spclsdsc_flg = 9950;
      Test00004_1.bdl_dsc_flg = 9951;
      Test00004_1.self_alert_flg = 9952;
      Test00004_1.chg_ckt_flg = 9953;
      Test00004_1.self_weight_flg = 9954;
      Test00004_1.msg_flg = 9955;
      Test00004_1.pop_msg_flg = 9956;
      Test00004_1.itemstock_flg = 9957;
      Test00004_1.orderpatrn_flg = 9958;
      Test00004_1.orderbook_flg = 9959;
      Test00004_1.safestock_per = 1.260;
      Test00004_1.autoorder_typ = 9961;
      Test00004_1.casecntup_typ = 9962;
      Test00004_1.producer_cd = 9963;
      Test00004_1.cust_dtl_flg = 9964;
      Test00004_1.coupon_flg = 9965;
      Test00004_1.kitchen_prn_flg = 9966;
      Test00004_1.pricing_flg = 9967;
      Test00004_1.user_val_1 = 9968;
      Test00004_1.user_val_2 = 9969;
      Test00004_1.user_val_3 = 9970;
      Test00004_1.user_val_4 = 9971;
      Test00004_1.user_val_5 = 9972;
      Test00004_1.ins_datetime = 'abc73';
      Test00004_1.upd_datetime = 'abc74';
      Test00004_1.status = 9975;
      Test00004_1.send_flg = 9976;
      Test00004_1.upd_user = 9977;
      Test00004_1.upd_system = 9978;
      Test00004_1.tax_exemption_flg = 9979;
      Test00004_1.dpnt_rbttarget_flg = 9980;
      Test00004_1.dpnt_usetarget_flg = 9981;

      //selectAllDataをして件数取得。
      List<CClsMst> Test00004_AllRtn = await db.selectAllData(Test00004_1);
      int count = Test00004_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00004_1);

      //データ取得に必要なオブジェクトを用意
      CClsMst Test00004_2 = CClsMst();
      //Keyの値を設定する
      Test00004_2.comp_cd = 9912;
      Test00004_2.stre_cd = 9913;
      Test00004_2.cls_typ = 9914;
      Test00004_2.lrgcls_cd = 9915;
      Test00004_2.mdlcls_cd = 9916;
      Test00004_2.smlcls_cd = 9917;
      Test00004_2.tnycls_cd = 9918;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CClsMst? Test00004_Rtn = await db.selectDataByPrimaryKey(Test00004_2);
      //取得行がない場合、nullが返ってきます
      if (Test00004_Rtn == null) {
        print('\n********** 異常発生：00004_CClsMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00004_Rtn?.comp_cd,9912);
        expect(Test00004_Rtn?.stre_cd,9913);
        expect(Test00004_Rtn?.cls_typ,9914);
        expect(Test00004_Rtn?.lrgcls_cd,9915);
        expect(Test00004_Rtn?.mdlcls_cd,9916);
        expect(Test00004_Rtn?.smlcls_cd,9917);
        expect(Test00004_Rtn?.tnycls_cd,9918);
        expect(Test00004_Rtn?.plu_cd,'abc19');
        expect(Test00004_Rtn?.cls_flg,9920);
        expect(Test00004_Rtn?.tax_cd1,9921);
        expect(Test00004_Rtn?.tax_cd2,9922);
        expect(Test00004_Rtn?.tax_cd3,9923);
        expect(Test00004_Rtn?.tax_cd4,9924);
        expect(Test00004_Rtn?.name,'abc25');
        expect(Test00004_Rtn?.short_name,'abc26');
        expect(Test00004_Rtn?.kana_name,'abc27');
        expect(Test00004_Rtn?.margin_flg,9928);
        expect(Test00004_Rtn?.regsale_flg,9929);
        expect(Test00004_Rtn?.clothdeal_flg,9930);
        expect(Test00004_Rtn?.dfltcls_cd,9931);
        expect(Test00004_Rtn?.msg_name,'abc32');
        expect(Test00004_Rtn?.pop_msg,'abc33');
        expect(Test00004_Rtn?.nonact_flg,9934);
        expect(Test00004_Rtn?.max_prc,9935);
        expect(Test00004_Rtn?.min_prc,9936);
        expect(Test00004_Rtn?.cost_per,1.237);
        expect(Test00004_Rtn?.loss_per,1.238);
        expect(Test00004_Rtn?.rbtpremium_per,1.239);
        expect(Test00004_Rtn?.prc_chg_flg,9940);
        expect(Test00004_Rtn?.rbttarget_flg,9941);
        expect(Test00004_Rtn?.stl_dsc_flg,9942);
        expect(Test00004_Rtn?.labeldept_cd,9943);
        expect(Test00004_Rtn?.multprc_flg,9944);
        expect(Test00004_Rtn?.multprc_per,1.245);
        expect(Test00004_Rtn?.sch_flg,9946);
        expect(Test00004_Rtn?.stlplus_flg,9947);
        expect(Test00004_Rtn?.pctr_tckt_flg,9948);
        expect(Test00004_Rtn?.clothing_flg,9949);
        expect(Test00004_Rtn?.spclsdsc_flg,9950);
        expect(Test00004_Rtn?.bdl_dsc_flg,9951);
        expect(Test00004_Rtn?.self_alert_flg,9952);
        expect(Test00004_Rtn?.chg_ckt_flg,9953);
        expect(Test00004_Rtn?.self_weight_flg,9954);
        expect(Test00004_Rtn?.msg_flg,9955);
        expect(Test00004_Rtn?.pop_msg_flg,9956);
        expect(Test00004_Rtn?.itemstock_flg,9957);
        expect(Test00004_Rtn?.orderpatrn_flg,9958);
        expect(Test00004_Rtn?.orderbook_flg,9959);
        expect(Test00004_Rtn?.safestock_per,1.260);
        expect(Test00004_Rtn?.autoorder_typ,9961);
        expect(Test00004_Rtn?.casecntup_typ,9962);
        expect(Test00004_Rtn?.producer_cd,9963);
        expect(Test00004_Rtn?.cust_dtl_flg,9964);
        expect(Test00004_Rtn?.coupon_flg,9965);
        expect(Test00004_Rtn?.kitchen_prn_flg,9966);
        expect(Test00004_Rtn?.pricing_flg,9967);
        expect(Test00004_Rtn?.user_val_1,9968);
        expect(Test00004_Rtn?.user_val_2,9969);
        expect(Test00004_Rtn?.user_val_3,9970);
        expect(Test00004_Rtn?.user_val_4,9971);
        expect(Test00004_Rtn?.user_val_5,9972);
        expect(Test00004_Rtn?.ins_datetime,'abc73');
        expect(Test00004_Rtn?.upd_datetime,'abc74');
        expect(Test00004_Rtn?.status,9975);
        expect(Test00004_Rtn?.send_flg,9976);
        expect(Test00004_Rtn?.upd_user,9977);
        expect(Test00004_Rtn?.upd_system,9978);
        expect(Test00004_Rtn?.tax_exemption_flg,9979);
        expect(Test00004_Rtn?.dpnt_rbttarget_flg,9980);
        expect(Test00004_Rtn?.dpnt_usetarget_flg,9981);
      }

      //selectAllDataをして件数取得。
      List<CClsMst> Test00004_AllRtn2 = await db.selectAllData(Test00004_1);
      int count2 = Test00004_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00004_1);
      print('********** テスト終了：00004_CClsMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00005 : CGrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00005_CGrpMst_01', () async {
      print('\n********** テスト実行：00005_CGrpMst_01 **********');
      CGrpMst Test00005_1 = CGrpMst();
      Test00005_1.comp_cd = 9912;
      Test00005_1.stre_cd = 9913;
      Test00005_1.cls_grp_cd = 9914;
      Test00005_1.mdl_smlcls_cd = 9915;
      Test00005_1.ins_datetime = 'abc16';
      Test00005_1.upd_datetime = 'abc17';
      Test00005_1.status = 9918;
      Test00005_1.send_flg = 9919;
      Test00005_1.upd_user = 9920;
      Test00005_1.upd_system = 9921;

      //selectAllDataをして件数取得。
      List<CGrpMst> Test00005_AllRtn = await db.selectAllData(Test00005_1);
      int count = Test00005_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00005_1);

      //データ取得に必要なオブジェクトを用意
      CGrpMst Test00005_2 = CGrpMst();
      //Keyの値を設定する
      Test00005_2.comp_cd = 9912;
      Test00005_2.stre_cd = 9913;
      Test00005_2.cls_grp_cd = 9914;
      Test00005_2.mdl_smlcls_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CGrpMst? Test00005_Rtn = await db.selectDataByPrimaryKey(Test00005_2);
      //取得行がない場合、nullが返ってきます
      if (Test00005_Rtn == null) {
        print('\n********** 異常発生：00005_CGrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00005_Rtn?.comp_cd,9912);
        expect(Test00005_Rtn?.stre_cd,9913);
        expect(Test00005_Rtn?.cls_grp_cd,9914);
        expect(Test00005_Rtn?.mdl_smlcls_cd,9915);
        expect(Test00005_Rtn?.ins_datetime,'abc16');
        expect(Test00005_Rtn?.upd_datetime,'abc17');
        expect(Test00005_Rtn?.status,9918);
        expect(Test00005_Rtn?.send_flg,9919);
        expect(Test00005_Rtn?.upd_user,9920);
        expect(Test00005_Rtn?.upd_system,9921);
      }

      //selectAllDataをして件数取得。
      List<CGrpMst> Test00005_AllRtn2 = await db.selectAllData(Test00005_1);
      int count2 = Test00005_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00005_1);
      print('********** テスト終了：00005_CGrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00006 : CZipcodeMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00006_CZipcodeMst_01', () async {
      print('\n********** テスト実行：00006_CZipcodeMst_01 **********');
      CZipcodeMst Test00006_1 = CZipcodeMst();
      Test00006_1.serial_no = 9912;
      Test00006_1.post_no = 'abc13';
      Test00006_1.address1 = 'abc14';
      Test00006_1.address2 = 'abc15';
      Test00006_1.address3 = 'abc16';
      Test00006_1.kana_address1 = 'abc17';
      Test00006_1.kana_address2 = 'abc18';
      Test00006_1.kana_address3 = 'abc19';
      Test00006_1.ins_datetime = 'abc20';
      Test00006_1.upd_datetime = 'abc21';
      Test00006_1.status = 9922;
      Test00006_1.send_flg = 9923;
      Test00006_1.upd_user = 9924;
      Test00006_1.upd_system = 9925;

      //selectAllDataをして件数取得。
      List<CZipcodeMst> Test00006_AllRtn = await db.selectAllData(Test00006_1);
      int count = Test00006_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00006_1);

      //データ取得に必要なオブジェクトを用意
      CZipcodeMst Test00006_2 = CZipcodeMst();
      //Keyの値を設定する
      Test00006_2.serial_no = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CZipcodeMst? Test00006_Rtn = await db.selectDataByPrimaryKey(Test00006_2);
      //取得行がない場合、nullが返ってきます
      if (Test00006_Rtn == null) {
        print('\n********** 異常発生：00006_CZipcodeMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00006_Rtn?.serial_no,9912);
        expect(Test00006_Rtn?.post_no,'abc13');
        expect(Test00006_Rtn?.address1,'abc14');
        expect(Test00006_Rtn?.address2,'abc15');
        expect(Test00006_Rtn?.address3,'abc16');
        expect(Test00006_Rtn?.kana_address1,'abc17');
        expect(Test00006_Rtn?.kana_address2,'abc18');
        expect(Test00006_Rtn?.kana_address3,'abc19');
        expect(Test00006_Rtn?.ins_datetime,'abc20');
        expect(Test00006_Rtn?.upd_datetime,'abc21');
        expect(Test00006_Rtn?.status,9922);
        expect(Test00006_Rtn?.send_flg,9923);
        expect(Test00006_Rtn?.upd_user,9924);
        expect(Test00006_Rtn?.upd_system,9925);
      }

      //selectAllDataをして件数取得。
      List<CZipcodeMst> Test00006_AllRtn2 = await db.selectAllData(Test00006_1);
      int count2 = Test00006_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00006_1);
      print('********** テスト終了：00006_CZipcodeMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00007 : CTaxMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00007_CTaxMst_01', () async {
      print('\n********** テスト実行：00007_CTaxMst_01 **********');
      CTaxMst Test00007_1 = CTaxMst();
      Test00007_1.comp_cd = 9912;
      Test00007_1.tax_cd = 9913;
      Test00007_1.tax_name = 'abc14';
      Test00007_1.tax_typ = 9915;
      Test00007_1.odd_flg = 9916;
      Test00007_1.tax_per = 1.217;
      Test00007_1.mov_cd = 9918;
      Test00007_1.ins_datetime = 'abc19';
      Test00007_1.upd_datetime = 'abc20';
      Test00007_1.status = 9921;
      Test00007_1.send_flg = 9922;
      Test00007_1.upd_user = 9923;
      Test00007_1.upd_system = 9924;

      //selectAllDataをして件数取得。
      List<CTaxMst> Test00007_AllRtn = await db.selectAllData(Test00007_1);
      int count = Test00007_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00007_1);

      //データ取得に必要なオブジェクトを用意
      CTaxMst Test00007_2 = CTaxMst();
      //Keyの値を設定する
      Test00007_2.comp_cd = 9912;
      Test00007_2.tax_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTaxMst? Test00007_Rtn = await db.selectDataByPrimaryKey(Test00007_2);
      //取得行がない場合、nullが返ってきます
      if (Test00007_Rtn == null) {
        print('\n********** 異常発生：00007_CTaxMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00007_Rtn?.comp_cd,9912);
        expect(Test00007_Rtn?.tax_cd,9913);
        expect(Test00007_Rtn?.tax_name,'abc14');
        expect(Test00007_Rtn?.tax_typ,9915);
        expect(Test00007_Rtn?.odd_flg,9916);
        expect(Test00007_Rtn?.tax_per,1.217);
        expect(Test00007_Rtn?.mov_cd,9918);
        expect(Test00007_Rtn?.ins_datetime,'abc19');
        expect(Test00007_Rtn?.upd_datetime,'abc20');
        expect(Test00007_Rtn?.status,9921);
        expect(Test00007_Rtn?.send_flg,9922);
        expect(Test00007_Rtn?.upd_user,9923);
        expect(Test00007_Rtn?.upd_system,9924);
      }

      //selectAllDataをして件数取得。
      List<CTaxMst> Test00007_AllRtn2 = await db.selectAllData(Test00007_1);
      int count2 = Test00007_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00007_1);
      print('********** テスト終了：00007_CTaxMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00008 : CCaldrMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00008_CCaldrMst_01', () async {
      print('\n********** テスト実行：00008_CCaldrMst_01 **********');
      CCaldrMst Test00008_1 = CCaldrMst();
      Test00008_1.comp_cd = 9912;
      Test00008_1.stre_cd = 9913;
      Test00008_1.caldr_date = 'abc14';
      Test00008_1.dayoff_flg = 9915;
      Test00008_1.comment1 = 'abc16';
      Test00008_1.comment2 = 'abc17';
      Test00008_1.am_weather = 9918;
      Test00008_1.pm_weather = 9919;
      Test00008_1.min_temp = 1.220;
      Test00008_1.max_temp = 1.221;
      Test00008_1.close_flg = 9922;
      Test00008_1.open_rslt = 9923;
      Test00008_1.close_rslt = 9924;
      Test00008_1.rsrv_cust = 9925;
      Test00008_1.ins_datetime = 'abc26';
      Test00008_1.upd_datetime = 'abc27';
      Test00008_1.status = 9928;
      Test00008_1.send_flg = 9929;
      Test00008_1.upd_user = 9930;
      Test00008_1.upd_system = 9931;
      Test00008_1.rsrv_cust_ai = 9932;

      //selectAllDataをして件数取得。
      List<CCaldrMst> Test00008_AllRtn = await db.selectAllData(Test00008_1);
      int count = Test00008_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00008_1);

      //データ取得に必要なオブジェクトを用意
      CCaldrMst Test00008_2 = CCaldrMst();
      //Keyの値を設定する
      Test00008_2.comp_cd = 9912;
      Test00008_2.stre_cd = 9913;
      Test00008_2.caldr_date = 'abc14';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCaldrMst? Test00008_Rtn = await db.selectDataByPrimaryKey(Test00008_2);
      //取得行がない場合、nullが返ってきます
      if (Test00008_Rtn == null) {
        print('\n********** 異常発生：00008_CCaldrMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00008_Rtn?.comp_cd,9912);
        expect(Test00008_Rtn?.stre_cd,9913);
        expect(Test00008_Rtn?.caldr_date,'abc14');
        expect(Test00008_Rtn?.dayoff_flg,9915);
        expect(Test00008_Rtn?.comment1,'abc16');
        expect(Test00008_Rtn?.comment2,'abc17');
        expect(Test00008_Rtn?.am_weather,9918);
        expect(Test00008_Rtn?.pm_weather,9919);
        expect(Test00008_Rtn?.min_temp,1.220);
        expect(Test00008_Rtn?.max_temp,1.221);
        expect(Test00008_Rtn?.close_flg,9922);
        expect(Test00008_Rtn?.open_rslt,9923);
        expect(Test00008_Rtn?.close_rslt,9924);
        expect(Test00008_Rtn?.rsrv_cust,9925);
        expect(Test00008_Rtn?.ins_datetime,'abc26');
        expect(Test00008_Rtn?.upd_datetime,'abc27');
        expect(Test00008_Rtn?.status,9928);
        expect(Test00008_Rtn?.send_flg,9929);
        expect(Test00008_Rtn?.upd_user,9930);
        expect(Test00008_Rtn?.upd_system,9931);
        expect(Test00008_Rtn?.rsrv_cust_ai,9932);
      }

      //selectAllDataをして件数取得。
      List<CCaldrMst> Test00008_AllRtn2 = await db.selectAllData(Test00008_1);
      int count2 = Test00008_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00008_1);
      print('********** テスト終了：00008_CCaldrMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00009 : SNathldyMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00009_SNathldyMst_01', () async {
      print('\n********** テスト実行：00009_SNathldyMst_01 **********');
      SNathldyMst Test00009_1 = SNathldyMst();
      Test00009_1.caldr_date = 'abc12';
      Test00009_1.comment1 = 'abc13';
      Test00009_1.ins_datetime = 'abc14';
      Test00009_1.upd_datetime = 'abc15';
      Test00009_1.status = 9916;
      Test00009_1.send_flg = 9917;
      Test00009_1.upd_user = 9918;
      Test00009_1.upd_system = 9919;

      //selectAllDataをして件数取得。
      List<SNathldyMst> Test00009_AllRtn = await db.selectAllData(Test00009_1);
      int count = Test00009_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00009_1);

      //データ取得に必要なオブジェクトを用意
      SNathldyMst Test00009_2 = SNathldyMst();
      //Keyの値を設定する
      Test00009_2.caldr_date = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SNathldyMst? Test00009_Rtn = await db.selectDataByPrimaryKey(Test00009_2);
      //取得行がない場合、nullが返ってきます
      if (Test00009_Rtn == null) {
        print('\n********** 異常発生：00009_SNathldyMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00009_Rtn?.caldr_date,'abc12');
        expect(Test00009_Rtn?.comment1,'abc13');
        expect(Test00009_Rtn?.ins_datetime,'abc14');
        expect(Test00009_Rtn?.upd_datetime,'abc15');
        expect(Test00009_Rtn?.status,9916);
        expect(Test00009_Rtn?.send_flg,9917);
        expect(Test00009_Rtn?.upd_user,9918);
        expect(Test00009_Rtn?.upd_system,9919);
      }

      //selectAllDataをして件数取得。
      List<SNathldyMst> Test00009_AllRtn2 = await db.selectAllData(Test00009_1);
      int count2 = Test00009_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00009_1);
      print('********** テスト終了：00009_SNathldyMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00010 : CSub1ClsMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00010_CSub1ClsMst_01', () async {
      print('\n********** テスト実行：00010_CSub1ClsMst_01 **********');
      CSub1ClsMst Test00010_1 = CSub1ClsMst();
      Test00010_1.comp_cd = 9912;
      Test00010_1.stre_cd = 9913;
      Test00010_1.cls_typ = 9914;
      Test00010_1.sub1_lrg_cd = 9915;
      Test00010_1.sub1_mdl_cd = 9916;
      Test00010_1.sub1_sml_cd = 9917;
      Test00010_1.name = 'abc18';
      Test00010_1.short_name = 'abc19';
      Test00010_1.kana_name = 'abc20';
      Test00010_1.rbttarget_flg = 9921;
      Test00010_1.stl_dsc_flg = 9922;
      Test00010_1.stlplus_flg = 9923;
      Test00010_1.pctr_tckt_flg = 9924;
      Test00010_1.ins_datetime = 'abc25';
      Test00010_1.upd_datetime = 'abc26';
      Test00010_1.status = 9927;
      Test00010_1.send_flg = 9928;
      Test00010_1.upd_user = 9929;
      Test00010_1.upd_system = 9930;
      Test00010_1.rbtpremium_per = 1.231;

      //selectAllDataをして件数取得。
      List<CSub1ClsMst> Test00010_AllRtn = await db.selectAllData(Test00010_1);
      int count = Test00010_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00010_1);

      //データ取得に必要なオブジェクトを用意
      CSub1ClsMst Test00010_2 = CSub1ClsMst();
      //Keyの値を設定する
      Test00010_2.comp_cd = 9912;
      Test00010_2.stre_cd = 9913;
      Test00010_2.cls_typ = 9914;
      Test00010_2.sub1_lrg_cd = 9915;
      Test00010_2.sub1_mdl_cd = 9916;
      Test00010_2.sub1_sml_cd = 9917;
      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CSub1ClsMst? Test00010_Rtn = await db.selectDataByPrimaryKey(Test00010_2);
      //取得行がない場合、nullが返ってきます
      if (Test00010_Rtn == null) {
        print('\n********** 異常発生：00010_CSub1ClsMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00010_Rtn?.comp_cd,9912);
        expect(Test00010_Rtn?.stre_cd,9913);
        expect(Test00010_Rtn?.cls_typ,9914);
        expect(Test00010_Rtn?.sub1_lrg_cd,9915);
        expect(Test00010_Rtn?.sub1_mdl_cd,9916);
        expect(Test00010_Rtn?.sub1_sml_cd,9917);
        expect(Test00010_Rtn?.name,'abc18');
        expect(Test00010_Rtn?.short_name,'abc19');
        expect(Test00010_Rtn?.kana_name,'abc20');
        expect(Test00010_Rtn?.rbttarget_flg,9921);
        expect(Test00010_Rtn?.stl_dsc_flg,9922);
        expect(Test00010_Rtn?.stlplus_flg,9923);
        expect(Test00010_Rtn?.pctr_tckt_flg,9924);
        expect(Test00010_Rtn?.ins_datetime,'abc25');
        expect(Test00010_Rtn?.upd_datetime,'abc26');
        expect(Test00010_Rtn?.status,9927);
        expect(Test00010_Rtn?.send_flg,9928);
        expect(Test00010_Rtn?.upd_user,9929);
        expect(Test00010_Rtn?.upd_system,9930);
        expect(Test00010_Rtn?.rbtpremium_per,1.231);
      }

      //selectAllDataをして件数取得。
      List<CSub1ClsMst> Test00010_AllRtn2 = await db.selectAllData(Test00010_1);
      int count2 = Test00010_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00010_1);
      print('********** テスト終了：00010_CSub1ClsMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00011 : CSub2ClsMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00011_CSub2ClsMst_01', () async {
      print('\n********** テスト実行：00011_CSub2ClsMst_01 **********');
      CSub2ClsMst Test00011_1 = CSub2ClsMst();
      Test00011_1.comp_cd = 9912;
      Test00011_1.stre_cd = 9913;
      Test00011_1.cls_typ = 9914;
      Test00011_1.sub2_lrg_cd = 9915;
      Test00011_1.sub2_mdl_cd = 9916;
      Test00011_1.sub2_sml_cd = 9917;
      Test00011_1.name = 'abc18';
      Test00011_1.short_name = 'abc19';
      Test00011_1.kana_name = 'abc20';
      Test00011_1.rbttarget_flg = 9921;
      Test00011_1.stl_dsc_flg = 9922;
      Test00011_1.stlplus_flg = 9923;
      Test00011_1.pctr_tckt_flg = 9924;
      Test00011_1.ins_datetime = 'abc25';
      Test00011_1.upd_datetime = 'abc26';
      Test00011_1.status = 9927;
      Test00011_1.send_flg = 9928;
      Test00011_1.upd_user = 9929;
      Test00011_1.upd_system = 9930;
      Test00011_1.rbtpremium_per = 1.231;

      //selectAllDataをして件数取得。
      List<CSub2ClsMst> Test00011_AllRtn = await db.selectAllData(Test00011_1);
      int count = Test00011_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00011_1);

      //データ取得に必要なオブジェクトを用意
      CSub2ClsMst Test00011_2 = CSub2ClsMst();
      //Keyの値を設定する
      Test00011_2.comp_cd = 9912;
      Test00011_2.stre_cd = 9913;
      Test00011_2.cls_typ = 9914;
      Test00011_2.sub2_lrg_cd = 9915;
      Test00011_2.sub2_mdl_cd = 9916;
      Test00011_2.sub2_sml_cd = 9917;
      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CSub2ClsMst? Test00011_Rtn = await db.selectDataByPrimaryKey(Test00011_2);
      //取得行がない場合、nullが返ってきます
      if (Test00011_Rtn == null) {
        print('\n********** 異常発生：00011_CSub2ClsMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00011_Rtn?.comp_cd,9912);
        expect(Test00011_Rtn?.stre_cd,9913);
        expect(Test00011_Rtn?.cls_typ,9914);
        expect(Test00011_Rtn?.sub2_lrg_cd,9915);
        expect(Test00011_Rtn?.sub2_mdl_cd,9916);
        expect(Test00011_Rtn?.sub2_sml_cd,9917);
        expect(Test00011_Rtn?.name,'abc18');
        expect(Test00011_Rtn?.short_name,'abc19');
        expect(Test00011_Rtn?.kana_name,'abc20');
        expect(Test00011_Rtn?.rbttarget_flg,9921);
        expect(Test00011_Rtn?.stl_dsc_flg,9922);
        expect(Test00011_Rtn?.stlplus_flg,9923);
        expect(Test00011_Rtn?.pctr_tckt_flg,9924);
        expect(Test00011_Rtn?.ins_datetime,'abc25');
        expect(Test00011_Rtn?.upd_datetime,'abc26');
        expect(Test00011_Rtn?.status,9927);
        expect(Test00011_Rtn?.send_flg,9928);
        expect(Test00011_Rtn?.upd_user,9929);
        expect(Test00011_Rtn?.upd_system,9930);
        expect(Test00011_Rtn?.rbtpremium_per,1.231);
      }

      //selectAllDataをして件数取得。
      List<CSub2ClsMst> Test00011_AllRtn2 = await db.selectAllData(Test00011_1);
      int count2 = Test00011_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00011_1);
      print('********** テスト終了：00011_CSub2ClsMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00012 : CPluMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00012_CPluMst_01', () async {
      print('\n********** テスト実行：00012_CPluMst_01 **********');
      CPluMst Test00012_1 = CPluMst();
      Test00012_1.comp_cd = 9912;
      Test00012_1.stre_cd = 9913;
      Test00012_1.plu_cd = 'abc14';
      Test00012_1.lrgcls_cd = 9915;
      Test00012_1.mdlcls_cd = 9916;
      Test00012_1.smlcls_cd = 9917;
      Test00012_1.tnycls_cd = 9918;
      Test00012_1.eos_cd = 'abc19';
      Test00012_1.bar_typ = 9920;
      Test00012_1.item_typ = 9921;
      Test00012_1.item_name = 'abc22';
      Test00012_1.pos_name = 'abc23';
      Test00012_1.list_typcapa = 'abc24';
      Test00012_1.list_prc = 9925;
      Test00012_1.instruct_prc = 9926;
      Test00012_1.pos_prc = 9927;
      Test00012_1.cust_prc = 9928;
      Test00012_1.cost_prc = 1.229;
      Test00012_1.chk_amt = 9930;
      Test00012_1.tax_cd_1 = 9931;
      Test00012_1.tax_cd_2 = 9932;
      Test00012_1.tax_cd_3 = 9933;
      Test00012_1.tax_cd_4 = 9934;
      Test00012_1.cost_tax_cd = 9935;
      Test00012_1.cost_per = 1.236;
      Test00012_1.rbtpremium_per = 1.237;
      Test00012_1.nonact_flg = 9938;
      Test00012_1.prc_chg_flg = 9939;
      Test00012_1.rbttarget_flg = 9940;
      Test00012_1.stl_dsc_flg = 9941;
      Test00012_1.weight_cnt = 9942;
      Test00012_1.plu_tare = 9943;
      Test00012_1.self_cnt_flg = 9944;
      Test00012_1.guara_month = 9945;
      Test00012_1.multprc_flg = 9946;
      Test00012_1.multprc_per = 1.247;
      Test00012_1.weight_flg = 9948;
      Test00012_1.mbrdsc_flg = 9949;
      Test00012_1.mbrdsc_prc = 9950;
      Test00012_1.mny_tckt_flg = 9951;
      Test00012_1.stlplus_flg = 9952;
      Test00012_1.prom_tckt_no = 9953;
      Test00012_1.weight = 9954;
      Test00012_1.pctr_tckt_flg = 9955;
      Test00012_1.btl_prc = 9956;
      Test00012_1.clsdsc_flg = 9957;
      Test00012_1.cpn_flg = 9958;
      Test00012_1.cpn_prc = 9959;
      Test00012_1.plu_cd_flg = 9960;
      Test00012_1.self_alert_flg = 9961;
      Test00012_1.chg_ckt_flg = 9962;
      Test00012_1.self_weight_flg = 9963;
      Test00012_1.msg_name = 'abc64';
      Test00012_1.msg_flg = 9965;
      Test00012_1.msg_name_cd = 9966;
      Test00012_1.pop_msg = 'abc67';
      Test00012_1.pop_msg_flg = 9968;
      Test00012_1.pop_msg_cd = 9969;
      Test00012_1.liqrcls_cd = 9970;
      Test00012_1.liqr_typcapa = 9971;
      Test00012_1.alcohol_per = 1.272;
      Test00012_1.liqrtax_cd = 9973;
      Test00012_1.use1_start_date = 'abc74';
      Test00012_1.use2_start_date = 'abc75';
      Test00012_1.prc_exe_flg = 9976;
      Test00012_1.tmp_exe_flg = 9977;
      Test00012_1.cust_dtl_flg = 9978;
      Test00012_1.tax_exemption_flg = 9979;
      Test00012_1.point_add = 9980;
      Test00012_1.coupon_flg = 9981;
      Test00012_1.kitchen_prn_flg = 9982;
      Test00012_1.pricing_flg = 9983;
      Test00012_1.bc_tckt_cnt = 9984;
      Test00012_1.last_sale_datetime = 'abc85';
      Test00012_1.maker_cd = 9986;
      Test00012_1.user_val_1 = 9987;
      Test00012_1.user_val_2 = 9988;
      Test00012_1.user_val_3 = 9989;
      Test00012_1.user_val_4 = 9990;
      Test00012_1.user_val_5 = 9991;
      Test00012_1.user_val_6 = 'abc92';
      Test00012_1.prc_upd_system = 9993;
      Test00012_1.ins_datetime = 'abc94';
      Test00012_1.upd_datetime = 'abc95';
      Test00012_1.status = 9996;
      Test00012_1.send_flg = 9997;
      Test00012_1.upd_user = 9998;
      Test00012_1.upd_system = 9999;
      Test00012_1.cust_prc2 = 99100;
      Test00012_1.mbrdsc_prc2 = 99101;
      Test00012_1.producer_cd = 99102;
      Test00012_1.certificate_typ = 99103;
      Test00012_1.kind_cd = 99104;
      Test00012_1.div_cd = 99105;
      Test00012_1.sub1_lrg_cd = 99106;
      Test00012_1.sub1_mdl_cd = 99107;
      Test00012_1.sub1_sml_cd = 99108;
      Test00012_1.sub2_lrg_cd = 99109;
      Test00012_1.sub2_mdl_cd = 99110;
      Test00012_1.sub2_sml_cd = 99111;
      Test00012_1.disc_cd = 99112;
      Test00012_1.typ_no = 'abc113';
      Test00012_1.dlug_flg = 99114;
      Test00012_1.otc_flg = 99115;
      Test00012_1.item_flg1 = 99116;
      Test00012_1.item_flg2 = 99117;
      Test00012_1.item_flg3 = 99118;
      Test00012_1.item_flg4 = 99119;
      Test00012_1.item_flg5 = 99120;
      Test00012_1.item_flg6 = 99121;
      Test00012_1.item_flg7 = 99122;
      Test00012_1.item_flg8 = 99123;
      Test00012_1.item_flg9 = 99124;
      Test00012_1.item_flg10 = 99125;
      Test00012_1.dpnt_rbttarget_flg = 99126;
      Test00012_1.dpnt_usetarget_flg = 99127;

      //selectAllDataをして件数取得。
      List<CPluMst> Test00012_AllRtn = await db.selectAllData(Test00012_1);
      int count = Test00012_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00012_1);

      //データ取得に必要なオブジェクトを用意
      CPluMst Test00012_2 = CPluMst();
      //Keyの値を設定する
      Test00012_2.comp_cd = 9912;
      Test00012_2.stre_cd = 9913;
      Test00012_2.plu_cd = 'abc14';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPluMst? Test00012_Rtn = await db.selectDataByPrimaryKey(Test00012_2);
      //取得行がない場合、nullが返ってきます
      if (Test00012_Rtn == null) {
        print('\n********** 異常発生：00012_CPluMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00012_Rtn?.comp_cd,9912);
        expect(Test00012_Rtn?.stre_cd,9913);
        expect(Test00012_Rtn?.plu_cd,'abc14');
        expect(Test00012_Rtn?.lrgcls_cd,9915);
        expect(Test00012_Rtn?.mdlcls_cd,9916);
        expect(Test00012_Rtn?.smlcls_cd,9917);
        expect(Test00012_Rtn?.tnycls_cd,9918);
        expect(Test00012_Rtn?.eos_cd,'abc19');
        expect(Test00012_Rtn?.bar_typ,9920);
        expect(Test00012_Rtn?.item_typ,9921);
        expect(Test00012_Rtn?.item_name,'abc22');
        expect(Test00012_Rtn?.pos_name,'abc23');
        expect(Test00012_Rtn?.list_typcapa,'abc24');
        expect(Test00012_Rtn?.list_prc,9925);
        expect(Test00012_Rtn?.instruct_prc,9926);
        expect(Test00012_Rtn?.pos_prc,9927);
        expect(Test00012_Rtn?.cust_prc,9928);
        expect(Test00012_Rtn?.cost_prc,1.229);
        expect(Test00012_Rtn?.chk_amt,9930);
        expect(Test00012_Rtn?.tax_cd_1,9931);
        expect(Test00012_Rtn?.tax_cd_2,9932);
        expect(Test00012_Rtn?.tax_cd_3,9933);
        expect(Test00012_Rtn?.tax_cd_4,9934);
        expect(Test00012_Rtn?.cost_tax_cd,9935);
        expect(Test00012_Rtn?.cost_per,1.236);
        expect(Test00012_Rtn?.rbtpremium_per,1.237);
        expect(Test00012_Rtn?.nonact_flg,9938);
        expect(Test00012_Rtn?.prc_chg_flg,9939);
        expect(Test00012_Rtn?.rbttarget_flg,9940);
        expect(Test00012_Rtn?.stl_dsc_flg,9941);
        expect(Test00012_Rtn?.weight_cnt,9942);
        expect(Test00012_Rtn?.plu_tare,9943);
        expect(Test00012_Rtn?.self_cnt_flg,9944);
        expect(Test00012_Rtn?.guara_month,9945);
        expect(Test00012_Rtn?.multprc_flg,9946);
        expect(Test00012_Rtn?.multprc_per,1.247);
        expect(Test00012_Rtn?.weight_flg,9948);
        expect(Test00012_Rtn?.mbrdsc_flg,9949);
        expect(Test00012_Rtn?.mbrdsc_prc,9950);
        expect(Test00012_Rtn?.mny_tckt_flg,9951);
        expect(Test00012_Rtn?.stlplus_flg,9952);
        expect(Test00012_Rtn?.prom_tckt_no,9953);
        expect(Test00012_Rtn?.weight,9954);
        expect(Test00012_Rtn?.pctr_tckt_flg,9955);
        expect(Test00012_Rtn?.btl_prc,9956);
        expect(Test00012_Rtn?.clsdsc_flg,9957);
        expect(Test00012_Rtn?.cpn_flg,9958);
        expect(Test00012_Rtn?.cpn_prc,9959);
        expect(Test00012_Rtn?.plu_cd_flg,9960);
        expect(Test00012_Rtn?.self_alert_flg,9961);
        expect(Test00012_Rtn?.chg_ckt_flg,9962);
        expect(Test00012_Rtn?.self_weight_flg,9963);
        expect(Test00012_Rtn?.msg_name,'abc64');
        expect(Test00012_Rtn?.msg_flg,9965);
        expect(Test00012_Rtn?.msg_name_cd,9966);
        expect(Test00012_Rtn?.pop_msg,'abc67');
        expect(Test00012_Rtn?.pop_msg_flg,9968);
        expect(Test00012_Rtn?.pop_msg_cd,9969);
        expect(Test00012_Rtn?.liqrcls_cd,9970);
        expect(Test00012_Rtn?.liqr_typcapa,9971);
        expect(Test00012_Rtn?.alcohol_per,1.272);
        expect(Test00012_Rtn?.liqrtax_cd,9973);
        expect(Test00012_Rtn?.use1_start_date,'abc74');
        expect(Test00012_Rtn?.use2_start_date,'abc75');
        expect(Test00012_Rtn?.prc_exe_flg,9976);
        expect(Test00012_Rtn?.tmp_exe_flg,9977);
        expect(Test00012_Rtn?.cust_dtl_flg,9978);
        expect(Test00012_Rtn?.tax_exemption_flg,9979);
        expect(Test00012_Rtn?.point_add,9980);
        expect(Test00012_Rtn?.coupon_flg,9981);
        expect(Test00012_Rtn?.kitchen_prn_flg,9982);
        expect(Test00012_Rtn?.pricing_flg,9983);
        expect(Test00012_Rtn?.bc_tckt_cnt,9984);
        expect(Test00012_Rtn?.last_sale_datetime,'abc85');
        expect(Test00012_Rtn?.maker_cd,9986);
        expect(Test00012_Rtn?.user_val_1,9987);
        expect(Test00012_Rtn?.user_val_2,9988);
        expect(Test00012_Rtn?.user_val_3,9989);
        expect(Test00012_Rtn?.user_val_4,9990);
        expect(Test00012_Rtn?.user_val_5,9991);
        expect(Test00012_Rtn?.user_val_6,'abc92');
        expect(Test00012_Rtn?.prc_upd_system,9993);
        expect(Test00012_Rtn?.ins_datetime,'abc94');
        expect(Test00012_Rtn?.upd_datetime,'abc95');
        expect(Test00012_Rtn?.status,9996);
        expect(Test00012_Rtn?.send_flg,9997);
        expect(Test00012_Rtn?.upd_user,9998);
        expect(Test00012_Rtn?.upd_system,9999);
        expect(Test00012_Rtn?.cust_prc2,99100);
        expect(Test00012_Rtn?.mbrdsc_prc2,99101);
        expect(Test00012_Rtn?.producer_cd,99102);
        expect(Test00012_Rtn?.certificate_typ,99103);
        expect(Test00012_Rtn?.kind_cd,99104);
        expect(Test00012_Rtn?.div_cd,99105);
        expect(Test00012_Rtn?.sub1_lrg_cd,99106);
        expect(Test00012_Rtn?.sub1_mdl_cd,99107);
        expect(Test00012_Rtn?.sub1_sml_cd,99108);
        expect(Test00012_Rtn?.sub2_lrg_cd,99109);
        expect(Test00012_Rtn?.sub2_mdl_cd,99110);
        expect(Test00012_Rtn?.sub2_sml_cd,99111);
        expect(Test00012_Rtn?.disc_cd,99112);
        expect(Test00012_Rtn?.typ_no,'abc113');
        expect(Test00012_Rtn?.dlug_flg,99114);
        expect(Test00012_Rtn?.otc_flg,99115);
        expect(Test00012_Rtn?.item_flg1,99116);
        expect(Test00012_Rtn?.item_flg2,99117);
        expect(Test00012_Rtn?.item_flg3,99118);
        expect(Test00012_Rtn?.item_flg4,99119);
        expect(Test00012_Rtn?.item_flg5,99120);
        expect(Test00012_Rtn?.item_flg6,99121);
        expect(Test00012_Rtn?.item_flg7,99122);
        expect(Test00012_Rtn?.item_flg8,99123);
        expect(Test00012_Rtn?.item_flg9,99124);
        expect(Test00012_Rtn?.item_flg10,99125);
        expect(Test00012_Rtn?.dpnt_rbttarget_flg,99126);
        expect(Test00012_Rtn?.dpnt_usetarget_flg,99127);
      }

      //selectAllDataをして件数取得。
      List<CPluMst> Test00012_AllRtn2 = await db.selectAllData(Test00012_1);
      int count2 = Test00012_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00012_1);
      print('********** テスト終了：00012_CPluMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00013 : CScanpluMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00013_CScanpluMst_01', () async {
      print('\n********** テスト実行：00013_CScanpluMst_01 **********');
      CScanpluMst Test00013_1 = CScanpluMst();
      Test00013_1.comp_cd = 9912;
      Test00013_1.stre_cd = 9913;
      Test00013_1.sku_cd = 'abc14';
      Test00013_1.plu_cd = 'abc15';
      Test00013_1.ins_datetime = 'abc16';
      Test00013_1.upd_datetime = 'abc17';
      Test00013_1.status = 9918;
      Test00013_1.send_flg = 9919;
      Test00013_1.upd_user = 9920;
      Test00013_1.upd_system = 9921;

      //selectAllDataをして件数取得。
      List<CScanpluMst> Test00013_AllRtn = await db.selectAllData(Test00013_1);
      int count = Test00013_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00013_1);

      //データ取得に必要なオブジェクトを用意
      CScanpluMst Test00013_2 = CScanpluMst();
      //Keyの値を設定する
      Test00013_2.comp_cd = 9912;
      Test00013_2.stre_cd = 9913;
      Test00013_2.sku_cd = 'abc14';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CScanpluMst? Test00013_Rtn = await db.selectDataByPrimaryKey(Test00013_2);
      //取得行がない場合、nullが返ってきます
      if (Test00013_Rtn == null) {
        print('\n********** 異常発生：00013_CScanpluMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00013_Rtn?.comp_cd,9912);
        expect(Test00013_Rtn?.stre_cd,9913);
        expect(Test00013_Rtn?.sku_cd,'abc14');
        expect(Test00013_Rtn?.plu_cd,'abc15');
        expect(Test00013_Rtn?.ins_datetime,'abc16');
        expect(Test00013_Rtn?.upd_datetime,'abc17');
        expect(Test00013_Rtn?.status,9918);
        expect(Test00013_Rtn?.send_flg,9919);
        expect(Test00013_Rtn?.upd_user,9920);
        expect(Test00013_Rtn?.upd_system,9921);
      }

      //selectAllDataをして件数取得。
      List<CScanpluMst> Test00013_AllRtn2 = await db.selectAllData(Test00013_1);
      int count2 = Test00013_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00013_1);
      print('********** テスト終了：00013_CScanpluMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00014 : CSetitemMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00014_CSetitemMst_01', () async {
      print('\n********** テスト実行：00014_CSetitemMst_01 **********');
      CSetitemMst Test00014_1 = CSetitemMst();
      Test00014_1.comp_cd = 9912;
      Test00014_1.setplu_cd = 'abc13';
      Test00014_1.plu_cd = 'abc14';
      Test00014_1.item_qty = 9915;
      Test00014_1.ins_datetime = 'abc16';
      Test00014_1.upd_datetime = 'abc17';
      Test00014_1.status = 9918;
      Test00014_1.send_flg = 9919;
      Test00014_1.upd_user = 9920;
      Test00014_1.upd_system = 9921;

      //selectAllDataをして件数取得。
      List<CSetitemMst> Test00014_AllRtn = await db.selectAllData(Test00014_1);
      int count = Test00014_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00014_1);

      //データ取得に必要なオブジェクトを用意
      CSetitemMst Test00014_2 = CSetitemMst();
      //Keyの値を設定する
      Test00014_2.comp_cd = 9912;
      Test00014_2.setplu_cd = 'abc13';
      Test00014_2.plu_cd = 'abc14';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CSetitemMst? Test00014_Rtn = await db.selectDataByPrimaryKey(Test00014_2);
      //取得行がない場合、nullが返ってきます
      if (Test00014_Rtn == null) {
        print('\n********** 異常発生：00014_CSetitemMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00014_Rtn?.comp_cd,9912);
        expect(Test00014_Rtn?.setplu_cd,'abc13');
        expect(Test00014_Rtn?.plu_cd,'abc14');
        expect(Test00014_Rtn?.item_qty,9915);
        expect(Test00014_Rtn?.ins_datetime,'abc16');
        expect(Test00014_Rtn?.upd_datetime,'abc17');
        expect(Test00014_Rtn?.status,9918);
        expect(Test00014_Rtn?.send_flg,9919);
        expect(Test00014_Rtn?.upd_user,9920);
        expect(Test00014_Rtn?.upd_system,9921);
      }

      //selectAllDataをして件数取得。
      List<CSetitemMst> Test00014_AllRtn2 = await db.selectAllData(Test00014_1);
      int count2 = Test00014_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00014_1);
      print('********** テスト終了：00014_CSetitemMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00015 : CCaseitemMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00015_CCaseitemMst_01', () async {
      print('\n********** テスト実行：00015_CCaseitemMst_01 **********');
      CCaseitemMst Test00015_1 = CCaseitemMst();
      Test00015_1.comp_cd = 9912;
      Test00015_1.caseitem_cd = 'abc13';
      Test00015_1.plu_cd = 'abc14';
      Test00015_1.item_qty = 9915;
      Test00015_1.val_prc = 9916;
      Test00015_1.case_typ = 9917;
      Test00015_1.ins_datetime = 'abc18';
      Test00015_1.upd_datetime = 'abc19';
      Test00015_1.status = 9920;
      Test00015_1.send_flg = 9921;
      Test00015_1.upd_user = 9922;
      Test00015_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CCaseitemMst> Test00015_AllRtn = await db.selectAllData(Test00015_1);
      int count = Test00015_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00015_1);

      //データ取得に必要なオブジェクトを用意
      CCaseitemMst Test00015_2 = CCaseitemMst();
      //Keyの値を設定する
      Test00015_2.comp_cd = 9912;
      Test00015_2.caseitem_cd = 'abc13';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCaseitemMst? Test00015_Rtn = await db.selectDataByPrimaryKey(Test00015_2);
      //取得行がない場合、nullが返ってきます
      if (Test00015_Rtn == null) {
        print('\n********** 異常発生：00015_CCaseitemMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00015_Rtn?.comp_cd,9912);
        expect(Test00015_Rtn?.caseitem_cd,'abc13');
        expect(Test00015_Rtn?.plu_cd,'abc14');
        expect(Test00015_Rtn?.item_qty,9915);
        expect(Test00015_Rtn?.val_prc,9916);
        expect(Test00015_Rtn?.case_typ,9917);
        expect(Test00015_Rtn?.ins_datetime,'abc18');
        expect(Test00015_Rtn?.upd_datetime,'abc19');
        expect(Test00015_Rtn?.status,9920);
        expect(Test00015_Rtn?.send_flg,9921);
        expect(Test00015_Rtn?.upd_user,9922);
        expect(Test00015_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CCaseitemMst> Test00015_AllRtn2 = await db.selectAllData(Test00015_1);
      int count2 = Test00015_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00015_1);
      print('********** テスト終了：00015_CCaseitemMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00016 : CAttribMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00016_CAttribMst_01', () async {
      print('\n********** テスト実行：00016_CAttribMst_01 **********');
      CAttribMst Test00016_1 = CAttribMst();
      Test00016_1.comp_cd = 9912;
      Test00016_1.stre_cd = 9913;
      Test00016_1.attrib_cd = 9914;
      Test00016_1.name = 'abc15';
      Test00016_1.short_name = 'abc16';
      Test00016_1.hq_send_flg = 9917;
      Test00016_1.ins_datetime = 'abc18';
      Test00016_1.upd_datetime = 'abc19';
      Test00016_1.status = 9920;
      Test00016_1.send_flg = 9921;
      Test00016_1.upd_user = 9922;
      Test00016_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CAttribMst> Test00016_AllRtn = await db.selectAllData(Test00016_1);
      int count = Test00016_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00016_1);

      //データ取得に必要なオブジェクトを用意
      CAttribMst Test00016_2 = CAttribMst();
      //Keyの値を設定する
      Test00016_2.comp_cd = 9912;
      Test00016_2.stre_cd = 9913;
      Test00016_2.attrib_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CAttribMst? Test00016_Rtn = await db.selectDataByPrimaryKey(Test00016_2);
      //取得行がない場合、nullが返ってきます
      if (Test00016_Rtn == null) {
        print('\n********** 異常発生：00016_CAttribMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00016_Rtn?.comp_cd,9912);
        expect(Test00016_Rtn?.stre_cd,9913);
        expect(Test00016_Rtn?.attrib_cd,9914);
        expect(Test00016_Rtn?.name,'abc15');
        expect(Test00016_Rtn?.short_name,'abc16');
        expect(Test00016_Rtn?.hq_send_flg,9917);
        expect(Test00016_Rtn?.ins_datetime,'abc18');
        expect(Test00016_Rtn?.upd_datetime,'abc19');
        expect(Test00016_Rtn?.status,9920);
        expect(Test00016_Rtn?.send_flg,9921);
        expect(Test00016_Rtn?.upd_user,9922);
        expect(Test00016_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CAttribMst> Test00016_AllRtn2 = await db.selectAllData(Test00016_1);
      int count2 = Test00016_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00016_1);
      print('********** テスト終了：00016_CAttribMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00017 : CAttribitemMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00017_CAttribitemMst_01', () async {
      print('\n********** テスト実行：00017_CAttribitemMst_01 **********');
      CAttribitemMst Test00017_1 = CAttribitemMst();
      Test00017_1.comp_cd = 9912;
      Test00017_1.stre_cd = 9913;
      Test00017_1.attrib_cd = 9914;
      Test00017_1.plu_cd = 'abc15';
      Test00017_1.ins_datetime = 'abc16';
      Test00017_1.upd_datetime = 'abc17';
      Test00017_1.status = 9918;
      Test00017_1.send_flg = 9919;
      Test00017_1.upd_user = 9920;
      Test00017_1.upd_system = 9921;

      //selectAllDataをして件数取得。
      List<CAttribitemMst> Test00017_AllRtn = await db.selectAllData(Test00017_1);
      int count = Test00017_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00017_1);

      //データ取得に必要なオブジェクトを用意
      CAttribitemMst Test00017_2 = CAttribitemMst();
      //Keyの値を設定する
      Test00017_2.comp_cd = 9912;
      Test00017_2.stre_cd = 9913;
      Test00017_2.attrib_cd = 9914;
      Test00017_2.plu_cd = 'abc15';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CAttribitemMst? Test00017_Rtn = await db.selectDataByPrimaryKey(Test00017_2);
      //取得行がない場合、nullが返ってきます
      if (Test00017_Rtn == null) {
        print('\n********** 異常発生：00017_CAttribitemMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00017_Rtn?.comp_cd,9912);
        expect(Test00017_Rtn?.stre_cd,9913);
        expect(Test00017_Rtn?.attrib_cd,9914);
        expect(Test00017_Rtn?.plu_cd,'abc15');
        expect(Test00017_Rtn?.ins_datetime,'abc16');
        expect(Test00017_Rtn?.upd_datetime,'abc17');
        expect(Test00017_Rtn?.status,9918);
        expect(Test00017_Rtn?.send_flg,9919);
        expect(Test00017_Rtn?.upd_user,9920);
        expect(Test00017_Rtn?.upd_system,9921);
      }

      //selectAllDataをして件数取得。
      List<CAttribitemMst> Test00017_AllRtn2 = await db.selectAllData(Test00017_1);
      int count2 = Test00017_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00017_1);
      print('********** テスト終了：00017_CAttribitemMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00018 : CLiqrclsMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00018_CLiqrclsMst_01', () async {
      print('\n********** テスト実行：00018_CLiqrclsMst_01 **********');
      CLiqrclsMst Test00018_1 = CLiqrclsMst();
      Test00018_1.comp_cd = 9912;
      Test00018_1.liqrcls_cd = 9913;
      Test00018_1.liqrcls_name = 'abc14';
      Test00018_1.prn_order = 9915;
      Test00018_1.odd_flg = 9916;
      Test00018_1.vcnmng = 9917;
      Test00018_1.amt_prn = 9918;
      Test00018_1.amtclr_flg = 9919;
      Test00018_1.powliqr_flg = 9920;
      Test00018_1.ins_datetime = 'abc21';
      Test00018_1.upd_datetime = 'abc22';
      Test00018_1.status = 9923;
      Test00018_1.send_flg = 9924;
      Test00018_1.upd_user = 9925;
      Test00018_1.upd_system = 9926;

      //selectAllDataをして件数取得。
      List<CLiqrclsMst> Test00018_AllRtn = await db.selectAllData(Test00018_1);
      int count = Test00018_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00018_1);

      //データ取得に必要なオブジェクトを用意
      CLiqrclsMst Test00018_2 = CLiqrclsMst();
      //Keyの値を設定する
      Test00018_2.comp_cd = 9912;
      Test00018_2.liqrcls_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CLiqrclsMst? Test00018_Rtn = await db.selectDataByPrimaryKey(Test00018_2);
      //取得行がない場合、nullが返ってきます
      if (Test00018_Rtn == null) {
        print('\n********** 異常発生：00018_CLiqrclsMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00018_Rtn?.comp_cd,9912);
        expect(Test00018_Rtn?.liqrcls_cd,9913);
        expect(Test00018_Rtn?.liqrcls_name,'abc14');
        expect(Test00018_Rtn?.prn_order,9915);
        expect(Test00018_Rtn?.odd_flg,9916);
        expect(Test00018_Rtn?.vcnmng,9917);
        expect(Test00018_Rtn?.amt_prn,9918);
        expect(Test00018_Rtn?.amtclr_flg,9919);
        expect(Test00018_Rtn?.powliqr_flg,9920);
        expect(Test00018_Rtn?.ins_datetime,'abc21');
        expect(Test00018_Rtn?.upd_datetime,'abc22');
        expect(Test00018_Rtn?.status,9923);
        expect(Test00018_Rtn?.send_flg,9924);
        expect(Test00018_Rtn?.upd_user,9925);
        expect(Test00018_Rtn?.upd_system,9926);
      }

      //selectAllDataをして件数取得。
      List<CLiqrclsMst> Test00018_AllRtn2 = await db.selectAllData(Test00018_1);
      int count2 = Test00018_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00018_1);
      print('********** テスト終了：00018_CLiqrclsMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00019 : CMakerMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00019_CMakerMst_01', () async {
      print('\n********** テスト実行：00019_CMakerMst_01 **********');
      CMakerMst Test00019_1 = CMakerMst();
      Test00019_1.comp_cd = 9912;
      Test00019_1.maker_cd = 9913;
      Test00019_1.parentmaker_cd = 9914;
      Test00019_1.name = 'abc15';
      Test00019_1.short_name = 'abc16';
      Test00019_1.kana_name = 'abc17';
      Test00019_1.ins_datetime = 'abc18';
      Test00019_1.upd_datetime = 'abc19';
      Test00019_1.status = 9920;
      Test00019_1.send_flg = 9921;
      Test00019_1.upd_user = 9922;
      Test00019_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CMakerMst> Test00019_AllRtn = await db.selectAllData(Test00019_1);
      int count = Test00019_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00019_1);

      //データ取得に必要なオブジェクトを用意
      CMakerMst Test00019_2 = CMakerMst();
      //Keyの値を設定する
      Test00019_2.comp_cd = 9912;
      Test00019_2.maker_cd = 9913;
      Test00019_2.parentmaker_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMakerMst? Test00019_Rtn = await db.selectDataByPrimaryKey(Test00019_2);
      //取得行がない場合、nullが返ってきます
      if (Test00019_Rtn == null) {
        print('\n********** 異常発生：00019_CMakerMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00019_Rtn?.comp_cd,9912);
        expect(Test00019_Rtn?.maker_cd,9913);
        expect(Test00019_Rtn?.parentmaker_cd,9914);
        expect(Test00019_Rtn?.name,'abc15');
        expect(Test00019_Rtn?.short_name,'abc16');
        expect(Test00019_Rtn?.kana_name,'abc17');
        expect(Test00019_Rtn?.ins_datetime,'abc18');
        expect(Test00019_Rtn?.upd_datetime,'abc19');
        expect(Test00019_Rtn?.status,9920);
        expect(Test00019_Rtn?.send_flg,9921);
        expect(Test00019_Rtn?.upd_user,9922);
        expect(Test00019_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CMakerMst> Test00019_AllRtn2 = await db.selectAllData(Test00019_1);
      int count2 = Test00019_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00019_1);
      print('********** テスト終了：00019_CMakerMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00020 : CProducerMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00020_CProducerMst_01', () async {
      print('\n********** テスト実行：00020_CProducerMst_01 **********');
      CProducerMst Test00020_1 = CProducerMst();
      Test00020_1.comp_cd = 9912;
      Test00020_1.stre_cd = 9913;
      Test00020_1.producer_cd = 9914;
      Test00020_1.name = 'abc15';
      Test00020_1.short_name = 'abc16';
      Test00020_1.ins_datetime = 'abc17';
      Test00020_1.upd_datetime = 'abc18';
      Test00020_1.status = 9919;
      Test00020_1.send_flg = 9920;
      Test00020_1.upd_user = 9921;
      Test00020_1.upd_system = 9922;
      Test00020_1.tax_cd = 9923;
      Test00020_1.producer_misc_1 = 9924;
      Test00020_1.producer_misc_2 = 9925;
      Test00020_1.producer_misc_3 = 9926;
      Test00020_1.producer_misc_4 = 9927;
      Test00020_1.producer_misc_5 = 9928;

      //selectAllDataをして件数取得。
      List<CProducerMst> Test00020_AllRtn = await db.selectAllData(Test00020_1);
      int count = Test00020_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00020_1);

      //データ取得に必要なオブジェクトを用意
      CProducerMst Test00020_2 = CProducerMst();
      //Keyの値を設定する
      Test00020_2.comp_cd = 9912;
      Test00020_2.stre_cd = 9913;
      Test00020_2.producer_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CProducerMst? Test00020_Rtn = await db.selectDataByPrimaryKey(Test00020_2);
      //取得行がない場合、nullが返ってきます
      if (Test00020_Rtn == null) {
        print('\n********** 異常発生：00020_CProducerMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00020_Rtn?.comp_cd,9912);
        expect(Test00020_Rtn?.stre_cd,9913);
        expect(Test00020_Rtn?.producer_cd,9914);
        expect(Test00020_Rtn?.name,'abc15');
        expect(Test00020_Rtn?.short_name,'abc16');
        expect(Test00020_Rtn?.ins_datetime,'abc17');
        expect(Test00020_Rtn?.upd_datetime,'abc18');
        expect(Test00020_Rtn?.status,9919);
        expect(Test00020_Rtn?.send_flg,9920);
        expect(Test00020_Rtn?.upd_user,9921);
        expect(Test00020_Rtn?.upd_system,9922);
        expect(Test00020_Rtn?.tax_cd,9923);
        expect(Test00020_Rtn?.producer_misc_1,9924);
        expect(Test00020_Rtn?.producer_misc_2,9925);
        expect(Test00020_Rtn?.producer_misc_3,9926);
        expect(Test00020_Rtn?.producer_misc_4,9927);
        expect(Test00020_Rtn?.producer_misc_5,9928);
      }

      //selectAllDataをして件数取得。
      List<CProducerMst> Test00020_AllRtn2 = await db.selectAllData(Test00020_1);
      int count2 = Test00020_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00020_1);
      print('********** テスト終了：00020_CProducerMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00021 : CLiqritemMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00021_CLiqritemMst_01', () async {
      print('\n********** テスト実行：00021_CLiqritemMst_01 **********');
      CLiqritemMst Test00021_1 = CLiqritemMst();
      Test00021_1.comp_cd = 9912;
      Test00021_1.liqritem_cd = 9913;
      Test00021_1.liqritem_name1 = 'abc14';
      Test00021_1.liqritem_name2 = 'abc15';
      Test00021_1.liqritem_name3 = 'abc16';
      Test00021_1.powliqr_flg = 9917;
      Test00021_1.data_c_01 = 'abc18';
      Test00021_1.data_c_02 = 'abc19';
      Test00021_1.data_n_01 = 9920;
      Test00021_1.data_n_02 = 9921;
      Test00021_1.ins_datetime = 'abc22';
      Test00021_1.upd_datetime = 'abc23';
      Test00021_1.status = 9924;
      Test00021_1.send_flg = 9925;
      Test00021_1.upd_user = 9926;
      Test00021_1.upd_system = 9927;

      //selectAllDataをして件数取得。
      List<CLiqritemMst> Test00021_AllRtn = await db.selectAllData(Test00021_1);
      int count = Test00021_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00021_1);

      //データ取得に必要なオブジェクトを用意
      CLiqritemMst Test00021_2 = CLiqritemMst();
      //Keyの値を設定する
      Test00021_2.comp_cd = 9912;
      Test00021_2.liqritem_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CLiqritemMst? Test00021_Rtn = await db.selectDataByPrimaryKey(Test00021_2);
      //取得行がない場合、nullが返ってきます
      if (Test00021_Rtn == null) {
        print('\n********** 異常発生：00021_CLiqritemMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00021_Rtn?.comp_cd,9912);
        expect(Test00021_Rtn?.liqritem_cd,9913);
        expect(Test00021_Rtn?.liqritem_name1,'abc14');
        expect(Test00021_Rtn?.liqritem_name2,'abc15');
        expect(Test00021_Rtn?.liqritem_name3,'abc16');
        expect(Test00021_Rtn?.powliqr_flg,9917);
        expect(Test00021_Rtn?.data_c_01,'abc18');
        expect(Test00021_Rtn?.data_c_02,'abc19');
        expect(Test00021_Rtn?.data_n_01,9920);
        expect(Test00021_Rtn?.data_n_02,9921);
        expect(Test00021_Rtn?.ins_datetime,'abc22');
        expect(Test00021_Rtn?.upd_datetime,'abc23');
        expect(Test00021_Rtn?.status,9924);
        expect(Test00021_Rtn?.send_flg,9925);
        expect(Test00021_Rtn?.upd_user,9926);
        expect(Test00021_Rtn?.upd_system,9927);

      }

      //selectAllDataをして件数取得。
      List<CLiqritemMst> Test00021_AllRtn2 = await db.selectAllData(Test00021_1);
      int count2 = Test00021_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00021_1);
      print('********** テスト終了：00021_CLiqritemMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00022 : CLiqrtaxMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00022_CLiqrtaxMst_01', () async {
      print('\n********** テスト実行：00022_CLiqrtaxMst_01 **********');
      CLiqrtaxMst Test00022_1 = CLiqrtaxMst();
      Test00022_1.comp_cd = 9912;
      Test00022_1.liqrtax_cd = 9913;
      Test00022_1.liqrtax_name = 'abc14';
      Test00022_1.liqrtax_rate = 9915;
      Test00022_1.liqrtax_alc = 1.216;
      Test00022_1.liqrtax_add = 1.217;
      Test00022_1.liqrtax_add_amt = 9918;
      Test00022_1.liqrtax_odd_flg = 9919;
      Test00022_1.data_c_01 = 'abc20';
      Test00022_1.data_n_01 = 9921;
      Test00022_1.data_n_02 = 9922;
      Test00022_1.data_n_03 = 1.223;
      Test00022_1.ins_datetime = 'abc24';
      Test00022_1.upd_datetime = 'abc25';
      Test00022_1.status = 9926;
      Test00022_1.send_flg = 9927;
      Test00022_1.upd_user = 9928;
      Test00022_1.upd_system = 9929;

      //selectAllDataをして件数取得。
      List<CLiqrtaxMst> Test00022_AllRtn = await db.selectAllData(Test00022_1);
      int count = Test00022_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00022_1);

      //データ取得に必要なオブジェクトを用意
      CLiqrtaxMst Test00022_2 = CLiqrtaxMst();
      //Keyの値を設定する
      Test00022_2.comp_cd = 9912;
      Test00022_2.liqrtax_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CLiqrtaxMst? Test00022_Rtn = await db.selectDataByPrimaryKey(Test00022_2);
      //取得行がない場合、nullが返ってきます
      if (Test00022_Rtn == null) {
        print('\n********** 異常発生：00022_CLiqrtaxMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00022_Rtn?.comp_cd,9912);
        expect(Test00022_Rtn?.liqrtax_cd,9913);
        expect(Test00022_Rtn?.liqrtax_name,'abc14');
        expect(Test00022_Rtn?.liqrtax_rate,9915);
        expect(Test00022_Rtn?.liqrtax_alc,1.216);
        expect(Test00022_Rtn?.liqrtax_add,1.217);
        expect(Test00022_Rtn?.liqrtax_add_amt,9918);
        expect(Test00022_Rtn?.liqrtax_odd_flg,9919);
        expect(Test00022_Rtn?.data_c_01,'abc20');
        expect(Test00022_Rtn?.data_n_01,9921);
        expect(Test00022_Rtn?.data_n_02,9922);
        expect(Test00022_Rtn?.data_n_03,1.223);
        expect(Test00022_Rtn?.ins_datetime,'abc24');
        expect(Test00022_Rtn?.upd_datetime,'abc25');
        expect(Test00022_Rtn?.status,9926);
        expect(Test00022_Rtn?.send_flg,9927);
        expect(Test00022_Rtn?.upd_user,9928);
        expect(Test00022_Rtn?.upd_system,9929);
      }

      //selectAllDataをして件数取得。
      List<CLiqrtaxMst> Test00022_AllRtn2 = await db.selectAllData(Test00022_1);
      int count2 = Test00022_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00022_1);
      print('********** テスト終了：00022_CLiqrtaxMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00023 : CReginfoMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00023_CReginfoMst_01', () async {
      print('\n********** テスト実行：00023_CReginfoMst_01 **********');
      CReginfoMst Test00023_1 = CReginfoMst();
      Test00023_1.comp_cd = 9912;
      Test00023_1.stre_cd = 9913;
      Test00023_1.mac_no = 9914;
      Test00023_1.mac_typ = 9915;
      Test00023_1.mac_addr = 'abc16';
      Test00023_1.ip_addr = 'abc17';
      Test00023_1.brdcast_addr = 'abc18';
      Test00023_1.ip_addr2 = 'abc19';
      Test00023_1.brdcast_addr2 = 'abc20';
      Test00023_1.org_mac_no = 9921;
      Test00023_1.crdt_trm_cd = 'abc22';
      Test00023_1.set_owner_flg = 9923;
      Test00023_1.mac_role1 = 9924;
      Test00023_1.mac_role2 = 9925;
      Test00023_1.mac_role3 = 9926;
      Test00023_1.pbchg_flg = 9927;
      Test00023_1.auto_opn_cshr_cd = 9928;
      Test00023_1.auto_opn_chkr_cd = 9929;
      Test00023_1.auto_cls_cshr_cd = 9930;
      Test00023_1.start_datetime = 'abc31';
      Test00023_1.end_datetime = 'abc32';
      Test00023_1.ins_datetime = 'abc33';
      Test00023_1.upd_datetime = 'abc34';
      Test00023_1.status = 9935;
      Test00023_1.send_flg = 9936;
      Test00023_1.upd_user = 9937;
      Test00023_1.upd_system = 9938;
      Test00023_1.mac_name = 'abc39';

      //selectAllDataをして件数取得。
      List<CReginfoMst> Test00023_AllRtn = await db.selectAllData(Test00023_1);
      int count = Test00023_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00023_1);

      //データ取得に必要なオブジェクトを用意
      CReginfoMst Test00023_2 = CReginfoMst();
      //Keyの値を設定する
      Test00023_2.comp_cd = 9912;
      Test00023_2.stre_cd = 9913;
      Test00023_2.mac_no = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReginfoMst? Test00023_Rtn = await db.selectDataByPrimaryKey(Test00023_2);
      //取得行がない場合、nullが返ってきます
      if (Test00023_Rtn == null) {
        print('\n********** 異常発生：00023_CReginfoMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00023_Rtn?.comp_cd,9912);
        expect(Test00023_Rtn?.stre_cd,9913);
        expect(Test00023_Rtn?.mac_no,9914);
        expect(Test00023_Rtn?.mac_typ,9915);
        expect(Test00023_Rtn?.mac_addr,'abc16');
        expect(Test00023_Rtn?.ip_addr,'abc17');
        expect(Test00023_Rtn?.brdcast_addr,'abc18');
        expect(Test00023_Rtn?.ip_addr2,'abc19');
        expect(Test00023_Rtn?.brdcast_addr2,'abc20');
        expect(Test00023_Rtn?.org_mac_no,9921);
        expect(Test00023_Rtn?.crdt_trm_cd,'abc22');
        expect(Test00023_Rtn?.set_owner_flg,9923);
        expect(Test00023_Rtn?.mac_role1,9924);
        expect(Test00023_Rtn?.mac_role2,9925);
        expect(Test00023_Rtn?.mac_role3,9926);
        expect(Test00023_Rtn?.pbchg_flg,9927);
        expect(Test00023_Rtn?.auto_opn_cshr_cd,9928);
        expect(Test00023_Rtn?.auto_opn_chkr_cd,9929);
        expect(Test00023_Rtn?.auto_cls_cshr_cd,9930);
        expect(Test00023_Rtn?.start_datetime,'abc31');
        expect(Test00023_Rtn?.end_datetime,'abc32');
        expect(Test00023_Rtn?.ins_datetime,'abc33');
        expect(Test00023_Rtn?.upd_datetime,'abc34');
        expect(Test00023_Rtn?.status,9935);
        expect(Test00023_Rtn?.send_flg,9936);
        expect(Test00023_Rtn?.upd_user,9937);
        expect(Test00023_Rtn?.upd_system,9938);
        expect(Test00023_Rtn?.mac_name,'abc39');
      }

      //selectAllDataをして件数取得。
      List<CReginfoMst> Test00023_AllRtn2 = await db.selectAllData(Test00023_1);
      int count2 = Test00023_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00023_1);
      print('********** テスト終了：00023_CReginfoMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00024 : COpencloseMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00024_COpencloseMst_01', () async {
      print('\n********** テスト実行：00024_COpencloseMst_01 **********');
      COpencloseMst Test00024_1 = COpencloseMst();
      Test00024_1.comp_cd = 9912;
      Test00024_1.stre_cd = 9913;
      Test00024_1.mac_no = 9914;
      Test00024_1.sale_date = 'abc15';
      Test00024_1.open_flg = 9916;
      Test00024_1.close_flg = 9917;
      Test00024_1.not_update_flg = 9918;
      Test00024_1.log_not_sndflg = 9919;
      Test00024_1.custlog_not_sndflg = 9920;
      Test00024_1.custlog_not_delflg = 9921;
      Test00024_1.stepup_flg = 9922;
      Test00024_1.ins_datetime = 'abc23';
      Test00024_1.upd_datetime = 'abc24';
      Test00024_1.status = 9925;
      Test00024_1.send_flg = 9926;
      Test00024_1.upd_user = 9927;
      Test00024_1.upd_system = 9928;
      Test00024_1.pos_ver = 'abc29';
      Test00024_1.pos_sub_ver = 'abc30';
      Test00024_1.recal_flg = 9931;

      //selectAllDataをして件数取得。
      List<COpencloseMst> Test00024_AllRtn = await db.selectAllData(Test00024_1);
      int count = Test00024_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00024_1);

      //データ取得に必要なオブジェクトを用意
      COpencloseMst Test00024_2 = COpencloseMst();
      //Keyの値を設定する
      Test00024_2.comp_cd = 9912;
      Test00024_2.stre_cd = 9913;
      Test00024_2.mac_no = 9914;
      Test00024_2.sale_date = 'abc15';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      COpencloseMst? Test00024_Rtn = await db.selectDataByPrimaryKey(Test00024_2);
      //取得行がない場合、nullが返ってきます
      if (Test00024_Rtn == null) {
        print('\n********** 異常発生：00024_COpencloseMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00024_Rtn?.comp_cd,9912);
        expect(Test00024_Rtn?.stre_cd,9913);
        expect(Test00024_Rtn?.mac_no,9914);
        expect(Test00024_Rtn?.sale_date,'abc15');
        expect(Test00024_Rtn?.open_flg,9916);
        expect(Test00024_Rtn?.close_flg,9917);
        expect(Test00024_Rtn?.not_update_flg,9918);
        expect(Test00024_Rtn?.log_not_sndflg,9919);
        expect(Test00024_Rtn?.custlog_not_sndflg,9920);
        expect(Test00024_Rtn?.custlog_not_delflg,9921);
        expect(Test00024_Rtn?.stepup_flg,9922);
        expect(Test00024_Rtn?.ins_datetime,'abc23');
        expect(Test00024_Rtn?.upd_datetime,'abc24');
        expect(Test00024_Rtn?.status,9925);
        expect(Test00024_Rtn?.send_flg,9926);
        expect(Test00024_Rtn?.upd_user,9927);
        expect(Test00024_Rtn?.upd_system,9928);
        expect(Test00024_Rtn?.pos_ver,'abc29');
        expect(Test00024_Rtn?.pos_sub_ver,'abc30');
        expect(Test00024_Rtn?.recal_flg,9931);
      }

      //selectAllDataをして件数取得。
      List<COpencloseMst> Test00024_AllRtn2 = await db.selectAllData(Test00024_1);
      int count2 = Test00024_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00024_1);
      print('********** テスト終了：00024_COpencloseMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00025 : CRegcnctSioMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00025_CRegcnctSioMst_01', () async {
      print('\n********** テスト実行：00025_CRegcnctSioMst_01 **********');
      CRegcnctSioMst Test00025_1 = CRegcnctSioMst();
      Test00025_1.comp_cd = 9912;
      Test00025_1.stre_cd = 9913;
      Test00025_1.mac_no = 9914;
      Test00025_1.com_port_no = 9915;
      Test00025_1.cnct_kind = 9916;
      Test00025_1.cnct_grp = 9917;
      Test00025_1.sio_rate = 9918;
      Test00025_1.sio_stop = 9919;
      Test00025_1.sio_record = 9920;
      Test00025_1.sio_parity = 9921;
      Test00025_1.qcjc_flg = 9922;
      Test00025_1.ins_datetime = 'abc23';
      Test00025_1.upd_datetime = 'abc24';
      Test00025_1.status = 9925;
      Test00025_1.send_flg = 9926;
      Test00025_1.upd_user = 9927;
      Test00025_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<CRegcnctSioMst> Test00025_AllRtn = await db.selectAllData(Test00025_1);
      int count = Test00025_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00025_1);

      //データ取得に必要なオブジェクトを用意
      CRegcnctSioMst Test00025_2 = CRegcnctSioMst();
      //Keyの値を設定する
      Test00025_2.comp_cd = 9912;
      Test00025_2.stre_cd = 9913;
      Test00025_2.mac_no = 9914;
      Test00025_2.com_port_no = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CRegcnctSioMst? Test00025_Rtn = await db.selectDataByPrimaryKey(Test00025_2);
      //取得行がない場合、nullが返ってきます
      if (Test00025_Rtn == null) {
        print('\n********** 異常発生：00025_CRegcnctSioMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00025_Rtn?.comp_cd,9912);
        expect(Test00025_Rtn?.stre_cd,9913);
        expect(Test00025_Rtn?.mac_no,9914);
        expect(Test00025_Rtn?.com_port_no,9915);
        expect(Test00025_Rtn?.cnct_kind,9916);
        expect(Test00025_Rtn?.cnct_grp,9917);
        expect(Test00025_Rtn?.sio_rate,9918);
        expect(Test00025_Rtn?.sio_stop,9919);
        expect(Test00025_Rtn?.sio_record,9920);
        expect(Test00025_Rtn?.sio_parity,9921);
        expect(Test00025_Rtn?.qcjc_flg,9922);
        expect(Test00025_Rtn?.ins_datetime,'abc23');
        expect(Test00025_Rtn?.upd_datetime,'abc24');
        expect(Test00025_Rtn?.status,9925);
        expect(Test00025_Rtn?.send_flg,9926);
        expect(Test00025_Rtn?.upd_user,9927);
        expect(Test00025_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<CRegcnctSioMst> Test00025_AllRtn2 = await db.selectAllData(Test00025_1);
      int count2 = Test00025_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00025_1);
      print('********** テスト終了：00025_CRegcnctSioMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00026 : CSioMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00026_CSioMst_01', () async {
      print('\n********** テスト実行：00026_CSioMst_01 **********');
      CSioMst Test00026_1 = CSioMst();
      Test00026_1.cnct_kind = 9912;
      Test00026_1.cnct_grp = 9913;
      Test00026_1.drv_sec_name = 'abc14';
      Test00026_1.sio_image_cd = 9915;
      Test00026_1.sio_rate = 9916;
      Test00026_1.sio_stop = 9917;
      Test00026_1.sio_record = 9918;
      Test00026_1.sio_parity = 9919;
      Test00026_1.ins_datetime = 'abc20';
      Test00026_1.upd_datetime = 'abc21';
      Test00026_1.status = 9922;
      Test00026_1.send_flg = 9923;
      Test00026_1.upd_user = 9924;
      Test00026_1.upd_system = 9925;

      //selectAllDataをして件数取得。
      List<CSioMst> Test00026_AllRtn = await db.selectAllData(Test00026_1);
      int count = Test00026_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00026_1);

      //データ取得に必要なオブジェクトを用意
      CSioMst Test00026_2 = CSioMst();
      //Keyの値を設定する
      Test00026_2.cnct_kind = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CSioMst? Test00026_Rtn = await db.selectDataByPrimaryKey(Test00026_2);
      //取得行がない場合、nullが返ってきます
      if (Test00026_Rtn == null) {
        print('\n********** 異常発生：00026_CSioMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00026_Rtn?.cnct_kind,9912);
        expect(Test00026_Rtn?.cnct_grp,9913);
        expect(Test00026_Rtn?.drv_sec_name,'abc14');
        expect(Test00026_Rtn?.sio_image_cd,9915);
        expect(Test00026_Rtn?.sio_rate,9916);
        expect(Test00026_Rtn?.sio_stop,9917);
        expect(Test00026_Rtn?.sio_record,9918);
        expect(Test00026_Rtn?.sio_parity,9919);
        expect(Test00026_Rtn?.ins_datetime,'abc20');
        expect(Test00026_Rtn?.upd_datetime,'abc21');
        expect(Test00026_Rtn?.status,9922);
        expect(Test00026_Rtn?.send_flg,9923);
        expect(Test00026_Rtn?.upd_user,9924);
        expect(Test00026_Rtn?.upd_system,9925);
      }

      //selectAllDataをして件数取得。
      List<CSioMst> Test00026_AllRtn2 = await db.selectAllData(Test00026_1);
      int count2 = Test00026_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00026_1);
      print('********** テスト終了：00026_CSioMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00027 : CReginfoGrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00027_CReginfoGrpMst_01', () async {
      print('\n********** テスト実行：00027_CReginfoGrpMst_01 **********');
      CReginfoGrpMst Test00027_1 = CReginfoGrpMst();
      Test00027_1.comp_cd = 9912;
      Test00027_1.stre_cd = 9913;
      Test00027_1.mac_no = 9914;
      Test00027_1.grp_typ = 9915;
      Test00027_1.grp_cd = 9916;
      Test00027_1.ins_datetime = 'abc17';
      Test00027_1.upd_datetime = 'abc18';
      Test00027_1.status = 9919;
      Test00027_1.send_flg = 9920;
      Test00027_1.upd_user = 9921;
      Test00027_1.upd_system = 9922;

      //selectAllDataをして件数取得。
      List<CReginfoGrpMst> Test00027_AllRtn = await db.selectAllData(Test00027_1);
      int count = Test00027_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00027_1);

      //データ取得に必要なオブジェクトを用意
      CReginfoGrpMst Test00027_2 = CReginfoGrpMst();
      //Keyの値を設定する
      Test00027_2.comp_cd = 9912;
      Test00027_2.stre_cd = 9913;
      Test00027_2.mac_no = 9914;
      Test00027_2.grp_typ = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReginfoGrpMst? Test00027_Rtn = await db.selectDataByPrimaryKey(Test00027_2);
      //取得行がない場合、nullが返ってきます
      if (Test00027_Rtn == null) {
        print('\n********** 異常発生：00027_CReginfoGrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00027_Rtn?.comp_cd,9912);
        expect(Test00027_Rtn?.stre_cd,9913);
        expect(Test00027_Rtn?.mac_no,9914);
        expect(Test00027_Rtn?.grp_typ,9915);
        expect(Test00027_Rtn?.grp_cd,9916);
        expect(Test00027_Rtn?.ins_datetime,'abc17');
        expect(Test00027_Rtn?.upd_datetime,'abc18');
        expect(Test00027_Rtn?.status,9919);
        expect(Test00027_Rtn?.send_flg,9920);
        expect(Test00027_Rtn?.upd_user,9921);
        expect(Test00027_Rtn?.upd_system,9922);
      }

      //selectAllDataをして件数取得。
      List<CReginfoGrpMst> Test00027_AllRtn2 = await db.selectAllData(Test00027_1);
      int count2 = Test00027_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00027_1);
      print('********** テスト終了：00027_CReginfoGrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00028 : CImgMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00028_CImgMst_01', () async {
      print('\n********** テスト実行：00028_CImgMst_01 **********');
      CImgMst Test00028_1 = CImgMst();
      Test00028_1.comp_cd = 9912;
      Test00028_1.stre_cd = 9913;
      Test00028_1.img_grp_cd = 9914;
      Test00028_1.img_cd = 9915;
      Test00028_1.img_data = 'abc16';
      Test00028_1.ins_datetime = 'abc17';
      Test00028_1.upd_datetime = 'abc18';
      Test00028_1.status = 9919;
      Test00028_1.send_flg = 9920;
      Test00028_1.upd_user = 9921;
      Test00028_1.upd_system = 9922;

      //selectAllDataをして件数取得。
      List<CImgMst> Test00028_AllRtn = await db.selectAllData(Test00028_1);
      int count = Test00028_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00028_1);

      //データ取得に必要なオブジェクトを用意
      CImgMst Test00028_2 = CImgMst();
      //Keyの値を設定する
      Test00028_2.comp_cd = 9912;
      Test00028_2.stre_cd = 9913;
      Test00028_2.img_grp_cd = 9914;
      Test00028_2.img_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CImgMst? Test00028_Rtn = await db.selectDataByPrimaryKey(Test00028_2);
      //取得行がない場合、nullが返ってきます
      if (Test00028_Rtn == null) {
        print('\n********** 異常発生：00028_CImgMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00028_Rtn?.comp_cd,9912);
        expect(Test00028_Rtn?.stre_cd,9913);
        expect(Test00028_Rtn?.img_grp_cd,9914);
        expect(Test00028_Rtn?.img_cd,9915);
        expect(Test00028_Rtn?.img_data,'abc16');
        expect(Test00028_Rtn?.ins_datetime,'abc17');
        expect(Test00028_Rtn?.upd_datetime,'abc18');
        expect(Test00028_Rtn?.status,9919);
        expect(Test00028_Rtn?.send_flg,9920);
        expect(Test00028_Rtn?.upd_user,9921);
        expect(Test00028_Rtn?.upd_system,9922);
      }

      //selectAllDataをして件数取得。
      List<CImgMst> Test00028_AllRtn2 = await db.selectAllData(Test00028_1);
      int count2 = Test00028_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00028_1);
      print('********** テスト終了：00028_CImgMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00029 : CPresetMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00029_CPresetMst_01', () async {
      print('\n********** テスト実行：00029_CPresetMst_01 **********');
      CPresetMst Test00029_1 = CPresetMst();
      Test00029_1.comp_cd = 9912;
      Test00029_1.stre_cd = 9913;
      Test00029_1.preset_grp_cd = 9914;
      Test00029_1.preset_cd = 9915;
      Test00029_1.preset_no = 9916;
      Test00029_1.presetcolor = 9917;
      Test00029_1.ky_cd = 9918;
      Test00029_1.ky_plu_cd = 'abc19';
      Test00029_1.ky_smlcls_cd = 9920;
      Test00029_1.ky_size_flg = 9921;
      Test00029_1.ky_status = 9922;
      Test00029_1.ky_name = 'abc23';
      Test00029_1.img_num = 9924;
      Test00029_1.ins_datetime = 'abc25';
      Test00029_1.upd_datetime = 'abc26';
      Test00029_1.status = 9927;
      Test00029_1.send_flg = 9928;
      Test00029_1.upd_user = 9929;
      Test00029_1.upd_system = 9930;

      //selectAllDataをして件数取得。
      List<CPresetMst> Test00029_AllRtn = await db.selectAllData(Test00029_1);
      int count = Test00029_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00029_1);

      //データ取得に必要なオブジェクトを用意
      CPresetMst Test00029_2 = CPresetMst();
      //Keyの値を設定する
      Test00029_2.comp_cd = 9912;
      Test00029_2.stre_cd = 9913;
      Test00029_2.preset_grp_cd = 9914;
      Test00029_2.preset_cd = 9915;
      Test00029_2.preset_no = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPresetMst? Test00029_Rtn = await db.selectDataByPrimaryKey(Test00029_2);
      //取得行がない場合、nullが返ってきます
      if (Test00029_Rtn == null) {
        print('\n********** 異常発生：00029_CPresetMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00029_Rtn?.comp_cd,9912);
        expect(Test00029_Rtn?.stre_cd,9913);
        expect(Test00029_Rtn?.preset_grp_cd,9914);
        expect(Test00029_Rtn?.preset_cd,9915);
        expect(Test00029_Rtn?.preset_no,9916);
        expect(Test00029_Rtn?.presetcolor,9917);
        expect(Test00029_Rtn?.ky_cd,9918);
        expect(Test00029_Rtn?.ky_plu_cd,'abc19');
        expect(Test00029_Rtn?.ky_smlcls_cd,9920);
        expect(Test00029_Rtn?.ky_size_flg,9921);
        expect(Test00029_Rtn?.ky_status,9922);
        expect(Test00029_Rtn?.ky_name,'abc23');
        expect(Test00029_Rtn?.img_num,9924);
        expect(Test00029_Rtn?.ins_datetime,'abc25');
        expect(Test00029_Rtn?.upd_datetime,'abc26');
        expect(Test00029_Rtn?.status,9927);
        expect(Test00029_Rtn?.send_flg,9928);
        expect(Test00029_Rtn?.upd_user,9929);
        expect(Test00029_Rtn?.upd_system,9930);
      }

      //selectAllDataをして件数取得。
      List<CPresetMst> Test00029_AllRtn2 = await db.selectAllData(Test00029_1);
      int count2 = Test00029_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00029_1);
      print('********** テスト終了：00029_CPresetMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00030 : CPresetImgMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00030_CPresetImgMst_01', () async {
      print('\n********** テスト実行：00030_CPresetImgMst_01 **********');
      CPresetImgMst Test00030_1 = CPresetImgMst();
      Test00030_1.comp_cd = 9912;
      Test00030_1.img_num = 9913;
      Test00030_1.cls_cd = 9914;
      Test00030_1.typ = 9915;
      Test00030_1.name = 'abc16';
      Test00030_1.size1 = 9917;
      Test00030_1.size2 = 9918;
      Test00030_1.color = 9919;
      Test00030_1.contrast = 9920;
      Test00030_1.memo = 'abc21';
      Test00030_1.ins_datetime = 'abc22';
      Test00030_1.upd_datetime = 'abc23';
      Test00030_1.status = 9924;
      Test00030_1.send_flg = 9925;
      Test00030_1.upd_user = 9926;
      Test00030_1.upd_system = 9927;

      //selectAllDataをして件数取得。
      List<CPresetImgMst> Test00030_AllRtn = await db.selectAllData(Test00030_1);
      int count = Test00030_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00030_1);

      //データ取得に必要なオブジェクトを用意
      CPresetImgMst Test00030_2 = CPresetImgMst();
      //Keyの値を設定する
      Test00030_2.comp_cd = 9912;
      Test00030_2.img_num = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPresetImgMst? Test00030_Rtn = await db.selectDataByPrimaryKey(Test00030_2);
      //取得行がない場合、nullが返ってきます
      if (Test00030_Rtn == null) {
        print('\n********** 異常発生：00030_CPresetImgMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00030_Rtn?.comp_cd,9912);
        expect(Test00030_Rtn?.img_num,9913);
        expect(Test00030_Rtn?.cls_cd,9914);
        expect(Test00030_Rtn?.typ,9915);
        expect(Test00030_Rtn?.name,'abc16');
        expect(Test00030_Rtn?.size1,9917);
        expect(Test00030_Rtn?.size2,9918);
        expect(Test00030_Rtn?.color,9919);
        expect(Test00030_Rtn?.contrast,9920);
        expect(Test00030_Rtn?.memo,'abc21');
        expect(Test00030_Rtn?.ins_datetime,'abc22');
        expect(Test00030_Rtn?.upd_datetime,'abc23');
        expect(Test00030_Rtn?.status,9924);
        expect(Test00030_Rtn?.send_flg,9925);
        expect(Test00030_Rtn?.upd_user,9926);
        expect(Test00030_Rtn?.upd_system,9927);
      }

      //selectAllDataをして件数取得。
      List<CPresetImgMst> Test00030_AllRtn2 = await db.selectAllData(Test00030_1);
      int count2 = Test00030_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00030_1);
      print('********** テスト終了：00030_CPresetImgMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00031 : CCtrlMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00031_CCtrlMst_01', () async {
      print('\n********** テスト実行：00031_CCtrlMst_01 **********');
      CCtrlMst Test00031_1 = CCtrlMst();
      Test00031_1.comp_cd = 9912;
      Test00031_1.ctrl_cd = 9913;
      Test00031_1.ctrl_data = 1.214;
      Test00031_1.data_typ = 9915;
      Test00031_1.ins_datetime = 'abc16';
      Test00031_1.upd_datetime = 'abc17';
      Test00031_1.status = 9918;
      Test00031_1.send_flg = 9919;
      Test00031_1.upd_user = 9920;
      Test00031_1.upd_system = 9921;

      //selectAllDataをして件数取得。
      List<CCtrlMst> Test00031_AllRtn = await db.selectAllData(Test00031_1);
      int count = Test00031_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00031_1);

      //データ取得に必要なオブジェクトを用意
      CCtrlMst Test00031_2 = CCtrlMst();
      //Keyの値を設定する
      Test00031_2.comp_cd = 9912;
      Test00031_2.ctrl_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCtrlMst? Test00031_Rtn = await db.selectDataByPrimaryKey(Test00031_2);
      //取得行がない場合、nullが返ってきます
      if (Test00031_Rtn == null) {
        print('\n********** 異常発生：00031_CCtrlMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00031_Rtn?.comp_cd,9912);
        expect(Test00031_Rtn?.ctrl_cd,9913);
        expect(Test00031_Rtn?.ctrl_data,1.214);
        expect(Test00031_Rtn?.data_typ,9915);
        expect(Test00031_Rtn?.ins_datetime,'abc16');
        expect(Test00031_Rtn?.upd_datetime,'abc17');
        expect(Test00031_Rtn?.status,9918);
        expect(Test00031_Rtn?.send_flg,9919);
        expect(Test00031_Rtn?.upd_user,9920);
        expect(Test00031_Rtn?.upd_system,9921);
      }

      //selectAllDataをして件数取得。
      List<CCtrlMst> Test00031_AllRtn2 = await db.selectAllData(Test00031_1);
      int count2 = Test00031_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00031_1);
      print('********** テスト終了：00031_CCtrlMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00032 : CCtrlSetMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00032_CCtrlSetMst_01', () async {
      print('\n********** テスト実行：00032_CCtrlSetMst_01 **********');
      CCtrlSetMst Test00032_1 = CCtrlSetMst();
      Test00032_1.ctrl_cd = 9912;
      Test00032_1.ctrl_name = 'abc13';
      Test00032_1.ctrl_dsp_cond = 9914;
      Test00032_1.ctrl_inp_cond = 9915;
      Test00032_1.ctrl_limit_max = 1.216;
      Test00032_1.ctrl_limit_min = 1.217;
      Test00032_1.ctrl_digits = 9918;
      Test00032_1.ctrl_zero_typ = 9919;
      Test00032_1.ctrl_btn_color = 9920;
      Test00032_1.ctrl_info_comment = 'abc21';
      Test00032_1.ctrl_info_pic = 9922;
      Test00032_1.ins_datetime = 'abc23';
      Test00032_1.upd_datetime = 'abc24';
      Test00032_1.status = 9925;
      Test00032_1.send_flg = 9926;
      Test00032_1.upd_user = 9927;
      Test00032_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<CCtrlSetMst> Test00032_AllRtn = await db.selectAllData(Test00032_1);
      int count = Test00032_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00032_1);

      //データ取得に必要なオブジェクトを用意
      CCtrlSetMst Test00032_2 = CCtrlSetMst();
      //Keyの値を設定する
      Test00032_2.ctrl_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCtrlSetMst? Test00032_Rtn = await db.selectDataByPrimaryKey(Test00032_2);
      //取得行がない場合、nullが返ってきます
      if (Test00032_Rtn == null) {
        print('\n********** 異常発生：00032_CCtrlSetMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00032_Rtn?.ctrl_cd,9912);
        expect(Test00032_Rtn?.ctrl_name,'abc13');
        expect(Test00032_Rtn?.ctrl_dsp_cond,9914);
        expect(Test00032_Rtn?.ctrl_inp_cond,9915);
        expect(Test00032_Rtn?.ctrl_limit_max,1.216);
        expect(Test00032_Rtn?.ctrl_limit_min,1.217);
        expect(Test00032_Rtn?.ctrl_digits,9918);
        expect(Test00032_Rtn?.ctrl_zero_typ,9919);
        expect(Test00032_Rtn?.ctrl_btn_color,9920);
        expect(Test00032_Rtn?.ctrl_info_comment,'abc21');
        expect(Test00032_Rtn?.ctrl_info_pic,9922);
        expect(Test00032_Rtn?.ins_datetime,'abc23');
        expect(Test00032_Rtn?.upd_datetime,'abc24');
        expect(Test00032_Rtn?.status,9925);
        expect(Test00032_Rtn?.send_flg,9926);
        expect(Test00032_Rtn?.upd_user,9927);
        expect(Test00032_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<CCtrlSetMst> Test00032_AllRtn2 = await db.selectAllData(Test00032_1);
      int count2 = Test00032_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00032_1);
      print('********** テスト終了：00032_CCtrlSetMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00033 : CCtrlSubMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00033_CCtrlSubMst_01', () async {
      print('\n********** テスト実行：00033_CCtrlSubMst_01 **********');
      CCtrlSubMst Test00033_1 = CCtrlSubMst();
      Test00033_1.ctrl_cd = 9912;
      Test00033_1.ctrl_ordr = 9913;
      Test00033_1.ctrl_data = 1.214;
      Test00033_1.img_cd = 9915;
      Test00033_1.ctrl_comment = 'abc16';
      Test00033_1.ctrl_btn_color = 9917;
      Test00033_1.ins_datetime = 'abc18';
      Test00033_1.upd_datetime = 'abc19';
      Test00033_1.status = 9920;
      Test00033_1.send_flg = 9921;
      Test00033_1.upd_user = 9922;
      Test00033_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CCtrlSubMst> Test00033_AllRtn = await db.selectAllData(Test00033_1);
      int count = Test00033_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00033_1);

      //データ取得に必要なオブジェクトを用意
      CCtrlSubMst Test00033_2 = CCtrlSubMst();
      //Keyの値を設定する
      Test00033_2.ctrl_cd = 9912;
      Test00033_2.ctrl_ordr = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCtrlSubMst? Test00033_Rtn = await db.selectDataByPrimaryKey(Test00033_2);
      //取得行がない場合、nullが返ってきます
      if (Test00033_Rtn == null) {
        print('\n********** 異常発生：00033_CCtrlSubMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00033_Rtn?.ctrl_cd,9912);
        expect(Test00033_Rtn?.ctrl_ordr,9913);
        expect(Test00033_Rtn?.ctrl_data,1.214);
        expect(Test00033_Rtn?.img_cd,9915);
        expect(Test00033_Rtn?.ctrl_comment,'abc16');
        expect(Test00033_Rtn?.ctrl_btn_color,9917);
        expect(Test00033_Rtn?.ins_datetime,'abc18');
        expect(Test00033_Rtn?.upd_datetime,'abc19');
        expect(Test00033_Rtn?.status,9920);
        expect(Test00033_Rtn?.send_flg,9921);
        expect(Test00033_Rtn?.upd_user,9922);
        expect(Test00033_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CCtrlSubMst> Test00033_AllRtn2 = await db.selectAllData(Test00033_1);
      int count2 = Test00033_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00033_1);
      print('********** テスト終了：00033_CCtrlSubMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00034 : CTrmMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00034_CTrmMst_01', () async {
      print('\n********** テスト実行：00034_CTrmMst_01 **********');
      CTrmMst Test00034_1 = CTrmMst();
      Test00034_1.comp_cd = 9912;
      Test00034_1.stre_cd = 9913;
      Test00034_1.trm_grp_cd = 9914;
      Test00034_1.trm_cd = 9915;
      Test00034_1.trm_data = 1.216;
      Test00034_1.trm_data_typ = 9917;
      Test00034_1.ins_datetime = 'abc18';
      Test00034_1.upd_datetime = 'abc19';
      Test00034_1.status = 9920;
      Test00034_1.send_flg = 9921;
      Test00034_1.upd_user = 9922;
      Test00034_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CTrmMst> Test00034_AllRtn = await db.selectAllData(Test00034_1);
      int count = Test00034_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00034_1);

      //データ取得に必要なオブジェクトを用意
      CTrmMst Test00034_2 = CTrmMst();
      //Keyの値を設定する
      Test00034_2.comp_cd = 9912;
      Test00034_2.stre_cd = 9913;
      Test00034_2.trm_grp_cd = 9914;
      Test00034_2.trm_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTrmMst? Test00034_Rtn = await db.selectDataByPrimaryKey(Test00034_2);
      //取得行がない場合、nullが返ってきます
      if (Test00034_Rtn == null) {
        print('\n********** 異常発生：00034_CTrmMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00034_Rtn?.comp_cd,9912);
        expect(Test00034_Rtn?.stre_cd,9913);
        expect(Test00034_Rtn?.trm_grp_cd,9914);
        expect(Test00034_Rtn?.trm_cd,9915);
        expect(Test00034_Rtn?.trm_data,1.216);
        expect(Test00034_Rtn?.trm_data_typ,9917);
        expect(Test00034_Rtn?.ins_datetime,'abc18');
        expect(Test00034_Rtn?.upd_datetime,'abc19');
        expect(Test00034_Rtn?.status,9920);
        expect(Test00034_Rtn?.send_flg,9921);
        expect(Test00034_Rtn?.upd_user,9922);
        expect(Test00034_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CTrmMst> Test00034_AllRtn2 = await db.selectAllData(Test00034_1);
      int count2 = Test00034_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00034_1);
      print('********** テスト終了：00034_CTrmMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00035 : CTrmSetMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00035_CTrmSetMst_01', () async {
      print('\n********** テスト実行：00035_CTrmSetMst_01 **********');
      CTrmSetMst Test00035_1 = CTrmSetMst();
      Test00035_1.trm_cd = 9912;
      Test00035_1.trm_name = 'abc13';
      Test00035_1.trm_dsp_cond = 9914;
      Test00035_1.trm_inp_cond = 9915;
      Test00035_1.trm_limit_max = 1.216;
      Test00035_1.trm_limit_min = 1.217;
      Test00035_1.trm_digits = 9918;
      Test00035_1.trm_zero_typ = 9919;
      Test00035_1.trm_btn_color = 9920;
      Test00035_1.trm_info_comment = 'abc21';
      Test00035_1.trm_info_pic = 9922;
      Test00035_1.ins_datetime = 'abc23';
      Test00035_1.upd_datetime = 'abc24';
      Test00035_1.status = 9925;
      Test00035_1.send_flg = 9926;
      Test00035_1.upd_user = 9927;
      Test00035_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<CTrmSetMst> Test00035_AllRtn = await db.selectAllData(Test00035_1);
      int count = Test00035_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00035_1);

      //データ取得に必要なオブジェクトを用意
      CTrmSetMst Test00035_2 = CTrmSetMst();
      //Keyの値を設定する
      Test00035_2.trm_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTrmSetMst? Test00035_Rtn = await db.selectDataByPrimaryKey(Test00035_2);
      //取得行がない場合、nullが返ってきます
      if (Test00035_Rtn == null) {
        print('\n********** 異常発生：00035_CTrmSetMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00035_Rtn?.trm_cd,9912);
        expect(Test00035_Rtn?.trm_name,'abc13');
        expect(Test00035_Rtn?.trm_dsp_cond,9914);
        expect(Test00035_Rtn?.trm_inp_cond,9915);
        expect(Test00035_Rtn?.trm_limit_max,1.216);
        expect(Test00035_Rtn?.trm_limit_min,1.217);
        expect(Test00035_Rtn?.trm_digits,9918);
        expect(Test00035_Rtn?.trm_zero_typ,9919);
        expect(Test00035_Rtn?.trm_btn_color,9920);
        expect(Test00035_Rtn?.trm_info_comment,'abc21');
        expect(Test00035_Rtn?.trm_info_pic,9922);
        expect(Test00035_Rtn?.ins_datetime,'abc23');
        expect(Test00035_Rtn?.upd_datetime,'abc24');
        expect(Test00035_Rtn?.status,9925);
        expect(Test00035_Rtn?.send_flg,9926);
        expect(Test00035_Rtn?.upd_user,9927);
        expect(Test00035_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<CTrmSetMst> Test00035_AllRtn2 = await db.selectAllData(Test00035_1);
      int count2 = Test00035_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00035_1);
      print('********** テスト終了：00035_CTrmSetMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00036 : CTrmSubMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00036_CTrmSubMst_01', () async {
      print('\n********** テスト実行：00036_CTrmSubMst_01 **********');
      CTrmSubMst Test00036_1 = CTrmSubMst();
      Test00036_1.trm_cd = 9912;
      Test00036_1.trm_ordr = 9913;
      Test00036_1.trm_data = 1.214;
      Test00036_1.fnc_cd = 9915;
      Test00036_1.img_cd = 9916;
      Test00036_1.trm_comment = 'abc17';
      Test00036_1.trm_btn_color = 9918;
      Test00036_1.ins_datetime = 'abc19';
      Test00036_1.upd_datetime = 'abc20';
      Test00036_1.status = 9921;
      Test00036_1.send_flg = 9922;
      Test00036_1.upd_user = 9923;
      Test00036_1.upd_system = 9924;

      //selectAllDataをして件数取得。
      List<CTrmSubMst> Test00036_AllRtn = await db.selectAllData(Test00036_1);
      int count = Test00036_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00036_1);

      //データ取得に必要なオブジェクトを用意
      CTrmSubMst Test00036_2 = CTrmSubMst();
      //Keyの値を設定する
      Test00036_2.trm_cd = 9912;
      Test00036_2.trm_ordr = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTrmSubMst? Test00036_Rtn = await db.selectDataByPrimaryKey(Test00036_2);
      //取得行がない場合、nullが返ってきます
      if (Test00036_Rtn == null) {
        print('\n********** 異常発生：00036_CTrmSubMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00036_Rtn?.trm_cd,9912);
        expect(Test00036_Rtn?.trm_ordr,9913);
        expect(Test00036_Rtn?.trm_data,1.214);
        expect(Test00036_Rtn?.fnc_cd,9915);
        expect(Test00036_Rtn?.img_cd,9916);
        expect(Test00036_Rtn?.trm_comment,'abc17');
        expect(Test00036_Rtn?.trm_btn_color,9918);
        expect(Test00036_Rtn?.ins_datetime,'abc19');
        expect(Test00036_Rtn?.upd_datetime,'abc20');
        expect(Test00036_Rtn?.status,9921);
        expect(Test00036_Rtn?.send_flg,9922);
        expect(Test00036_Rtn?.upd_user,9923);
        expect(Test00036_Rtn?.upd_system,9924);
      }

      //selectAllDataをして件数取得。
      List<CTrmSubMst> Test00036_AllRtn2 = await db.selectAllData(Test00036_1);
      int count2 = Test00036_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00036_1);
      print('********** テスト終了：00036_CTrmSubMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00037 : CTrmMenuMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00037_CTrmMenuMst_01', () async {
      print('\n********** テスト実行：00037_CTrmMenuMst_01 **********');
      CTrmMenuMst Test00037_1 = CTrmMenuMst();
      Test00037_1.comp_cd = 9912;
      Test00037_1.stre_cd = 9913;
      Test00037_1.menu_kind = 9914;
      Test00037_1.trm_title = 'abc15';
      Test00037_1.trm_btn_max = 9916;
      Test00037_1.trm_page = 9917;
      Test00037_1.trm_btn_pos = 9918;
      Test00037_1.trm_btn_name = 'abc19';
      Test00037_1.trm_btn_color = 9920;
      Test00037_1.trm_menu = 9921;
      Test00037_1.trm_tag = 9922;
      Test00037_1.trm_quick = 9923;
      Test00037_1.cust_disp_flg = 9924;
      Test00037_1.ins_datetime = 'abc25';
      Test00037_1.upd_datetime = 'abc26';
      Test00037_1.status = 9927;
      Test00037_1.send_flg = 9928;
      Test00037_1.upd_user = 9929;
      Test00037_1.upd_system = 9930;

      //selectAllDataをして件数取得。
      List<CTrmMenuMst> Test00037_AllRtn = await db.selectAllData(Test00037_1);
      int count = Test00037_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00037_1);

      //データ取得に必要なオブジェクトを用意
      CTrmMenuMst Test00037_2 = CTrmMenuMst();
      //Keyの値を設定する
      Test00037_2.comp_cd = 9912;
      Test00037_2.stre_cd = 9913;
      Test00037_2.menu_kind = 9914;
      Test00037_2.trm_page = 9917;
      Test00037_2.trm_btn_pos = 9918;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTrmMenuMst? Test00037_Rtn = await db.selectDataByPrimaryKey(Test00037_2);
      //取得行がない場合、nullが返ってきます
      if (Test00037_Rtn == null) {
        print('\n********** 異常発生：00037_CTrmMenuMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00037_Rtn?.comp_cd,9912);
        expect(Test00037_Rtn?.stre_cd,9913);
        expect(Test00037_Rtn?.menu_kind,9914);
        expect(Test00037_Rtn?.trm_title,'abc15');
        expect(Test00037_Rtn?.trm_btn_max,9916);
        expect(Test00037_Rtn?.trm_page,9917);
        expect(Test00037_Rtn?.trm_btn_pos,9918);
        expect(Test00037_Rtn?.trm_btn_name,'abc19');
        expect(Test00037_Rtn?.trm_btn_color,9920);
        expect(Test00037_Rtn?.trm_menu,9921);
        expect(Test00037_Rtn?.trm_tag,9922);
        expect(Test00037_Rtn?.trm_quick,9923);
        expect(Test00037_Rtn?.cust_disp_flg,9924);
        expect(Test00037_Rtn?.ins_datetime,'abc25');
        expect(Test00037_Rtn?.upd_datetime,'abc26');
        expect(Test00037_Rtn?.status,9927);
        expect(Test00037_Rtn?.send_flg,9928);
        expect(Test00037_Rtn?.upd_user,9929);
        expect(Test00037_Rtn?.upd_system,9930);
      }

      //selectAllDataをして件数取得。
      List<CTrmMenuMst> Test00037_AllRtn2 = await db.selectAllData(Test00037_1);
      int count2 = Test00037_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00037_1);
      print('********** テスト終了：00037_CTrmMenuMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00038 : CTrmTagGrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00038_CTrmTagGrpMst_01', () async {
      print('\n********** テスト実行：00038_CTrmTagGrpMst_01 **********');
      CTrmTagGrpMst Test00038_1 = CTrmTagGrpMst();
      Test00038_1.comp_cd = 9912;
      Test00038_1.stre_cd = 9913;
      Test00038_1.trm_tag = 9914;
      Test00038_1.trm_ordr = 9915;
      Test00038_1.trm_cd = 9916;
      Test00038_1.ins_datetime = 'abc17';
      Test00038_1.upd_datetime = 'abc18';
      Test00038_1.status = 9919;
      Test00038_1.send_flg = 9920;
      Test00038_1.upd_user = 9921;
      Test00038_1.upd_system = 9922;

      //selectAllDataをして件数取得。
      List<CTrmTagGrpMst> Test00038_AllRtn = await db.selectAllData(Test00038_1);
      int count = Test00038_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00038_1);

      //データ取得に必要なオブジェクトを用意
      CTrmTagGrpMst Test00038_2 = CTrmTagGrpMst();
      //Keyの値を設定する
      Test00038_2.comp_cd = 9912;
      Test00038_2.stre_cd = 9913;
      Test00038_2.trm_tag = 9914;
      Test00038_2.trm_ordr = 9915;
      Test00038_2.trm_cd = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTrmTagGrpMst? Test00038_Rtn = await db.selectDataByPrimaryKey(Test00038_2);
      //取得行がない場合、nullが返ってきます
      if (Test00038_Rtn == null) {
        print('\n********** 異常発生：00038_CTrmTagGrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00038_Rtn?.comp_cd,9912);
        expect(Test00038_Rtn?.stre_cd,9913);
        expect(Test00038_Rtn?.trm_tag,9914);
        expect(Test00038_Rtn?.trm_ordr,9915);
        expect(Test00038_Rtn?.trm_cd,9916);
        expect(Test00038_Rtn?.ins_datetime,'abc17');
        expect(Test00038_Rtn?.upd_datetime,'abc18');
        expect(Test00038_Rtn?.status,9919);
        expect(Test00038_Rtn?.send_flg,9920);
        expect(Test00038_Rtn?.upd_user,9921);
        expect(Test00038_Rtn?.upd_system,9922);
      }

      //selectAllDataをして件数取得。
      List<CTrmTagGrpMst> Test00038_AllRtn2 = await db.selectAllData(Test00038_1);
      int count2 = Test00038_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00038_1);
      print('********** テスト終了：00038_CTrmTagGrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00039 : CKeyfncMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00039_CKeyfncMst_01', () async {
      print('\n********** テスト実行：00039_CKeyfncMst_01 **********');
      CKeyfncMst Test00039_1 = CKeyfncMst();
      Test00039_1.comp_cd = 9912;
      Test00039_1.stre_cd = 9913;
      Test00039_1.kopt_grp_cd = 9914;
      Test00039_1.fnc_cd = 9915;
      Test00039_1.fnc_name = 'abc16';
      Test00039_1.fnc_comment = 'abc17';
      Test00039_1.fnc_disp_flg = 9918;
      Test00039_1.ins_datetime = 'abc19';
      Test00039_1.upd_datetime = 'abc20';
      Test00039_1.status = 9921;
      Test00039_1.send_flg = 9922;
      Test00039_1.upd_user = 9923;
      Test00039_1.upd_system = 9924;
      Test00039_1.ext_preset_disp = 9925;

      //selectAllDataをして件数取得。
      List<CKeyfncMst> Test00039_AllRtn = await db.selectAllData(Test00039_1);
      int count = Test00039_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00039_1);

      //データ取得に必要なオブジェクトを用意
      CKeyfncMst Test00039_2 = CKeyfncMst();
      //Keyの値を設定する
      Test00039_2.comp_cd = 9912;
      Test00039_2.stre_cd = 9913;
      Test00039_2.kopt_grp_cd = 9914;
      Test00039_2.fnc_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CKeyfncMst? Test00039_Rtn = await db.selectDataByPrimaryKey(Test00039_2);
      //取得行がない場合、nullが返ってきます
      if (Test00039_Rtn == null) {
        print('\n********** 異常発生：00039_CKeyfncMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00039_Rtn?.comp_cd,9912);
        expect(Test00039_Rtn?.stre_cd,9913);
        expect(Test00039_Rtn?.kopt_grp_cd,9914);
        expect(Test00039_Rtn?.fnc_cd,9915);
        expect(Test00039_Rtn?.fnc_name,'abc16');
        expect(Test00039_Rtn?.fnc_comment,'abc17');
        expect(Test00039_Rtn?.fnc_disp_flg,9918);
        expect(Test00039_Rtn?.ins_datetime,'abc19');
        expect(Test00039_Rtn?.upd_datetime,'abc20');
        expect(Test00039_Rtn?.status,9921);
        expect(Test00039_Rtn?.send_flg,9922);
        expect(Test00039_Rtn?.upd_user,9923);
        expect(Test00039_Rtn?.upd_system,9924);
        expect(Test00039_Rtn?.ext_preset_disp,9925);
      }

      //selectAllDataをして件数取得。
      List<CKeyfncMst> Test00039_AllRtn2 = await db.selectAllData(Test00039_1);
      int count2 = Test00039_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00039_1);
      print('********** テスト終了：00039_CKeyfncMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00040 : CKeyoptMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00040_CKeyoptMst_01', () async {
      print('\n********** テスト実行：00040_CKeyoptMst_01 **********');
      CKeyoptMst Test00040_1 = CKeyoptMst();
      Test00040_1.comp_cd = 9912;
      Test00040_1.stre_cd = 9913;
      Test00040_1.kopt_grp_cd = 9914;
      Test00040_1.fnc_cd = 9915;
      Test00040_1.kopt_cd = 9916;
      Test00040_1.kopt_data = 9917;
      Test00040_1.kopt_str_data = 'abc18';
      Test00040_1.ins_datetime = 'abc19';
      Test00040_1.upd_datetime = 'abc20';
      Test00040_1.status = 9921;
      Test00040_1.send_flg = 9922;
      Test00040_1.upd_user = 9923;
      Test00040_1.upd_system = 9924;

      //selectAllDataをして件数取得。
      List<CKeyoptMst> Test00040_AllRtn = await db.selectAllData(Test00040_1);
      int count = Test00040_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00040_1);

      //データ取得に必要なオブジェクトを用意
      CKeyoptMst Test00040_2 = CKeyoptMst();
      //Keyの値を設定する
      Test00040_2.comp_cd = 9912;
      Test00040_2.stre_cd = 9913;
      Test00040_2.kopt_grp_cd = 9914;
      Test00040_2.fnc_cd = 9915;
      Test00040_2.kopt_cd = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CKeyoptMst? Test00040_Rtn = await db.selectDataByPrimaryKey(Test00040_2);
      //取得行がない場合、nullが返ってきます
      if (Test00040_Rtn == null) {
        print('\n********** 異常発生：00040_CKeyoptMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00040_Rtn?.comp_cd,9912);
        expect(Test00040_Rtn?.stre_cd,9913);
        expect(Test00040_Rtn?.kopt_grp_cd,9914);
        expect(Test00040_Rtn?.fnc_cd,9915);
        expect(Test00040_Rtn?.kopt_cd,9916);
        expect(Test00040_Rtn?.kopt_data,9917);
        expect(Test00040_Rtn?.kopt_str_data,'abc18');
        expect(Test00040_Rtn?.ins_datetime,'abc19');
        expect(Test00040_Rtn?.upd_datetime,'abc20');
        expect(Test00040_Rtn?.status,9921);
        expect(Test00040_Rtn?.send_flg,9922);
        expect(Test00040_Rtn?.upd_user,9923);
        expect(Test00040_Rtn?.upd_system,9924);
      }

      //selectAllDataをして件数取得。
      List<CKeyoptMst> Test00040_AllRtn2 = await db.selectAllData(Test00040_1);
      int count2 = Test00040_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00040_1);
      print('********** テスト終了：00040_CKeyoptMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00041 : CKeykindMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00041_CKeykindMst_01', () async {
      print('\n********** テスト実行：00041_CKeykindMst_01 **********');
      CKeykindMst Test00041_1 = CKeykindMst();
      Test00041_1.key_kind_cd = 9912;
      Test00041_1.kind_name = 'abc13';

      //selectAllDataをして件数取得。
      List<CKeykindMst> Test00041_AllRtn = await db.selectAllData(Test00041_1);
      int count = Test00041_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00041_1);

      //データ取得に必要なオブジェクトを用意
      CKeykindMst Test00041_2 = CKeykindMst();
      //Keyの値を設定する
      Test00041_2.key_kind_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CKeykindMst? Test00041_Rtn = await db.selectDataByPrimaryKey(Test00041_2);
      //取得行がない場合、nullが返ってきます
      if (Test00041_Rtn == null) {
        print('\n********** 異常発生：00041_CKeykindMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00041_Rtn?.key_kind_cd,9912);
        expect(Test00041_Rtn?.kind_name,'abc13');
      }

      //selectAllDataをして件数取得。
      List<CKeykindMst> Test00041_AllRtn2 = await db.selectAllData(Test00041_1);
      int count2 = Test00041_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00041_1);
      print('********** テスト終了：00041_CKeykindMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00042 : CKeykindGrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00042_CKeykindGrpMst_01', () async {
      print('\n********** テスト実行：00042_CKeykindGrpMst_01 **********');
      CKeykindGrpMst Test00042_1 = CKeykindGrpMst();
      Test00042_1.key_kind_cd = 9912;
      Test00042_1.fnc_cd = 9913;
      Test00042_1.ref_fnc_cd = 9914;

      //selectAllDataをして件数取得。
      List<CKeykindGrpMst> Test00042_AllRtn = await db.selectAllData(Test00042_1);
      int count = Test00042_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00042_1);

      //データ取得に必要なオブジェクトを用意
      CKeykindGrpMst Test00042_2 = CKeykindGrpMst();
      //Keyの値を設定する
      Test00042_2.key_kind_cd = 9912;
      Test00042_2.fnc_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CKeykindGrpMst? Test00042_Rtn = await db.selectDataByPrimaryKey(Test00042_2);
      //取得行がない場合、nullが返ってきます
      if (Test00042_Rtn == null) {
        print('\n********** 異常発生：00042_CKeykindGrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00042_Rtn?.key_kind_cd,9912);
        expect(Test00042_Rtn?.fnc_cd,9913);
        expect(Test00042_Rtn?.ref_fnc_cd,9914);
      }

      //selectAllDataをして件数取得。
      List<CKeykindGrpMst> Test00042_AllRtn2 = await db.selectAllData(Test00042_1);
      int count2 = Test00042_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00042_1);
      print('********** テスト終了：00042_CKeykindGrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00043 : CKeyoptSetMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00043_CKeyoptSetMst_01', () async {
      print('\n********** テスト実行：00043_CKeyoptSetMst_01 **********');
      CKeyoptSetMst Test00043_1 = CKeyoptSetMst();
      Test00043_1.ref_fnc_cd = 9912;
      Test00043_1.kopt_cd = 9913;
      Test00043_1.kopt_name = 'abc14';
      Test00043_1.kopt_dsp_cond = 9915;
      Test00043_1.kopt_inp_cond = 9916;
      Test00043_1.kopt_limit_max = 9917;
      Test00043_1.kopt_limit_min = 9918;
      Test00043_1.kopt_digits = 9919;
      Test00043_1.kopt_zero_typ = 9920;
      Test00043_1.kopt_btn_color = 9921;
      Test00043_1.kopt_info_comment = 'abc22';
      Test00043_1.kopt_info_pic = 9923;
      Test00043_1.kopt_div_kind_cd = 9924;

      //selectAllDataをして件数取得。
      List<CKeyoptSetMst> Test00043_AllRtn = await db.selectAllData(Test00043_1);
      int count = Test00043_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00043_1);

      //データ取得に必要なオブジェクトを用意
      CKeyoptSetMst Test00043_2 = CKeyoptSetMst();
      //Keyの値を設定する
      Test00043_2.ref_fnc_cd = 9912;
      Test00043_2.kopt_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CKeyoptSetMst? Test00043_Rtn = await db.selectDataByPrimaryKey(Test00043_2);
      //取得行がない場合、nullが返ってきます
      if (Test00043_Rtn == null) {
        print('\n********** 異常発生：00043_CKeyoptSetMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00043_Rtn?.ref_fnc_cd,9912);
        expect(Test00043_Rtn?.kopt_cd,9913);
        expect(Test00043_Rtn?.kopt_name,'abc14');
        expect(Test00043_Rtn?.kopt_dsp_cond,9915);
        expect(Test00043_Rtn?.kopt_inp_cond,9916);
        expect(Test00043_Rtn?.kopt_limit_max,9917);
        expect(Test00043_Rtn?.kopt_limit_min,9918);
        expect(Test00043_Rtn?.kopt_digits,9919);
        expect(Test00043_Rtn?.kopt_zero_typ,9920);
        expect(Test00043_Rtn?.kopt_btn_color,9921);
        expect(Test00043_Rtn?.kopt_info_comment,'abc22');
        expect(Test00043_Rtn?.kopt_info_pic,9923);
        expect(Test00043_Rtn?.kopt_div_kind_cd,9924);
      }

      //selectAllDataをして件数取得。
      List<CKeyoptSetMst> Test00043_AllRtn2 = await db.selectAllData(Test00043_1);
      int count2 = Test00043_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00043_1);
      print('********** テスト終了：00043_CKeyoptSetMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00044 : CKeyoptSubMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00044_CKeyoptSubMst_01', () async {
      print('\n********** テスト実行：00044_CKeyoptSubMst_01 **********');
      CKeyoptSubMst Test00044_1 = CKeyoptSubMst();
      Test00044_1.ref_fnc_cd = 9912;
      Test00044_1.kopt_cd = 9913;
      Test00044_1.koptsub_ordr = 9914;
      Test00044_1.koptsub_data = 9915;
      Test00044_1.fnc_cd = 9916;
      Test00044_1.img_cd = 9917;
      Test00044_1.koptsub_comment = 'abc18';
      Test00044_1.koptsub_btn_color = 9919;

      //selectAllDataをして件数取得。
      List<CKeyoptSubMst> Test00044_AllRtn = await db.selectAllData(Test00044_1);
      int count = Test00044_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00044_1);

      //データ取得に必要なオブジェクトを用意
      CKeyoptSubMst Test00044_2 = CKeyoptSubMst();
      //Keyの値を設定する
      Test00044_2.ref_fnc_cd = 9912;
      Test00044_2.kopt_cd = 9913;
      Test00044_2.koptsub_ordr = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CKeyoptSubMst? Test00044_Rtn = await db.selectDataByPrimaryKey(Test00044_2);
      //取得行がない場合、nullが返ってきます
      if (Test00044_Rtn == null) {
        print('\n********** 異常発生：00044_CKeyoptSubMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00044_Rtn?.ref_fnc_cd,9912);
        expect(Test00044_Rtn?.kopt_cd,9913);
        expect(Test00044_Rtn?.koptsub_ordr,9914);
        expect(Test00044_Rtn?.koptsub_data,9915);
        expect(Test00044_Rtn?.fnc_cd,9916);
        expect(Test00044_Rtn?.img_cd,9917);
        expect(Test00044_Rtn?.koptsub_comment,'abc18');
        expect(Test00044_Rtn?.koptsub_btn_color,9919);
      }

      //selectAllDataをして件数取得。
      List<CKeyoptSubMst> Test00044_AllRtn2 = await db.selectAllData(Test00044_1);
      int count2 = Test00044_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00044_1);
      print('********** テスト終了：00044_CKeyoptSubMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00045 : CDivideMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00045_CDivideMst_01', () async {
      print('\n********** テスト実行：00045_CDivideMst_01 **********');
      CDivideMst Test00045_1 = CDivideMst();
      Test00045_1.comp_cd = 9912;
      Test00045_1.kind_cd = 9913;
      Test00045_1.div_cd = 9914;
      Test00045_1.name = 'abc15';
      Test00045_1.short_name = 'abc16';
      Test00045_1.exp_cd1 = 9917;
      Test00045_1.exp_cd2 = 9918;
      Test00045_1.exp_data = 'abc19';
      Test00045_1.ins_datetime = 'abc20';
      Test00045_1.upd_datetime = 'abc21';
      Test00045_1.status = 9922;
      Test00045_1.send_flg = 9923;
      Test00045_1.upd_user = 9924;
      Test00045_1.upd_system = 9925;
      Test00045_1.exp_amt = 9926;

      //selectAllDataをして件数取得。
      List<CDivideMst> Test00045_AllRtn = await db.selectAllData(Test00045_1);
      int count = Test00045_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00045_1);

      //データ取得に必要なオブジェクトを用意
      CDivideMst Test00045_2 = CDivideMst();
      //Keyの値を設定する
      Test00045_2.comp_cd = 9912;
      Test00045_2.kind_cd = 9913;
      Test00045_2.div_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDivideMst? Test00045_Rtn = await db.selectDataByPrimaryKey(Test00045_2);
      //取得行がない場合、nullが返ってきます
      if (Test00045_Rtn == null) {
        print('\n********** 異常発生：00045_CDivideMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00045_Rtn?.comp_cd,9912);
        expect(Test00045_Rtn?.kind_cd,9913);
        expect(Test00045_Rtn?.div_cd,9914);
        expect(Test00045_Rtn?.name,'abc15');
        expect(Test00045_Rtn?.short_name,'abc16');
        expect(Test00045_Rtn?.exp_cd1,9917);
        expect(Test00045_Rtn?.exp_cd2,9918);
        expect(Test00045_Rtn?.exp_data,'abc19');
        expect(Test00045_Rtn?.ins_datetime,'abc20');
        expect(Test00045_Rtn?.upd_datetime,'abc21');
        expect(Test00045_Rtn?.status,9922);
        expect(Test00045_Rtn?.send_flg,9923);
        expect(Test00045_Rtn?.upd_user,9924);
        expect(Test00045_Rtn?.upd_system,9925);
        expect(Test00045_Rtn?.exp_amt,9926);
      }

      //selectAllDataをして件数取得。
      List<CDivideMst> Test00045_AllRtn2 = await db.selectAllData(Test00045_1);
      int count2 = Test00045_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00045_1);
      print('********** テスト終了：00045_CDivideMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00046 : CTmpLog
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00046_CTmpLog_01', () async {
      print('\n********** テスト実行：00046_CTmpLog_01 **********');
      CTmpLog Test00046_1 = CTmpLog();
      Test00046_1.serial_no = 'abc12';
      Test00046_1.seq_no = 9913;
      Test00046_1.comp_cd = 9914;
      Test00046_1.stre_cd = 9915;
      Test00046_1.mac_no = 9916;
      Test00046_1.cshr_cd = 9917;
      Test00046_1.plu_cd = 'abc18';
      Test00046_1.lrgcls_cd = 9919;
      Test00046_1.mdlcls_cd = 9920;
      Test00046_1.smlcls_cd = 9921;
      Test00046_1.dflttnycls_cd = 9922;
      Test00046_1.u_prc = 9923;
      Test00046_1.item_name = 'abc24';
      Test00046_1.tran_flg = 9925;
      Test00046_1.sub_tran_flg = 9926;
      Test00046_1.ins_datetime = 'abc27';
      Test00046_1.upd_datetime = 'abc28';
      Test00046_1.status = 9929;
      Test00046_1.send_flg = 9930;
      Test00046_1.upd_user = 9931;
      Test00046_1.upd_system = 9932;

      //selectAllDataをして件数取得。
      List<CTmpLog> Test00046_AllRtn = await db.selectAllData(Test00046_1);
      int count = Test00046_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00046_1);

      //データ取得に必要なオブジェクトを用意
      CTmpLog Test00046_2 = CTmpLog();
      //Keyの値を設定する
      Test00046_2.serial_no = 'abc12';
      Test00046_2.seq_no = 9913;
      Test00046_2.comp_cd = 9914;
      Test00046_2.stre_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTmpLog? Test00046_Rtn = await db.selectDataByPrimaryKey(Test00046_2);
      //取得行がない場合、nullが返ってきます
      if (Test00046_Rtn == null) {
        print('\n********** 異常発生：00046_CTmpLog_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00046_Rtn?.serial_no,'abc12');
        expect(Test00046_Rtn?.seq_no,9913);
        expect(Test00046_Rtn?.comp_cd,9914);
        expect(Test00046_Rtn?.stre_cd,9915);
        expect(Test00046_Rtn?.mac_no,9916);
        expect(Test00046_Rtn?.cshr_cd,9917);
        expect(Test00046_Rtn?.plu_cd,'abc18');
        expect(Test00046_Rtn?.lrgcls_cd,9919);
        expect(Test00046_Rtn?.mdlcls_cd,9920);
        expect(Test00046_Rtn?.smlcls_cd,9921);
        expect(Test00046_Rtn?.dflttnycls_cd,9922);
        expect(Test00046_Rtn?.u_prc,9923);
        expect(Test00046_Rtn?.item_name,'abc24');
        expect(Test00046_Rtn?.tran_flg,9925);
        expect(Test00046_Rtn?.sub_tran_flg,9926);
        expect(Test00046_Rtn?.ins_datetime,'abc27');
        expect(Test00046_Rtn?.upd_datetime,'abc28');
        expect(Test00046_Rtn?.status,9929);
        expect(Test00046_Rtn?.send_flg,9930);
        expect(Test00046_Rtn?.upd_user,9931);
        expect(Test00046_Rtn?.upd_system,9932);
      }

      //selectAllDataをして件数取得。
      List<CTmpLog> Test00046_AllRtn2 = await db.selectAllData(Test00046_1);
      int count2 = Test00046_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00046_1);
      print('********** テスト終了：00046_CTmpLog_01 **********\n\n');
    });

    // ********************************************************
    // テスト00047 : CPrcchgMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00047_CPrcchgMst_01', () async {
      print('\n********** テスト実行：00047_CPrcchgMst_01 **********');
      CPrcchgMst Test00047_1 = CPrcchgMst();
      Test00047_1.serial_no = 'abc12';
      Test00047_1.seq_no = 9913;
      Test00047_1.comp_cd = 9914;
      Test00047_1.stre_cd = 9915;
      Test00047_1.plu_cd = 'abc16';
      Test00047_1.pos_prc = 9917;
      Test00047_1.cust_prc = 9918;
      Test00047_1.mac_no = 9919;
      Test00047_1.staff_cd = 9920;
      Test00047_1.maker_cd = 9921;
      Test00047_1.tran_flg = 9922;
      Test00047_1.sub_tran_flg = 9923;
      Test00047_1.ins_datetime = 'abc24';
      Test00047_1.upd_datetime = 'abc25';
      Test00047_1.status = 9926;
      Test00047_1.send_flg = 9927;
      Test00047_1.upd_user = 9928;
      Test00047_1.upd_system = 9929;

      //selectAllDataをして件数取得。
      List<CPrcchgMst> Test00047_AllRtn = await db.selectAllData(Test00047_1);
      int count = Test00047_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00047_1);

      //データ取得に必要なオブジェクトを用意
      CPrcchgMst Test00047_2 = CPrcchgMst();
      //Keyの値を設定する
      Test00047_2.serial_no = 'abc12';
      Test00047_2.seq_no = 9913;
      Test00047_2.comp_cd = 9914;
      Test00047_2.stre_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPrcchgMst? Test00047_Rtn = await db.selectDataByPrimaryKey(Test00047_2);
      //取得行がない場合、nullが返ってきます
      if (Test00047_Rtn == null) {
        print('\n********** 異常発生：00047_CPrcchgMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00047_Rtn?.serial_no,'abc12');
        expect(Test00047_Rtn?.seq_no,9913);
        expect(Test00047_Rtn?.comp_cd,9914);
        expect(Test00047_Rtn?.stre_cd,9915);
        expect(Test00047_Rtn?.plu_cd,'abc16');
        expect(Test00047_Rtn?.pos_prc,9917);
        expect(Test00047_Rtn?.cust_prc,9918);
        expect(Test00047_Rtn?.mac_no,9919);
        expect(Test00047_Rtn?.staff_cd,9920);
        expect(Test00047_Rtn?.maker_cd,9921);
        expect(Test00047_Rtn?.tran_flg,9922);
        expect(Test00047_Rtn?.sub_tran_flg,9923);
        expect(Test00047_Rtn?.ins_datetime,'abc24');
        expect(Test00047_Rtn?.upd_datetime,'abc25');
        expect(Test00047_Rtn?.status,9926);
        expect(Test00047_Rtn?.send_flg,9927);
        expect(Test00047_Rtn?.upd_user,9928);
        expect(Test00047_Rtn?.upd_system,9929);
      }

      //selectAllDataをして件数取得。
      List<CPrcchgMst> Test00047_AllRtn2 = await db.selectAllData(Test00047_1);
      int count2 = Test00047_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00047_1);
      print('********** テスト終了：00047_CPrcchgMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00048 : CBatrepoMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00048_CBatrepoMst_01', () async {
      print('\n********** テスト実行：00048_CBatrepoMst_01 **********');
      CBatrepoMst Test00048_1 = CBatrepoMst();
      Test00048_1.comp_cd = 9912;
      Test00048_1.stre_cd = 9913;
      Test00048_1.batch_grp_cd = 9914;
      Test00048_1.batch_no = 9915;
      Test00048_1.report_ordr = 9916;
      Test00048_1.batch_flg = 9917;
      Test00048_1.batch_name = 'abc18';
      Test00048_1.batch_report_no = 9919;
      Test00048_1.condi_typ1 = 9920;
      Test00048_1.condi_typ2 = 9921;
      Test00048_1.condi_typ3 = 9922;
      Test00048_1.condi_typ4 = 9923;
      Test00048_1.condi_typ5 = 9924;
      Test00048_1.condi_typ6 = 9925;
      Test00048_1.condi_typ7 = 9926;
      Test00048_1.condi_typ8 = 9927;
      Test00048_1.condi_typ9 = 9928;
      Test00048_1.out_dvc_flg = 9929;
      Test00048_1.batch_flg2 = 9930;
      Test00048_1.condi_start1 = 9931;
      Test00048_1.condi_end1 = 9932;
      Test00048_1.condi_start2 = 9933;
      Test00048_1.condi_end2 = 9934;
      Test00048_1.condi_start3 = 9935;
      Test00048_1.condi_end3 = 9936;
      Test00048_1.condi_start4 = 9937;
      Test00048_1.condi_end4 = 9938;
      Test00048_1.condi_start5 = 9939;
      Test00048_1.condi_end5 = 9940;
      Test00048_1.condi_start6 = 9941;
      Test00048_1.condi_end6 = 9942;
      Test00048_1.condi_start7 = 9943;
      Test00048_1.condi_end7 = 9944;
      Test00048_1.condi_start8 = 9945;
      Test00048_1.condi_end8 = 9946;
      Test00048_1.condi_start9 = 9947;
      Test00048_1.condi_end9 = 9948;
      Test00048_1.sel_mac_type = 9949;
      Test00048_1.ins_datetime = 'abc50';
      Test00048_1.upd_datetime = 'abc51';
      Test00048_1.status = 9952;
      Test00048_1.send_flg = 9953;
      Test00048_1.upd_user = 9954;
      Test00048_1.upd_system = 9955;

      //selectAllDataをして件数取得。
      List<CBatrepoMst> Test00048_AllRtn = await db.selectAllData(Test00048_1);
      int count = Test00048_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00048_1);

      //データ取得に必要なオブジェクトを用意
      CBatrepoMst Test00048_2 = CBatrepoMst();
      //Keyの値を設定する
      Test00048_2.comp_cd = 9912;
      Test00048_2.stre_cd = 9913;
      Test00048_2.batch_grp_cd = 9914;
      Test00048_2.batch_no = 9915;
      Test00048_2.report_ordr = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CBatrepoMst? Test00048_Rtn = await db.selectDataByPrimaryKey(Test00048_2);
      //取得行がない場合、nullが返ってきます
      if (Test00048_Rtn == null) {
        print('\n********** 異常発生：00048_CBatrepoMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00048_Rtn?.comp_cd,9912);
        expect(Test00048_Rtn?.stre_cd,9913);
        expect(Test00048_Rtn?.batch_grp_cd,9914);
        expect(Test00048_Rtn?.batch_no,9915);
        expect(Test00048_Rtn?.report_ordr,9916);
        expect(Test00048_Rtn?.batch_flg,9917);
        expect(Test00048_Rtn?.batch_name,'abc18');
        expect(Test00048_Rtn?.batch_report_no,9919);
        expect(Test00048_Rtn?.condi_typ1,9920);
        expect(Test00048_Rtn?.condi_typ2,9921);
        expect(Test00048_Rtn?.condi_typ3,9922);
        expect(Test00048_Rtn?.condi_typ4,9923);
        expect(Test00048_Rtn?.condi_typ5,9924);
        expect(Test00048_Rtn?.condi_typ6,9925);
        expect(Test00048_Rtn?.condi_typ7,9926);
        expect(Test00048_Rtn?.condi_typ8,9927);
        expect(Test00048_Rtn?.condi_typ9,9928);
        expect(Test00048_Rtn?.out_dvc_flg,9929);
        expect(Test00048_Rtn?.batch_flg2,9930);
        expect(Test00048_Rtn?.condi_start1,9931);
        expect(Test00048_Rtn?.condi_end1,9932);
        expect(Test00048_Rtn?.condi_start2,9933);
        expect(Test00048_Rtn?.condi_end2,9934);
        expect(Test00048_Rtn?.condi_start3,9935);
        expect(Test00048_Rtn?.condi_end3,9936);
        expect(Test00048_Rtn?.condi_start4,9937);
        expect(Test00048_Rtn?.condi_end4,9938);
        expect(Test00048_Rtn?.condi_start5,9939);
        expect(Test00048_Rtn?.condi_end5,9940);
        expect(Test00048_Rtn?.condi_start6,9941);
        expect(Test00048_Rtn?.condi_end6,9942);
        expect(Test00048_Rtn?.condi_start7,9943);
        expect(Test00048_Rtn?.condi_end7,9944);
        expect(Test00048_Rtn?.condi_start8,9945);
        expect(Test00048_Rtn?.condi_end8,9946);
        expect(Test00048_Rtn?.condi_start9,9947);
        expect(Test00048_Rtn?.condi_end9,9948);
        expect(Test00048_Rtn?.sel_mac_type,9949);
        expect(Test00048_Rtn?.ins_datetime,'abc50');
        expect(Test00048_Rtn?.upd_datetime,'abc51');
        expect(Test00048_Rtn?.status,9952);
        expect(Test00048_Rtn?.send_flg,9953);
        expect(Test00048_Rtn?.upd_user,9954);
        expect(Test00048_Rtn?.upd_system,9955);
      }

      //selectAllDataをして件数取得。
      List<CBatrepoMst> Test00048_AllRtn2 = await db.selectAllData(Test00048_1);
      int count2 = Test00048_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00048_1);
      print('********** テスト終了：00048_CBatrepoMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00049 : CReportCnt
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00049_CReportCnt_01', () async {
      print('\n********** テスト実行：00049_CReportCnt_01 **********');
      CReportCnt Test00049_1 = CReportCnt();
      Test00049_1.comp_cd = 9912;
      Test00049_1.stre_cd = 9913;
      Test00049_1.mac_no = 9914;
      Test00049_1.report_cnt_cd = 9915;
      Test00049_1.settle_cnt = 9916;
      Test00049_1.bfr_datetime = 'abc17';
      Test00049_1.ins_datetime = 'abc18';
      Test00049_1.upd_datetime = 'abc19';
      Test00049_1.status = 9920;
      Test00049_1.send_flg = 9921;
      Test00049_1.upd_user = 9922;
      Test00049_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CReportCnt> Test00049_AllRtn = await db.selectAllData(Test00049_1);
      int count = Test00049_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00049_1);

      //データ取得に必要なオブジェクトを用意
      CReportCnt Test00049_2 = CReportCnt();
      //Keyの値を設定する
      Test00049_2.comp_cd = 9912;
      Test00049_2.stre_cd = 9913;
      Test00049_2.mac_no = 9914;
      Test00049_2.report_cnt_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReportCnt? Test00049_Rtn = await db.selectDataByPrimaryKey(Test00049_2);
      //取得行がない場合、nullが返ってきます
      if (Test00049_Rtn == null) {
        print('\n********** 異常発生：00049_CReportCnt_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00049_Rtn?.comp_cd,9912);
        expect(Test00049_Rtn?.stre_cd,9913);
        expect(Test00049_Rtn?.mac_no,9914);
        expect(Test00049_Rtn?.report_cnt_cd,9915);
        expect(Test00049_Rtn?.settle_cnt,9916);
        expect(Test00049_Rtn?.bfr_datetime,'abc17');
        expect(Test00049_Rtn?.ins_datetime,'abc18');
        expect(Test00049_Rtn?.upd_datetime,'abc19');
        expect(Test00049_Rtn?.status,9920);
        expect(Test00049_Rtn?.send_flg,9921);
        expect(Test00049_Rtn?.upd_user,9922);
        expect(Test00049_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CReportCnt> Test00049_AllRtn2 = await db.selectAllData(Test00049_1);
      int count2 = Test00049_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00049_1);
      print('********** テスト終了：00049_CReportCnt_01 **********\n\n');
    });

    // ********************************************************
    // テスト00050 : CMemoMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00050_CMemoMst_01', () async {
      print('\n********** テスト実行：00050_CMemoMst_01 **********');
      CMemoMst Test00050_1 = CMemoMst();
      Test00050_1.comp_cd = 9912;
      Test00050_1.stre_cd = 9913;
      Test00050_1.img_cd = 9914;
      Test00050_1.color = 9915;
      Test00050_1.memo1 = 'abc16';
      Test00050_1.memo2 = 'abc17';
      Test00050_1.memo3 = 'abc18';
      Test00050_1.memo4 = 'abc19';
      Test00050_1.memo5 = 'abc20';
      Test00050_1.memo6 = 'abc21';
      Test00050_1.memo7 = 'abc22';
      Test00050_1.ins_datetime = 'abc23';
      Test00050_1.upd_datetime = 'abc24';
      Test00050_1.status = 9925;
      Test00050_1.send_flg = 9926;
      Test00050_1.upd_user = 9927;
      Test00050_1.upd_system = 9928;
      Test00050_1.title = 'abc29';
      Test00050_1.img_name = 'abc30';
      Test00050_1.stop_flg = 9931;
      Test00050_1.read_flg = 9932;
      Test00050_1.renew_flg = 9933;

      //selectAllDataをして件数取得。
      List<CMemoMst> Test00050_AllRtn = await db.selectAllData(Test00050_1);
      int count = Test00050_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00050_1);

      //データ取得に必要なオブジェクトを用意
      CMemoMst Test00050_2 = CMemoMst();
      //Keyの値を設定する
      Test00050_2.comp_cd = 9912;
      Test00050_2.stre_cd = 9913;
      Test00050_2.img_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMemoMst? Test00050_Rtn = await db.selectDataByPrimaryKey(Test00050_2);
      //取得行がない場合、nullが返ってきます
      if (Test00050_Rtn == null) {
        print('\n********** 異常発生：00050_CMemoMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00050_Rtn?.comp_cd,9912);
        expect(Test00050_Rtn?.stre_cd,9913);
        expect(Test00050_Rtn?.img_cd,9914);
        expect(Test00050_Rtn?.color,9915);
        expect(Test00050_Rtn?.memo1,'abc16');
        expect(Test00050_Rtn?.memo2,'abc17');
        expect(Test00050_Rtn?.memo3,'abc18');
        expect(Test00050_Rtn?.memo4,'abc19');
        expect(Test00050_Rtn?.memo5,'abc20');
        expect(Test00050_Rtn?.memo6,'abc21');
        expect(Test00050_Rtn?.memo7,'abc22');
        expect(Test00050_Rtn?.ins_datetime,'abc23');
        expect(Test00050_Rtn?.upd_datetime,'abc24');
        expect(Test00050_Rtn?.status,9925);
        expect(Test00050_Rtn?.send_flg,9926);
        expect(Test00050_Rtn?.upd_user,9927);
        expect(Test00050_Rtn?.upd_system,9928);
        expect(Test00050_Rtn?.title,'abc29');
        expect(Test00050_Rtn?.img_name,'abc30');
        expect(Test00050_Rtn?.stop_flg,9931);
        expect(Test00050_Rtn?.read_flg,9932);
        expect(Test00050_Rtn?.renew_flg,9933);
      }

      //selectAllDataをして件数取得。
      List<CMemoMst> Test00050_AllRtn2 = await db.selectAllData(Test00050_1);
      int count2 = Test00050_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00050_1);
      print('********** テスト終了：00050_CMemoMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00051 : CMemosndMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00051_CMemosndMst_01', () async {
      print('\n********** テスト実行：00051_CMemosndMst_01 **********');
      CMemosndMst Test00051_1 = CMemosndMst();
      Test00051_1.comp_cd = 9912;
      Test00051_1.stre_cd = 9913;
      Test00051_1.img_cd = 9914;
      Test00051_1.ecr_no = 9915;
      Test00051_1.ins_datetime = 'abc16';
      Test00051_1.upd_datetime = 'abc17';
      Test00051_1.status = 9918;
      Test00051_1.send_flg = 9919;
      Test00051_1.upd_user = 9920;
      Test00051_1.upd_system = 9921;

      //selectAllDataをして件数取得。
      List<CMemosndMst> Test00051_AllRtn = await db.selectAllData(Test00051_1);
      int count = Test00051_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00051_1);

      //データ取得に必要なオブジェクトを用意
      CMemosndMst Test00051_2 = CMemosndMst();
      //Keyの値を設定する
      Test00051_2.comp_cd = 9912;
      Test00051_2.stre_cd = 9913;
      Test00051_2.img_cd = 9914;
      Test00051_2.ecr_no = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMemosndMst? Test00051_Rtn = await db.selectDataByPrimaryKey(Test00051_2);
      //取得行がない場合、nullが返ってきます
      if (Test00051_Rtn == null) {
        print('\n********** 異常発生：00051_CMemosndMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00051_Rtn?.comp_cd,9912);
        expect(Test00051_Rtn?.stre_cd,9913);
        expect(Test00051_Rtn?.img_cd,9914);
        expect(Test00051_Rtn?.ecr_no,9915);
        expect(Test00051_Rtn?.ins_datetime,'abc16');
        expect(Test00051_Rtn?.upd_datetime,'abc17');
        expect(Test00051_Rtn?.status,9918);
        expect(Test00051_Rtn?.send_flg,9919);
        expect(Test00051_Rtn?.upd_user,9920);
        expect(Test00051_Rtn?.upd_system,9921);
      }

      //selectAllDataをして件数取得。
      List<CMemosndMst> Test00051_AllRtn2 = await db.selectAllData(Test00051_1);
      int count2 = Test00051_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00051_1);
      print('********** テスト終了：00051_CMemosndMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00052 : CRecogGrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00052_CRecogGrpMst_01', () async {
      print('\n********** テスト実行：00052_CRecogGrpMst_01 **********');
      CRecogGrpMst Test00052_1 = CRecogGrpMst();
      Test00052_1.recog_grp_cd = 9912;
      Test00052_1.recog_sub_grp_cd = 9913;
      Test00052_1.page = 9914;
      Test00052_1.posi = 9915;
      Test00052_1.recog_flg = 9916;
      Test00052_1.ins_datetime = 'abc17';
      Test00052_1.upd_datetime = 'abc18';
      Test00052_1.status = 9919;
      Test00052_1.send_flg = 9920;
      Test00052_1.upd_user = 9921;
      Test00052_1.upd_system = 9922;

      //selectAllDataをして件数取得。
      List<CRecogGrpMst> Test00052_AllRtn = await db.selectAllData(Test00052_1);
      int count = Test00052_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00052_1);

      //データ取得に必要なオブジェクトを用意
      CRecogGrpMst Test00052_2 = CRecogGrpMst();
      //Keyの値を設定する
      Test00052_2.recog_grp_cd = 9912;
      Test00052_2.recog_sub_grp_cd = 9913;
      Test00052_2.page = 9914;
      Test00052_2.posi = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CRecogGrpMst? Test00052_Rtn = await db.selectDataByPrimaryKey(Test00052_2);
      //取得行がない場合、nullが返ってきます
      if (Test00052_Rtn == null) {
        print('\n********** 異常発生：00052_CRecogGrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00052_Rtn?.recog_grp_cd,9912);
        expect(Test00052_Rtn?.recog_sub_grp_cd,9913);
        expect(Test00052_Rtn?.page,9914);
        expect(Test00052_Rtn?.posi,9915);
        expect(Test00052_Rtn?.recog_flg,9916);
        expect(Test00052_Rtn?.ins_datetime,'abc17');
        expect(Test00052_Rtn?.upd_datetime,'abc18');
        expect(Test00052_Rtn?.status,9919);
        expect(Test00052_Rtn?.send_flg,9920);
        expect(Test00052_Rtn?.upd_user,9921);
        expect(Test00052_Rtn?.upd_system,9922);
      }

      //selectAllDataをして件数取得。
      List<CRecogGrpMst> Test00052_AllRtn2 = await db.selectAllData(Test00052_1);
      int count2 = Test00052_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00052_1);
      print('********** テスト終了：00052_CRecogGrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00053 : PRecogMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00053_PRecogMst_01', () async {
      print('\n********** テスト実行：00053_PRecogMst_01 **********');
      PRecogMst Test00053_1 = PRecogMst();
      Test00053_1.page = 9912;
      Test00053_1.posi = 9913;
      Test00053_1.recog_name = 'abc14';
      Test00053_1.recog_set_flg = 9915;

      //selectAllDataをして件数取得。
      List<PRecogMst> Test00053_AllRtn = await db.selectAllData(Test00053_1);
      int count = Test00053_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00053_1);

      //データ取得に必要なオブジェクトを用意
      PRecogMst Test00053_2 = PRecogMst();
      //Keyの値を設定する
      Test00053_2.page = 9912;
      Test00053_2.posi = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PRecogMst? Test00053_Rtn = await db.selectDataByPrimaryKey(Test00053_2);
      //取得行がない場合、nullが返ってきます
      if (Test00053_Rtn == null) {
        print('\n********** 異常発生：00053_PRecogMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00053_Rtn?.page,9912);
        expect(Test00053_Rtn?.posi,9913);
        expect(Test00053_Rtn?.recog_name,'abc14');
        expect(Test00053_Rtn?.recog_set_flg,9915);
      }

      //selectAllDataをして件数取得。
      List<PRecogMst> Test00053_AllRtn2 = await db.selectAllData(Test00053_1);
      int count2 = Test00053_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00053_1);
      print('********** テスト終了：00053_PRecogMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00054 : CRecoginfoMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00054_CRecoginfoMst_01', () async {
      print('\n********** テスト実行：00054_CRecoginfoMst_01 **********');
      CRecoginfoMst Test00054_1 = CRecoginfoMst();
      Test00054_1.comp_cd = 9912;
      Test00054_1.stre_cd = 9913;
      Test00054_1.mac_no = 9914;
      Test00054_1.page = 9915;
      Test00054_1.password = 'abc16';
      Test00054_1.fcode = 'abc17';
      Test00054_1.qcjc_type = 'abc18';
      Test00054_1.emergency_type = 'abc19';
      Test00054_1.emergency_date = 'abc20';
      Test00054_1.ins_datetime = 'abc21';
      Test00054_1.upd_datetime = 'abc22';
      Test00054_1.status = 9923;
      Test00054_1.send_flg = 9924;
      Test00054_1.upd_user = 9925;
      Test00054_1.upd_system = 9926;

      //selectAllDataをして件数取得。
      List<CRecoginfoMst> Test00054_AllRtn = await db.selectAllData(Test00054_1);
      int count = Test00054_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00054_1);

      //データ取得に必要なオブジェクトを用意
      CRecoginfoMst Test00054_2 = CRecoginfoMst();
      //Keyの値を設定する
      Test00054_2.comp_cd = 9912;
      Test00054_2.stre_cd = 9913;
      Test00054_2.mac_no = 9914;
      Test00054_2.page = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CRecoginfoMst? Test00054_Rtn = await db.selectDataByPrimaryKey(Test00054_2);
      //取得行がない場合、nullが返ってきます
      if (Test00054_Rtn == null) {
        print('\n********** 異常発生：00054_CRecoginfoMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00054_Rtn?.comp_cd,9912);
        expect(Test00054_Rtn?.stre_cd,9913);
        expect(Test00054_Rtn?.mac_no,9914);
        expect(Test00054_Rtn?.page,9915);
        expect(Test00054_Rtn?.password,'abc16');
        expect(Test00054_Rtn?.fcode,'abc17');
        expect(Test00054_Rtn?.qcjc_type,'abc18');
        expect(Test00054_Rtn?.emergency_type,'abc19');
        expect(Test00054_Rtn?.emergency_date,'abc20');
        expect(Test00054_Rtn?.ins_datetime,'abc21');
        expect(Test00054_Rtn?.upd_datetime,'abc22');
        expect(Test00054_Rtn?.status,9923);
        expect(Test00054_Rtn?.send_flg,9924);
        expect(Test00054_Rtn?.upd_user,9925);
        expect(Test00054_Rtn?.upd_system,9926);
      }

      //selectAllDataをして件数取得。
      List<CRecoginfoMst> Test00054_AllRtn2 = await db.selectAllData(Test00054_1);
      int count2 = Test00054_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00054_1);
      print('********** テスト終了：00054_CRecoginfoMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00055 : CReportMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00055_CReportMst_01', () async {
      print('\n********** テスト実行：00055_CReportMst_01 **********');
      CReportMst Test00055_1 = CReportMst();
      Test00055_1.code = 9912;
      Test00055_1.prn_ordr = 9913;
      Test00055_1.srch_ordr = 9914;
      Test00055_1.grp_cd = 9915;
      Test00055_1.sub_grp_cd = 9916;
      Test00055_1.left_offset = 9917;
      Test00055_1.typ = 9918;
      Test00055_1.val_kind = 9919;
      Test00055_1.val_calc = 9920;
      Test00055_1.val_mark = 9921;
      Test00055_1.fmt_typ = 9922;
      Test00055_1.img_cd = 9923;
      Test00055_1.field1 = 'abc24';
      Test00055_1.field2 = 'abc25';
      Test00055_1.field3 = 'abc26';
      Test00055_1.condi1 = 'abc27';
      Test00055_1.condi2 = 'abc28';
      Test00055_1.condi3 = 'abc29';
      Test00055_1.repo_sql_cd = 9930;
      Test00055_1.recog_grp_cd = 9931;
      Test00055_1.trm_chk_grp_cd = 9932;
      Test00055_1.judge = 'abc33';
      Test00055_1.printer_no = 9934;

      //selectAllDataをして件数取得。
      List<CReportMst> Test00055_AllRtn = await db.selectAllData(Test00055_1);
      int count = Test00055_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00055_1);

      //データ取得に必要なオブジェクトを用意
      CReportMst Test00055_2 = CReportMst();
      //Keyの値を設定する
      Test00055_2.code = 9912;
      Test00055_2.prn_ordr = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReportMst? Test00055_Rtn = await db.selectDataByPrimaryKey(Test00055_2);
      //取得行がない場合、nullが返ってきます
      if (Test00055_Rtn == null) {
        print('\n********** 異常発生：00055_CReportMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00055_Rtn?.code,9912);
        expect(Test00055_Rtn?.prn_ordr,9913);
        expect(Test00055_Rtn?.srch_ordr,9914);
        expect(Test00055_Rtn?.grp_cd,9915);
        expect(Test00055_Rtn?.sub_grp_cd,9916);
        expect(Test00055_Rtn?.left_offset,9917);
        expect(Test00055_Rtn?.typ,9918);
        expect(Test00055_Rtn?.val_kind,9919);
        expect(Test00055_Rtn?.val_calc,9920);
        expect(Test00055_Rtn?.val_mark,9921);
        expect(Test00055_Rtn?.fmt_typ,9922);
        expect(Test00055_Rtn?.img_cd,9923);
        expect(Test00055_Rtn?.field1,'abc24');
        expect(Test00055_Rtn?.field2,'abc25');
        expect(Test00055_Rtn?.field3,'abc26');
        expect(Test00055_Rtn?.condi1,'abc27');
        expect(Test00055_Rtn?.condi2,'abc28');
        expect(Test00055_Rtn?.condi3,'abc29');
        expect(Test00055_Rtn?.repo_sql_cd,9930);
        expect(Test00055_Rtn?.recog_grp_cd,9931);
        expect(Test00055_Rtn?.trm_chk_grp_cd,9932);
        expect(Test00055_Rtn?.judge,'abc33');
        expect(Test00055_Rtn?.printer_no,9934);
      }

      //selectAllDataをして件数取得。
      List<CReportMst> Test00055_AllRtn2 = await db.selectAllData(Test00055_1);
      int count2 = Test00055_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00055_1);
      print('********** テスト終了：00055_CReportMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00056 : CMenuObjMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00056_CMenuObjMst_01', () async {
      print('\n********** テスト実行：00056_CMenuObjMst_01 **********');
      CMenuObjMst Test00056_1 = CMenuObjMst();
      Test00056_1.comp_cd = 9912;
      Test00056_1.stre_cd = 9913;
      Test00056_1.proc = 'abc14';
      Test00056_1.win_name = 'abc15';
      Test00056_1.page = 9916;
      Test00056_1.btn_pos_x = 9917;
      Test00056_1.btn_pos_y = 9918;
      Test00056_1.btn_width = 9919;
      Test00056_1.btn_height = 9920;
      Test00056_1.object_div = 9921;
      Test00056_1.appl_grp_cd = 9922;
      Test00056_1.btn_color = 9923;
      Test00056_1.img_name = 'abc24';
      Test00056_1.pass_chk_flg = 9925;
      Test00056_1.ins_datetime = 'abc26';
      Test00056_1.upd_datetime = 'abc27';
      Test00056_1.status = 9928;
      Test00056_1.send_flg = 9929;
      Test00056_1.upd_user = 9930;
      Test00056_1.upd_system = 9931;

      //selectAllDataをして件数取得。
      List<CMenuObjMst> Test00056_AllRtn = await db.selectAllData(Test00056_1);
      int count = Test00056_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00056_1);

      //データ取得に必要なオブジェクトを用意
      CMenuObjMst Test00056_2 = CMenuObjMst();
      //Keyの値を設定する
      Test00056_2.comp_cd = 9912;
      Test00056_2.stre_cd = 9913;
      Test00056_2.proc = 'abc14';
      Test00056_2.win_name = 'abc15';
      Test00056_2.page = 9916;
      Test00056_2.btn_pos_x = 9917;
      Test00056_2.btn_pos_y = 9918;
      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMenuObjMst? Test00056_Rtn = await db.selectDataByPrimaryKey(Test00056_2);
      //取得行がない場合、nullが返ってきます
      if (Test00056_Rtn == null) {
        print('\n********** 異常発生：00056_CMenuObjMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00056_Rtn?.comp_cd,9912);
        expect(Test00056_Rtn?.stre_cd,9913);
        expect(Test00056_Rtn?.proc,'abc14');
        expect(Test00056_Rtn?.win_name,'abc15');
        expect(Test00056_Rtn?.page,9916);
        expect(Test00056_Rtn?.btn_pos_x,9917);
        expect(Test00056_Rtn?.btn_pos_y,9918);
        expect(Test00056_Rtn?.btn_width,9919);
        expect(Test00056_Rtn?.btn_height,9920);
        expect(Test00056_Rtn?.object_div,9921);
        expect(Test00056_Rtn?.appl_grp_cd,9922);
        expect(Test00056_Rtn?.btn_color,9923);
        expect(Test00056_Rtn?.img_name,'abc24');
        expect(Test00056_Rtn?.pass_chk_flg,9925);
        expect(Test00056_Rtn?.ins_datetime,'abc26');
        expect(Test00056_Rtn?.upd_datetime,'abc27');
        expect(Test00056_Rtn?.status,9928);
        expect(Test00056_Rtn?.send_flg,9929);
        expect(Test00056_Rtn?.upd_user,9930);
        expect(Test00056_Rtn?.upd_system,9931);
      }

      //selectAllDataをして件数取得。
      List<CMenuObjMst> Test00056_AllRtn2 = await db.selectAllData(Test00056_1);
      int count2 = Test00056_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00056_1);
      print('********** テスト終了：00056_CMenuObjMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00057 : PTriggerKeyMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00057_PTriggerKeyMst_01', () async {
      print('\n********** テスト実行：00057_PTriggerKeyMst_01 **********');
      PTriggerKeyMst Test00057_1 = PTriggerKeyMst();
      Test00057_1.proc = 'abc12';
      Test00057_1.win_name = 'abc13';
      Test00057_1.trigger_key = 'abc14';
      Test00057_1.call_type = 9915;
      Test00057_1.target_code = 9916;
      Test00057_1.ins_datetime = 'abc17';
      Test00057_1.upd_datetime = 'abc18';
      Test00057_1.status = 9919;
      Test00057_1.send_flg = 9920;
      Test00057_1.upd_user = 9921;
      Test00057_1.upd_system = 9922;

      //selectAllDataをして件数取得。
      List<PTriggerKeyMst> Test00057_AllRtn = await db.selectAllData(Test00057_1);
      int count = Test00057_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00057_1);

      //データ取得に必要なオブジェクトを用意
      PTriggerKeyMst Test00057_2 = PTriggerKeyMst();
      //Keyの値を設定する
      Test00057_2.proc = 'abc12';
      Test00057_2.win_name = 'abc13';
      Test00057_2.trigger_key = 'abc14';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PTriggerKeyMst? Test00057_Rtn = await db.selectDataByPrimaryKey(Test00057_2);
      //取得行がない場合、nullが返ってきます
      if (Test00057_Rtn == null) {
        print('\n********** 異常発生：00057_PTriggerKeyMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00057_Rtn?.proc,'abc12');
        expect(Test00057_Rtn?.win_name,'abc13');
        expect(Test00057_Rtn?.trigger_key,'abc14');
        expect(Test00057_Rtn?.call_type,9915);
        expect(Test00057_Rtn?.target_code,9916);
        expect(Test00057_Rtn?.ins_datetime,'abc17');
        expect(Test00057_Rtn?.upd_datetime,'abc18');
        expect(Test00057_Rtn?.status,9919);
        expect(Test00057_Rtn?.send_flg,9920);
        expect(Test00057_Rtn?.upd_user,9921);
        expect(Test00057_Rtn?.upd_system,9922);
      }

      //selectAllDataをして件数取得。
      List<PTriggerKeyMst> Test00057_AllRtn2 = await db.selectAllData(Test00057_1);
      int count2 = Test00057_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00057_1);
      print('********** テスト終了：00057_PTriggerKeyMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00058 : CFinitMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00058_CFinitMst_01', () async {
      print('\n********** テスト実行：00058_CFinitMst_01 **********');
      CFinitMst Test00058_1 = CFinitMst();
      Test00058_1.finit_grp_cd = 9912;
      Test00058_1.finit_cd = 9913;
      Test00058_1.set_tbl_name = 'abc14';
      Test00058_1.set_tbl_typ = 9915;
      Test00058_1.finit_dsp_chk_div = 9916;
      Test00058_1.freq_dsp_chk_div = 9917;
      Test00058_1.freq_ope_mode = 9918;
      Test00058_1.offline_chk_flg = 9919;
      Test00058_1.seq_name = 'abc20';
      Test00058_1.freq_csrv_cnct_skip = 9921;
      Test00058_1.freq_csrc_cust_real_skip = 9922;
      Test00058_1.freq_csrv_cnct_key = 'abc23';
      Test00058_1.freq_csrv_del_oth_stre = 9924;
      Test00058_1.svr_div = 9925;
      Test00058_1.default_file_name = 'abc26';
      Test00058_1.rmst_freq_dsp_chk_div = 9927;

      //selectAllDataをして件数取得。
      List<CFinitMst> Test00058_AllRtn = await db.selectAllData(Test00058_1);
      int count = Test00058_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00058_1);

      //データ取得に必要なオブジェクトを用意
      CFinitMst Test00058_2 = CFinitMst();
      //Keyの値を設定する
      Test00058_2.finit_grp_cd = 9912;
      Test00058_2.finit_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CFinitMst? Test00058_Rtn = await db.selectDataByPrimaryKey(Test00058_2);
      //取得行がない場合、nullが返ってきます
      if (Test00058_Rtn == null) {
        print('\n********** 異常発生：00058_CFinitMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00058_Rtn?.finit_grp_cd,9912);
        expect(Test00058_Rtn?.finit_cd,9913);
        expect(Test00058_Rtn?.set_tbl_name,'abc14');
        expect(Test00058_Rtn?.set_tbl_typ,9915);
        expect(Test00058_Rtn?.finit_dsp_chk_div,9916);
        expect(Test00058_Rtn?.freq_dsp_chk_div,9917);
        expect(Test00058_Rtn?.freq_ope_mode,9918);
        expect(Test00058_Rtn?.offline_chk_flg,9919);
        expect(Test00058_Rtn?.seq_name,'abc20');
        expect(Test00058_Rtn?.freq_csrv_cnct_skip,9921);
        expect(Test00058_Rtn?.freq_csrc_cust_real_skip,9922);
        expect(Test00058_Rtn?.freq_csrv_cnct_key,'abc23');
        expect(Test00058_Rtn?.freq_csrv_del_oth_stre,9924);
        expect(Test00058_Rtn?.svr_div,9925);
        expect(Test00058_Rtn?.default_file_name,'abc26');
        expect(Test00058_Rtn?.rmst_freq_dsp_chk_div,9927);
      }

      //selectAllDataをして件数取得。
      List<CFinitMst> Test00058_AllRtn2 = await db.selectAllData(Test00058_1);
      int count2 = Test00058_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00058_1);
      print('********** テスト終了：00058_CFinitMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00059 : CFinitGrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00059_CFinitGrpMst_01', () async {
      print('\n********** テスト実行：00059_CFinitGrpMst_01 **********');
      CFinitGrpMst Test00059_1 = CFinitGrpMst();
      Test00059_1.finit_grp_cd = 9912;
      Test00059_1.finit_grp_name = 'abc13';

      //selectAllDataをして件数取得。
      List<CFinitGrpMst> Test00059_AllRtn = await db.selectAllData(Test00059_1);
      int count = Test00059_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00059_1);

      //データ取得に必要なオブジェクトを用意
      CFinitGrpMst Test00059_2 = CFinitGrpMst();
      //Keyの値を設定する
      Test00059_2.finit_grp_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CFinitGrpMst? Test00059_Rtn = await db.selectDataByPrimaryKey(Test00059_2);
      //取得行がない場合、nullが返ってきます
      if (Test00059_Rtn == null) {
        print('\n********** 異常発生：00059_CFinitGrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00059_Rtn?.finit_grp_cd,9912);
        expect(Test00059_Rtn?.finit_grp_name,'abc13');
      }

      //selectAllDataをして件数取得。
      List<CFinitGrpMst> Test00059_AllRtn2 = await db.selectAllData(Test00059_1);
      int count2 = Test00059_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00059_1);
      print('********** テスト終了：00059_CFinitGrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00060 : CSetTblNameMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00060_CSetTblNameMst_01', () async {
      print('\n********** テスト実行：00060_CSetTblNameMst_01 **********');
      CSetTblNameMst Test00060_1 = CSetTblNameMst();
      Test00060_1.set_tbl_name = 'abc12';
      Test00060_1.disp_name = 'abc13';

      //selectAllDataをして件数取得。
      List<CSetTblNameMst> Test00060_AllRtn = await db.selectAllData(Test00060_1);
      int count = Test00060_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00060_1);

      //データ取得に必要なオブジェクトを用意
      CSetTblNameMst Test00060_2 = CSetTblNameMst();
      //Keyの値を設定する
      Test00060_2.set_tbl_name = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CSetTblNameMst? Test00060_Rtn = await db.selectDataByPrimaryKey(Test00060_2);
      //取得行がない場合、nullが返ってきます
      if (Test00060_Rtn == null) {
        print('\n********** 異常発生：00060_CSetTblNameMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00060_Rtn?.set_tbl_name,'abc12');
        expect(Test00060_Rtn?.disp_name,'abc13');
      }

      //selectAllDataをして件数取得。
      List<CSetTblNameMst> Test00060_AllRtn2 = await db.selectAllData(Test00060_1);
      int count2 = Test00060_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00060_1);
      print('********** テスト終了：00060_CSetTblNameMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00061 : CApplGrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00061_CApplGrpMst_01', () async {
      print('\n********** テスト実行：00061_CApplGrpMst_01 **********');
      CApplGrpMst Test00061_1 = CApplGrpMst();
      Test00061_1.comp_cd = 9912;
      Test00061_1.stre_cd = 9913;
      Test00061_1.appl_grp_cd = 9914;
      Test00061_1.appl_name = 'abc15';
      Test00061_1.cond_con_typ = 'abc16';
      Test00061_1.cond_trm_cd = 9917;
      Test00061_1.recog_grp_cd = 9918;
      Test00061_1.ins_datetime = 'abc19';
      Test00061_1.upd_datetime = 'abc20';
      Test00061_1.status = 9921;
      Test00061_1.send_flg = 9922;
      Test00061_1.upd_user = 9923;
      Test00061_1.upd_system = 9924;
      Test00061_1.menu_chk_flg = 9925;
      Test00061_1.flg_1 = 9926;
      Test00061_1.flg_2 = 9927;
      Test00061_1.flg_3 = 9928;
      Test00061_1.flg_4 = 9929;

      //selectAllDataをして件数取得。
      List<CApplGrpMst> Test00061_AllRtn = await db.selectAllData(Test00061_1);
      int count = Test00061_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00061_1);

      //データ取得に必要なオブジェクトを用意
      CApplGrpMst Test00061_2 = CApplGrpMst();
      //Keyの値を設定する
      Test00061_2.comp_cd = 9912;
      Test00061_2.stre_cd = 9913;
      Test00061_2.appl_grp_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CApplGrpMst? Test00061_Rtn = await db.selectDataByPrimaryKey(Test00061_2);
      //取得行がない場合、nullが返ってきます
      if (Test00061_Rtn == null) {
        print('\n********** 異常発生：00061_CApplGrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00061_Rtn?.comp_cd,9912);
        expect(Test00061_Rtn?.stre_cd,9913);
        expect(Test00061_Rtn?.appl_grp_cd,9914);
        expect(Test00061_Rtn?.appl_name,'abc15');
        expect(Test00061_Rtn?.cond_con_typ,'abc16');
        expect(Test00061_Rtn?.cond_trm_cd,9917);
        expect(Test00061_Rtn?.recog_grp_cd,9918);
        expect(Test00061_Rtn?.ins_datetime,'abc19');
        expect(Test00061_Rtn?.upd_datetime,'abc20');
        expect(Test00061_Rtn?.status,9921);
        expect(Test00061_Rtn?.send_flg,9922);
        expect(Test00061_Rtn?.upd_user,9923);
        expect(Test00061_Rtn?.upd_system,9924);
        expect(Test00061_Rtn?.menu_chk_flg,9925);
        expect(Test00061_Rtn?.flg_1,9926);
        expect(Test00061_Rtn?.flg_2,9927);
        expect(Test00061_Rtn?.flg_3,9928);
        expect(Test00061_Rtn?.flg_4,9929);
      }

      //selectAllDataをして件数取得。
      List<CApplGrpMst> Test00061_AllRtn2 = await db.selectAllData(Test00061_1);
      int count2 = Test00061_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00061_1);
      print('********** テスト終了：00061_CApplGrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00062 : PApplMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00062_PApplMst_01', () async {
      print('\n********** テスト実行：00062_PApplMst_01 **********');
      PApplMst Test00062_1 = PApplMst();
      Test00062_1.appl_grp_cd = 9912;
      Test00062_1.appl_cd = 9913;
      Test00062_1.call_type = 9914;
      Test00062_1.name = 'abc15';
      Test00062_1.position = 'abc16';
      Test00062_1.param1 = 'abc17';
      Test00062_1.param2 = 'abc18';
      Test00062_1.param3 = 'abc19';
      Test00062_1.param4 = 'abc20';
      Test00062_1.param5 = 'abc21';
      Test00062_1.recog_grp_cd = 9922;
      Test00062_1.pause_flg = 9923;

      //selectAllDataをして件数取得。
      List<PApplMst> Test00062_AllRtn = await db.selectAllData(Test00062_1);
      int count = Test00062_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00062_1);

      //データ取得に必要なオブジェクトを用意
      PApplMst Test00062_2 = PApplMst();
      //Keyの値を設定する
      Test00062_2.appl_grp_cd = 9912;
      Test00062_2.appl_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PApplMst? Test00062_Rtn = await db.selectDataByPrimaryKey(Test00062_2);
      //取得行がない場合、nullが返ってきます
      if (Test00062_Rtn == null) {
        print('\n********** 異常発生：00062_PApplMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00062_Rtn?.appl_grp_cd,9912);
        expect(Test00062_Rtn?.appl_cd,9913);
        expect(Test00062_Rtn?.call_type,9914);
        expect(Test00062_Rtn?.name,'abc15');
        expect(Test00062_Rtn?.position,'abc16');
        expect(Test00062_Rtn?.param1,'abc17');
        expect(Test00062_Rtn?.param2,'abc18');
        expect(Test00062_Rtn?.param3,'abc19');
        expect(Test00062_Rtn?.param4,'abc20');
        expect(Test00062_Rtn?.param5,'abc21');
        expect(Test00062_Rtn?.recog_grp_cd,9922);
        expect(Test00062_Rtn?.pause_flg,9923);
      }

      //selectAllDataをして件数取得。
      List<PApplMst> Test00062_AllRtn2 = await db.selectAllData(Test00062_1);
      int count2 = Test00062_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00062_1);
      print('********** テスト終了：00062_PApplMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00063 : CDialogMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00063_CDialogMst_01', () async {
      print('\n********** テスト実行：00063_CDialogMst_01 **********');
      CDialogMst Test00063_1 = CDialogMst();
      Test00063_1.comp_cd = 9912;
      Test00063_1.stre_cd = 9913;
      Test00063_1.dialog_cd = 9914;
      Test00063_1.title_img_cd = 9915;
      Test00063_1.title_col = 9916;
      Test00063_1.title_siz = 9917;
      Test00063_1.message1 = 'abc18';
      Test00063_1.message1_col = 9919;
      Test00063_1.message1_siz = 9920;
      Test00063_1.message2 = 'abc21';
      Test00063_1.message2_col = 9922;
      Test00063_1.message2_siz = 9923;
      Test00063_1.message3 = 'abc24';
      Test00063_1.message3_col = 9925;
      Test00063_1.message3_siz = 9926;
      Test00063_1.message4 = 'abc27';
      Test00063_1.message4_col = 9928;
      Test00063_1.message4_siz = 9929;
      Test00063_1.message5 = 'abc30';
      Test00063_1.message5_col = 9931;
      Test00063_1.message5_siz = 9932;
      Test00063_1.dialog_typ = 9933;
      Test00063_1.dialog_img_cd = 9934;
      Test00063_1.dialog_icon_cd = 9935;
      Test00063_1.dialog_sound_cd = 9936;
      Test00063_1.ins_datetime = 'abc37';
      Test00063_1.upd_datetime = 'abc38';
      Test00063_1.status = 9939;
      Test00063_1.send_flg = 9940;
      Test00063_1.upd_user = 9941;
      Test00063_1.upd_system = 9942;

      //selectAllDataをして件数取得。
      List<CDialogMst> Test00063_AllRtn = await db.selectAllData(Test00063_1);
      int count = Test00063_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00063_1);

      //データ取得に必要なオブジェクトを用意
      CDialogMst Test00063_2 = CDialogMst();
      //Keyの値を設定する
      Test00063_2.comp_cd = 9912;
      Test00063_2.stre_cd = 9913;
      Test00063_2.dialog_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDialogMst? Test00063_Rtn = await db.selectDataByPrimaryKey(Test00063_2);
      //取得行がない場合、nullが返ってきます
      if (Test00063_Rtn == null) {
        print('\n********** 異常発生：00063_CDialogMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00063_Rtn?.comp_cd,9912);
        expect(Test00063_Rtn?.stre_cd,9913);
        expect(Test00063_Rtn?.dialog_cd,9914);
        expect(Test00063_Rtn?.title_img_cd,9915);
        expect(Test00063_Rtn?.title_col,9916);
        expect(Test00063_Rtn?.title_siz,9917);
        expect(Test00063_Rtn?.message1,'abc18');
        expect(Test00063_Rtn?.message1_col,9919);
        expect(Test00063_Rtn?.message1_siz,9920);
        expect(Test00063_Rtn?.message2,'abc21');
        expect(Test00063_Rtn?.message2_col,9922);
        expect(Test00063_Rtn?.message2_siz,9923);
        expect(Test00063_Rtn?.message3,'abc24');
        expect(Test00063_Rtn?.message3_col,9925);
        expect(Test00063_Rtn?.message3_siz,9926);
        expect(Test00063_Rtn?.message4,'abc27');
        expect(Test00063_Rtn?.message4_col,9928);
        expect(Test00063_Rtn?.message4_siz,9929);
        expect(Test00063_Rtn?.message5,'abc30');
        expect(Test00063_Rtn?.message5_col,9931);
        expect(Test00063_Rtn?.message5_siz,9932);
        expect(Test00063_Rtn?.dialog_typ,9933);
        expect(Test00063_Rtn?.dialog_img_cd,9934);
        expect(Test00063_Rtn?.dialog_icon_cd,9935);
        expect(Test00063_Rtn?.dialog_sound_cd,9936);
        expect(Test00063_Rtn?.ins_datetime,'abc37');
        expect(Test00063_Rtn?.upd_datetime,'abc38');
        expect(Test00063_Rtn?.status,9939);
        expect(Test00063_Rtn?.send_flg,9940);
        expect(Test00063_Rtn?.upd_user,9941);
        expect(Test00063_Rtn?.upd_system,9942);
      }

      //selectAllDataをして件数取得。
      List<CDialogMst> Test00063_AllRtn2 = await db.selectAllData(Test00063_1);
      int count2 = Test00063_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00063_1);
      print('********** テスト終了：00063_CDialogMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00064 : CDialogExMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00064_CDialogExMst_01', () async {
      print('\n********** テスト実行：00064_CDialogExMst_01 **********');
      CDialogExMst Test00064_1 = CDialogExMst();
      Test00064_1.comp_cd = 9912;
      Test00064_1.stre_cd = 9913;
      Test00064_1.dialog_cd = 9914;
      Test00064_1.title_img_cd = 9915;
      Test00064_1.title_col = 9916;
      Test00064_1.title_siz = 9917;
      Test00064_1.message1 = 'abc18';
      Test00064_1.message1_col = 9919;
      Test00064_1.message1_siz = 9920;
      Test00064_1.message2 = 'abc21';
      Test00064_1.message2_col = 9922;
      Test00064_1.message2_siz = 9923;
      Test00064_1.message3 = 'abc24';
      Test00064_1.message3_col = 9925;
      Test00064_1.message3_siz = 9926;
      Test00064_1.message4 = 'abc27';
      Test00064_1.message4_col = 9928;
      Test00064_1.message4_siz = 9929;
      Test00064_1.message5 = 'abc30';
      Test00064_1.message5_col = 9931;
      Test00064_1.message5_siz = 9932;
      Test00064_1.dialog_typ = 9933;
      Test00064_1.dialog_img_cd = 9934;
      Test00064_1.dialog_icon_cd = 9935;
      Test00064_1.dialog_sound_cd = 9936;
      Test00064_1.btn1_msg = 'abc37';
      Test00064_1.btn2_msg = 'abc38';
      Test00064_1.btn3_msg = 'abc39';
      Test00064_1.ins_datetime = 'abc40';
      Test00064_1.upd_datetime = 'abc41';
      Test00064_1.status = 9942;
      Test00064_1.send_flg = 9943;
      Test00064_1.upd_user = 9944;
      Test00064_1.upd_system = 9945;

      //selectAllDataをして件数取得。
      List<CDialogExMst> Test00064_AllRtn = await db.selectAllData(Test00064_1);
      int count = Test00064_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00064_1);

      //データ取得に必要なオブジェクトを用意
      CDialogExMst Test00064_2 = CDialogExMst();
      //Keyの値を設定する
      Test00064_2.comp_cd = 9912;
      Test00064_2.stre_cd = 9913;
      Test00064_2.dialog_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDialogExMst? Test00064_Rtn = await db.selectDataByPrimaryKey(Test00064_2);
      //取得行がない場合、nullが返ってきます
      if (Test00064_Rtn == null) {
        print('\n********** 異常発生：00064_CDialogExMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00064_Rtn?.comp_cd,9912);
        expect(Test00064_Rtn?.stre_cd,9913);
        expect(Test00064_Rtn?.dialog_cd,9914);
        expect(Test00064_Rtn?.title_img_cd,9915);
        expect(Test00064_Rtn?.title_col,9916);
        expect(Test00064_Rtn?.title_siz,9917);
        expect(Test00064_Rtn?.message1,'abc18');
        expect(Test00064_Rtn?.message1_col,9919);
        expect(Test00064_Rtn?.message1_siz,9920);
        expect(Test00064_Rtn?.message2,'abc21');
        expect(Test00064_Rtn?.message2_col,9922);
        expect(Test00064_Rtn?.message2_siz,9923);
        expect(Test00064_Rtn?.message3,'abc24');
        expect(Test00064_Rtn?.message3_col,9925);
        expect(Test00064_Rtn?.message3_siz,9926);
        expect(Test00064_Rtn?.message4,'abc27');
        expect(Test00064_Rtn?.message4_col,9928);
        expect(Test00064_Rtn?.message4_siz,9929);
        expect(Test00064_Rtn?.message5,'abc30');
        expect(Test00064_Rtn?.message5_col,9931);
        expect(Test00064_Rtn?.message5_siz,9932);
        expect(Test00064_Rtn?.dialog_typ,9933);
        expect(Test00064_Rtn?.dialog_img_cd,9934);
        expect(Test00064_Rtn?.dialog_icon_cd,9935);
        expect(Test00064_Rtn?.dialog_sound_cd,9936);
        expect(Test00064_Rtn?.btn1_msg,'abc37');
        expect(Test00064_Rtn?.btn2_msg,'abc38');
        expect(Test00064_Rtn?.btn3_msg,'abc39');
        expect(Test00064_Rtn?.ins_datetime,'abc40');
        expect(Test00064_Rtn?.upd_datetime,'abc41');
        expect(Test00064_Rtn?.status,9942);
        expect(Test00064_Rtn?.send_flg,9943);
        expect(Test00064_Rtn?.upd_user,9944);
        expect(Test00064_Rtn?.upd_system,9945);
      }

      //selectAllDataをして件数取得。
      List<CDialogExMst> Test00064_AllRtn2 = await db.selectAllData(Test00064_1);
      int count2 = Test00064_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00064_1);
      print('********** テスト終了：00064_CDialogExMst_01 **********\n\n');
    });


    // ********************************************************
    // テスト00065 : PPromschMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00065_PPromschMst_01', () async {
      print('\n********** テスト実行：00065_PPromschMst_01 **********');
      PPromschMst Test00065_1 = PPromschMst();
      Test00065_1.comp_cd = 9912;
      Test00065_1.stre_cd = 9913;
      Test00065_1.plan_cd = 'abc14';
      Test00065_1.prom_cd = 9915;
      Test00065_1.prom_typ = 9916;
      Test00065_1.sch_typ = 9917;
      Test00065_1.prom_name = 'abc18';
      Test00065_1.reward_val = 9919;
      Test00065_1.item_cd = 'abc20';
      Test00065_1.lrgcls_cd = 9921;
      Test00065_1.mdlcls_cd = 9922;
      Test00065_1.smlcls_cd = 9923;
      Test00065_1.tnycls_cd = 9924;
      Test00065_1.dsc_val = 9925;
      Test00065_1.cost = 1.226;
      Test00065_1.cost_per = 1.227;
      Test00065_1.cust_dsc_val = 9928;
      Test00065_1.form_qty1 = 9929;
      Test00065_1.form_qty2 = 9930;
      Test00065_1.form_qty3 = 9931;
      Test00065_1.form_qty4 = 9932;
      Test00065_1.form_qty5 = 9933;
      Test00065_1.form_prc1 = 9934;
      Test00065_1.form_prc2 = 9935;
      Test00065_1.form_prc3 = 9936;
      Test00065_1.form_prc4 = 9937;
      Test00065_1.form_prc5 = 9938;
      Test00065_1.cust_form_prc1 = 9939;
      Test00065_1.cust_form_prc2 = 9940;
      Test00065_1.cust_form_prc3 = 9941;
      Test00065_1.cust_form_prc4 = 9942;
      Test00065_1.cust_form_prc5 = 9943;
      Test00065_1.av_prc = 9944;
      Test00065_1.cust_av_prc = 9945;
      Test00065_1.avprc_adpt_flg = 9946;
      Test00065_1.avprc_util_flg = 9947;
      Test00065_1.low_limit = 9948;
      Test00065_1.svs_typ = 9949;
      Test00065_1.dsc_typ = 9950;
      Test00065_1.rec_limit = 9951;
      Test00065_1.rec_buy_limit = 9952;
      Test00065_1.start_datetime = 'abc53';
      Test00065_1.end_datetime = 'abc54';
      Test00065_1.timesch_flg = 9955;
      Test00065_1.sun_flg = 9956;
      Test00065_1.mon_flg = 9957;
      Test00065_1.tue_flg = 9958;
      Test00065_1.wed_flg = 9959;
      Test00065_1.thu_flg = 9960;
      Test00065_1.fri_flg = 9961;
      Test00065_1.sat_flg = 9962;
      Test00065_1.eachsch_typ = 9963;
      Test00065_1.eachsch_flg = 'abc64';
      Test00065_1.stop_flg = 9965;
      Test00065_1.min_prc = 9966;
      Test00065_1.max_prc = 9967;
      Test00065_1.tax_flg = 9968;
      Test00065_1.member_qty = 9969;
      Test00065_1.div_cd = 9970;
      Test00065_1.acct_cd = 9971;
      Test00065_1.promo_ext_id = 'abc72';
      Test00065_1.trends_typ = 9973;
      Test00065_1.user_val_1 = 9974;
      Test00065_1.user_val_2 = 9975;
      Test00065_1.user_val_3 = 9976;
      Test00065_1.user_val_4 = 9977;
      Test00065_1.user_val_5 = 9978;
      Test00065_1.user_val_6 = 'abc79';
      Test00065_1.ins_datetime = 'abc80';
      Test00065_1.upd_datetime = 'abc81';
      Test00065_1.status = 9982;
      Test00065_1.send_flg = 9983;
      Test00065_1.upd_user = 9984;
      Test00065_1.upd_system = 9985;
      Test00065_1.point_add_magn = 1.286;
      Test00065_1.point_add_mem_typ = 9987;
      Test00065_1.svs_cls_f_data1 = 1.288;
      Test00065_1.svs_cls_s_data1 = 9989;
      Test00065_1.svs_cls_s_data2 = 9990;
      Test00065_1.svs_cls_s_data3 = 9991;
      Test00065_1.plupts_rate = 1.292;
      Test00065_1.custsvs_unit = 9993;
      Test00065_1.ref_acct = 9994;
      Test00065_1.linked_prom_id = 9995;
      Test00065_1.date_flg1 = 9996;
      Test00065_1.date_flg2 = 9997;
      Test00065_1.date_flg3 = 9998;
      Test00065_1.date_flg4 = 9999;
      Test00065_1.date_flg5 = 99100;

      //selectAllDataをして件数取得。
      List<PPromschMst> Test00065_AllRtn = await db.selectAllData(Test00065_1);
      int count = Test00065_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00065_1);

      //データ取得に必要なオブジェクトを用意
      PPromschMst Test00065_2 = PPromschMst();
      //Keyの値を設定する
      Test00065_2.comp_cd = 9912;
      Test00065_2.stre_cd = 9913;
      Test00065_2.plan_cd = 'abc14';
      Test00065_2.prom_cd = 9915;
      Test00065_2.prom_typ = 9916;
      Test00065_2.item_cd = 'abc20';
      Test00065_2.lrgcls_cd = 9921;
      Test00065_2.mdlcls_cd = 9922;
      Test00065_2.smlcls_cd = 9923;
      Test00065_2.tnycls_cd = 9924;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPromschMst? Test00065_Rtn = await db.selectDataByPrimaryKey(Test00065_2);
      //取得行がない場合、nullが返ってきます
      if (Test00065_Rtn == null) {
        print('\n********** 異常発生：00065_PPromschMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00065_Rtn?.comp_cd,9912);
        expect(Test00065_Rtn?.stre_cd,9913);
        expect(Test00065_Rtn?.plan_cd,'abc14');
        expect(Test00065_Rtn?.prom_cd,9915);
        expect(Test00065_Rtn?.prom_typ,9916);
        expect(Test00065_Rtn?.sch_typ,9917);
        expect(Test00065_Rtn?.prom_name,'abc18');
        expect(Test00065_Rtn?.reward_val,9919);
        expect(Test00065_Rtn?.item_cd,'abc20');
        expect(Test00065_Rtn?.lrgcls_cd,9921);
        expect(Test00065_Rtn?.mdlcls_cd,9922);
        expect(Test00065_Rtn?.smlcls_cd,9923);
        expect(Test00065_Rtn?.tnycls_cd,9924);
        expect(Test00065_Rtn?.dsc_val,9925);
        expect(Test00065_Rtn?.cost,1.226);
        expect(Test00065_Rtn?.cost_per,1.227);
        expect(Test00065_Rtn?.cust_dsc_val,9928);
        expect(Test00065_Rtn?.form_qty1,9929);
        expect(Test00065_Rtn?.form_qty2,9930);
        expect(Test00065_Rtn?.form_qty3,9931);
        expect(Test00065_Rtn?.form_qty4,9932);
        expect(Test00065_Rtn?.form_qty5,9933);
        expect(Test00065_Rtn?.form_prc1,9934);
        expect(Test00065_Rtn?.form_prc2,9935);
        expect(Test00065_Rtn?.form_prc3,9936);
        expect(Test00065_Rtn?.form_prc4,9937);
        expect(Test00065_Rtn?.form_prc5,9938);
        expect(Test00065_Rtn?.cust_form_prc1,9939);
        expect(Test00065_Rtn?.cust_form_prc2,9940);
        expect(Test00065_Rtn?.cust_form_prc3,9941);
        expect(Test00065_Rtn?.cust_form_prc4,9942);
        expect(Test00065_Rtn?.cust_form_prc5,9943);
        expect(Test00065_Rtn?.av_prc,9944);
        expect(Test00065_Rtn?.cust_av_prc,9945);
        expect(Test00065_Rtn?.avprc_adpt_flg,9946);
        expect(Test00065_Rtn?.avprc_util_flg,9947);
        expect(Test00065_Rtn?.low_limit,9948);
        expect(Test00065_Rtn?.svs_typ,9949);
        expect(Test00065_Rtn?.dsc_typ,9950);
        expect(Test00065_Rtn?.rec_limit,9951);
        expect(Test00065_Rtn?.rec_buy_limit,9952);
        expect(Test00065_Rtn?.start_datetime,'abc53');
        expect(Test00065_Rtn?.end_datetime,'abc54');
        expect(Test00065_Rtn?.timesch_flg,9955);
        expect(Test00065_Rtn?.sun_flg,9956);
        expect(Test00065_Rtn?.mon_flg,9957);
        expect(Test00065_Rtn?.tue_flg,9958);
        expect(Test00065_Rtn?.wed_flg,9959);
        expect(Test00065_Rtn?.thu_flg,9960);
        expect(Test00065_Rtn?.fri_flg,9961);
        expect(Test00065_Rtn?.sat_flg,9962);
        expect(Test00065_Rtn?.eachsch_typ,9963);
        expect(Test00065_Rtn?.eachsch_flg,'abc64');
        expect(Test00065_Rtn?.stop_flg,9965);
        expect(Test00065_Rtn?.min_prc,9966);
        expect(Test00065_Rtn?.max_prc,9967);
        expect(Test00065_Rtn?.tax_flg,9968);
        expect(Test00065_Rtn?.member_qty,9969);
        expect(Test00065_Rtn?.div_cd,9970);
        expect(Test00065_Rtn?.acct_cd,9971);
        expect(Test00065_Rtn?.promo_ext_id,'abc72');
        expect(Test00065_Rtn?.trends_typ,9973);
        expect(Test00065_Rtn?.user_val_1,9974);
        expect(Test00065_Rtn?.user_val_2,9975);
        expect(Test00065_Rtn?.user_val_3,9976);
        expect(Test00065_Rtn?.user_val_4,9977);
        expect(Test00065_Rtn?.user_val_5,9978);
        expect(Test00065_Rtn?.user_val_6,'abc79');
        expect(Test00065_Rtn?.ins_datetime,'abc80');
        expect(Test00065_Rtn?.upd_datetime,'abc81');
        expect(Test00065_Rtn?.status,9982);
        expect(Test00065_Rtn?.send_flg,9983);
        expect(Test00065_Rtn?.upd_user,9984);
        expect(Test00065_Rtn?.upd_system,9985);
        expect(Test00065_Rtn?.point_add_magn,1.286);
        expect(Test00065_Rtn?.point_add_mem_typ,9987);
        expect(Test00065_Rtn?.svs_cls_f_data1,1.288);
        expect(Test00065_Rtn?.svs_cls_s_data1,9989);
        expect(Test00065_Rtn?.svs_cls_s_data2,9990);
        expect(Test00065_Rtn?.svs_cls_s_data3,9991);
        expect(Test00065_Rtn?.plupts_rate,1.292);
        expect(Test00065_Rtn?.custsvs_unit,9993);
        expect(Test00065_Rtn?.ref_acct,9994);
        expect(Test00065_Rtn?.linked_prom_id,9995);
        expect(Test00065_Rtn?.date_flg1,9996);
        expect(Test00065_Rtn?.date_flg2,9997);
        expect(Test00065_Rtn?.date_flg3,9998);
        expect(Test00065_Rtn?.date_flg4,9999);
        expect(Test00065_Rtn?.date_flg5,99100);
      }

      //selectAllDataをして件数取得。
      List<PPromschMst> Test00065_AllRtn2 = await db.selectAllData(Test00065_1);
      int count2 = Test00065_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00065_1);
      print('********** テスト終了：00065_PPromschMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00066 : PPromitemMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00066_PPromitemMst_01', () async {
      print('\n********** テスト実行：00066_PPromitemMst_01 **********');
      PPromitemMst Test00066_1 = PPromitemMst();
      Test00066_1.comp_cd = 9912;
      Test00066_1.stre_cd = 9913;
      Test00066_1.plan_cd = 'abc14';
      Test00066_1.prom_cd = 9915;
      Test00066_1.prom_typ = 9916;
      Test00066_1.item_typ = 9917;
      Test00066_1.item_cd = 'abc18';
      Test00066_1.item_cd2 = 'abc19';
      Test00066_1.stop_flg = 9920;
      Test00066_1.set_qty = 9921;
      Test00066_1.grp_cd = 9922;
      Test00066_1.user_val_1 = 9923;
      Test00066_1.user_val_2 = 9924;
      Test00066_1.user_val_3 = 9925;
      Test00066_1.user_val_4 = 9926;
      Test00066_1.user_val_5 = 9927;
      Test00066_1.user_val_6 = 'abc28';
      Test00066_1.ins_datetime = 'abc29';
      Test00066_1.upd_datetime = 'abc30';
      Test00066_1.status = 9931;
      Test00066_1.send_flg = 9932;
      Test00066_1.upd_user = 9933;
      Test00066_1.upd_system = 9934;

      //selectAllDataをして件数取得。
      List<PPromitemMst> Test00066_AllRtn = await db.selectAllData(Test00066_1);
      int count = Test00066_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00066_1);

      //データ取得に必要なオブジェクトを用意
      PPromitemMst Test00066_2 = PPromitemMst();
      //Keyの値を設定する
      Test00066_2.comp_cd = 9912;
      Test00066_2.stre_cd = 9913;
      Test00066_2.plan_cd = 'abc14';
      Test00066_2.prom_cd = 9915;
      Test00066_2.item_cd = 'abc18';
      Test00066_2.item_cd2 = 'abc19';
      Test00066_2.grp_cd = 9922;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPromitemMst? Test00066_Rtn = await db.selectDataByPrimaryKey(Test00066_2);
      //取得行がない場合、nullが返ってきます
      if (Test00066_Rtn == null) {
        print('\n********** 異常発生：00066_PPromitemMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00066_Rtn?.comp_cd,9912);
        expect(Test00066_Rtn?.stre_cd,9913);
        expect(Test00066_Rtn?.plan_cd,'abc14');
        expect(Test00066_Rtn?.prom_cd,9915);
        expect(Test00066_Rtn?.prom_typ,9916);
        expect(Test00066_Rtn?.item_typ,9917);
        expect(Test00066_Rtn?.item_cd,'abc18');
        expect(Test00066_Rtn?.item_cd2,'abc19');
        expect(Test00066_Rtn?.stop_flg,9920);
        expect(Test00066_Rtn?.set_qty,9921);
        expect(Test00066_Rtn?.grp_cd,9922);
        expect(Test00066_Rtn?.user_val_1,9923);
        expect(Test00066_Rtn?.user_val_2,9924);
        expect(Test00066_Rtn?.user_val_3,9925);
        expect(Test00066_Rtn?.user_val_4,9926);
        expect(Test00066_Rtn?.user_val_5,9927);
        expect(Test00066_Rtn?.user_val_6,'abc28');
        expect(Test00066_Rtn?.ins_datetime,'abc29');
        expect(Test00066_Rtn?.upd_datetime,'abc30');
        expect(Test00066_Rtn?.status,9931);
        expect(Test00066_Rtn?.send_flg,9932);
        expect(Test00066_Rtn?.upd_user,9933);
        expect(Test00066_Rtn?.upd_system,9934);
      }

      //selectAllDataをして件数取得。
      List<PPromitemMst> Test00066_AllRtn2 = await db.selectAllData(Test00066_1);
      int count2 = Test00066_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00066_1);
      print('********** テスト終了：00066_PPromitemMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00067 : CInstreMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00067_CInstreMst_01', () async {
      print('\n********** テスト実行：00067_CInstreMst_01 **********');
      CInstreMst Test00067_1 = CInstreMst();
      Test00067_1.comp_cd = 9912;
      Test00067_1.instre_flg = 'abc13';
      Test00067_1.format_no = 9914;
      Test00067_1.format_typ = 9915;
      Test00067_1.cls_code = 9916;
      Test00067_1.ins_datetime = 'abc17';
      Test00067_1.upd_datetime = 'abc18';
      Test00067_1.status = 9919;
      Test00067_1.send_flg = 9920;
      Test00067_1.upd_user = 9921;
      Test00067_1.upd_system = 9922;

      //selectAllDataをして件数取得。
      List<CInstreMst> Test00067_AllRtn = await db.selectAllData(Test00067_1);
      int count = Test00067_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00067_1);

      //データ取得に必要なオブジェクトを用意
      CInstreMst Test00067_2 = CInstreMst();
      //Keyの値を設定する
      Test00067_2.comp_cd = 9912;
      Test00067_2.instre_flg = 'abc13';
      Test00067_2.format_no = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CInstreMst? Test00067_Rtn = await db.selectDataByPrimaryKey(Test00067_2);
      //取得行がない場合、nullが返ってきます
      if (Test00067_Rtn == null) {
        print('\n********** 異常発生：00067_CInstreMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00067_Rtn?.comp_cd,9912);
        expect(Test00067_Rtn?.instre_flg,'abc13');
        expect(Test00067_Rtn?.format_no,9914);
        expect(Test00067_Rtn?.format_typ,9915);
        expect(Test00067_Rtn?.cls_code,9916);
        expect(Test00067_Rtn?.ins_datetime,'abc17');
        expect(Test00067_Rtn?.upd_datetime,'abc18');
        expect(Test00067_Rtn?.status,9919);
        expect(Test00067_Rtn?.send_flg,9920);
        expect(Test00067_Rtn?.upd_user,9921);
        expect(Test00067_Rtn?.upd_system,9922);
      }

      //selectAllDataをして件数取得。
      List<CInstreMst> Test00067_AllRtn2 = await db.selectAllData(Test00067_1);
      int count2 = Test00067_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00067_1);
      print('********** テスト終了：00067_CInstreMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00068 : CFmttypMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00068_CFmttypMst_01', () async {
      print('\n********** テスト実行：00068_CFmttypMst_01 **********');
      CFmttypMst Test00068_1 = CFmttypMst();
      Test00068_1.format_typ = 9912;
      Test00068_1.format_typ_name = 'abc13';
      Test00068_1.disp_flg = 9914;
      Test00068_1.ins_datetime = 'abc15';
      Test00068_1.upd_datetime = 'abc16';
      Test00068_1.status = 9917;
      Test00068_1.send_flg = 9918;
      Test00068_1.upd_user = 9919;
      Test00068_1.upd_system = 9920;

      //selectAllDataをして件数取得。
      List<CFmttypMst> Test00068_AllRtn = await db.selectAllData(Test00068_1);
      int count = Test00068_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00068_1);

      //データ取得に必要なオブジェクトを用意
      CFmttypMst Test00068_2 = CFmttypMst();
      //Keyの値を設定する
      Test00068_2.format_typ = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CFmttypMst? Test00068_Rtn = await db.selectDataByPrimaryKey(Test00068_2);
      //取得行がない場合、nullが返ってきます
      if (Test00068_Rtn == null) {
        print('\n********** 異常発生：00068_CFmttypMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00068_Rtn?.format_typ,9912);
        expect(Test00068_Rtn?.format_typ_name,'abc13');
        expect(Test00068_Rtn?.disp_flg,9914);
        expect(Test00068_Rtn?.ins_datetime,'abc15');
        expect(Test00068_Rtn?.upd_datetime,'abc16');
        expect(Test00068_Rtn?.status,9917);
        expect(Test00068_Rtn?.send_flg,9918);
        expect(Test00068_Rtn?.upd_user,9919);
        expect(Test00068_Rtn?.upd_system,9920);
      }

      //selectAllDataをして件数取得。
      List<CFmttypMst> Test00068_AllRtn2 = await db.selectAllData(Test00068_1);
      int count2 = Test00068_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00068_1);
      print('********** テスト終了：00068_CFmttypMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00069 : CBarfmtMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00069_CBarfmtMst_01', () async {
      print('\n********** テスト実行：00069_CBarfmtMst_01 **********');
      CBarfmtMst Test00069_1 = CBarfmtMst();
      Test00069_1.format_no = 9912;
      Test00069_1.format_typ = 9913;
      Test00069_1.format = 'abc14';
      Test00069_1.flg_num = 9915;
      Test00069_1.format_num = 9916;
      Test00069_1.disp_flg = 9917;
      Test00069_1.ins_datetime = 'abc18';
      Test00069_1.upd_datetime = 'abc19';
      Test00069_1.status = 9920;
      Test00069_1.send_flg = 9921;
      Test00069_1.upd_user = 9922;
      Test00069_1.upd_system = 9923;
      Test00069_1.cls_flg = 9924;

      //selectAllDataをして件数取得。
      List<CBarfmtMst> Test00069_AllRtn = await db.selectAllData(Test00069_1);
      int count = Test00069_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00069_1);

      //データ取得に必要なオブジェクトを用意
      CBarfmtMst Test00069_2 = CBarfmtMst();
      //Keyの値を設定する
      Test00069_2.format_no = 9912;
      Test00069_2.format_typ = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CBarfmtMst? Test00069_Rtn = await db.selectDataByPrimaryKey(Test00069_2);
      //取得行がない場合、nullが返ってきます
      if (Test00069_Rtn == null) {
        print('\n********** 異常発生：00069_CBarfmtMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00069_Rtn?.format_no,9912);
        expect(Test00069_Rtn?.format_typ,9913);
        expect(Test00069_Rtn?.format,'abc14');
        expect(Test00069_Rtn?.flg_num,9915);
        expect(Test00069_Rtn?.format_num,9916);
        expect(Test00069_Rtn?.disp_flg,9917);
        expect(Test00069_Rtn?.ins_datetime,'abc18');
        expect(Test00069_Rtn?.upd_datetime,'abc19');
        expect(Test00069_Rtn?.status,9920);
        expect(Test00069_Rtn?.send_flg,9921);
        expect(Test00069_Rtn?.upd_user,9922);
        expect(Test00069_Rtn?.upd_system,9923);
        expect(Test00069_Rtn?.cls_flg,9924);
      }

      //selectAllDataをして件数取得。
      List<CBarfmtMst> Test00069_AllRtn2 = await db.selectAllData(Test00069_1);
      int count2 = Test00069_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00069_1);
      print('********** テスト終了：00069_CBarfmtMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00070 : CMsgMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00070_CMsgMst_01', () async {
      print('\n********** テスト実行：00070_CMsgMst_01 **********');
      CMsgMst Test00070_1 = CMsgMst();
      Test00070_1.comp_cd = 9912;
      Test00070_1.stre_cd = 9913;
      Test00070_1.msg_cd = 9914;
      Test00070_1.msg_kind = 9915;
      Test00070_1.msg_data_1 = 'abc16';
      Test00070_1.msg_data_2 = 'abc17';
      Test00070_1.msg_data_3 = 'abc18';
      Test00070_1.msg_data_4 = 'abc19';
      Test00070_1.msg_data_5 = 'abc20';
      Test00070_1.ins_datetime = 'abc21';
      Test00070_1.upd_datetime = 'abc22';
      Test00070_1.status = 9923;
      Test00070_1.send_flg = 9924;
      Test00070_1.upd_user = 9925;
      Test00070_1.upd_system = 9926;
      Test00070_1.msg_size_1 = 9927;
      Test00070_1.msg_size_2 = 9928;
      Test00070_1.msg_size_3 = 9929;
      Test00070_1.msg_size_4 = 9930;
      Test00070_1.msg_size_5 = 9931;
      Test00070_1.msg_color_1 = 9932;
      Test00070_1.msg_color_2 = 9933;
      Test00070_1.msg_color_3 = 9934;
      Test00070_1.msg_color_4 = 9935;
      Test00070_1.msg_color_5 = 9936;
      Test00070_1.back_color = 9937;
      Test00070_1.back_pict_typ = 9938;
      Test00070_1.second = 9939;
      Test00070_1.flg_01 = 9940;
      Test00070_1.flg_02 = 9941;
      Test00070_1.flg_03 = 9942;
      Test00070_1.flg_04 = 9943;
      Test00070_1.flg_05 = 9944;
      Test00070_1.msg_data_6 = 'abc45';
      Test00070_1.msg_data_7 = 'abc46';
      Test00070_1.msg_data_8 = 'abc47';
      Test00070_1.msg_data_9 = 'abc48';
      Test00070_1.msg_data_10 = 'abc49';
      Test00070_1.msg_size_6 = 9950;
      Test00070_1.msg_size_7 = 9951;
      Test00070_1.msg_size_8 = 9952;
      Test00070_1.msg_size_9 = 9953;
      Test00070_1.msg_size_10 = 9954;
      Test00070_1.msg_color_6 = 9955;
      Test00070_1.msg_color_7 = 9956;
      Test00070_1.msg_color_8 = 9957;
      Test00070_1.msg_color_9 = 9958;
      Test00070_1.msg_color_10 = 9959;
      Test00070_1.flg_06 = 9960;
      Test00070_1.flg_07 = 9961;
      Test00070_1.flg_08 = 9962;
      Test00070_1.flg_09 = 9963;
      Test00070_1.flg_10 = 9964;

      //selectAllDataをして件数取得。
      List<CMsgMst> Test00070_AllRtn = await db.selectAllData(Test00070_1);
      int count = Test00070_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00070_1);

      //データ取得に必要なオブジェクトを用意
      CMsgMst Test00070_2 = CMsgMst();
      //Keyの値を設定する
      Test00070_2.comp_cd = 9912;
      Test00070_2.stre_cd = 9913;
      Test00070_2.msg_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMsgMst? Test00070_Rtn = await db.selectDataByPrimaryKey(Test00070_2);
      //取得行がない場合、nullが返ってきます
      if (Test00070_Rtn == null) {
        print('\n********** 異常発生：00070_CMsgMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00070_Rtn?.comp_cd,9912);
        expect(Test00070_Rtn?.stre_cd,9913);
        expect(Test00070_Rtn?.msg_cd,9914);
        expect(Test00070_Rtn?.msg_kind,9915);
        expect(Test00070_Rtn?.msg_data_1,'abc16');
        expect(Test00070_Rtn?.msg_data_2,'abc17');
        expect(Test00070_Rtn?.msg_data_3,'abc18');
        expect(Test00070_Rtn?.msg_data_4,'abc19');
        expect(Test00070_Rtn?.msg_data_5,'abc20');
        expect(Test00070_Rtn?.ins_datetime,'abc21');
        expect(Test00070_Rtn?.upd_datetime,'abc22');
        expect(Test00070_Rtn?.status,9923);
        expect(Test00070_Rtn?.send_flg,9924);
        expect(Test00070_Rtn?.upd_user,9925);
        expect(Test00070_Rtn?.upd_system,9926);
        expect(Test00070_Rtn?.msg_size_1,9927);
        expect(Test00070_Rtn?.msg_size_2,9928);
        expect(Test00070_Rtn?.msg_size_3,9929);
        expect(Test00070_Rtn?.msg_size_4,9930);
        expect(Test00070_Rtn?.msg_size_5,9931);
        expect(Test00070_Rtn?.msg_color_1,9932);
        expect(Test00070_Rtn?.msg_color_2,9933);
        expect(Test00070_Rtn?.msg_color_3,9934);
        expect(Test00070_Rtn?.msg_color_4,9935);
        expect(Test00070_Rtn?.msg_color_5,9936);
        expect(Test00070_Rtn?.back_color,9937);
        expect(Test00070_Rtn?.back_pict_typ,9938);
        expect(Test00070_Rtn?.second,9939);
        expect(Test00070_Rtn?.flg_01,9940);
        expect(Test00070_Rtn?.flg_02,9941);
        expect(Test00070_Rtn?.flg_03,9942);
        expect(Test00070_Rtn?.flg_04,9943);
        expect(Test00070_Rtn?.flg_05,9944);
        expect(Test00070_Rtn?.msg_data_6,'abc45');
        expect(Test00070_Rtn?.msg_data_7,'abc46');
        expect(Test00070_Rtn?.msg_data_8,'abc47');
        expect(Test00070_Rtn?.msg_data_9,'abc48');
        expect(Test00070_Rtn?.msg_data_10,'abc49');
        expect(Test00070_Rtn?.msg_size_6,9950);
        expect(Test00070_Rtn?.msg_size_7,9951);
        expect(Test00070_Rtn?.msg_size_8,9952);
        expect(Test00070_Rtn?.msg_size_9,9953);
        expect(Test00070_Rtn?.msg_size_10,9954);
        expect(Test00070_Rtn?.msg_color_6,9955);
        expect(Test00070_Rtn?.msg_color_7,9956);
        expect(Test00070_Rtn?.msg_color_8,9957);
        expect(Test00070_Rtn?.msg_color_9,9958);
        expect(Test00070_Rtn?.msg_color_10,9959);
        expect(Test00070_Rtn?.flg_06,9960);
        expect(Test00070_Rtn?.flg_07,9961);
        expect(Test00070_Rtn?.flg_08,9962);
        expect(Test00070_Rtn?.flg_09,9963);
        expect(Test00070_Rtn?.flg_10,9964);
      }

      //selectAllDataをして件数取得。
      List<CMsgMst> Test00070_AllRtn2 = await db.selectAllData(Test00070_1);
      int count2 = Test00070_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00070_1);
      print('********** テスト終了：00070_CMsgMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00071 : CMsglayoutMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00071_CMsglayoutMst_01', () async {
      print('\n********** テスト実行：00071_CMsglayoutMst_01 **********');
      CMsglayoutMst Test00071_1 = CMsglayoutMst();
      Test00071_1.comp_cd = 9912;
      Test00071_1.stre_cd = 9913;
      Test00071_1.msggrp_cd = 9914;
      Test00071_1.msg_typ = 9915;
      Test00071_1.msg_cd = 9916;
      Test00071_1.target_typ = 9917;
      Test00071_1.ins_datetime = 'abc18';
      Test00071_1.upd_datetime = 'abc19';
      Test00071_1.status = 9920;
      Test00071_1.send_flg = 9921;
      Test00071_1.upd_user = 9922;
      Test00071_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CMsglayoutMst> Test00071_AllRtn = await db.selectAllData(Test00071_1);
      int count = Test00071_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00071_1);

      //データ取得に必要なオブジェクトを用意
      CMsglayoutMst Test00071_2 = CMsglayoutMst();
      //Keyの値を設定する
      Test00071_2.comp_cd = 9912;
      Test00071_2.stre_cd = 9913;
      Test00071_2.msggrp_cd = 9914;
      Test00071_2.msg_typ = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMsglayoutMst? Test00071_Rtn = await db.selectDataByPrimaryKey(Test00071_2);
      //取得行がない場合、nullが返ってきます
      if (Test00071_Rtn == null) {
        print('\n********** 異常発生：00071_CMsglayoutMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00071_Rtn?.comp_cd,9912);
        expect(Test00071_Rtn?.stre_cd,9913);
        expect(Test00071_Rtn?.msggrp_cd,9914);
        expect(Test00071_Rtn?.msg_typ,9915);
        expect(Test00071_Rtn?.msg_cd,9916);
        expect(Test00071_Rtn?.target_typ,9917);
        expect(Test00071_Rtn?.ins_datetime,'abc18');
        expect(Test00071_Rtn?.upd_datetime,'abc19');
        expect(Test00071_Rtn?.status,9920);
        expect(Test00071_Rtn?.send_flg,9921);
        expect(Test00071_Rtn?.upd_user,9922);
        expect(Test00071_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CMsglayoutMst> Test00071_AllRtn2 = await db.selectAllData(Test00071_1);
      int count2 = Test00071_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00071_1);
      print('********** テスト終了：00071_CMsglayoutMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00072 : CMsgschMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00072_CMsgschMst_01', () async {
      print('\n********** テスト実行：00072_CMsgschMst_01 **********');
      CMsgschMst Test00072_1 = CMsgschMst();
      Test00072_1.comp_cd = 9912;
      Test00072_1.stre_cd = 9913;
      Test00072_1.msgsch_cd = 9914;
      Test00072_1.name = 'abc15';
      Test00072_1.short_name = 'abc16';
      Test00072_1.start_datetime = 'abc17';
      Test00072_1.end_datetime = 'abc18';
      Test00072_1.timesch_flg = 9919;
      Test00072_1.sun_flg = 9920;
      Test00072_1.mon_flg = 9921;
      Test00072_1.tue_flg = 9922;
      Test00072_1.wed_flg = 9923;
      Test00072_1.thu_flg = 9924;
      Test00072_1.fri_flg = 9925;
      Test00072_1.sat_flg = 9926;
      Test00072_1.stop_flg = 9927;
      Test00072_1.ins_datetime = 'abc28';
      Test00072_1.upd_datetime = 'abc29';
      Test00072_1.status = 9930;
      Test00072_1.send_flg = 9931;
      Test00072_1.upd_user = 9932;
      Test00072_1.upd_system = 9933;

      //selectAllDataをして件数取得。
      List<CMsgschMst> Test00072_AllRtn = await db.selectAllData(Test00072_1);
      int count = Test00072_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00072_1);

      //データ取得に必要なオブジェクトを用意
      CMsgschMst Test00072_2 = CMsgschMst();
      //Keyの値を設定する
      Test00072_2.comp_cd = 9912;
      Test00072_2.stre_cd = 9913;
      Test00072_2.msgsch_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMsgschMst? Test00072_Rtn = await db.selectDataByPrimaryKey(Test00072_2);
      //取得行がない場合、nullが返ってきます
      if (Test00072_Rtn == null) {
        print('\n********** 異常発生：00072_CMsgschMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00072_Rtn?.comp_cd,9912);
        expect(Test00072_Rtn?.stre_cd,9913);
        expect(Test00072_Rtn?.msgsch_cd,9914);
        expect(Test00072_Rtn?.name,'abc15');
        expect(Test00072_Rtn?.short_name,'abc16');
        expect(Test00072_Rtn?.start_datetime,'abc17');
        expect(Test00072_Rtn?.end_datetime,'abc18');
        expect(Test00072_Rtn?.timesch_flg,9919);
        expect(Test00072_Rtn?.sun_flg,9920);
        expect(Test00072_Rtn?.mon_flg,9921);
        expect(Test00072_Rtn?.tue_flg,9922);
        expect(Test00072_Rtn?.wed_flg,9923);
        expect(Test00072_Rtn?.thu_flg,9924);
        expect(Test00072_Rtn?.fri_flg,9925);
        expect(Test00072_Rtn?.sat_flg,9926);
        expect(Test00072_Rtn?.stop_flg,9927);
        expect(Test00072_Rtn?.ins_datetime,'abc28');
        expect(Test00072_Rtn?.upd_datetime,'abc29');
        expect(Test00072_Rtn?.status,9930);
        expect(Test00072_Rtn?.send_flg,9931);
        expect(Test00072_Rtn?.upd_user,9932);
        expect(Test00072_Rtn?.upd_system,9933);
      }

      //selectAllDataをして件数取得。
      List<CMsgschMst> Test00072_AllRtn2 = await db.selectAllData(Test00072_1);
      int count2 = Test00072_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00072_1);
      print('********** テスト終了：00072_CMsgschMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00073 : CMsgschLayoutMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00073_CMsgschLayoutMst_01', () async {
      print('\n********** テスト実行：00073_CMsgschLayoutMst_01 **********');
      CMsgschLayoutMst Test00073_1 = CMsgschLayoutMst();
      Test00073_1.comp_cd = 9912;
      Test00073_1.stre_cd = 9913;
      Test00073_1.msgsch_cd = 9914;
      Test00073_1.msggrp_cd = 9915;
      Test00073_1.msg_typ = 9916;
      Test00073_1.msg_cd = 9917;
      Test00073_1.target_typ = 9918;
      Test00073_1.stop_flg = 9919;
      Test00073_1.ins_datetime = 'abc20';
      Test00073_1.upd_datetime = 'abc21';
      Test00073_1.status = 9922;
      Test00073_1.send_flg = 9923;
      Test00073_1.upd_user = 9924;
      Test00073_1.upd_system = 9925;

      //selectAllDataをして件数取得。
      List<CMsgschLayoutMst> Test00073_AllRtn = await db.selectAllData(Test00073_1);
      int count = Test00073_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00073_1);

      //データ取得に必要なオブジェクトを用意
      CMsgschLayoutMst Test00073_2 = CMsgschLayoutMst();
      //Keyの値を設定する
      Test00073_2.comp_cd = 9912;
      Test00073_2.stre_cd = 9913;
      Test00073_2.msgsch_cd = 9914;
      Test00073_2.msggrp_cd = 9915;
      Test00073_2.msg_typ = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMsgschLayoutMst? Test00073_Rtn = await db.selectDataByPrimaryKey(Test00073_2);
      //取得行がない場合、nullが返ってきます
      if (Test00073_Rtn == null) {
        print('\n********** 異常発生：00073_CMsgschLayoutMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00073_Rtn?.comp_cd,9912);
        expect(Test00073_Rtn?.stre_cd,9913);
        expect(Test00073_Rtn?.msgsch_cd,9914);
        expect(Test00073_Rtn?.msggrp_cd,9915);
        expect(Test00073_Rtn?.msg_typ,9916);
        expect(Test00073_Rtn?.msg_cd,9917);
        expect(Test00073_Rtn?.target_typ,9918);
        expect(Test00073_Rtn?.stop_flg,9919);
        expect(Test00073_Rtn?.ins_datetime,'abc20');
        expect(Test00073_Rtn?.upd_datetime,'abc21');
        expect(Test00073_Rtn?.status,9922);
        expect(Test00073_Rtn?.send_flg,9923);
        expect(Test00073_Rtn?.upd_user,9924);
        expect(Test00073_Rtn?.upd_system,9925);
      }

      //selectAllDataをして件数取得。
      List<CMsgschLayoutMst> Test00073_AllRtn2 = await db.selectAllData(Test00073_1);
      int count2 = Test00073_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00073_1);
      print('********** テスト終了：00073_CMsgschLayoutMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00074 : CTrmChkMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00074_CTrmChkMst_01', () async {
      print('\n********** テスト実行：00074_CTrmChkMst_01 **********');
      CTrmChkMst Test00074_1 = CTrmChkMst();
      Test00074_1.trm_chk_grp_cd = 9912;
      Test00074_1.trm_cd = 9913;
      Test00074_1.trm_data = 1.214;
      Test00074_1.trm_chk_eq_flg = 9915;

      //selectAllDataをして件数取得。
      List<CTrmChkMst> Test00074_AllRtn = await db.selectAllData(Test00074_1);
      int count = Test00074_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00074_1);

      //データ取得に必要なオブジェクトを用意
      CTrmChkMst Test00074_2 = CTrmChkMst();
      //Keyの値を設定する
      Test00074_2.trm_chk_grp_cd = 9912;
      Test00074_2.trm_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTrmChkMst? Test00074_Rtn = await db.selectDataByPrimaryKey(Test00074_2);
      //取得行がない場合、nullが返ってきます
      if (Test00074_Rtn == null) {
        print('\n********** 異常発生：00074_CTrmChkMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00074_Rtn?.trm_chk_grp_cd,9912);
        expect(Test00074_Rtn?.trm_cd,9913);
        expect(Test00074_Rtn?.trm_data,1.214);
        expect(Test00074_Rtn?.trm_chk_eq_flg,9915);
      }

      //selectAllDataをして件数取得。
      List<CTrmChkMst> Test00074_AllRtn2 = await db.selectAllData(Test00074_1);
      int count2 = Test00074_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00074_1);
      print('********** テスト終了：00074_CTrmChkMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00075 : CReportCondMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00075_CReportCondMst_01', () async {
      print('\n********** テスト実行：00075_CReportCondMst_01 **********');
      CReportCondMst Test00075_1 = CReportCondMst();
      Test00075_1.code = 9912;
      Test00075_1.menu_kind = 9913;
      Test00075_1.sub_menu_kind = 9914;
      Test00075_1.btn_stp = 9915;
      Test00075_1.btn_grp = 9916;
      Test00075_1.attr_cd = 9917;

      //selectAllDataをして件数取得。
      List<CReportCondMst> Test00075_AllRtn = await db.selectAllData(Test00075_1);
      int count = Test00075_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00075_1);

      //データ取得に必要なオブジェクトを用意
      CReportCondMst Test00075_2 = CReportCondMst();
      //Keyの値を設定する
      Test00075_2.code = 9912;
      Test00075_2.menu_kind = 9913;
      Test00075_2.sub_menu_kind = 9914;
      Test00075_2.btn_stp = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReportCondMst? Test00075_Rtn = await db.selectDataByPrimaryKey(Test00075_2);
      //取得行がない場合、nullが返ってきます
      if (Test00075_Rtn == null) {
        print('\n********** 異常発生：00075_CReportCondMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00075_Rtn?.code,9912);
        expect(Test00075_Rtn?.menu_kind,9913);
        expect(Test00075_Rtn?.sub_menu_kind,9914);
        expect(Test00075_Rtn?.btn_stp,9915);
        expect(Test00075_Rtn?.btn_grp,9916);
        expect(Test00075_Rtn?.attr_cd,9917);
      }

      //selectAllDataをして件数取得。
      List<CReportCondMst> Test00075_AllRtn2 = await db.selectAllData(Test00075_1);
      int count2 = Test00075_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00075_1);
      print('********** テスト終了：00075_CReportCondMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00076 : CReportAttrMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00076_CReportAttrMst_01', () async {
      print('\n********** テスト実行：00076_CReportAttrMst_01 **********');
      CReportAttrMst Test00076_1 = CReportAttrMst();
      Test00076_1.attr_cd = 9912;
      Test00076_1.attr_sub_cd = 9913;
      Test00076_1.attr_typ = 9914;
      Test00076_1.start_data = 'abc15';
      Test00076_1.end_data = 'abc16';
      Test00076_1.digits = 9917;
      Test00076_1.img_cd = 9918;
      Test00076_1.repo_sql_cd = 9919;

      //selectAllDataをして件数取得。
      List<CReportAttrMst> Test00076_AllRtn = await db.selectAllData(Test00076_1);
      int count = Test00076_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00076_1);

      //データ取得に必要なオブジェクトを用意
      CReportAttrMst Test00076_2 = CReportAttrMst();
      //Keyの値を設定する
      Test00076_2.attr_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReportAttrMst? Test00076_Rtn = await db.selectDataByPrimaryKey(Test00076_2);
      //取得行がない場合、nullが返ってきます
      if (Test00076_Rtn == null) {
        print('\n********** 異常発生：00076_CReportAttrMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00076_Rtn?.attr_cd,9912);
        expect(Test00076_Rtn?.attr_sub_cd,9913);
        expect(Test00076_Rtn?.attr_typ,9914);
        expect(Test00076_Rtn?.start_data,'abc15');
        expect(Test00076_Rtn?.end_data,'abc16');
        expect(Test00076_Rtn?.digits,9917);
        expect(Test00076_Rtn?.img_cd,9918);
        expect(Test00076_Rtn?.repo_sql_cd,9919);
      }

      //selectAllDataをして件数取得。
      List<CReportAttrMst> Test00076_AllRtn2 = await db.selectAllData(Test00076_1);
      int count2 = Test00076_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00076_1);
      print('********** テスト終了：00076_CReportAttrMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00077 : CReportAttrSubMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00077_CReportAttrSubMst_01', () async {
      print('\n********** テスト実行：00077_CReportAttrSubMst_01 **********');
      CReportAttrSubMst Test00077_1 = CReportAttrSubMst();
      Test00077_1.attr_sub_cd = 9912;
      Test00077_1.attr_sub_ordr = 9913;
      Test00077_1.img_cd = 9914;
      Test00077_1.repo_sql_cd = 9915;

      //selectAllDataをして件数取得。
      List<CReportAttrSubMst> Test00077_AllRtn = await db.selectAllData(Test00077_1);
      int count = Test00077_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00077_1);

      //データ取得に必要なオブジェクトを用意
      CReportAttrSubMst Test00077_2 = CReportAttrSubMst();
      //Keyの値を設定する
      Test00077_2.attr_sub_cd = 9912;
      Test00077_2.attr_sub_ordr = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReportAttrSubMst? Test00077_Rtn = await db.selectDataByPrimaryKey(Test00077_2);
      //取得行がない場合、nullが返ってきます
      if (Test00077_Rtn == null) {
        print('\n********** 異常発生：00077_CReportAttrSubMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00077_Rtn?.attr_sub_cd,9912);
        expect(Test00077_Rtn?.attr_sub_ordr,9913);
        expect(Test00077_Rtn?.img_cd,9914);
        expect(Test00077_Rtn?.repo_sql_cd,9915);
      }

      //selectAllDataをして件数取得。
      List<CReportAttrSubMst> Test00077_AllRtn2 = await db.selectAllData(Test00077_1);
      int count2 = Test00077_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00077_1);
      print('********** テスト終了：00077_CReportAttrSubMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00078 : CReportSqlMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00078_CReportSqlMst_01', () async {
      print('\n********** テスト実行：00078_CReportSqlMst_01 **********');
      CReportSqlMst Test00078_1 = CReportSqlMst();
      Test00078_1.repo_sql_cd = 9912;
      Test00078_1.repo_sql_typ = 9913;
      Test00078_1.cond_sql = 'abc14';
      Test00078_1.cnct_sql1 = 9915;
      Test00078_1.cond_sql1 = 'abc16';
      Test00078_1.cnct_sql2 = 9917;
      Test00078_1.cond_sql2 = 'abc18';

      //selectAllDataをして件数取得。
      List<CReportSqlMst> Test00078_AllRtn = await db.selectAllData(Test00078_1);
      int count = Test00078_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00078_1);

      //データ取得に必要なオブジェクトを用意
      CReportSqlMst Test00078_2 = CReportSqlMst();
      //Keyの値を設定する
      Test00078_2.repo_sql_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReportSqlMst? Test00078_Rtn = await db.selectDataByPrimaryKey(Test00078_2);
      //取得行がない場合、nullが返ってきます
      if (Test00078_Rtn == null) {
        print('\n********** 異常発生：00078_CReportSqlMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00078_Rtn?.repo_sql_cd,9912);
        expect(Test00078_Rtn?.repo_sql_typ,9913);
        expect(Test00078_Rtn?.cond_sql,'abc14');
        expect(Test00078_Rtn?.cnct_sql1,9915);
        expect(Test00078_Rtn?.cond_sql1,'abc16');
        expect(Test00078_Rtn?.cnct_sql2,9917);
        expect(Test00078_Rtn?.cond_sql2,'abc18');
      }

      //selectAllDataをして件数取得。
      List<CReportSqlMst> Test00078_AllRtn2 = await db.selectAllData(Test00078_1);
      int count2 = Test00078_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00078_1);
      print('********** テスト終了：00078_CReportSqlMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00079 : CTcountMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00079_CTcountMst_01', () async {
      print('\n********** テスト実行：00079_CTcountMst_01 **********');
      CTcountMst Test00079_1 = CTcountMst();
      Test00079_1.tcount_cd = 9912;
      Test00079_1.set_tbl_name = 'abc13';
      Test00079_1.set_tbl_typ = 9914;
      Test00079_1.file_dir = 'abc15';
      Test00079_1.dat_div = 9916;
      Test00079_1.recog_grp_cd = 9917;

      //selectAllDataをして件数取得。
      List<CTcountMst> Test00079_AllRtn = await db.selectAllData(Test00079_1);
      int count = Test00079_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00079_1);

      //データ取得に必要なオブジェクトを用意
      CTcountMst Test00079_2 = CTcountMst();
      //Keyの値を設定する
      Test00079_2.tcount_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTcountMst? Test00079_Rtn = await db.selectDataByPrimaryKey(Test00079_2);
      //取得行がない場合、nullが返ってきます
      if (Test00079_Rtn == null) {
        print('\n********** 異常発生：00079_CTcountMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00079_Rtn?.tcount_cd,9912);
        expect(Test00079_Rtn?.set_tbl_name,'abc13');
        expect(Test00079_Rtn?.set_tbl_typ,9914);
        expect(Test00079_Rtn?.file_dir,'abc15');
        expect(Test00079_Rtn?.dat_div,9916);
        expect(Test00079_Rtn?.recog_grp_cd,9917);
      }

      //selectAllDataをして件数取得。
      List<CTcountMst> Test00079_AllRtn2 = await db.selectAllData(Test00079_1);
      int count2 = Test00079_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00079_1);
      print('********** テスト終了：00079_CTcountMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00080 : CStropnclsMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00080_CStropnclsMst_01', () async {
      print('\n********** テスト実行：00080_CStropnclsMst_01 **********');
      CStropnclsMst Test00080_1 = CStropnclsMst();
      Test00080_1.comp_cd = 9912;
      Test00080_1.stre_cd = 9913;
      Test00080_1.stropncls_grp = 9914;
      Test00080_1.stropncls_cd = 9915;
      Test00080_1.stropncls_data = 1.216;
      Test00080_1.data_typ = 9917;
      Test00080_1.ins_datetime = 'abc18';
      Test00080_1.upd_datetime = 'abc19';
      Test00080_1.status = 9920;
      Test00080_1.send_flg = 9921;
      Test00080_1.upd_user = 9922;
      Test00080_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CStropnclsMst> Test00080_AllRtn = await db.selectAllData(Test00080_1);
      int count = Test00080_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00080_1);

      //データ取得に必要なオブジェクトを用意
      CStropnclsMst Test00080_2 = CStropnclsMst();
      //Keyの値を設定する
      Test00080_2.comp_cd = 9912;
      Test00080_2.stre_cd = 9913;
      Test00080_2.stropncls_grp = 9914;
      Test00080_2.stropncls_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStropnclsMst? Test00080_Rtn = await db.selectDataByPrimaryKey(Test00080_2);
      //取得行がない場合、nullが返ってきます
      if (Test00080_Rtn == null) {
        print('\n********** 異常発生：00080_CStropnclsMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00080_Rtn?.comp_cd,9912);
        expect(Test00080_Rtn?.stre_cd,9913);
        expect(Test00080_Rtn?.stropncls_grp,9914);
        expect(Test00080_Rtn?.stropncls_cd,9915);
        expect(Test00080_Rtn?.stropncls_data,1.216);
        expect(Test00080_Rtn?.data_typ,9917);
        expect(Test00080_Rtn?.ins_datetime,'abc18');
        expect(Test00080_Rtn?.upd_datetime,'abc19');
        expect(Test00080_Rtn?.status,9920);
        expect(Test00080_Rtn?.send_flg,9921);
        expect(Test00080_Rtn?.upd_user,9922);
        expect(Test00080_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CStropnclsMst> Test00080_AllRtn2 = await db.selectAllData(Test00080_1);
      int count2 = Test00080_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00080_1);
      print('********** テスト終了：00080_CStropnclsMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00081 : CStropnclsSetMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00081_CStropnclsSetMst_01', () async {
      print('\n********** テスト実行：00081_CStropnclsSetMst_01 **********');
      CStropnclsSetMst Test00081_1 = CStropnclsSetMst();
      Test00081_1.stropncls_cd = 9912;
      Test00081_1.stropncls_name = 'abc13';
      Test00081_1.stropncls_dsp_cond = 9914;
      Test00081_1.stropncls_inp_cond = 9915;
      Test00081_1.stropncls_limit_max = 1.216;
      Test00081_1.stropncls_limit_min = 1.217;
      Test00081_1.stropncls_digits = 9918;
      Test00081_1.stropncls_zero_typ = 9919;
      Test00081_1.stropncls_btn_color = 9920;
      Test00081_1.stropncls_info_comment = 'abc21';
      Test00081_1.stropncls_info_pic = 9922;
      Test00081_1.ins_datetime = 'abc23';
      Test00081_1.upd_datetime = 'abc24';
      Test00081_1.status = 9925;
      Test00081_1.send_flg = 9926;
      Test00081_1.upd_user = 9927;
      Test00081_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<CStropnclsSetMst> Test00081_AllRtn = await db.selectAllData(Test00081_1);
      int count = Test00081_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00081_1);

      //データ取得に必要なオブジェクトを用意
      CStropnclsSetMst Test00081_2 = CStropnclsSetMst();
      //Keyの値を設定する
      Test00081_2.stropncls_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStropnclsSetMst? Test00081_Rtn = await db.selectDataByPrimaryKey(Test00081_2);
      //取得行がない場合、nullが返ってきます
      if (Test00081_Rtn == null) {
        print('\n********** 異常発生：00081_CStropnclsSetMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00081_Rtn?.stropncls_cd,9912);
        expect(Test00081_Rtn?.stropncls_name,'abc13');
        expect(Test00081_Rtn?.stropncls_dsp_cond,9914);
        expect(Test00081_Rtn?.stropncls_inp_cond,9915);
        expect(Test00081_Rtn?.stropncls_limit_max,1.216);
        expect(Test00081_Rtn?.stropncls_limit_min,1.217);
        expect(Test00081_Rtn?.stropncls_digits,9918);
        expect(Test00081_Rtn?.stropncls_zero_typ,9919);
        expect(Test00081_Rtn?.stropncls_btn_color,9920);
        expect(Test00081_Rtn?.stropncls_info_comment,'abc21');
        expect(Test00081_Rtn?.stropncls_info_pic,9922);
        expect(Test00081_Rtn?.ins_datetime,'abc23');
        expect(Test00081_Rtn?.upd_datetime,'abc24');
        expect(Test00081_Rtn?.status,9925);
        expect(Test00081_Rtn?.send_flg,9926);
        expect(Test00081_Rtn?.upd_user,9927);
        expect(Test00081_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<CStropnclsSetMst> Test00081_AllRtn2 = await db.selectAllData(Test00081_1);
      int count2 = Test00081_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00081_1);
      print('********** テスト終了：00081_CStropnclsSetMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00082 : CStropnclsSubMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00082_CStropnclsSubMst_01', () async {
      print('\n********** テスト実行：00082_CStropnclsSubMst_01 **********');
      CStropnclsSubMst Test00082_1 = CStropnclsSubMst();
      Test00082_1.stropncls_cd = 9912;
      Test00082_1.stropncls_ordr = 9913;
      Test00082_1.stropncls_data = 1.214;
      Test00082_1.img_cd = 9915;
      Test00082_1.stropncls_comment = 'abc16';
      Test00082_1.stropncls_btn_color = 9917;
      Test00082_1.ins_datetime = 'abc18';
      Test00082_1.upd_datetime = 'abc19';
      Test00082_1.status = 9920;
      Test00082_1.send_flg = 9921;
      Test00082_1.upd_user = 9922;
      Test00082_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CStropnclsSubMst> Test00082_AllRtn = await db.selectAllData(Test00082_1);
      int count = Test00082_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00082_1);

      //データ取得に必要なオブジェクトを用意
      CStropnclsSubMst Test00082_2 = CStropnclsSubMst();
      //Keyの値を設定する
      Test00082_2.stropncls_cd = 9912;
      Test00082_2.stropncls_ordr = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStropnclsSubMst? Test00082_Rtn = await db.selectDataByPrimaryKey(Test00082_2);
      //取得行がない場合、nullが返ってきます
      if (Test00082_Rtn == null) {
        print('\n********** 異常発生：00082_CStropnclsSubMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00082_Rtn?.stropncls_cd,9912);
        expect(Test00082_Rtn?.stropncls_ordr,9913);
        expect(Test00082_Rtn?.stropncls_data,1.214);
        expect(Test00082_Rtn?.img_cd,9915);
        expect(Test00082_Rtn?.stropncls_comment,'abc16');
        expect(Test00082_Rtn?.stropncls_btn_color,9917);
        expect(Test00082_Rtn?.ins_datetime,'abc18');
        expect(Test00082_Rtn?.upd_datetime,'abc19');
        expect(Test00082_Rtn?.status,9920);
        expect(Test00082_Rtn?.send_flg,9921);
        expect(Test00082_Rtn?.upd_user,9922);
        expect(Test00082_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CStropnclsSubMst> Test00082_AllRtn2 = await db.selectAllData(Test00082_1);
      int count2 = Test00082_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00082_1);
      print('********** テスト終了：00082_CStropnclsSubMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00083 : CCashrecycleMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00083_CCashrecycleMst_01', () async {
      print('\n********** テスト実行：00083_CCashrecycleMst_01 **********');
      CCashrecycleMst Test00083_1 = CCashrecycleMst();
      Test00083_1.comp_cd = 9912;
      Test00083_1.stre_cd = 9913;
      Test00083_1.cashrecycle_grp = 9914;
      Test00083_1.code = 9915;
      Test00083_1.data = 1.216;
      Test00083_1.data_typ = 9917;
      Test00083_1.ins_datetime = 'abc18';
      Test00083_1.upd_datetime = 'abc19';
      Test00083_1.status = 9920;
      Test00083_1.send_flg = 9921;
      Test00083_1.upd_user = 9922;
      Test00083_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CCashrecycleMst> Test00083_AllRtn = await db.selectAllData(Test00083_1);
      int count = Test00083_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00083_1);

      //データ取得に必要なオブジェクトを用意
      CCashrecycleMst Test00083_2 = CCashrecycleMst();
      //Keyの値を設定する
      Test00083_2.comp_cd = 9912;
      Test00083_2.stre_cd = 9913;
      Test00083_2.cashrecycle_grp = 9914;
      Test00083_2.code = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCashrecycleMst? Test00083_Rtn = await db.selectDataByPrimaryKey(Test00083_2);
      //取得行がない場合、nullが返ってきます
      if (Test00083_Rtn == null) {
        print('\n********** 異常発生：00083_CCashrecycleMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00083_Rtn?.comp_cd,9912);
        expect(Test00083_Rtn?.stre_cd,9913);
        expect(Test00083_Rtn?.cashrecycle_grp,9914);
        expect(Test00083_Rtn?.code,9915);
        expect(Test00083_Rtn?.data,1.216);
        expect(Test00083_Rtn?.data_typ,9917);
        expect(Test00083_Rtn?.ins_datetime,'abc18');
        expect(Test00083_Rtn?.upd_datetime,'abc19');
        expect(Test00083_Rtn?.status,9920);
        expect(Test00083_Rtn?.send_flg,9921);
        expect(Test00083_Rtn?.upd_user,9922);
        expect(Test00083_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CCashrecycleMst> Test00083_AllRtn2 = await db.selectAllData(Test00083_1);
      int count2 = Test00083_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00083_1);
      print('********** テスト終了：00083_CCashrecycleMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00084 : CCashrecycleSetMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00084_CCashrecycleSetMst_01', () async {
      print('\n********** テスト実行：00084_CCashrecycleSetMst_01 **********');
      CCashrecycleSetMst Test00084_1 = CCashrecycleSetMst();
      Test00084_1.code = 9912;
      Test00084_1.set_name = 'abc13';
      Test00084_1.dsp_cond = 9914;
      Test00084_1.inp_cond = 9915;
      Test00084_1.limit_max = 1.216;
      Test00084_1.limit_min = 1.217;
      Test00084_1.digits = 9918;
      Test00084_1.zero_typ = 9919;
      Test00084_1.btn_color = 9920;
      Test00084_1.info_comment = 'abc21';
      Test00084_1.info_pic = 9922;
      Test00084_1.ins_datetime = 'abc23';
      Test00084_1.upd_datetime = 'abc24';
      Test00084_1.status = 9925;
      Test00084_1.send_flg = 9926;
      Test00084_1.upd_user = 9927;
      Test00084_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<CCashrecycleSetMst> Test00084_AllRtn = await db.selectAllData(Test00084_1);
      int count = Test00084_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00084_1);

      //データ取得に必要なオブジェクトを用意
      CCashrecycleSetMst Test00084_2 = CCashrecycleSetMst();
      //Keyの値を設定する
      Test00084_2.code = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCashrecycleSetMst? Test00084_Rtn = await db.selectDataByPrimaryKey(Test00084_2);
      //取得行がない場合、nullが返ってきます
      if (Test00084_Rtn == null) {
        print('\n********** 異常発生：00084_CCashrecycleSetMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00084_Rtn?.code,9912);
        expect(Test00084_Rtn?.set_name,'abc13');
        expect(Test00084_Rtn?.dsp_cond,9914);
        expect(Test00084_Rtn?.inp_cond,9915);
        expect(Test00084_Rtn?.limit_max,1.216);
        expect(Test00084_Rtn?.limit_min,1.217);
        expect(Test00084_Rtn?.digits,9918);
        expect(Test00084_Rtn?.zero_typ,9919);
        expect(Test00084_Rtn?.btn_color,9920);
        expect(Test00084_Rtn?.info_comment,'abc21');
        expect(Test00084_Rtn?.info_pic,9922);
        expect(Test00084_Rtn?.ins_datetime,'abc23');
        expect(Test00084_Rtn?.upd_datetime,'abc24');
        expect(Test00084_Rtn?.status,9925);
        expect(Test00084_Rtn?.send_flg,9926);
        expect(Test00084_Rtn?.upd_user,9927);
        expect(Test00084_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<CCashrecycleSetMst> Test00084_AllRtn2 = await db.selectAllData(Test00084_1);
      int count2 = Test00084_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00084_1);
      print('********** テスト終了：00084_CCashrecycleSetMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00085 : CCashrecycleSubMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00085_CCashrecycleSubMst_01', () async {
      print('\n********** テスト実行：00085_CCashrecycleSubMst_01 **********');
      CCashrecycleSubMst Test00085_1 = CCashrecycleSubMst();
      Test00085_1.code = 9912;
      Test00085_1.ordr = 9913;
      Test00085_1.data = 1.214;
      Test00085_1.img_cd = 9915;
      Test00085_1.comment = 'abc16';
      Test00085_1.btn_color = 9917;
      Test00085_1.ins_datetime = 'abc18';
      Test00085_1.upd_datetime = 'abc19';
      Test00085_1.status = 9920;
      Test00085_1.send_flg = 9921;
      Test00085_1.upd_user = 9922;
      Test00085_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CCashrecycleSubMst> Test00085_AllRtn = await db.selectAllData(Test00085_1);
      int count = Test00085_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00085_1);

      //データ取得に必要なオブジェクトを用意
      CCashrecycleSubMst Test00085_2 = CCashrecycleSubMst();
      //Keyの値を設定する
      Test00085_2.code = 9912;
      Test00085_2.ordr = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCashrecycleSubMst? Test00085_Rtn = await db.selectDataByPrimaryKey(Test00085_2);
      //取得行がない場合、nullが返ってきます
      if (Test00085_Rtn == null) {
        print('\n********** 異常発生：00085_CCashrecycleSubMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00085_Rtn?.code,9912);
        expect(Test00085_Rtn?.ordr,9913);
        expect(Test00085_Rtn?.data,1.214);
        expect(Test00085_Rtn?.img_cd,9915);
        expect(Test00085_Rtn?.comment,'abc16');
        expect(Test00085_Rtn?.btn_color,9917);
        expect(Test00085_Rtn?.ins_datetime,'abc18');
        expect(Test00085_Rtn?.upd_datetime,'abc19');
        expect(Test00085_Rtn?.status,9920);
        expect(Test00085_Rtn?.send_flg,9921);
        expect(Test00085_Rtn?.upd_user,9922);
        expect(Test00085_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CCashrecycleSubMst> Test00085_AllRtn2 = await db.selectAllData(Test00085_1);
      int count2 = Test00085_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00085_1);
      print('********** テスト終了：00085_CCashrecycleSubMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00086 : CCashrecycleInfoMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00086_CCashrecycleInfoMst_01', () async {
      print('\n********** テスト実行：00086_CCashrecycleInfoMst_01 **********');
      CCashrecycleInfoMst Test00086_1 = CCashrecycleInfoMst();
      Test00086_1.comp_cd = 9912;
      Test00086_1.stre_cd = 9913;
      Test00086_1.mac_no = 9914;
      Test00086_1.cashrecycle_grp = 9915;
      Test00086_1.cal_grp_cd = 9916;
      Test00086_1.server = 9917;
      Test00086_1.server_macno = 9918;
      Test00086_1.server_info = 'abc19';
      Test00086_1.sub_server = 9920;
      Test00086_1.sub_server_macno = 9921;
      Test00086_1.sub_server_info = 'abc22';
      Test00086_1.first_disp_macno1 = 9923;
      Test00086_1.first_disp_macno2 = 9924;
      Test00086_1.first_disp_macno3 = 9925;
      Test00086_1.ins_datetime = 'abc26';
      Test00086_1.upd_datetime = 'abc27';
      Test00086_1.status = 9928;
      Test00086_1.send_flg = 9929;
      Test00086_1.upd_user = 9930;
      Test00086_1.upd_system = 9931;

      //selectAllDataをして件数取得。
      List<CCashrecycleInfoMst> Test00086_AllRtn = await db.selectAllData(Test00086_1);
      int count = Test00086_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00086_1);

      //データ取得に必要なオブジェクトを用意
      CCashrecycleInfoMst Test00086_2 = CCashrecycleInfoMst();
      //Keyの値を設定する
      Test00086_2.comp_cd = 9912;
      Test00086_2.stre_cd = 9913;
      Test00086_2.mac_no = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCashrecycleInfoMst? Test00086_Rtn = await db.selectDataByPrimaryKey(Test00086_2);
      //取得行がない場合、nullが返ってきます
      if (Test00086_Rtn == null) {
        print('\n********** 異常発生：00086_CCashrecycleInfoMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00086_Rtn?.comp_cd,9912);
        expect(Test00086_Rtn?.stre_cd,9913);
        expect(Test00086_Rtn?.mac_no,9914);
        expect(Test00086_Rtn?.cashrecycle_grp,9915);
        expect(Test00086_Rtn?.cal_grp_cd,9916);
        expect(Test00086_Rtn?.server,9917);
        expect(Test00086_Rtn?.server_macno,9918);
        expect(Test00086_Rtn?.server_info,'abc19');
        expect(Test00086_Rtn?.sub_server,9920);
        expect(Test00086_Rtn?.sub_server_macno,9921);
        expect(Test00086_Rtn?.sub_server_info,'abc22');
        expect(Test00086_Rtn?.first_disp_macno1,9923);
        expect(Test00086_Rtn?.first_disp_macno2,9924);
        expect(Test00086_Rtn?.first_disp_macno3,9925);
        expect(Test00086_Rtn?.ins_datetime,'abc26');
        expect(Test00086_Rtn?.upd_datetime,'abc27');
        expect(Test00086_Rtn?.status,9928);
        expect(Test00086_Rtn?.send_flg,9929);
        expect(Test00086_Rtn?.upd_user,9930);
        expect(Test00086_Rtn?.upd_system,9931);
      }

      //selectAllDataをして件数取得。
      List<CCashrecycleInfoMst> Test00086_AllRtn2 = await db.selectAllData(Test00086_1);
      int count2 = Test00086_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00086_1);
      print('********** テスト終了：00086_CCashrecycleInfoMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00087 : CMsglayoutSetMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00087_CMsglayoutSetMst_01', () async {
      print('\n********** テスト実行：00087_CMsglayoutSetMst_01 **********');
      CMsglayoutSetMst Test00087_1 = CMsglayoutSetMst();
      Test00087_1.msg_set_kind = 9912;
      Test00087_1.msg_data = 9913;
      Test00087_1.msg_name = 'abc14';
      Test00087_1.msg_dsp_cond = 9915;
      Test00087_1.msg_target_dsp_cond = 9916;
      Test00087_1.ins_datetime = 'abc17';
      Test00087_1.upd_datetime = 'abc18';
      Test00087_1.status = 9919;
      Test00087_1.send_flg = 9920;
      Test00087_1.upd_user = 9921;
      Test00087_1.upd_system = 9922;

      //selectAllDataをして件数取得。
      List<CMsglayoutSetMst> Test00087_AllRtn = await db.selectAllData(Test00087_1);
      int count = Test00087_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00087_1);

      //データ取得に必要なオブジェクトを用意
      CMsglayoutSetMst Test00087_2 = CMsglayoutSetMst();
      //Keyの値を設定する
      Test00087_2.msg_set_kind = 9912;
      Test00087_2.msg_data = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMsglayoutSetMst? Test00087_Rtn = await db.selectDataByPrimaryKey(Test00087_2);
      //取得行がない場合、nullが返ってきます
      if (Test00087_Rtn == null) {
        print('\n********** 異常発生：00087_CMsglayoutSetMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00087_Rtn?.msg_set_kind,9912);
        expect(Test00087_Rtn?.msg_data,9913);
        expect(Test00087_Rtn?.msg_name,'abc14');
        expect(Test00087_Rtn?.msg_dsp_cond,9915);
        expect(Test00087_Rtn?.msg_target_dsp_cond,9916);
        expect(Test00087_Rtn?.ins_datetime,'abc17');
        expect(Test00087_Rtn?.upd_datetime,'abc18');
        expect(Test00087_Rtn?.status,9919);
        expect(Test00087_Rtn?.send_flg,9920);
        expect(Test00087_Rtn?.upd_user,9921);
        expect(Test00087_Rtn?.upd_system,9922);
      }

      //selectAllDataをして件数取得。
      List<CMsglayoutSetMst> Test00087_AllRtn2 = await db.selectAllData(Test00087_1);
      int count2 = Test00087_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00087_1);
      print('********** テスト終了：00087_CMsglayoutSetMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00088 : CPayoperatorMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00088_CPayoperatorMst_01', () async {
      print('\n********** テスト実行：00088_CPayoperatorMst_01 **********');
      CPayoperatorMst Test00088_1 = CPayoperatorMst();
      Test00088_1.comp_cd = 9912;
      Test00088_1.stre_cd = 9913;
      Test00088_1.payopera_typ = 'abc14';
      Test00088_1.payopera_cd = 9915;
      Test00088_1.name = 'abc16';
      Test00088_1.short_name = 'abc17';
      Test00088_1.misc_cd = 9918;
      Test00088_1.showorder = 9919;
      Test00088_1.ins_datetime = 'abc20';
      Test00088_1.upd_datetime = 'abc21';
      Test00088_1.status = 9922;
      Test00088_1.send_flg = 9923;
      Test00088_1.upd_user = 9924;
      Test00088_1.upd_system = 9925;

      //selectAllDataをして件数取得。
      List<CPayoperatorMst> Test00088_AllRtn = await db.selectAllData(Test00088_1);
      int count = Test00088_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00088_1);

      //データ取得に必要なオブジェクトを用意
      CPayoperatorMst Test00088_2 = CPayoperatorMst();
      //Keyの値を設定する
      Test00088_2.comp_cd = 9912;
      Test00088_2.stre_cd = 9913;
      Test00088_2.payopera_typ = 'abc14';
      Test00088_2.payopera_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPayoperatorMst? Test00088_Rtn = await db.selectDataByPrimaryKey(Test00088_2);
      //取得行がない場合、nullが返ってきます
      if (Test00088_Rtn == null) {
        print('\n********** 異常発生：00088_CPayoperatorMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00088_Rtn?.comp_cd,9912);
        expect(Test00088_Rtn?.stre_cd,9913);
        expect(Test00088_Rtn?.payopera_typ,'abc14');
        expect(Test00088_Rtn?.payopera_cd,9915);
        expect(Test00088_Rtn?.name,'abc16');
        expect(Test00088_Rtn?.short_name,'abc17');
        expect(Test00088_Rtn?.misc_cd,9918);
        expect(Test00088_Rtn?.showorder,9919);
        expect(Test00088_Rtn?.ins_datetime,'abc20');
        expect(Test00088_Rtn?.upd_datetime,'abc21');
        expect(Test00088_Rtn?.status,9922);
        expect(Test00088_Rtn?.send_flg,9923);
        expect(Test00088_Rtn?.upd_user,9924);
        expect(Test00088_Rtn?.upd_system,9925);
      }

      //selectAllDataをして件数取得。
      List<CPayoperatorMst> Test00088_AllRtn2 = await db.selectAllData(Test00088_1);
      int count2 = Test00088_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00088_1);
      print('********** テスト終了：00088_CPayoperatorMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00089 : CBatprcchgMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00089_CBatprcchgMst_01', () async {
      print('\n********** テスト実行：00089_CBatprcchgMst_01 **********');
      CBatprcchgMst Test00089_1 = CBatprcchgMst();
      Test00089_1.prcchg_cd = 9912;
      Test00089_1.order_cd = 9913;
      Test00089_1.comp_cd = 9914;
      Test00089_1.stre_cd = 9915;
      Test00089_1.plu_cd = 'abc16';
      Test00089_1.flg = 9917;
      Test00089_1.pos_prc = 9918;
      Test00089_1.cust_prc = 9919;
      Test00089_1.start_datetime = 'abc20';
      Test00089_1.end_datetime = 'abc21';
      Test00089_1.timesch_flg = 9922;
      Test00089_1.sun_flg = 9923;
      Test00089_1.mon_flg = 9924;
      Test00089_1.tue_flg = 9925;
      Test00089_1.wed_flg = 9926;
      Test00089_1.thu_flg = 9927;
      Test00089_1.fri_flg = 9928;
      Test00089_1.sat_flg = 9929;
      Test00089_1.stop_flg = 9930;
      Test00089_1.ins_datetime = 'abc31';
      Test00089_1.upd_datetime = 'abc32';
      Test00089_1.status = 9933;
      Test00089_1.send_flg = 9934;
      Test00089_1.upd_user = 9935;
      Test00089_1.upd_system = 9936;

      //selectAllDataをして件数取得。
      List<CBatprcchgMst> Test00089_AllRtn = await db.selectAllData(Test00089_1);
      int count = Test00089_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00089_1);

      //データ取得に必要なオブジェクトを用意
      CBatprcchgMst Test00089_2 = CBatprcchgMst();
      //Keyの値を設定する
      Test00089_2.prcchg_cd = 9912;
      Test00089_2.order_cd = 9913;
      Test00089_2.comp_cd = 9914;
      Test00089_2.stre_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CBatprcchgMst? Test00089_Rtn = await db.selectDataByPrimaryKey(Test00089_2);
      //取得行がない場合、nullが返ってきます
      if (Test00089_Rtn == null) {
        print('\n********** 異常発生：00089_CBatprcchgMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00089_Rtn?.prcchg_cd,9912);
        expect(Test00089_Rtn?.order_cd,9913);
        expect(Test00089_Rtn?.comp_cd,9914);
        expect(Test00089_Rtn?.stre_cd,9915);
        expect(Test00089_Rtn?.plu_cd,'abc16');
        expect(Test00089_Rtn?.flg,9917);
        expect(Test00089_Rtn?.pos_prc,9918);
        expect(Test00089_Rtn?.cust_prc,9919);
        expect(Test00089_Rtn?.start_datetime,'abc20');
        expect(Test00089_Rtn?.end_datetime,'abc21');
        expect(Test00089_Rtn?.timesch_flg,9922);
        expect(Test00089_Rtn?.sun_flg,9923);
        expect(Test00089_Rtn?.mon_flg,9924);
        expect(Test00089_Rtn?.tue_flg,9925);
        expect(Test00089_Rtn?.wed_flg,9926);
        expect(Test00089_Rtn?.thu_flg,9927);
        expect(Test00089_Rtn?.fri_flg,9928);
        expect(Test00089_Rtn?.sat_flg,9929);
        expect(Test00089_Rtn?.stop_flg,9930);
        expect(Test00089_Rtn?.ins_datetime,'abc31');
        expect(Test00089_Rtn?.upd_datetime,'abc32');
        expect(Test00089_Rtn?.status,9933);
        expect(Test00089_Rtn?.send_flg,9934);
        expect(Test00089_Rtn?.upd_user,9935);
        expect(Test00089_Rtn?.upd_system,9936);
      }

      //selectAllDataをして件数取得。
      List<CBatprcchgMst> Test00089_AllRtn2 = await db.selectAllData(Test00089_1);
      int count2 = Test00089_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00089_1);
      print('********** テスト終了：00089_CBatprcchgMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00090 : CDivide2Mst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00090_CDivide2Mst_01', () async {
      print('\n********** テスト実行：00090_CDivide2Mst_01 **********');
      CDivide2Mst Test00090_1 = CDivide2Mst();
      Test00090_1.comp_cd = 9912;
      Test00090_1.stre_cd = 9913;
      Test00090_1.kind_cd = 9914;
      Test00090_1.div_cd = 9915;
      Test00090_1.name = 'abc16';
      Test00090_1.short_name = 'abc17';
      Test00090_1.exp_cd1 = 9918;
      Test00090_1.exp_cd2 = 9919;
      Test00090_1.exp_cd3 = 9920;
      Test00090_1.exp_cd4 = 9921;
      Test00090_1.exp_data1 = 'abc22';
      Test00090_1.exp_data2 = 'abc23';
      Test00090_1.exp_data3 = 'abc24';
      Test00090_1.exp_l_cd1 = 9925;
      Test00090_1.exp_l_cd2 = 9926;
      Test00090_1.exp_l_cd3 = 9927;
      Test00090_1.exp_d_cd1 = 1.228;
      Test00090_1.exp_d_cd2 = 1.229;
      Test00090_1.exp_amt = 9930;
      Test00090_1.ins_datetime = 'abc31';
      Test00090_1.upd_datetime = 'abc32';
      Test00090_1.status = 9933;
      Test00090_1.send_flg = 9934;
      Test00090_1.upd_user = 9935;
      Test00090_1.upd_system = 9936;

      //selectAllDataをして件数取得。
      List<CDivide2Mst> Test00090_AllRtn = await db.selectAllData(Test00090_1);
      int count = Test00090_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00090_1);

      //データ取得に必要なオブジェクトを用意
      CDivide2Mst Test00090_2 = CDivide2Mst();
      //Keyの値を設定する
      Test00090_2.comp_cd = 9912;
      Test00090_2.stre_cd = 9913;
      Test00090_2.kind_cd = 9914;
      Test00090_2.div_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDivide2Mst? Test00090_Rtn = await db.selectDataByPrimaryKey(Test00090_2);
      //取得行がない場合、nullが返ってきます
      if (Test00090_Rtn == null) {
        print('\n********** 異常発生：00090_CDivide2Mst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00090_Rtn?.comp_cd,9912);
        expect(Test00090_Rtn?.stre_cd,9913);
        expect(Test00090_Rtn?.kind_cd,9914);
        expect(Test00090_Rtn?.div_cd,9915);
        expect(Test00090_Rtn?.name,'abc16');
        expect(Test00090_Rtn?.short_name,'abc17');
        expect(Test00090_Rtn?.exp_cd1,9918);
        expect(Test00090_Rtn?.exp_cd2,9919);
        expect(Test00090_Rtn?.exp_cd3,9920);
        expect(Test00090_Rtn?.exp_cd4,9921);
        expect(Test00090_Rtn?.exp_data1,'abc22');
        expect(Test00090_Rtn?.exp_data2,'abc23');
        expect(Test00090_Rtn?.exp_data3,'abc24');
        expect(Test00090_Rtn?.exp_l_cd1,9925);
        expect(Test00090_Rtn?.exp_l_cd2,9926);
        expect(Test00090_Rtn?.exp_l_cd3,9927);
        expect(Test00090_Rtn?.exp_d_cd1,1.228);
        expect(Test00090_Rtn?.exp_d_cd2,1.229);
        expect(Test00090_Rtn?.exp_amt,9930);
        expect(Test00090_Rtn?.ins_datetime,'abc31');
        expect(Test00090_Rtn?.upd_datetime,'abc32');
        expect(Test00090_Rtn?.status,9933);
        expect(Test00090_Rtn?.send_flg,9934);
        expect(Test00090_Rtn?.upd_user,9935);
        expect(Test00090_Rtn?.upd_system,9936);
      }

      //selectAllDataをして件数取得。
      List<CDivide2Mst> Test00090_AllRtn2 = await db.selectAllData(Test00090_1);
      int count2 = Test00090_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00090_1);
      print('********** テスト終了：00090_CDivide2Mst_01 **********\n\n');
    });
  });
}

