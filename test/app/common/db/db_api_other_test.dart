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
本テストでは、以下の90tableを対象にする
pos_other_table_access.dart 04_POS_その他 14tables
pos_log_table_access.dart 05_POS_ログ 14tables
non_promotion_table_access.dart 06_ノンプロモーション系 10tables
royalty_promotion_table_access.dart 07_ロイヤリティプロモーション系 18tables
customer_table_access.dart 08_顧客マスタ系 5tables
staff_table_access.dart 09_従業員マスタ系 8tables
system_table_access.dart 10_システム系 4tables
pos_sale_performance_table_access.dart 16tables
flutter_add_table_access.dart Flutter環境への移行に伴い追加したテーブル 1table
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
    // テスト00091 : CReservTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00091_CReservTbl_01', () async {
      print('\n********** テスト実行：00091_CReservTbl_01 **********');
      CReservTbl Test00091_1 = CReservTbl();
      Test00091_1.serial_no = 'abc12';
      Test00091_1.cust_no = 'abc13';
      Test00091_1.last_name = 'abc14';
      Test00091_1.first_name = 'abc15';
      Test00091_1.tel_no1 = 'abc16';
      Test00091_1.tel_no2 = 'abc17';
      Test00091_1.post_no = 'abc18';
      Test00091_1.address1 = 'abc19';
      Test00091_1.address2 = 'abc20';
      Test00091_1.address3 = 'abc21';
      Test00091_1.recept_date = 'abc22';
      Test00091_1.ferry_date = 'abc23';
      Test00091_1.arrival_date = 'abc24';
      Test00091_1.qty = 9925;
      Test00091_1.ttl = 9926;
      Test00091_1.advance_money = 9927;
      Test00091_1.memo1 = 'abc28';
      Test00091_1.memo2 = 'abc29';
      Test00091_1.finish = 9930;

      //selectAllDataをして件数取得。
      List<CReservTbl> Test00091_AllRtn = await db.selectAllData(Test00091_1);
      int count = Test00091_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00091_1);

      //データ取得に必要なオブジェクトを用意
      CReservTbl Test00091_2 = CReservTbl();
      //Keyの値を設定する
      Test00091_2.serial_no = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReservTbl? Test00091_Rtn = await db.selectDataByPrimaryKey(Test00091_2);
      //取得行がない場合、nullが返ってきます
      if (Test00091_Rtn == null) {
        print('\n********** 異常発生：00091_CReservTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00091_Rtn?.serial_no,'abc12');
        expect(Test00091_Rtn?.cust_no,'abc13');
        expect(Test00091_Rtn?.last_name,'abc14');
        expect(Test00091_Rtn?.first_name,'abc15');
        expect(Test00091_Rtn?.tel_no1,'abc16');
        expect(Test00091_Rtn?.tel_no2,'abc17');
        expect(Test00091_Rtn?.post_no,'abc18');
        expect(Test00091_Rtn?.address1,'abc19');
        expect(Test00091_Rtn?.address2,'abc20');
        expect(Test00091_Rtn?.address3,'abc21');
        expect(Test00091_Rtn?.recept_date,'abc22');
        expect(Test00091_Rtn?.ferry_date,'abc23');
        expect(Test00091_Rtn?.arrival_date,'abc24');
        expect(Test00091_Rtn?.qty,9925);
        expect(Test00091_Rtn?.ttl,9926);
        expect(Test00091_Rtn?.advance_money,9927);
        expect(Test00091_Rtn?.memo1,'abc28');
        expect(Test00091_Rtn?.memo2,'abc29');
        expect(Test00091_Rtn?.finish,9930);
      }

      //selectAllDataをして件数取得。
      List<CReservTbl> Test00091_AllRtn2 = await db.selectAllData(Test00091_1);
      int count2 = Test00091_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00091_1);
      print('********** テスト終了：00091_CReservTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00092 : PPbchgBalanceTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00092_PPbchgBalanceTbl_01', () async {
      print('\n********** テスト実行：00092_PPbchgBalanceTbl_01 **********');
      PPbchgBalanceTbl Test00092_1 = PPbchgBalanceTbl();
      Test00092_1.comp_cd = 9912;
      Test00092_1.stre_cd = 9913;
      Test00092_1.groupcd = 9914;
      Test00092_1.officecd = 9915;
      Test00092_1.dwn_balance = 9916;
      Test00092_1.validflag = 9917;
      Test00092_1.now_balance = 9918;
      Test00092_1.pay_amt = 9919;
      Test00092_1.settle_flg = 9920;
      Test00092_1.fil1 = 9921;
      Test00092_1.fil2 = 9922;

      //selectAllDataをして件数取得。
      List<PPbchgBalanceTbl> Test00092_AllRtn = await db.selectAllData(Test00092_1);
      int count = Test00092_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00092_1);

      //データ取得に必要なオブジェクトを用意
      PPbchgBalanceTbl Test00092_2 = PPbchgBalanceTbl();
      //Keyの値を設定する
      Test00092_2.comp_cd = 9912;
      Test00092_2.stre_cd = 9913;
      Test00092_2.groupcd = 9914;
      Test00092_2.officecd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPbchgBalanceTbl? Test00092_Rtn = await db.selectDataByPrimaryKey(Test00092_2);
      //取得行がない場合、nullが返ってきます
      if (Test00092_Rtn == null) {
        print('\n********** 異常発生：00092_PPbchgBalanceTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00092_Rtn?.comp_cd,9912);
        expect(Test00092_Rtn?.stre_cd,9913);
        expect(Test00092_Rtn?.groupcd,9914);
        expect(Test00092_Rtn?.officecd,9915);
        expect(Test00092_Rtn?.dwn_balance,9916);
        expect(Test00092_Rtn?.validflag,9917);
        expect(Test00092_Rtn?.now_balance,9918);
        expect(Test00092_Rtn?.pay_amt,9919);
        expect(Test00092_Rtn?.settle_flg,9920);
        expect(Test00092_Rtn?.fil1,9921);
        expect(Test00092_Rtn?.fil2,9922);
      }

      //selectAllDataをして件数取得。
      List<PPbchgBalanceTbl> Test00092_AllRtn2 = await db.selectAllData(Test00092_1);
      int count2 = Test00092_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00092_1);
      print('********** テスト終了：00092_PPbchgBalanceTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00093 : PPbchgStreTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00093_PPbchgStreTbl_01', () async {
      print('\n********** テスト実行：00093_PPbchgStreTbl_01 **********');
      PPbchgStreTbl Test00093_1 = PPbchgStreTbl();
      Test00093_1.comp_cd = 9912;
      Test00093_1.stre_cd = 9913;
      Test00093_1.groupcd = 9914;
      Test00093_1.officecd = 9915;
      Test00093_1.strecd = 9916;
      Test00093_1.termcd = 9917;
      Test00093_1.minimum = 9918;
      Test00093_1.svcstopclassify = 9919;
      Test00093_1.svcstopmoney = 9920;
      Test00093_1.office_svcclassify = 9921;
      Test00093_1.office_validflag = 9922;
      Test00093_1.office_changed = 'abc23';
      Test00093_1.stre_svcclassify = 9924;
      Test00093_1.stre_validflag = 9925;
      Test00093_1.stre_changed = 'abc26';
      Test00093_1.eastclassify = 9927;
      Test00093_1.westclassify = 9928;
      Test00093_1.term_svcclassify = 9929;
      Test00093_1.term_validflag = 9930;
      Test00093_1.term_changed = 'abc31';
      Test00093_1.fil1 = 9932;
      Test00093_1.fil2 = 9933;

      //selectAllDataをして件数取得。
      List<PPbchgStreTbl> Test00093_AllRtn = await db.selectAllData(Test00093_1);
      int count = Test00093_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00093_1);

      //データ取得に必要なオブジェクトを用意
      PPbchgStreTbl Test00093_2 = PPbchgStreTbl();
      //Keyの値を設定する
      Test00093_2.comp_cd = 9912;
      Test00093_2.stre_cd = 9913;
      Test00093_2.groupcd = 9914;
      Test00093_2.officecd = 9915;
      Test00093_2.strecd = 9916;
      Test00093_2.termcd = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPbchgStreTbl? Test00093_Rtn = await db.selectDataByPrimaryKey(Test00093_2);
      //取得行がない場合、nullが返ってきます
      if (Test00093_Rtn == null) {
        print('\n********** 異常発生：00093_PPbchgStreTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00093_Rtn?.comp_cd,9912);
        expect(Test00093_Rtn?.stre_cd,9913);
        expect(Test00093_Rtn?.groupcd,9914);
        expect(Test00093_Rtn?.officecd,9915);
        expect(Test00093_Rtn?.strecd,9916);
        expect(Test00093_Rtn?.termcd,9917);
        expect(Test00093_Rtn?.minimum,9918);
        expect(Test00093_Rtn?.svcstopclassify,9919);
        expect(Test00093_Rtn?.svcstopmoney,9920);
        expect(Test00093_Rtn?.office_svcclassify,9921);
        expect(Test00093_Rtn?.office_validflag,9922);
        expect(Test00093_Rtn?.office_changed,'abc23');
        expect(Test00093_Rtn?.stre_svcclassify,9924);
        expect(Test00093_Rtn?.stre_validflag,9925);
        expect(Test00093_Rtn?.stre_changed,'abc26');
        expect(Test00093_Rtn?.eastclassify,9927);
        expect(Test00093_Rtn?.westclassify,9928);
        expect(Test00093_Rtn?.term_svcclassify,9929);
        expect(Test00093_Rtn?.term_validflag,9930);
        expect(Test00093_Rtn?.term_changed,'abc31');
        expect(Test00093_Rtn?.fil1,9932);
        expect(Test00093_Rtn?.fil2,9933);
      }

      //selectAllDataをして件数取得。
      List<PPbchgStreTbl> Test00093_AllRtn2 = await db.selectAllData(Test00093_1);
      int count2 = Test00093_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00093_1);
      print('********** テスト終了：00093_PPbchgStreTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00094 : PPbchgCorpTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00094_PPbchgCorpTbl_01', () async {
      print('\n********** テスト実行：00094_PPbchgCorpTbl_01 **********');
      PPbchgCorpTbl Test00094_1 = PPbchgCorpTbl();
      Test00094_1.comp_cd = 9912;
      Test00094_1.stre_cd = 9913;
      Test00094_1.corpcd = 9914;
      Test00094_1.subclassify = 9915;
      Test00094_1.subcd = 9916;
      Test00094_1.name = 'abc17';
      Test00094_1.kana = 'abc18';
      Test00094_1.isntt = 9919;
      Test00094_1.corp_svcclassify = 9920;
      Test00094_1.corp_validflag = 9921;
      Test00094_1.corp_svcstart = 'abc22';
      Test00094_1.barcodekind = 9923;
      Test00094_1.sclassify = 9924;
      Test00094_1.sjclassify = 9925;
      Test00094_1.sjmoney = 9926;
      Test00094_1.sjcolumn = 9927;
      Test00094_1.sjrow = 9928;
      Test00094_1.pclassify = 9929;
      Test00094_1.ddclassify = 9930;
      Test00094_1.ddcolumn = 9931;
      Test00094_1.ddrows = 9932;
      Test00094_1.ddrowe = 9933;
      Test00094_1.ddmethod = 9934;
      Test00094_1.orgcolumn = 9935;
      Test00094_1.orgrows = 9936;
      Test00094_1.orgrowe = 9937;
      Test00094_1.rclassify = 9938;
      Test00094_1.fclassify = 9939;
      Test00094_1.fmoney1 = 9940;
      Test00094_1.funit1 = 9941;
      Test00094_1.fee1 = 9942;
      Test00094_1.fmoney2 = 9943;
      Test00094_1.funit2 = 9944;
      Test00094_1.fee2 = 9945;
      Test00094_1.fmoney3 = 9946;
      Test00094_1.funit3 = 9947;
      Test00094_1.fee3 = 9948;
      Test00094_1.fmoney4 = 9949;
      Test00094_1.funit4 = 9950;
      Test00094_1.fee4 = 9951;
      Test00094_1.fmoney5 = 9952;
      Test00094_1.funit5 = 9953;
      Test00094_1.fee5 = 9954;
      Test00094_1.limit_amt = 9955;
      Test00094_1.decision_svcclassify = 9956;
      Test00094_1.decision_validflag = 9957;
      Test00094_1.decision_changed = 'abc58';
      Test00094_1.fil1 = 9959;
      Test00094_1.fil2 = 9960;

      //selectAllDataをして件数取得。
      List<PPbchgCorpTbl> Test00094_AllRtn = await db.selectAllData(Test00094_1);
      int count = Test00094_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00094_1);

      //データ取得に必要なオブジェクトを用意
      PPbchgCorpTbl Test00094_2 = PPbchgCorpTbl();
      //Keyの値を設定する
      Test00094_2.comp_cd = 9912;
      Test00094_2.stre_cd = 9913;
      Test00094_2.corpcd = 9914;
      Test00094_2.subclassify = 9915;
      Test00094_2.subcd = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPbchgCorpTbl? Test00094_Rtn = await db.selectDataByPrimaryKey(Test00094_2);
      //取得行がない場合、nullが返ってきます
      if (Test00094_Rtn == null) {
        print('\n********** 異常発生：00094_PPbchgCorpTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00094_Rtn?.comp_cd,9912);
        expect(Test00094_Rtn?.stre_cd,9913);
        expect(Test00094_Rtn?.corpcd,9914);
        expect(Test00094_Rtn?.subclassify,9915);
        expect(Test00094_Rtn?.subcd,9916);
        expect(Test00094_Rtn?.name,'abc17');
        expect(Test00094_Rtn?.kana,'abc18');
        expect(Test00094_Rtn?.isntt,9919);
        expect(Test00094_Rtn?.corp_svcclassify,9920);
        expect(Test00094_Rtn?.corp_validflag,9921);
        expect(Test00094_Rtn?.corp_svcstart,'abc22');
        expect(Test00094_Rtn?.barcodekind,9923);
        expect(Test00094_Rtn?.sclassify,9924);
        expect(Test00094_Rtn?.sjclassify,9925);
        expect(Test00094_Rtn?.sjmoney,9926);
        expect(Test00094_Rtn?.sjcolumn,9927);
        expect(Test00094_Rtn?.sjrow,9928);
        expect(Test00094_Rtn?.pclassify,9929);
        expect(Test00094_Rtn?.ddclassify,9930);
        expect(Test00094_Rtn?.ddcolumn,9931);
        expect(Test00094_Rtn?.ddrows,9932);
        expect(Test00094_Rtn?.ddrowe,9933);
        expect(Test00094_Rtn?.ddmethod,9934);
        expect(Test00094_Rtn?.orgcolumn,9935);
        expect(Test00094_Rtn?.orgrows,9936);
        expect(Test00094_Rtn?.orgrowe,9937);
        expect(Test00094_Rtn?.rclassify,9938);
        expect(Test00094_Rtn?.fclassify,9939);
        expect(Test00094_Rtn?.fmoney1,9940);
        expect(Test00094_Rtn?.funit1,9941);
        expect(Test00094_Rtn?.fee1,9942);
        expect(Test00094_Rtn?.fmoney2,9943);
        expect(Test00094_Rtn?.funit2,9944);
        expect(Test00094_Rtn?.fee2,9945);
        expect(Test00094_Rtn?.fmoney3,9946);
        expect(Test00094_Rtn?.funit3,9947);
        expect(Test00094_Rtn?.fee3,9948);
        expect(Test00094_Rtn?.fmoney4,9949);
        expect(Test00094_Rtn?.funit4,9950);
        expect(Test00094_Rtn?.fee4,9951);
        expect(Test00094_Rtn?.fmoney5,9952);
        expect(Test00094_Rtn?.funit5,9953);
        expect(Test00094_Rtn?.fee5,9954);
        expect(Test00094_Rtn?.limit_amt,9955);
        expect(Test00094_Rtn?.decision_svcclassify,9956);
        expect(Test00094_Rtn?.decision_validflag,9957);
        expect(Test00094_Rtn?.decision_changed,'abc58');
        expect(Test00094_Rtn?.fil1,9959);
        expect(Test00094_Rtn?.fil2,9960);
      }

      //selectAllDataをして件数取得。
      List<PPbchgCorpTbl> Test00094_AllRtn2 = await db.selectAllData(Test00094_1);
      int count2 = Test00094_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00094_1);
      print('********** テスト終了：00094_PPbchgCorpTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00095 : PPbchgNcorpTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00095_PPbchgNcorpTbl_01', () async {
      print('\n********** テスト実行：00095_PPbchgNcorpTbl_01 **********');
      PPbchgNcorpTbl Test00095_1 = PPbchgNcorpTbl();
      Test00095_1.comp_cd = 9912;
      Test00095_1.stre_cd = 9913;
      Test00095_1.groupcd = 9914;
      Test00095_1.officecd = 9915;
      Test00095_1.strecd = 9916;
      Test00095_1.termcd = 9917;
      Test00095_1.corpcd = 9918;
      Test00095_1.subcd = 9919;
      Test00095_1.validflag = 9920;
      Test00095_1.changed = 'abc21';
      Test00095_1.fil1 = 9922;
      Test00095_1.fil2 = 9923;

      //selectAllDataをして件数取得。
      List<PPbchgNcorpTbl> Test00095_AllRtn = await db.selectAllData(Test00095_1);
      int count = Test00095_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00095_1);

      //データ取得に必要なオブジェクトを用意
      PPbchgNcorpTbl Test00095_2 = PPbchgNcorpTbl();
      //Keyの値を設定する
      Test00095_2.comp_cd = 9912;
      Test00095_2.stre_cd = 9913;
      Test00095_2.groupcd = 9914;
      Test00095_2.officecd = 9915;
      Test00095_2.strecd = 9916;
      Test00095_2.termcd = 9917;
      Test00095_2.corpcd = 9918;
      Test00095_2.subcd = 9919;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPbchgNcorpTbl? Test00095_Rtn = await db.selectDataByPrimaryKey(Test00095_2);
      //取得行がない場合、nullが返ってきます
      if (Test00095_Rtn == null) {
        print('\n********** 異常発生：00095_PPbchgNcorpTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00095_Rtn?.comp_cd,9912);
        expect(Test00095_Rtn?.stre_cd,9913);
        expect(Test00095_Rtn?.groupcd,9914);
        expect(Test00095_Rtn?.officecd,9915);
        expect(Test00095_Rtn?.strecd,9916);
        expect(Test00095_Rtn?.termcd,9917);
        expect(Test00095_Rtn?.corpcd,9918);
        expect(Test00095_Rtn?.subcd,9919);
        expect(Test00095_Rtn?.validflag,9920);
        expect(Test00095_Rtn?.changed,'abc21');
        expect(Test00095_Rtn?.fil1,9922);
        expect(Test00095_Rtn?.fil2,9923);
      }

      //selectAllDataをして件数取得。
      List<PPbchgNcorpTbl> Test00095_AllRtn2 = await db.selectAllData(Test00095_1);
      int count2 = Test00095_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00095_1);
      print('********** テスト終了：00095_PPbchgNcorpTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00096 : PPbchgNtteTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00096_PPbchgNtteTbl_01', () async {
      print('\n********** テスト実行：00096_PPbchgNtteTbl_01 **********');
      PPbchgNtteTbl Test00096_1 = PPbchgNtteTbl();
      Test00096_1.comp_cd = 9912;
      Test00096_1.stre_cd = 9913;
      Test00096_1.startno = 9914;
      Test00096_1.endno = 9915;
      Test00096_1.validflag = 9916;
      Test00096_1.changed = 'abc17';
      Test00096_1.fil1 = 9918;
      Test00096_1.fil2 = 9919;

      //selectAllDataをして件数取得。
      List<PPbchgNtteTbl> Test00096_AllRtn = await db.selectAllData(Test00096_1);
      int count = Test00096_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00096_1);

      //データ取得に必要なオブジェクトを用意
      PPbchgNtteTbl Test00096_2 = PPbchgNtteTbl();
      //Keyの値を設定する
      Test00096_2.comp_cd = 9912;
      Test00096_2.stre_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPbchgNtteTbl? Test00096_Rtn = await db.selectDataByPrimaryKey(Test00096_2);
      //取得行がない場合、nullが返ってきます
      if (Test00096_Rtn == null) {
        print('\n********** 異常発生：00096_PPbchgNtteTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00096_Rtn?.comp_cd,9912);
        expect(Test00096_Rtn?.stre_cd,9913);
        expect(Test00096_Rtn?.startno,9914);
        expect(Test00096_Rtn?.endno,9915);
        expect(Test00096_Rtn?.validflag,9916);
        expect(Test00096_Rtn?.changed,'abc17');
        expect(Test00096_Rtn?.fil1,9918);
        expect(Test00096_Rtn?.fil2,9919);
      }

      //selectAllDataをして件数取得。
      List<PPbchgNtteTbl> Test00096_AllRtn2 = await db.selectAllData(Test00096_1);
      int count2 = Test00096_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00096_1);
      print('********** テスト終了：00096_PPbchgNtteTbl_01 **********\n\n');
    });
    
    // ********************************************************
    // テスト00097 : CCrdtDemandTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00097_CCrdtDemandTbl_01', () async {
      print('\n********** テスト実行：00097_CCrdtDemandTbl_01 **********');
      CCrdtDemandTbl Test00097_1 = CCrdtDemandTbl();
      Test00097_1.comp_cd = 9912;
      Test00097_1.card_kind = 9913;
      Test00097_1.company_cd = 9914;
      Test00097_1.id = 'abc15';
      Test00097_1.business = 9916;
      Test00097_1.mbr_no_from = 9917;
      Test00097_1.mbr_no_to = 9918;
      Test00097_1.mbr_no_position = 9919;
      Test00097_1.mbr_no_digit = 9920;
      Test00097_1.ckdigit_chk = 9921;
      Test00097_1.ckdigit_wait = 'abc22';
      Test00097_1.card_company_name = 'abc23';
      Test00097_1.good_thru_position = 9924;
      Test00097_1.pay_autoinput_chk = 9925;
      Test00097_1.pay_shut_day = 9926;
      Test00097_1.pay_day = 9927;
      Test00097_1.lump = 9928;
      Test00097_1.twice = 9929;
      Test00097_1.divide = 9930;
      Test00097_1.bonus_lump = 9931;
      Test00097_1.bonus_twice = 9932;
      Test00097_1.bonus_use = 9933;
      Test00097_1.ribo = 9934;
      Test00097_1.skip = 9935;
      Test00097_1.divide3 = 9936;
      Test00097_1.divide4 = 9937;
      Test00097_1.divide5 = 9938;
      Test00097_1.divide6 = 9939;
      Test00097_1.divide7 = 9940;
      Test00097_1.divide8 = 9941;
      Test00097_1.divide9 = 9942;
      Test00097_1.divide10 = 9943;
      Test00097_1.divide11 = 9944;
      Test00097_1.divide12 = 9945;
      Test00097_1.divide15 = 9946;
      Test00097_1.divide18 = 9947;
      Test00097_1.divide20 = 9948;
      Test00097_1.divide24 = 9949;
      Test00097_1.divide25 = 9950;
      Test00097_1.divide30 = 9951;
      Test00097_1.divide35 = 9952;
      Test00097_1.divide36 = 9953;
      Test00097_1.divide3_limit = 9954;
      Test00097_1.divide4_limit = 9955;
      Test00097_1.divide5_limit = 9956;
      Test00097_1.divide6_limit = 9957;
      Test00097_1.divide7_limit = 9958;
      Test00097_1.divide8_limit = 9959;
      Test00097_1.divide9_limit = 9960;
      Test00097_1.divide10_limit = 9961;
      Test00097_1.divide11_limit = 9962;
      Test00097_1.divide12_limit = 9963;
      Test00097_1.divide15_limit = 9964;
      Test00097_1.divide18_limit = 9965;
      Test00097_1.divide20_limit = 9966;
      Test00097_1.divide24_limit = 9967;
      Test00097_1.divide25_limit = 9968;
      Test00097_1.divide30_limit = 9969;
      Test00097_1.divide35_limit = 9970;
      Test00097_1.divide36_limit = 9971;
      Test00097_1.bonus_use2 = 9972;
      Test00097_1.bonus_use3 = 9973;
      Test00097_1.bonus_use4 = 9974;
      Test00097_1.bonus_use5 = 9975;
      Test00097_1.bonus_use6 = 9976;
      Test00097_1.bonus_use7 = 9977;
      Test00097_1.bonus_use8 = 9978;
      Test00097_1.bonus_use9 = 9979;
      Test00097_1.bonus_use10 = 9980;
      Test00097_1.bonus_use11 = 9981;
      Test00097_1.bonus_use12 = 9982;
      Test00097_1.bonus_use15 = 9983;
      Test00097_1.bonus_use18 = 9984;
      Test00097_1.bonus_use20 = 9985;
      Test00097_1.bonus_use24 = 9986;
      Test00097_1.bonus_use25 = 9987;
      Test00097_1.bonus_use30 = 9988;
      Test00097_1.bonus_use35 = 9989;
      Test00097_1.bonus_use36 = 9990;
      Test00097_1.bonus_use2_limit = 9991;
      Test00097_1.bonus_use3_limit = 9992;
      Test00097_1.bonus_use4_limit = 9993;
      Test00097_1.bonus_use5_limit = 9994;
      Test00097_1.bonus_use6_limit = 9995;
      Test00097_1.bonus_use7_limit = 9996;
      Test00097_1.bonus_use8_limit = 9997;
      Test00097_1.bonus_use9_limit = 9998;
      Test00097_1.bonus_use10_limit = 9999;
      Test00097_1.bonus_use11_limit = 99100;
      Test00097_1.bonus_use12_limit = 99101;
      Test00097_1.bonus_use15_limit = 99102;
      Test00097_1.bonus_use18_limit = 99103;
      Test00097_1.bonus_use20_limit = 99104;
      Test00097_1.bonus_use24_limit = 99105;
      Test00097_1.bonus_use25_limit = 99106;
      Test00097_1.bonus_use30_limit = 99107;
      Test00097_1.bonus_use35_limit = 99108;
      Test00097_1.bonus_use36_limit = 99109;
      Test00097_1.pay_input_chk = 99110;
      Test00097_1.winter_bonus_from = 99111;
      Test00097_1.winter_bonus_to = 99112;
      Test00097_1.winter_bonus_pay1 = 99113;
      Test00097_1.winter_bonus_pay2 = 99114;
      Test00097_1.winter_bonus_pay3 = 99115;
      Test00097_1.summer_bonus_from = 99116;
      Test00097_1.summer_bonus_to = 99117;
      Test00097_1.summer_bonus_pay1 = 99118;
      Test00097_1.summer_bonus_pay2 = 99119;
      Test00097_1.summer_bonus_pay3 = 99120;
      Test00097_1.bonus_lump_limit = 99121;
      Test00097_1.bonus_twice_limit = 99122;
      Test00097_1.offline_limit = 99123;
      Test00097_1.card_jis = 99124;
      Test00097_1.ins_datetime = 'abc125';
      Test00097_1.upd_datetime = 'abc126';
      Test00097_1.status = 99127;
      Test00097_1.send_flg = 99128;
      Test00097_1.upd_user = 99129;
      Test00097_1.upd_system = 99130;
      Test00097_1.company_cd_to = 99131;
      Test00097_1.stlcrdtdsc_per = 99132;
      Test00097_1.mkr_cd = 99133;
      Test00097_1.destination = 'abc134';
      Test00097_1.signless_flg = 99135;
      Test00097_1.coopcode1 = 99136;
      Test00097_1.coopcode2 = 99137;
      Test00097_1.coopcode3 = 99138;
      Test00097_1.bonus_add_input_chk = 99139;
      Test00097_1.bonus_cnt_input_chk = 99140;
      Test00097_1.bonus_cnt = 99141;
      Test00097_1.paymonth_input_chk = 99142;
      Test00097_1.sign_amt = 99143;
      Test00097_1.effect_code = 99144;
      Test00097_1.fil1 = 99145;

      //selectAllDataをして件数取得。
      List<CCrdtDemandTbl> Test00097_AllRtn = await db.selectAllData(Test00097_1);
      int count = Test00097_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00097_1);

      //データ取得に必要なオブジェクトを用意
      CCrdtDemandTbl Test00097_2 = CCrdtDemandTbl();
      //Keyの値を設定する
      Test00097_2.comp_cd = 9912;
      Test00097_2.card_kind = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCrdtDemandTbl? Test00097_Rtn = await db.selectDataByPrimaryKey(Test00097_2);
      //取得行がない場合、nullが返ってきます
      if (Test00097_Rtn == null) {
        print('\n********** 異常発生：00097_CCrdtDemandTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00097_Rtn?.comp_cd,9912);
        expect(Test00097_Rtn?.card_kind,9913);
        expect(Test00097_Rtn?.company_cd,9914);
        expect(Test00097_Rtn?.id,'abc15');
        expect(Test00097_Rtn?.business,9916);
        expect(Test00097_Rtn?.mbr_no_from,9917);
        expect(Test00097_Rtn?.mbr_no_to,9918);
        expect(Test00097_Rtn?.mbr_no_position,9919);
        expect(Test00097_Rtn?.mbr_no_digit,9920);
        expect(Test00097_Rtn?.ckdigit_chk,9921);
        expect(Test00097_Rtn?.ckdigit_wait,'abc22');
        expect(Test00097_Rtn?.card_company_name,'abc23');
        expect(Test00097_Rtn?.good_thru_position,9924);
        expect(Test00097_Rtn?.pay_autoinput_chk,9925);
        expect(Test00097_Rtn?.pay_shut_day,9926);
        expect(Test00097_Rtn?.pay_day,9927);
        expect(Test00097_Rtn?.lump,9928);
        expect(Test00097_Rtn?.twice,9929);
        expect(Test00097_Rtn?.divide,9930);
        expect(Test00097_Rtn?.bonus_lump,9931);
        expect(Test00097_Rtn?.bonus_twice,9932);
        expect(Test00097_Rtn?.bonus_use,9933);
        expect(Test00097_Rtn?.ribo,9934);
        expect(Test00097_Rtn?.skip,9935);
        expect(Test00097_Rtn?.divide3,9936);
        expect(Test00097_Rtn?.divide4,9937);
        expect(Test00097_Rtn?.divide5,9938);
        expect(Test00097_Rtn?.divide6,9939);
        expect(Test00097_Rtn?.divide7,9940);
        expect(Test00097_Rtn?.divide8,9941);
        expect(Test00097_Rtn?.divide9,9942);
        expect(Test00097_Rtn?.divide10,9943);
        expect(Test00097_Rtn?.divide11,9944);
        expect(Test00097_Rtn?.divide12,9945);
        expect(Test00097_Rtn?.divide15,9946);
        expect(Test00097_Rtn?.divide18,9947);
        expect(Test00097_Rtn?.divide20,9948);
        expect(Test00097_Rtn?.divide24,9949);
        expect(Test00097_Rtn?.divide25,9950);
        expect(Test00097_Rtn?.divide30,9951);
        expect(Test00097_Rtn?.divide35,9952);
        expect(Test00097_Rtn?.divide36,9953);
        expect(Test00097_Rtn?.divide3_limit,9954);
        expect(Test00097_Rtn?.divide4_limit,9955);
        expect(Test00097_Rtn?.divide5_limit,9956);
        expect(Test00097_Rtn?.divide6_limit,9957);
        expect(Test00097_Rtn?.divide7_limit,9958);
        expect(Test00097_Rtn?.divide8_limit,9959);
        expect(Test00097_Rtn?.divide9_limit,9960);
        expect(Test00097_Rtn?.divide10_limit,9961);
        expect(Test00097_Rtn?.divide11_limit,9962);
        expect(Test00097_Rtn?.divide12_limit,9963);
        expect(Test00097_Rtn?.divide15_limit,9964);
        expect(Test00097_Rtn?.divide18_limit,9965);
        expect(Test00097_Rtn?.divide20_limit,9966);
        expect(Test00097_Rtn?.divide24_limit,9967);
        expect(Test00097_Rtn?.divide25_limit,9968);
        expect(Test00097_Rtn?.divide30_limit,9969);
        expect(Test00097_Rtn?.divide35_limit,9970);
        expect(Test00097_Rtn?.divide36_limit,9971);
        expect(Test00097_Rtn?.bonus_use2,9972);
        expect(Test00097_Rtn?.bonus_use3,9973);
        expect(Test00097_Rtn?.bonus_use4,9974);
        expect(Test00097_Rtn?.bonus_use5,9975);
        expect(Test00097_Rtn?.bonus_use6,9976);
        expect(Test00097_Rtn?.bonus_use7,9977);
        expect(Test00097_Rtn?.bonus_use8,9978);
        expect(Test00097_Rtn?.bonus_use9,9979);
        expect(Test00097_Rtn?.bonus_use10,9980);
        expect(Test00097_Rtn?.bonus_use11,9981);
        expect(Test00097_Rtn?.bonus_use12,9982);
        expect(Test00097_Rtn?.bonus_use15,9983);
        expect(Test00097_Rtn?.bonus_use18,9984);
        expect(Test00097_Rtn?.bonus_use20,9985);
        expect(Test00097_Rtn?.bonus_use24,9986);
        expect(Test00097_Rtn?.bonus_use25,9987);
        expect(Test00097_Rtn?.bonus_use30,9988);
        expect(Test00097_Rtn?.bonus_use35,9989);
        expect(Test00097_Rtn?.bonus_use36,9990);
        expect(Test00097_Rtn?.bonus_use2_limit,9991);
        expect(Test00097_Rtn?.bonus_use3_limit,9992);
        expect(Test00097_Rtn?.bonus_use4_limit,9993);
        expect(Test00097_Rtn?.bonus_use5_limit,9994);
        expect(Test00097_Rtn?.bonus_use6_limit,9995);
        expect(Test00097_Rtn?.bonus_use7_limit,9996);
        expect(Test00097_Rtn?.bonus_use8_limit,9997);
        expect(Test00097_Rtn?.bonus_use9_limit,9998);
        expect(Test00097_Rtn?.bonus_use10_limit,9999);
        expect(Test00097_Rtn?.bonus_use11_limit,99100);
        expect(Test00097_Rtn?.bonus_use12_limit,99101);
        expect(Test00097_Rtn?.bonus_use15_limit,99102);
        expect(Test00097_Rtn?.bonus_use18_limit,99103);
        expect(Test00097_Rtn?.bonus_use20_limit,99104);
        expect(Test00097_Rtn?.bonus_use24_limit,99105);
        expect(Test00097_Rtn?.bonus_use25_limit,99106);
        expect(Test00097_Rtn?.bonus_use30_limit,99107);
        expect(Test00097_Rtn?.bonus_use35_limit,99108);
        expect(Test00097_Rtn?.bonus_use36_limit,99109);
        expect(Test00097_Rtn?.pay_input_chk,99110);
        expect(Test00097_Rtn?.winter_bonus_from,99111);
        expect(Test00097_Rtn?.winter_bonus_to,99112);
        expect(Test00097_Rtn?.winter_bonus_pay1,99113);
        expect(Test00097_Rtn?.winter_bonus_pay2,99114);
        expect(Test00097_Rtn?.winter_bonus_pay3,99115);
        expect(Test00097_Rtn?.summer_bonus_from,99116);
        expect(Test00097_Rtn?.summer_bonus_to,99117);
        expect(Test00097_Rtn?.summer_bonus_pay1,99118);
        expect(Test00097_Rtn?.summer_bonus_pay2,99119);
        expect(Test00097_Rtn?.summer_bonus_pay3,99120);
        expect(Test00097_Rtn?.bonus_lump_limit,99121);
        expect(Test00097_Rtn?.bonus_twice_limit,99122);
        expect(Test00097_Rtn?.offline_limit,99123);
        expect(Test00097_Rtn?.card_jis,99124);
        expect(Test00097_Rtn?.ins_datetime,'abc125');
        expect(Test00097_Rtn?.upd_datetime,'abc126');
        expect(Test00097_Rtn?.status,99127);
        expect(Test00097_Rtn?.send_flg,99128);
        expect(Test00097_Rtn?.upd_user,99129);
        expect(Test00097_Rtn?.upd_system,99130);
        expect(Test00097_Rtn?.company_cd_to,99131);
        expect(Test00097_Rtn?.stlcrdtdsc_per,99132);
        expect(Test00097_Rtn?.mkr_cd,99133);
        expect(Test00097_Rtn?.destination,'abc134');
        expect(Test00097_Rtn?.signless_flg,99135);
        expect(Test00097_Rtn?.coopcode1,99136);
        expect(Test00097_Rtn?.coopcode2,99137);
        expect(Test00097_Rtn?.coopcode3,99138);
        expect(Test00097_Rtn?.bonus_add_input_chk,99139);
        expect(Test00097_Rtn?.bonus_cnt_input_chk,99140);
        expect(Test00097_Rtn?.bonus_cnt,99141);
        expect(Test00097_Rtn?.paymonth_input_chk,99142);
        expect(Test00097_Rtn?.sign_amt,99143);
        expect(Test00097_Rtn?.effect_code,99144);
        expect(Test00097_Rtn?.fil1,99145);
      }

      //selectAllDataをして件数取得。
      List<CCrdtDemandTbl> Test00097_AllRtn2 = await db.selectAllData(Test00097_1);
      int count2 = Test00097_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00097_1);
      print('********** テスト終了：00097_CCrdtDemandTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00098 : PPrcchgSchMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00098_PPrcchgSchMst_01', () async {
      print('\n********** テスト実行：00098_PPrcchgSchMst_01 **********');
      PPrcchgSchMst Test00098_1 = PPrcchgSchMst();
      Test00098_1.comp_cd = 9912;
      Test00098_1.stre_cd = 9913;
      Test00098_1.prcchg_cd = 9914;
      Test00098_1.div_cd = 9915;
      Test00098_1.start_datetime = 'abc16';
      Test00098_1.end_datetime = 'abc17';
      Test00098_1.ins_datetime = 'abc18';
      Test00098_1.upd_datetime = 'abc19';
      Test00098_1.status = 9920;
      Test00098_1.send_flg = 9921;
      Test00098_1.upd_user = 9922;
      Test00098_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<PPrcchgSchMst> Test00098_AllRtn = await db.selectAllData(Test00098_1);
      int count = Test00098_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00098_1);

      //データ取得に必要なオブジェクトを用意
      PPrcchgSchMst Test00098_2 = PPrcchgSchMst();
      //Keyの値を設定する
      Test00098_2.comp_cd = 9912;
      Test00098_2.stre_cd = 9913;
      Test00098_2.prcchg_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPrcchgSchMst? Test00098_Rtn = await db.selectDataByPrimaryKey(Test00098_2);
      //取得行がない場合、nullが返ってきます
      if (Test00098_Rtn == null) {
        print('\n********** 異常発生：00098_PPrcchgSchMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00098_Rtn?.comp_cd,9912);
        expect(Test00098_Rtn?.stre_cd,9913);
        expect(Test00098_Rtn?.prcchg_cd,9914);
        expect(Test00098_Rtn?.div_cd,9915);
        expect(Test00098_Rtn?.start_datetime,'abc16');
        expect(Test00098_Rtn?.end_datetime,'abc17');
        expect(Test00098_Rtn?.ins_datetime,'abc18');
        expect(Test00098_Rtn?.upd_datetime,'abc19');
        expect(Test00098_Rtn?.status,9920);
        expect(Test00098_Rtn?.send_flg,9921);
        expect(Test00098_Rtn?.upd_user,9922);
        expect(Test00098_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<PPrcchgSchMst> Test00098_AllRtn2 = await db.selectAllData(Test00098_1);
      int count2 = Test00098_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00098_1);
      print('********** テスト終了：00098_PPrcchgSchMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00099 : PPrcchgItemMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00099_PPrcchgItemMst_01', () async {
      print('\n********** テスト実行：00099_PPrcchgItemMst_01 **********');
      PPrcchgItemMst Test00099_1 = PPrcchgItemMst();
      Test00099_1.comp_cd = 9912;
      Test00099_1.stre_cd = 9913;
      Test00099_1.prcchg_cd = 9914;
      Test00099_1.bkup_flg = 9915;
      Test00099_1.plu_cd = 'abc16';
      Test00099_1.item_name = 'abc17';
      Test00099_1.pos_prc = 9918;
      Test00099_1.cust_prc = 9919;
      Test00099_1.cost_prc = 1.220;
      Test00099_1.ins_datetime = 'abc21';
      Test00099_1.upd_datetime = 'abc22';
      Test00099_1.status = 9923;
      Test00099_1.send_flg = 9924;
      Test00099_1.upd_user = 9925;
      Test00099_1.upd_system = 9926;

      //selectAllDataをして件数取得。
      List<PPrcchgItemMst> Test00099_AllRtn = await db.selectAllData(Test00099_1);
      int count = Test00099_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00099_1);

      //データ取得に必要なオブジェクトを用意
      PPrcchgItemMst Test00099_2 = PPrcchgItemMst();
      //Keyの値を設定する
      Test00099_2.comp_cd = 9912;
      Test00099_2.stre_cd = 9913;
      Test00099_2.prcchg_cd = 9914;
      Test00099_2.bkup_flg = 9915;
      Test00099_2.plu_cd = 'abc16';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPrcchgItemMst? Test00099_Rtn = await db.selectDataByPrimaryKey(Test00099_2);
      //取得行がない場合、nullが返ってきます
      if (Test00099_Rtn == null) {
        print('\n********** 異常発生：00099_PPrcchgItemMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00099_Rtn?.comp_cd,9912);
        expect(Test00099_Rtn?.stre_cd,9913);
        expect(Test00099_Rtn?.prcchg_cd,9914);
        expect(Test00099_Rtn?.bkup_flg,9915);
        expect(Test00099_Rtn?.plu_cd,'abc16');
        expect(Test00099_Rtn?.item_name,'abc17');
        expect(Test00099_Rtn?.pos_prc,9918);
        expect(Test00099_Rtn?.cust_prc,9919);
        expect(Test00099_Rtn?.cost_prc,1.220);
        expect(Test00099_Rtn?.ins_datetime,'abc21');
        expect(Test00099_Rtn?.upd_datetime,'abc22');
        expect(Test00099_Rtn?.status,9923);
        expect(Test00099_Rtn?.send_flg,9924);
        expect(Test00099_Rtn?.upd_user,9925);
        expect(Test00099_Rtn?.upd_system,9926);
      }

      //selectAllDataをして件数取得。
      List<PPrcchgItemMst> Test00099_AllRtn2 = await db.selectAllData(Test00099_1);
      int count2 = Test00099_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00099_1);
      print('********** テスト終了：00099_PPrcchgItemMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00100 : PPrcchgMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00100_PPrcchgMst_01', () async {
      print('\n********** テスト実行：00100_PPrcchgMst_01 **********');
      PPrcchgMst Test00100_1 = PPrcchgMst();
      Test00100_1.serial_no = 9912;
      Test00100_1.plu_cd = 'abc13';
      Test00100_1.item_name = 'abc14';
      Test00100_1.pos_prc = 9915;
      Test00100_1.cust_prc = 9916;
      Test00100_1.cost_prc = 1.217;
      Test00100_1.prcchg_cd = 9918;
      Test00100_1.mac_no = 9919;
      Test00100_1.div_cd = 9920;
      Test00100_1.ins_datetime = 'abc21';
      Test00100_1.upd_datetime = 'abc22';
      Test00100_1.status = 9923;
      Test00100_1.send_flg = 9924;
      Test00100_1.upd_user = 9925;
      Test00100_1.upd_system = 9926;

      //selectAllDataをして件数取得。
      List<PPrcchgMst> Test00100_AllRtn = await db.selectAllData(Test00100_1);
      int count = Test00100_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00100_1);

      //データ取得に必要なオブジェクトを用意
      PPrcchgMst Test00100_2 = PPrcchgMst();
      //Keyの値を設定する
      Test00100_2.serial_no = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PPrcchgMst? Test00100_Rtn = await db.selectDataByPrimaryKey(Test00100_2);
      //取得行がない場合、nullが返ってきます
      if (Test00100_Rtn == null) {
        print('\n********** 異常発生：00100_PPrcchgMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00100_Rtn?.serial_no,9912);
        expect(Test00100_Rtn?.plu_cd,'abc13');
        expect(Test00100_Rtn?.item_name,'abc14');
        expect(Test00100_Rtn?.pos_prc,9915);
        expect(Test00100_Rtn?.cust_prc,9916);
        expect(Test00100_Rtn?.cost_prc,1.217);
        expect(Test00100_Rtn?.prcchg_cd,9918);
        expect(Test00100_Rtn?.mac_no,9919);
        expect(Test00100_Rtn?.div_cd,9920);
        expect(Test00100_Rtn?.ins_datetime,'abc21');
        expect(Test00100_Rtn?.upd_datetime,'abc22');
        expect(Test00100_Rtn?.status,9923);
        expect(Test00100_Rtn?.send_flg,9924);
        expect(Test00100_Rtn?.upd_user,9925);
        expect(Test00100_Rtn?.upd_system,9926);
      }

      //selectAllDataをして件数取得。
      List<PPrcchgMst> Test00100_AllRtn2 = await db.selectAllData(Test00100_1);
      int count2 = Test00100_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00100_1);
      print('********** テスト終了：00100_PPrcchgMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00101 : SBackyardGrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00101_SBackyardGrpMst_01', () async {
      print('\n********** テスト実行：00101_SBackyardGrpMst_01 **********');
      SBackyardGrpMst Test00101_1 = SBackyardGrpMst();
      Test00101_1.comp_cd = 9912;
      Test00101_1.stre_cd = 9913;
      Test00101_1.cnct_no = 9914;
      Test00101_1.cls_typ = 9915;
      Test00101_1.cls_cd = 9916;
      Test00101_1.ins_datetime = 'abc17';
      Test00101_1.upd_datetime = 'abc18';
      Test00101_1.status = 9919;
      Test00101_1.send_flg = 9920;
      Test00101_1.upd_user = 9921;
      Test00101_1.upd_system = 9922;

      //selectAllDataをして件数取得。
      List<SBackyardGrpMst> Test00101_AllRtn = await db.selectAllData(Test00101_1);
      int count = Test00101_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00101_1);

      //データ取得に必要なオブジェクトを用意
      SBackyardGrpMst Test00101_2 = SBackyardGrpMst();
      //Keyの値を設定する
      Test00101_2.comp_cd = 9912;
      Test00101_2.stre_cd = 9913;
      Test00101_2.cnct_no = 9914;
      Test00101_2.cls_typ = 9915;
      Test00101_2.cls_cd = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SBackyardGrpMst? Test00101_Rtn = await db.selectDataByPrimaryKey(Test00101_2);
      //取得行がない場合、nullが返ってきます
      if (Test00101_Rtn == null) {
        print('\n********** 異常発生：00101_SBackyardGrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00101_Rtn?.comp_cd,9912);
        expect(Test00101_Rtn?.stre_cd,9913);
        expect(Test00101_Rtn?.cnct_no,9914);
        expect(Test00101_Rtn?.cls_typ,9915);
        expect(Test00101_Rtn?.cls_cd,9916);
        expect(Test00101_Rtn?.ins_datetime,'abc17');
        expect(Test00101_Rtn?.upd_datetime,'abc18');
        expect(Test00101_Rtn?.status,9919);
        expect(Test00101_Rtn?.send_flg,9920);
        expect(Test00101_Rtn?.upd_user,9921);
        expect(Test00101_Rtn?.upd_system,9922);
      }

      //selectAllDataをして件数取得。
      List<SBackyardGrpMst> Test00101_AllRtn2 = await db.selectAllData(Test00101_1);
      int count2 = Test00101_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00101_1);
      print('********** テスト終了：00101_SBackyardGrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00102 : CWizInfTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00102_CWizInfTbl_01', () async {
      print('\n********** テスト実行：00102_CWizInfTbl_01 **********');
      CWizInfTbl Test00102_1 = CWizInfTbl();
      Test00102_1.cd = 9912;
      Test00102_1.ipaddr = 'abc13';
      Test00102_1.mac_addr = 'abc14';
      Test00102_1.pwr_sts = 9915;
      Test00102_1.run_flg = 9916;
      Test00102_1.run_bfre_date = 'abc17';
      Test00102_1.ins_datetime = 'abc18';
      Test00102_1.upd_datetime = 'abc19';
      Test00102_1.status = 9920;
      Test00102_1.send_flg = 9921;
      Test00102_1.upd_user = 9922;
      Test00102_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CWizInfTbl> Test00102_AllRtn = await db.selectAllData(Test00102_1);
      int count = Test00102_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00102_1);

      //データ取得に必要なオブジェクトを用意
      CWizInfTbl Test00102_2 = CWizInfTbl();
      //Keyの値を設定する
      Test00102_2.cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CWizInfTbl? Test00102_Rtn = await db.selectDataByPrimaryKey(Test00102_2);
      //取得行がない場合、nullが返ってきます
      if (Test00102_Rtn == null) {
        print('\n********** 異常発生：00102_CWizInfTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00102_Rtn?.cd,9912);
        expect(Test00102_Rtn?.ipaddr,'abc13');
        expect(Test00102_Rtn?.mac_addr,'abc14');
        expect(Test00102_Rtn?.pwr_sts,9915);
        expect(Test00102_Rtn?.run_flg,9916);
        expect(Test00102_Rtn?.run_bfre_date,'abc17');
        expect(Test00102_Rtn?.ins_datetime,'abc18');
        expect(Test00102_Rtn?.upd_datetime,'abc19');
        expect(Test00102_Rtn?.status,9920);
        expect(Test00102_Rtn?.send_flg,9921);
        expect(Test00102_Rtn?.upd_user,9922);
        expect(Test00102_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CWizInfTbl> Test00102_AllRtn2 = await db.selectAllData(Test00102_1);
      int count2 = Test00102_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00102_1);
      print('********** テスト終了：00102_CWizInfTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00103 : CPassportInfoMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00103_CPassportInfoMst_01', () async {
      print('\n********** テスト実行：00103_CPassportInfoMst_01 **********');
      CPassportInfoMst Test00103_1 = CPassportInfoMst();
      Test00103_1.kind = 9912;
      Test00103_1.code = 9913;
      Test00103_1.data_jp = 'abc14';
      Test00103_1.data_ex = 'abc15';
      Test00103_1.langue = 9916;
      Test00103_1.data_01 = 'abc17';
      Test00103_1.data_02 = 'abc18';
      Test00103_1.country_code = 9919;
      Test00103_1.data_03 = 'abc20';
      Test00103_1.flg_01 = 9921;
      Test00103_1.ins_datetime = 'abc22';
      Test00103_1.upd_datetime = 'abc23';
      Test00103_1.status = 9924;
      Test00103_1.send_flg = 9925;
      Test00103_1.upd_user = 9926;
      Test00103_1.upd_system = 9927;

      //selectAllDataをして件数取得。
      List<CPassportInfoMst> Test00103_AllRtn = await db.selectAllData(Test00103_1);
      int count = Test00103_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00103_1);

      //データ取得に必要なオブジェクトを用意
      CPassportInfoMst Test00103_2 = CPassportInfoMst();
      //Keyの値を設定する
      Test00103_2.kind = 9912;
      Test00103_2.code = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPassportInfoMst? Test00103_Rtn = await db.selectDataByPrimaryKey(Test00103_2);
      //取得行がない場合、nullが返ってきます
      if (Test00103_Rtn == null) {
        print('\n********** 異常発生：00103_CPassportInfoMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00103_Rtn?.kind,9912);
        expect(Test00103_Rtn?.code,9913);
        expect(Test00103_Rtn?.data_jp,'abc14');
        expect(Test00103_Rtn?.data_ex,'abc15');
        expect(Test00103_Rtn?.langue,9916);
        expect(Test00103_Rtn?.data_01,'abc17');
        expect(Test00103_Rtn?.data_02,'abc18');
        expect(Test00103_Rtn?.country_code,9919);
        expect(Test00103_Rtn?.data_03,'abc20');
        expect(Test00103_Rtn?.flg_01,9921);
        expect(Test00103_Rtn?.ins_datetime,'abc22');
        expect(Test00103_Rtn?.upd_datetime,'abc23');
        expect(Test00103_Rtn?.status,9924);
        expect(Test00103_Rtn?.send_flg,9925);
        expect(Test00103_Rtn?.upd_user,9926);
        expect(Test00103_Rtn?.upd_system,9927);
      }

      //selectAllDataをして件数取得。
      List<CPassportInfoMst> Test00103_AllRtn2 = await db.selectAllData(Test00103_1);
      int count2 = Test00103_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00103_1);
      print('********** テスト終了：00103_CPassportInfoMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00104 : PNotfpluOffTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00104_PNotfpluOffTbl_01', () async {
      print('\n********** テスト実行：00104_PNotfpluOffTbl_01 **********');
      PNotfpluOffTbl Test00104_1 = PNotfpluOffTbl();
      Test00104_1.plu_cd = 'abc12';
      Test00104_1.lrgcls_cd = 9913;
      Test00104_1.mdlcls_cd = 9914;
      Test00104_1.smlcls_cd = 9915;
      Test00104_1.tnycls_cd = 9916;
      Test00104_1.item_name = 'abc17';
      Test00104_1.pos_name = 'abc18';
      Test00104_1.pos_prc = 9919;
      Test00104_1.tax_cd_1 = 9920;
      Test00104_1.mac_no = 9921;
      Test00104_1.staff_cd = 9922;

      //selectAllDataをして件数取得。
      List<PNotfpluOffTbl> Test00104_AllRtn = await db.selectAllData(Test00104_1);
      int count = Test00104_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00104_1);

      //データ取得に必要なオブジェクトを用意
      PNotfpluOffTbl Test00104_2 = PNotfpluOffTbl();
      //Keyの値を設定する
      Test00104_2.plu_cd = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      PNotfpluOffTbl? Test00104_Rtn = await db.selectDataByPrimaryKey(Test00104_2);
      //取得行がない場合、nullが返ってきます
      if (Test00104_Rtn == null) {
        print('\n********** 異常発生：00104_PNotfpluOffTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00104_Rtn?.plu_cd,'abc12');
        expect(Test00104_Rtn?.lrgcls_cd,9913);
        expect(Test00104_Rtn?.mdlcls_cd,9914);
        expect(Test00104_Rtn?.smlcls_cd,9915);
        expect(Test00104_Rtn?.tnycls_cd,9916);
        expect(Test00104_Rtn?.item_name,'abc17');
        expect(Test00104_Rtn?.pos_name,'abc18');
        expect(Test00104_Rtn?.pos_prc,9919);
        expect(Test00104_Rtn?.tax_cd_1,9920);
        expect(Test00104_Rtn?.mac_no,9921);
        expect(Test00104_Rtn?.staff_cd,9922);
      }

      //selectAllDataをして件数取得。
      List<PNotfpluOffTbl> Test00104_AllRtn2 = await db.selectAllData(Test00104_1);
      int count2 = Test00104_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00104_1);
      print('********** テスト終了：00104_PNotfpluOffTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00105 : CHeaderLog
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00105_CHeaderLog_01', () async {
      print('\n********** テスト実行：00105_CHeaderLog_01 **********');
      CHeaderLog Test00105_1 = CHeaderLog();
      Test00105_1.serial_no = 'abc12';
      Test00105_1.comp_cd = 9913;
      Test00105_1.stre_cd = 9914;
      Test00105_1.mac_no = 9915;
      Test00105_1.receipt_no = 9916;
      Test00105_1.print_no = 9917;
      Test00105_1.cshr_no = 9918;
      Test00105_1.chkr_no = 9919;
      Test00105_1.cust_no = 'abc20';
      Test00105_1.sale_date = 'abc21';
      Test00105_1.starttime = 'abc22';
      Test00105_1.endtime = 'abc23';
      Test00105_1.ope_mode_flg = 9924;
      Test00105_1.inout_flg = 9925;
      Test00105_1.prn_typ = 9926;
      Test00105_1.void_serial_no = 'abc27';
      Test00105_1.qc_serial_no = 'abc28';
      Test00105_1.void_kind = 9929;
      Test00105_1.void_sale_date = 'abc30';
      Test00105_1.data_log_cnt = 9931;
      Test00105_1.ej_log_cnt = 9932;
      Test00105_1.status_log_cnt = 9933;
      Test00105_1.tran_flg = 9934;
      Test00105_1.sub_tran_flg = 9935;
      Test00105_1.off_entry_flg = 9936;
      Test00105_1.various_flg_1 = 9937;
      Test00105_1.various_flg_2 = 9938;
      Test00105_1.various_flg_3 = 9939;
      Test00105_1.various_num_1 = 9940;
      Test00105_1.various_num_2 = 9941;
      Test00105_1.various_num_3 = 9942;
      Test00105_1.various_data = 'abc43';
      Test00105_1.various_flg_4 = 9944;
      Test00105_1.various_flg_5 = 9945;
      Test00105_1.various_flg_6 = 9946;
      Test00105_1.various_flg_7 = 9947;
      Test00105_1.various_flg_8 = 9948;
      Test00105_1.various_flg_9 = 9949;
      Test00105_1.various_flg_10 = 9950;
      Test00105_1.various_flg_11 = 9951;
      Test00105_1.various_flg_12 = 9952;
      Test00105_1.various_flg_13 = 9953;
      Test00105_1.reserv_flg = 9954;
      Test00105_1.reserv_stre_cd = 9955;
      Test00105_1.reserv_status = 9956;
      Test00105_1.reserv_chg_cnt = 9957;
      Test00105_1.reserv_cd = 'abc58';
      Test00105_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLog> Test00105_AllRtn = await db.selectAllData(Test00105_1);
      int count = Test00105_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00105_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLog Test00105_2 = CHeaderLog();
      //Keyの値を設定する
      Test00105_2.serial_no = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLog? Test00105_Rtn = await db.selectDataByPrimaryKey(Test00105_2);
      //取得行がない場合、nullが返ってきます
      if (Test00105_Rtn == null) {
        print('\n********** 異常発生：00105_CHeaderLog_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00105_Rtn?.serial_no,'abc12');
        expect(Test00105_Rtn?.comp_cd,9913);
        expect(Test00105_Rtn?.stre_cd,9914);
        expect(Test00105_Rtn?.mac_no,9915);
        expect(Test00105_Rtn?.receipt_no,9916);
        expect(Test00105_Rtn?.print_no,9917);
        expect(Test00105_Rtn?.cshr_no,9918);
        expect(Test00105_Rtn?.chkr_no,9919);
        expect(Test00105_Rtn?.cust_no,'abc20');
        expect(Test00105_Rtn?.sale_date,'abc21');
        expect(Test00105_Rtn?.starttime,'abc22');
        expect(Test00105_Rtn?.endtime,'abc23');
        expect(Test00105_Rtn?.ope_mode_flg,9924);
        expect(Test00105_Rtn?.inout_flg,9925);
        expect(Test00105_Rtn?.prn_typ,9926);
        expect(Test00105_Rtn?.void_serial_no,'abc27');
        expect(Test00105_Rtn?.qc_serial_no,'abc28');
        expect(Test00105_Rtn?.void_kind,9929);
        expect(Test00105_Rtn?.void_sale_date,'abc30');
        expect(Test00105_Rtn?.data_log_cnt,9931);
        expect(Test00105_Rtn?.ej_log_cnt,9932);
        expect(Test00105_Rtn?.status_log_cnt,9933);
        expect(Test00105_Rtn?.tran_flg,9934);
        expect(Test00105_Rtn?.sub_tran_flg,9935);
        expect(Test00105_Rtn?.off_entry_flg,9936);
        expect(Test00105_Rtn?.various_flg_1,9937);
        expect(Test00105_Rtn?.various_flg_2,9938);
        expect(Test00105_Rtn?.various_flg_3,9939);
        expect(Test00105_Rtn?.various_num_1,9940);
        expect(Test00105_Rtn?.various_num_2,9941);
        expect(Test00105_Rtn?.various_num_3,9942);
        expect(Test00105_Rtn?.various_data,'abc43');
        expect(Test00105_Rtn?.various_flg_4,9944);
        expect(Test00105_Rtn?.various_flg_5,9945);
        expect(Test00105_Rtn?.various_flg_6,9946);
        expect(Test00105_Rtn?.various_flg_7,9947);
        expect(Test00105_Rtn?.various_flg_8,9948);
        expect(Test00105_Rtn?.various_flg_9,9949);
        expect(Test00105_Rtn?.various_flg_10,9950);
        expect(Test00105_Rtn?.various_flg_11,9951);
        expect(Test00105_Rtn?.various_flg_12,9952);
        expect(Test00105_Rtn?.various_flg_13,9953);
        expect(Test00105_Rtn?.reserv_flg,9954);
        expect(Test00105_Rtn?.reserv_stre_cd,9955);
        expect(Test00105_Rtn?.reserv_status,9956);
        expect(Test00105_Rtn?.reserv_chg_cnt,9957);
        expect(Test00105_Rtn?.reserv_cd,'abc58');
        expect(Test00105_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLog> Test00105_AllRtn2 = await db.selectAllData(Test00105_1);
      int count2 = Test00105_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00105_1);
      print('********** テスト終了：00105_CHeaderLog_01 **********\n\n');
    });

    // ********************************************************
    // テスト00106 : CDataLog
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00106_CDataLog_01', () async {
      print('\n********** テスト実行：00106_CDataLog_01 **********');
      CDataLog Test00106_1 = CDataLog();
      Test00106_1.serial_no = 'abc12';
      Test00106_1.seq_no = 9913;
      Test00106_1.cnct_seq_no = 9914;
      Test00106_1.func_cd = 9915;
      Test00106_1.func_seq_no = 9916;
      Test00106_1.c_data1 = 'abc17';
      Test00106_1.c_data2 = 'abc18';
      Test00106_1.c_data3 = 'abc19';
      Test00106_1.c_data4 = 'abc20';
      Test00106_1.c_data5 = 'abc21';
      Test00106_1.c_data6 = 'abc22';
      Test00106_1.c_data7 = 'abc23';
      Test00106_1.c_data8 = 'abc24';
      Test00106_1.c_data9 = 'abc25';
      Test00106_1.c_data10 = 'abc26';
      Test00106_1.n_data1 = 1.227;
      Test00106_1.n_data2 = 1.228;
      Test00106_1.n_data3 = 1.229;
      Test00106_1.n_data4 = 1.230;
      Test00106_1.n_data5 = 1.231;
      Test00106_1.n_data6 = 1.232;
      Test00106_1.n_data7 = 1.233;
      Test00106_1.n_data8 = 1.234;
      Test00106_1.n_data9 = 1.235;
      Test00106_1.n_data10 = 1.236;
      Test00106_1.n_data11 = 1.237;
      Test00106_1.n_data12 = 1.238;
      Test00106_1.n_data13 = 1.239;
      Test00106_1.n_data14 = 1.240;
      Test00106_1.n_data15 = 1.241;
      Test00106_1.n_data16 = 1.242;
      Test00106_1.n_data17 = 1.243;
      Test00106_1.n_data18 = 1.244;
      Test00106_1.n_data19 = 1.245;
      Test00106_1.n_data20 = 1.246;
      Test00106_1.n_data21 = 1.247;
      Test00106_1.n_data22 = 1.248;
      Test00106_1.n_data23 = 1.249;
      Test00106_1.n_data24 = 1.250;
      Test00106_1.n_data25 = 1.251;
      Test00106_1.n_data26 = 1.252;
      Test00106_1.n_data27 = 1.253;
      Test00106_1.n_data28 = 1.254;
      Test00106_1.n_data29 = 1.255;
      Test00106_1.n_data30 = 1.256;
      Test00106_1.d_data1 = 'abc57';
      Test00106_1.d_data2 = 'abc58';
      Test00106_1.d_data3 = 'abc59';
      Test00106_1.d_data4 = 'abc60';
      Test00106_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLog> Test00106_AllRtn = await db.selectAllData(Test00106_1);
      int count = Test00106_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00106_1);

      //データ取得に必要なオブジェクトを用意
      CDataLog Test00106_2 = CDataLog();
      //Keyの値を設定する
      Test00106_2.serial_no = 'abc12';
      Test00106_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLog? Test00106_Rtn = await db.selectDataByPrimaryKey(Test00106_2);
      //取得行がない場合、nullが返ってきます
      if (Test00106_Rtn == null) {
        print('\n********** 異常発生：00106_CDataLog_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00106_Rtn?.serial_no,'abc12');
        expect(Test00106_Rtn?.seq_no,9913);
        expect(Test00106_Rtn?.cnct_seq_no,9914);
        expect(Test00106_Rtn?.func_cd,9915);
        expect(Test00106_Rtn?.func_seq_no,9916);
        expect(Test00106_Rtn?.c_data1,'abc17');
        expect(Test00106_Rtn?.c_data2,'abc18');
        expect(Test00106_Rtn?.c_data3,'abc19');
        expect(Test00106_Rtn?.c_data4,'abc20');
        expect(Test00106_Rtn?.c_data5,'abc21');
        expect(Test00106_Rtn?.c_data6,'abc22');
        expect(Test00106_Rtn?.c_data7,'abc23');
        expect(Test00106_Rtn?.c_data8,'abc24');
        expect(Test00106_Rtn?.c_data9,'abc25');
        expect(Test00106_Rtn?.c_data10,'abc26');
        expect(Test00106_Rtn?.n_data1,1.227);
        expect(Test00106_Rtn?.n_data2,1.228);
        expect(Test00106_Rtn?.n_data3,1.229);
        expect(Test00106_Rtn?.n_data4,1.230);
        expect(Test00106_Rtn?.n_data5,1.231);
        expect(Test00106_Rtn?.n_data6,1.232);
        expect(Test00106_Rtn?.n_data7,1.233);
        expect(Test00106_Rtn?.n_data8,1.234);
        expect(Test00106_Rtn?.n_data9,1.235);
        expect(Test00106_Rtn?.n_data10,1.236);
        expect(Test00106_Rtn?.n_data11,1.237);
        expect(Test00106_Rtn?.n_data12,1.238);
        expect(Test00106_Rtn?.n_data13,1.239);
        expect(Test00106_Rtn?.n_data14,1.240);
        expect(Test00106_Rtn?.n_data15,1.241);
        expect(Test00106_Rtn?.n_data16,1.242);
        expect(Test00106_Rtn?.n_data17,1.243);
        expect(Test00106_Rtn?.n_data18,1.244);
        expect(Test00106_Rtn?.n_data19,1.245);
        expect(Test00106_Rtn?.n_data20,1.246);
        expect(Test00106_Rtn?.n_data21,1.247);
        expect(Test00106_Rtn?.n_data22,1.248);
        expect(Test00106_Rtn?.n_data23,1.249);
        expect(Test00106_Rtn?.n_data24,1.250);
        expect(Test00106_Rtn?.n_data25,1.251);
        expect(Test00106_Rtn?.n_data26,1.252);
        expect(Test00106_Rtn?.n_data27,1.253);
        expect(Test00106_Rtn?.n_data28,1.254);
        expect(Test00106_Rtn?.n_data29,1.255);
        expect(Test00106_Rtn?.n_data30,1.256);
        expect(Test00106_Rtn?.d_data1,'abc57');
        expect(Test00106_Rtn?.d_data2,'abc58');
        expect(Test00106_Rtn?.d_data3,'abc59');
        expect(Test00106_Rtn?.d_data4,'abc60');
        expect(Test00106_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLog> Test00106_AllRtn2 = await db.selectAllData(Test00106_1);
      int count2 = Test00106_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00106_1);
      print('********** テスト終了：00106_CDataLog_01 **********\n\n');
    });

    // ********************************************************
    // テスト00107 : CStatusLog
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00107_CStatusLog_01', () async {
      print('\n********** テスト実行：00107_CStatusLog_01 **********');
      CStatusLog Test00107_1 = CStatusLog();
      Test00107_1.serial_no = 'abc12';
      Test00107_1.seq_no = 9913;
      Test00107_1.cnct_seq_no = 9914;
      Test00107_1.func_cd = 9915;
      Test00107_1.func_seq_no = 9916;
      Test00107_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLog> Test00107_AllRtn = await db.selectAllData(Test00107_1);
      int count = Test00107_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00107_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLog Test00107_2 = CStatusLog();
      //Keyの値を設定する
      Test00107_2.serial_no = 'abc12';
      Test00107_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLog? Test00107_Rtn = await db.selectDataByPrimaryKey(Test00107_2);
      //取得行がない場合、nullが返ってきます
      if (Test00107_Rtn == null) {
        print('\n********** 異常発生：00107_CStatusLog_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00107_Rtn?.serial_no,'abc12');
        expect(Test00107_Rtn?.seq_no,9913);
        expect(Test00107_Rtn?.cnct_seq_no,9914);
        expect(Test00107_Rtn?.func_cd,9915);
        expect(Test00107_Rtn?.func_seq_no,9916);
        expect(Test00107_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLog> Test00107_AllRtn2 = await db.selectAllData(Test00107_1);
      int count2 = Test00107_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00107_1);
      print('********** テスト終了：00107_CStatusLog_01 **********\n\n');
    });

    // ********************************************************
    // テスト00108 : CEjLog
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00108_CEjLog_01', () async {
      print('\n********** テスト実行：00108_CEjLog_01 **********');
      CEjLog Test00108_1 = CEjLog();
      Test00108_1.serial_no = 'abc12';
      Test00108_1.comp_cd = 9913;
      Test00108_1.stre_cd = 9914;
      Test00108_1.mac_no = 9915;
      Test00108_1.print_no = 9916;
      Test00108_1.seq_no = 9917;
      Test00108_1.receipt_no = 9918;
      Test00108_1.end_rec_flg = 9919;
      Test00108_1.only_ejlog_flg = 9920;
      Test00108_1.cshr_no = 9921;
      Test00108_1.chkr_no = 9922;
      Test00108_1.now_sale_datetime = 'abc23';
      Test00108_1.sale_date = 'abc24';
      Test00108_1.ope_mode_flg = 9925;
      Test00108_1.print_data = 'abc26';
      Test00108_1.sub_only_ejlog_flg = 9927;
      Test00108_1.trankey_search = 'abc28';
      Test00108_1.etckey_search = 'abc29';

      //selectAllDataをして件数取得。
      List<CEjLog> Test00108_AllRtn = await db.selectAllData(Test00108_1);
      int count = Test00108_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00108_1);

      //データ取得に必要なオブジェクトを用意
      CEjLog Test00108_2 = CEjLog();
      //Keyの値を設定する
      Test00108_2.serial_no = 'abc12';
      Test00108_2.seq_no = 9917;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CEjLog? Test00108_Rtn = await db.selectDataByPrimaryKey(Test00108_2);
      //取得行がない場合、nullが返ってきます
      if (Test00108_Rtn == null) {
        print('\n********** 異常発生：00108_CEjLog_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00108_Rtn?.serial_no,'abc12');
        expect(Test00108_Rtn?.comp_cd,9913);
        expect(Test00108_Rtn?.stre_cd,9914);
        expect(Test00108_Rtn?.mac_no,9915);
        expect(Test00108_Rtn?.print_no,9916);
        expect(Test00108_Rtn?.seq_no,9917);
        expect(Test00108_Rtn?.receipt_no,9918);
        expect(Test00108_Rtn?.end_rec_flg,9919);
        expect(Test00108_Rtn?.only_ejlog_flg,9920);
        expect(Test00108_Rtn?.cshr_no,9921);
        expect(Test00108_Rtn?.chkr_no,9922);
        expect(Test00108_Rtn?.now_sale_datetime,'abc23');
        expect(Test00108_Rtn?.sale_date,'abc24');
        expect(Test00108_Rtn?.ope_mode_flg,9925);
        expect(Test00108_Rtn?.print_data,'abc26');
        expect(Test00108_Rtn?.sub_only_ejlog_flg,9927);
        expect(Test00108_Rtn?.trankey_search,'abc28');
        expect(Test00108_Rtn?.etckey_search,'abc29');
      }

      //selectAllDataをして件数取得。
      List<CEjLog> Test00108_AllRtn2 = await db.selectAllData(Test00108_1);
      int count2 = Test00108_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00108_1);
      print('********** テスト終了：00108_CEjLog_01 **********\n\n');
    });

    // ********************************************************
    // テスト00109 : CVoidLog01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00109_CVoidLog01_01', () async {
      print('\n********** テスト実行：00109_CVoidLog01_01 **********');
      CVoidLog01 Test00109_1 = CVoidLog01();
      Test00109_1.serial_no = 'abc12';
      Test00109_1.void_serial_no = 'abc13';
      Test00109_1.mac_no = 9914;
      Test00109_1.sale_date = 'abc15';
      Test00109_1.void_sale_date = 'abc16';
      Test00109_1.void_kind = 9917;
      Test00109_1.void_taxfree_no = 'abc18';
      Test00109_1.various_data1 = 'abc19';
      Test00109_1.various_data2 = 'abc20';

      //selectAllDataをして件数取得。
      List<CVoidLog01> Test00109_AllRtn = await db.selectAllData(Test00109_1);
      int count = Test00109_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00109_1);

      //データ取得に必要なオブジェクトを用意
      CVoidLog01 Test00109_2 = CVoidLog01();
      //Keyの値を設定する
      Test00109_2.serial_no = 'abc12';
      Test00109_2.void_serial_no = 'abc13';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CVoidLog01? Test00109_Rtn = await db.selectDataByPrimaryKey(Test00109_2);
      //取得行がない場合、nullが返ってきます
      if (Test00109_Rtn == null) {
        print('\n********** 異常発生：00109_CVoidLog01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00109_Rtn?.serial_no,'abc12');
        expect(Test00109_Rtn?.void_serial_no,'abc13');
        expect(Test00109_Rtn?.mac_no,9914);
        expect(Test00109_Rtn?.sale_date,'abc15');
        expect(Test00109_Rtn?.void_sale_date,'abc16');
        expect(Test00109_Rtn?.void_kind,9917);
        expect(Test00109_Rtn?.void_taxfree_no,'abc18');
        expect(Test00109_Rtn?.various_data1,'abc19');
        expect(Test00109_Rtn?.various_data2,'abc20');
      }

      //selectAllDataをして件数取得。
      List<CVoidLog01> Test00109_AllRtn2 = await db.selectAllData(Test00109_1);
      int count2 = Test00109_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00109_1);
      print('********** テスト終了：00109_CVoidLog01_01 **********\n\n');
    });

    // ********************************************************
    // テスト00110 : CPbchgLog
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00110_CPbchgLog_01', () async {
      print('\n********** テスト実行：00110_CPbchgLog_01 **********');
      CPbchgLog Test00110_1 = CPbchgLog();
      Test00110_1.serial_no = 'abc12';
      Test00110_1.seq_no = 9913;
      Test00110_1.comp_cd = 9914;
      Test00110_1.stre_cd = 9915;
      Test00110_1.mac_no = 9916;
      Test00110_1.date = 'abc17';
      Test00110_1.time = 'abc18';
      Test00110_1.groupcd = 9919;
      Test00110_1.officecd = 9920;
      Test00110_1.strecd = 9921;
      Test00110_1.termcd = 9922;
      Test00110_1.dealseqno = 9923;
      Test00110_1.servicekind = 'abc24';
      Test00110_1.serviceseqno = 9925;
      Test00110_1.settlestatus = 9926;
      Test00110_1.settlekind = 9927;
      Test00110_1.cashamt = 9928;
      Test00110_1.charge1 = 9929;
      Test00110_1.charge2 = 9930;
      Test00110_1.dealererr = 9931;
      Test00110_1.receipterr = 9932;
      Test00110_1.validdate = 'abc33';
      Test00110_1.barcodekind = 9934;
      Test00110_1.barcode1 = 'abc35';
      Test00110_1.barcode2 = 'abc36';
      Test00110_1.barcode3 = 'abc37';
      Test00110_1.barcode4 = 'abc38';
      Test00110_1.receiptmsgno = 9939;
      Test00110_1.comparestatus = 9940;
      Test00110_1.name = 'abc41';
      Test00110_1.tran_flg = 9942;
      Test00110_1.sub_tran_flg = 9943;
      Test00110_1.receipt_flg = 9944;
      Test00110_1.matching_flg = 9945;
      Test00110_1.check_flg = 9946;
      Test00110_1.fil1 = 9947;
      Test00110_1.fil2 = 9948;

      //selectAllDataをして件数取得。
      List<CPbchgLog> Test00110_AllRtn = await db.selectAllData(Test00110_1);
      int count = Test00110_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00110_1);

      //データ取得に必要なオブジェクトを用意
      CPbchgLog Test00110_2 = CPbchgLog();
      //Keyの値を設定する
      Test00110_2.serial_no = 'abc12';
      Test00110_2.seq_no = 9913;
      Test00110_2.comp_cd = 9914;
      Test00110_2.stre_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPbchgLog? Test00110_Rtn = await db.selectDataByPrimaryKey(Test00110_2);
      //取得行がない場合、nullが返ってきます
      if (Test00110_Rtn == null) {
        print('\n********** 異常発生：00110_CPbchgLog_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00110_Rtn?.serial_no,'abc12');
        expect(Test00110_Rtn?.seq_no,9913);
        expect(Test00110_Rtn?.comp_cd,9914);
        expect(Test00110_Rtn?.stre_cd,9915);
        expect(Test00110_Rtn?.mac_no,9916);
        expect(Test00110_Rtn?.date,'abc17');
        expect(Test00110_Rtn?.time,'abc18');
        expect(Test00110_Rtn?.groupcd,9919);
        expect(Test00110_Rtn?.officecd,9920);
        expect(Test00110_Rtn?.strecd,9921);
        expect(Test00110_Rtn?.termcd,9922);
        expect(Test00110_Rtn?.dealseqno,9923);
        expect(Test00110_Rtn?.servicekind,'abc24');
        expect(Test00110_Rtn?.serviceseqno,9925);
        expect(Test00110_Rtn?.settlestatus,9926);
        expect(Test00110_Rtn?.settlekind,9927);
        expect(Test00110_Rtn?.cashamt,9928);
        expect(Test00110_Rtn?.charge1,9929);
        expect(Test00110_Rtn?.charge2,9930);
        expect(Test00110_Rtn?.dealererr,9931);
        expect(Test00110_Rtn?.receipterr,9932);
        expect(Test00110_Rtn?.validdate,'abc33');
        expect(Test00110_Rtn?.barcodekind,9934);
        expect(Test00110_Rtn?.barcode1,'abc35');
        expect(Test00110_Rtn?.barcode2,'abc36');
        expect(Test00110_Rtn?.barcode3,'abc37');
        expect(Test00110_Rtn?.barcode4,'abc38');
        expect(Test00110_Rtn?.receiptmsgno,9939);
        expect(Test00110_Rtn?.comparestatus,9940);
        expect(Test00110_Rtn?.name,'abc41');
        expect(Test00110_Rtn?.tran_flg,9942);
        expect(Test00110_Rtn?.sub_tran_flg,9943);
        expect(Test00110_Rtn?.receipt_flg,9944);
        expect(Test00110_Rtn?.matching_flg,9945);
        expect(Test00110_Rtn?.check_flg,9946);
        expect(Test00110_Rtn?.fil1,9947);
        expect(Test00110_Rtn?.fil2,9948);
      }

      //selectAllDataをして件数取得。
      List<CPbchgLog> Test00110_AllRtn2 = await db.selectAllData(Test00110_1);
      int count2 = Test00110_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00110_1);
      print('********** テスト終了：00110_CPbchgLog_01 **********\n\n');
    });

    // ********************************************************
    // テスト00111 : CReservLog
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00111_CReservLog_01', () async {
      print('\n********** テスト実行：00111_CReservLog_01 **********');
      CReservLog Test00111_1 = CReservLog();
      Test00111_1.serial_no = 'abc12';
      Test00111_1.now_sale_datetime = 'abc13';
      Test00111_1.void_serial_no = 'abc14';
      Test00111_1.cust_no = 'abc15';
      Test00111_1.last_name = 'abc16';
      Test00111_1.first_name = 'abc17';
      Test00111_1.tel_no1 = 'abc18';
      Test00111_1.tel_no2 = 'abc19';
      Test00111_1.address1 = 'abc20';
      Test00111_1.address2 = 'abc21';
      Test00111_1.address3 = 'abc22';
      Test00111_1.recept_date = 'abc23';
      Test00111_1.ferry_date = 'abc24';
      Test00111_1.arrival_date = 'abc25';
      Test00111_1.qty = 9926;
      Test00111_1.ttl = 9927;
      Test00111_1.advance_money = 9928;
      Test00111_1.memo1 = 'abc29';
      Test00111_1.memo2 = 'abc30';
      Test00111_1.fil1 = 9931;
      Test00111_1.fil2 = 9932;
      Test00111_1.fil3 = 9933;
      Test00111_1.finish = 9934;
      Test00111_1.tran_flg = 9935;
      Test00111_1.sub_tran_flg = 9936;
      Test00111_1.center_flg = 9937;
      Test00111_1.update_flg = 9938;

      //selectAllDataをして件数取得。
      List<CReservLog> Test00111_AllRtn = await db.selectAllData(Test00111_1);
      int count = Test00111_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00111_1);

      //データ取得に必要なオブジェクトを用意
      CReservLog Test00111_2 = CReservLog();
      //Keyの値を設定する
      Test00111_2.serial_no = 'abc12';
      Test00111_2.now_sale_datetime = 'abc13';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReservLog? Test00111_Rtn = await db.selectDataByPrimaryKey(Test00111_2);
      //取得行がない場合、nullが返ってきます
      if (Test00111_Rtn == null) {
        print('\n********** 異常発生：00111_CReservLog_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00111_Rtn?.serial_no,'abc12');
        expect(Test00111_Rtn?.now_sale_datetime,'abc13');
        expect(Test00111_Rtn?.void_serial_no,'abc14');
        expect(Test00111_Rtn?.cust_no,'abc15');
        expect(Test00111_Rtn?.last_name,'abc16');
        expect(Test00111_Rtn?.first_name,'abc17');
        expect(Test00111_Rtn?.tel_no1,'abc18');
        expect(Test00111_Rtn?.tel_no2,'abc19');
        expect(Test00111_Rtn?.address1,'abc20');
        expect(Test00111_Rtn?.address2,'abc21');
        expect(Test00111_Rtn?.address3,'abc22');
        expect(Test00111_Rtn?.recept_date,'abc23');
        expect(Test00111_Rtn?.ferry_date,'abc24');
        expect(Test00111_Rtn?.arrival_date,'abc25');
        expect(Test00111_Rtn?.qty,9926);
        expect(Test00111_Rtn?.ttl,9927);
        expect(Test00111_Rtn?.advance_money,9928);
        expect(Test00111_Rtn?.memo1,'abc29');
        expect(Test00111_Rtn?.memo2,'abc30');
        expect(Test00111_Rtn?.fil1,9931);
        expect(Test00111_Rtn?.fil2,9932);
        expect(Test00111_Rtn?.fil3,9933);
        expect(Test00111_Rtn?.finish,9934);
        expect(Test00111_Rtn?.tran_flg,9935);
        expect(Test00111_Rtn?.sub_tran_flg,9936);
        expect(Test00111_Rtn?.center_flg,9937);
        expect(Test00111_Rtn?.update_flg,9938);
      }

      //selectAllDataをして件数取得。
      List<CReservLog> Test00111_AllRtn2 = await db.selectAllData(Test00111_1);
      int count2 = Test00111_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00111_1);
      print('********** テスト終了：00111_CReservLog_01 **********\n\n');
    });

    // ********************************************************
    // テスト00112 : CRecoverTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00112_CRecoverTbl_01', () async {
      print('\n********** テスト実行：00112_CRecoverTbl_01 **********');
      CRecoverTbl Test00112_1 = CRecoverTbl();
      Test00112_1.comp_cd = 9912;
      Test00112_1.stre_cd = 9913;
      Test00112_1.mac_no = 9914;
      Test00112_1.sale_date = 'abc15';
      Test00112_1.exec_flg = 9916;
      Test00112_1.ins_datetime = 'abc17';
      Test00112_1.upd_datetime = 'abc18';

      //selectAllDataをして件数取得。
      List<CRecoverTbl> Test00112_AllRtn = await db.selectAllData(Test00112_1);
      int count = Test00112_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00112_1);

      //データ取得に必要なオブジェクトを用意
      CRecoverTbl Test00112_2 = CRecoverTbl();
      //Keyの値を設定する
      Test00112_2.comp_cd = 9912;
      Test00112_2.stre_cd = 9913;
      Test00112_2.mac_no = 9914;
      Test00112_2.sale_date = 'abc15';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CRecoverTbl? Test00112_Rtn = await db.selectDataByPrimaryKey(Test00112_2);
      //取得行がない場合、nullが返ってきます
      if (Test00112_Rtn == null) {
        print('\n********** 異常発生：00112_CRecoverTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00112_Rtn?.comp_cd,9912);
        expect(Test00112_Rtn?.stre_cd,9913);
        expect(Test00112_Rtn?.mac_no,9914);
        expect(Test00112_Rtn?.sale_date,'abc15');
        expect(Test00112_Rtn?.exec_flg,9916);
        expect(Test00112_Rtn?.ins_datetime,'abc17');
        expect(Test00112_Rtn?.upd_datetime,'abc18');
      }

      //selectAllDataをして件数取得。
      List<CRecoverTbl> Test00112_AllRtn2 = await db.selectAllData(Test00112_1);
      int count2 = Test00112_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00112_1);
      print('********** テスト終了：00112_CRecoverTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00113 : CPbchgLog01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00113_CPbchgLog01_01', () async {
      print('\n********** テスト実行：00113_CPbchgLog01_01 **********');
      CPbchgLog01 Test00113_1 = CPbchgLog01();
      Test00113_1.serial_no = 'abc12';
      Test00113_1.seq_no = 9913;
      Test00113_1.comp_cd = 9914;
      Test00113_1.stre_cd = 9915;
      Test00113_1.mac_no = 9916;
      Test00113_1.date = 'abc17';
      Test00113_1.time = 'abc18';
      Test00113_1.groupcd = 9919;
      Test00113_1.officecd = 9920;
      Test00113_1.strecd = 9921;
      Test00113_1.termcd = 9922;
      Test00113_1.dealseqno = 9923;
      Test00113_1.servicekind = 'abc24';
      Test00113_1.serviceseqno = 9925;
      Test00113_1.settlestatus = 9926;
      Test00113_1.settlekind = 9927;
      Test00113_1.cashamt = 9928;
      Test00113_1.charge1 = 9929;
      Test00113_1.charge2 = 9930;
      Test00113_1.dealererr = 9931;
      Test00113_1.receipterr = 9932;
      Test00113_1.validdate = 'abc33';
      Test00113_1.barcodekind = 9934;
      Test00113_1.barcode1 = 'abc35';
      Test00113_1.barcode2 = 'abc36';
      Test00113_1.barcode3 = 'abc37';
      Test00113_1.barcode4 = 'abc38';
      Test00113_1.receiptmsgno = 9939;
      Test00113_1.comparestatus = 9940;
      Test00113_1.name = 'abc41';
      Test00113_1.tran_flg = 9942;
      Test00113_1.sub_tran_flg = 9943;
      Test00113_1.receipt_flg = 9944;
      Test00113_1.matching_flg = 9945;
      Test00113_1.check_flg = 9946;
      Test00113_1.fil1 = 9947;
      Test00113_1.fil2 = 9948;

      //selectAllDataをして件数取得。
      List<CPbchgLog01> Test00113_AllRtn = await db.selectAllData(Test00113_1);
      int count = Test00113_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00113_1);

      //データ取得に必要なオブジェクトを用意
      CPbchgLog01 Test00113_2 = CPbchgLog01();
      //Keyの値を設定する
      Test00113_2.serial_no = 'abc12';
      Test00113_2.seq_no = 9913;
      Test00113_2.comp_cd = 9914;
      Test00113_2.stre_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPbchgLog01? Test00113_Rtn = await db.selectDataByPrimaryKey(Test00113_2);
      //取得行がない場合、nullが返ってきます
      if (Test00113_Rtn == null) {
        print('\n********** 異常発生：00113_CPbchgLog01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00113_Rtn?.serial_no,'abc12');
        expect(Test00113_Rtn?.seq_no,9913);
        expect(Test00113_Rtn?.comp_cd,9914);
        expect(Test00113_Rtn?.stre_cd,9915);
        expect(Test00113_Rtn?.mac_no,9916);
        expect(Test00113_Rtn?.date,'abc17');
        expect(Test00113_Rtn?.time,'abc18');
        expect(Test00113_Rtn?.groupcd,9919);
        expect(Test00113_Rtn?.officecd,9920);
        expect(Test00113_Rtn?.strecd,9921);
        expect(Test00113_Rtn?.termcd,9922);
        expect(Test00113_Rtn?.dealseqno,9923);
        expect(Test00113_Rtn?.servicekind,'abc24');
        expect(Test00113_Rtn?.serviceseqno,9925);
        expect(Test00113_Rtn?.settlestatus,9926);
        expect(Test00113_Rtn?.settlekind,9927);
        expect(Test00113_Rtn?.cashamt,9928);
        expect(Test00113_Rtn?.charge1,9929);
        expect(Test00113_Rtn?.charge2,9930);
        expect(Test00113_Rtn?.dealererr,9931);
        expect(Test00113_Rtn?.receipterr,9932);
        expect(Test00113_Rtn?.validdate,'abc33');
        expect(Test00113_Rtn?.barcodekind,9934);
        expect(Test00113_Rtn?.barcode1,'abc35');
        expect(Test00113_Rtn?.barcode2,'abc36');
        expect(Test00113_Rtn?.barcode3,'abc37');
        expect(Test00113_Rtn?.barcode4,'abc38');
        expect(Test00113_Rtn?.receiptmsgno,9939);
        expect(Test00113_Rtn?.comparestatus,9940);
        expect(Test00113_Rtn?.name,'abc41');
        expect(Test00113_Rtn?.tran_flg,9942);
        expect(Test00113_Rtn?.sub_tran_flg,9943);
        expect(Test00113_Rtn?.receipt_flg,9944);
        expect(Test00113_Rtn?.matching_flg,9945);
        expect(Test00113_Rtn?.check_flg,9946);
        expect(Test00113_Rtn?.fil1,9947);
        expect(Test00113_Rtn?.fil2,9948);
      }

      //selectAllDataをして件数取得。
      List<CPbchgLog01> Test00113_AllRtn2 = await db.selectAllData(Test00113_1);
      int count2 = Test00113_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00113_1);
      print('********** テスト終了：00113_CPbchgLog01_01 **********\n\n');
    });

    // ********************************************************
    // テスト00114 : CReservLog01
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00114_CReservLog01_01', () async {
      print('\n********** テスト実行：00114_CReservLog01_01 **********');
      CReservLog01 Test00114_1 = CReservLog01();
      Test00114_1.serial_no = 'abc12';
      Test00114_1.now_sale_datetime = 'abc13';
      Test00114_1.void_serial_no = 'abc14';
      Test00114_1.cust_no = 'abc15';
      Test00114_1.last_name = 'abc16';
      Test00114_1.first_name = 'abc17';
      Test00114_1.tel_no1 = 'abc18';
      Test00114_1.tel_no2 = 'abc19';
      Test00114_1.address1 = 'abc20';
      Test00114_1.address2 = 'abc21';
      Test00114_1.address3 = 'abc22';
      Test00114_1.recept_date = 'abc23';
      Test00114_1.ferry_date = 'abc24';
      Test00114_1.arrival_date = 'abc25';
      Test00114_1.qty = 9926;
      Test00114_1.ttl = 9927;
      Test00114_1.advance_money = 9928;
      Test00114_1.memo1 = 'abc29';
      Test00114_1.memo2 = 'abc30';
      Test00114_1.fil1 = 9931;
      Test00114_1.fil2 = 9932;
      Test00114_1.fil3 = 9933;
      Test00114_1.finish = 9934;
      Test00114_1.tran_flg = 9935;
      Test00114_1.sub_tran_flg = 9936;
      Test00114_1.center_flg = 9937;
      Test00114_1.update_flg = 9938;

      //selectAllDataをして件数取得。
      List<CReservLog01> Test00114_AllRtn = await db.selectAllData(Test00114_1);
      int count = Test00114_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00114_1);

      //データ取得に必要なオブジェクトを用意
      CReservLog01 Test00114_2 = CReservLog01();
      //Keyの値を設定する
      Test00114_2.serial_no = 'abc12';
      Test00114_2.now_sale_datetime = 'abc13';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CReservLog01? Test00114_Rtn = await db.selectDataByPrimaryKey(Test00114_2);
      //取得行がない場合、nullが返ってきます
      if (Test00114_Rtn == null) {
        print('\n********** 異常発生：00114_CReservLog01_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00114_Rtn?.serial_no,'abc12');
        expect(Test00114_Rtn?.now_sale_datetime,'abc13');
        expect(Test00114_Rtn?.void_serial_no,'abc14');
        expect(Test00114_Rtn?.cust_no,'abc15');
        expect(Test00114_Rtn?.last_name,'abc16');
        expect(Test00114_Rtn?.first_name,'abc17');
        expect(Test00114_Rtn?.tel_no1,'abc18');
        expect(Test00114_Rtn?.tel_no2,'abc19');
        expect(Test00114_Rtn?.address1,'abc20');
        expect(Test00114_Rtn?.address2,'abc21');
        expect(Test00114_Rtn?.address3,'abc22');
        expect(Test00114_Rtn?.recept_date,'abc23');
        expect(Test00114_Rtn?.ferry_date,'abc24');
        expect(Test00114_Rtn?.arrival_date,'abc25');
        expect(Test00114_Rtn?.qty,9926);
        expect(Test00114_Rtn?.ttl,9927);
        expect(Test00114_Rtn?.advance_money,9928);
        expect(Test00114_Rtn?.memo1,'abc29');
        expect(Test00114_Rtn?.memo2,'abc30');
        expect(Test00114_Rtn?.fil1,9931);
        expect(Test00114_Rtn?.fil2,9932);
        expect(Test00114_Rtn?.fil3,9933);
        expect(Test00114_Rtn?.finish,9934);
        expect(Test00114_Rtn?.tran_flg,9935);
        expect(Test00114_Rtn?.sub_tran_flg,9936);
        expect(Test00114_Rtn?.center_flg,9937);
        expect(Test00114_Rtn?.update_flg,9938);
      }

      //selectAllDataをして件数取得。
      List<CReservLog01> Test00114_AllRtn2 = await db.selectAllData(Test00114_1);
      int count2 = Test00114_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00114_1);
      print('********** テスト終了：00114_CReservLog01_01 **********\n\n');
    });

    // ********************************************************
    // テスト00115 : CHeaderLogFloating
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00115_CHeaderLogFloating_01', () async {
      print('\n********** テスト実行：00115_CHeaderLogFloating_01 **********');
      CHeaderLogFloating Test00115_1 = CHeaderLogFloating();
      Test00115_1.serial_no = 'abc12';
      Test00115_1.comp_cd = 9913;
      Test00115_1.stre_cd = 9914;
      Test00115_1.mac_no = 9915;
      Test00115_1.receipt_no = 9916;
      Test00115_1.print_no = 9917;
      Test00115_1.cshr_no = 9918;
      Test00115_1.chkr_no = 9919;
      Test00115_1.cust_no = 'abc20';
      Test00115_1.sale_date = 'abc21';
      Test00115_1.starttime = 'abc22';
      Test00115_1.endtime = 'abc23';
      Test00115_1.ope_mode_flg = 9924;
      Test00115_1.inout_flg = 9925;
      Test00115_1.prn_typ = 9926;
      Test00115_1.void_serial_no = 'abc27';
      Test00115_1.qc_serial_no = 'abc28';
      Test00115_1.void_kind = 9929;
      Test00115_1.void_sale_date = 'abc30';
      Test00115_1.data_log_cnt = 9931;
      Test00115_1.ej_log_cnt = 9932;
      Test00115_1.status_log_cnt = 9933;
      Test00115_1.tran_flg = 9934;
      Test00115_1.sub_tran_flg = 9935;
      Test00115_1.off_entry_flg = 9936;
      Test00115_1.various_flg_1 = 9937;
      Test00115_1.various_flg_2 = 9938;
      Test00115_1.various_flg_3 = 9939;
      Test00115_1.various_num_1 = 9940;
      Test00115_1.various_num_2 = 9941;
      Test00115_1.various_num_3 = 9942;
      Test00115_1.various_data = 'abc43';
      Test00115_1.various_flg_4 = 9944;
      Test00115_1.various_flg_5 = 9945;
      Test00115_1.various_flg_6 = 9946;
      Test00115_1.various_flg_7 = 9947;
      Test00115_1.various_flg_8 = 9948;
      Test00115_1.various_flg_9 = 9949;
      Test00115_1.various_flg_10 = 9950;
      Test00115_1.various_flg_11 = 9951;
      Test00115_1.various_flg_12 = 9952;
      Test00115_1.various_flg_13 = 9953;
      Test00115_1.reserv_flg = 9954;
      Test00115_1.reserv_stre_cd = 9955;
      Test00115_1.reserv_status = 9956;
      Test00115_1.reserv_chg_cnt = 9957;
      Test00115_1.reserv_cd = 'abc58';
      Test00115_1.lock_cd = 'abc59';

      //selectAllDataをして件数取得。
      List<CHeaderLogFloating> Test00115_AllRtn = await db.selectAllData(Test00115_1);
      int count = Test00115_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00115_1);

      //データ取得に必要なオブジェクトを用意
      CHeaderLogFloating Test00115_2 = CHeaderLogFloating();
      //Keyの値を設定する
      Test00115_2.serial_no = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHeaderLogFloating? Test00115_Rtn = await db.selectDataByPrimaryKey(Test00115_2);
      //取得行がない場合、nullが返ってきます
      if (Test00115_Rtn == null) {
        print('\n********** 異常発生：00115_CHeaderLogFloating_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00115_Rtn?.serial_no,'abc12');
        expect(Test00115_Rtn?.comp_cd,9913);
        expect(Test00115_Rtn?.stre_cd,9914);
        expect(Test00115_Rtn?.mac_no,9915);
        expect(Test00115_Rtn?.receipt_no,9916);
        expect(Test00115_Rtn?.print_no,9917);
        expect(Test00115_Rtn?.cshr_no,9918);
        expect(Test00115_Rtn?.chkr_no,9919);
        expect(Test00115_Rtn?.cust_no,'abc20');
        expect(Test00115_Rtn?.sale_date,'abc21');
        expect(Test00115_Rtn?.starttime,'abc22');
        expect(Test00115_Rtn?.endtime,'abc23');
        expect(Test00115_Rtn?.ope_mode_flg,9924);
        expect(Test00115_Rtn?.inout_flg,9925);
        expect(Test00115_Rtn?.prn_typ,9926);
        expect(Test00115_Rtn?.void_serial_no,'abc27');
        expect(Test00115_Rtn?.qc_serial_no,'abc28');
        expect(Test00115_Rtn?.void_kind,9929);
        expect(Test00115_Rtn?.void_sale_date,'abc30');
        expect(Test00115_Rtn?.data_log_cnt,9931);
        expect(Test00115_Rtn?.ej_log_cnt,9932);
        expect(Test00115_Rtn?.status_log_cnt,9933);
        expect(Test00115_Rtn?.tran_flg,9934);
        expect(Test00115_Rtn?.sub_tran_flg,9935);
        expect(Test00115_Rtn?.off_entry_flg,9936);
        expect(Test00115_Rtn?.various_flg_1,9937);
        expect(Test00115_Rtn?.various_flg_2,9938);
        expect(Test00115_Rtn?.various_flg_3,9939);
        expect(Test00115_Rtn?.various_num_1,9940);
        expect(Test00115_Rtn?.various_num_2,9941);
        expect(Test00115_Rtn?.various_num_3,9942);
        expect(Test00115_Rtn?.various_data,'abc43');
        expect(Test00115_Rtn?.various_flg_4,9944);
        expect(Test00115_Rtn?.various_flg_5,9945);
        expect(Test00115_Rtn?.various_flg_6,9946);
        expect(Test00115_Rtn?.various_flg_7,9947);
        expect(Test00115_Rtn?.various_flg_8,9948);
        expect(Test00115_Rtn?.various_flg_9,9949);
        expect(Test00115_Rtn?.various_flg_10,9950);
        expect(Test00115_Rtn?.various_flg_11,9951);
        expect(Test00115_Rtn?.various_flg_12,9952);
        expect(Test00115_Rtn?.various_flg_13,9953);
        expect(Test00115_Rtn?.reserv_flg,9954);
        expect(Test00115_Rtn?.reserv_stre_cd,9955);
        expect(Test00115_Rtn?.reserv_status,9956);
        expect(Test00115_Rtn?.reserv_chg_cnt,9957);
        expect(Test00115_Rtn?.reserv_cd,'abc58');
        expect(Test00115_Rtn?.lock_cd,'abc59');
      }

      //selectAllDataをして件数取得。
      List<CHeaderLogFloating> Test00115_AllRtn2 = await db.selectAllData(Test00115_1);
      int count2 = Test00115_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00115_1);
      print('********** テスト終了：00115_CHeaderLogFloating_01 **********\n\n');
    });

    // ********************************************************
    // テスト00116 : CDataLogFloating
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00116_CDataLogFloating_01', () async {
      print('\n********** テスト実行：00116_CDataLogFloating_01 **********');
      CDataLogFloating Test00116_1 = CDataLogFloating();
      Test00116_1.serial_no = 'abc12';
      Test00116_1.seq_no = 9913;
      Test00116_1.cnct_seq_no = 9914;
      Test00116_1.func_cd = 9915;
      Test00116_1.func_seq_no = 9916;
      Test00116_1.c_data1 = 'abc17';
      Test00116_1.c_data2 = 'abc18';
      Test00116_1.c_data3 = 'abc19';
      Test00116_1.c_data4 = 'abc20';
      Test00116_1.c_data5 = 'abc21';
      Test00116_1.c_data6 = 'abc22';
      Test00116_1.c_data7 = 'abc23';
      Test00116_1.c_data8 = 'abc24';
      Test00116_1.c_data9 = 'abc25';
      Test00116_1.c_data10 = 'abc26';
      Test00116_1.n_data1 = 1.227;
      Test00116_1.n_data2 = 1.228;
      Test00116_1.n_data3 = 1.229;
      Test00116_1.n_data4 = 1.230;
      Test00116_1.n_data5 = 1.231;
      Test00116_1.n_data6 = 1.232;
      Test00116_1.n_data7 = 1.233;
      Test00116_1.n_data8 = 1.234;
      Test00116_1.n_data9 = 1.235;
      Test00116_1.n_data10 = 1.236;
      Test00116_1.n_data11 = 1.237;
      Test00116_1.n_data12 = 1.238;
      Test00116_1.n_data13 = 1.239;
      Test00116_1.n_data14 = 1.240;
      Test00116_1.n_data15 = 1.241;
      Test00116_1.n_data16 = 1.242;
      Test00116_1.n_data17 = 1.243;
      Test00116_1.n_data18 = 1.244;
      Test00116_1.n_data19 = 1.245;
      Test00116_1.n_data20 = 1.246;
      Test00116_1.n_data21 = 1.247;
      Test00116_1.n_data22 = 1.248;
      Test00116_1.n_data23 = 1.249;
      Test00116_1.n_data24 = 1.250;
      Test00116_1.n_data25 = 1.251;
      Test00116_1.n_data26 = 1.252;
      Test00116_1.n_data27 = 1.253;
      Test00116_1.n_data28 = 1.254;
      Test00116_1.n_data29 = 1.255;
      Test00116_1.n_data30 = 1.256;
      Test00116_1.d_data1 = 'abc57';
      Test00116_1.d_data2 = 'abc58';
      Test00116_1.d_data3 = 'abc59';
      Test00116_1.d_data4 = 'abc60';
      Test00116_1.d_data5 = 'abc61';

      //selectAllDataをして件数取得。
      List<CDataLogFloating> Test00116_AllRtn = await db.selectAllData(Test00116_1);
      int count = Test00116_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00116_1);

      //データ取得に必要なオブジェクトを用意
      CDataLogFloating Test00116_2 = CDataLogFloating();
      //Keyの値を設定する
      Test00116_2.serial_no = 'abc12';
      Test00116_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CDataLogFloating? Test00116_Rtn = await db.selectDataByPrimaryKey(Test00116_2);
      //取得行がない場合、nullが返ってきます
      if (Test00116_Rtn == null) {
        print('\n********** 異常発生：00116_CDataLogFloating_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00116_Rtn?.serial_no,'abc12');
        expect(Test00116_Rtn?.seq_no,9913);
        expect(Test00116_Rtn?.cnct_seq_no,9914);
        expect(Test00116_Rtn?.func_cd,9915);
        expect(Test00116_Rtn?.func_seq_no,9916);
        expect(Test00116_Rtn?.c_data1,'abc17');
        expect(Test00116_Rtn?.c_data2,'abc18');
        expect(Test00116_Rtn?.c_data3,'abc19');
        expect(Test00116_Rtn?.c_data4,'abc20');
        expect(Test00116_Rtn?.c_data5,'abc21');
        expect(Test00116_Rtn?.c_data6,'abc22');
        expect(Test00116_Rtn?.c_data7,'abc23');
        expect(Test00116_Rtn?.c_data8,'abc24');
        expect(Test00116_Rtn?.c_data9,'abc25');
        expect(Test00116_Rtn?.c_data10,'abc26');
        expect(Test00116_Rtn?.n_data1,1.227);
        expect(Test00116_Rtn?.n_data2,1.228);
        expect(Test00116_Rtn?.n_data3,1.229);
        expect(Test00116_Rtn?.n_data4,1.230);
        expect(Test00116_Rtn?.n_data5,1.231);
        expect(Test00116_Rtn?.n_data6,1.232);
        expect(Test00116_Rtn?.n_data7,1.233);
        expect(Test00116_Rtn?.n_data8,1.234);
        expect(Test00116_Rtn?.n_data9,1.235);
        expect(Test00116_Rtn?.n_data10,1.236);
        expect(Test00116_Rtn?.n_data11,1.237);
        expect(Test00116_Rtn?.n_data12,1.238);
        expect(Test00116_Rtn?.n_data13,1.239);
        expect(Test00116_Rtn?.n_data14,1.240);
        expect(Test00116_Rtn?.n_data15,1.241);
        expect(Test00116_Rtn?.n_data16,1.242);
        expect(Test00116_Rtn?.n_data17,1.243);
        expect(Test00116_Rtn?.n_data18,1.244);
        expect(Test00116_Rtn?.n_data19,1.245);
        expect(Test00116_Rtn?.n_data20,1.246);
        expect(Test00116_Rtn?.n_data21,1.247);
        expect(Test00116_Rtn?.n_data22,1.248);
        expect(Test00116_Rtn?.n_data23,1.249);
        expect(Test00116_Rtn?.n_data24,1.250);
        expect(Test00116_Rtn?.n_data25,1.251);
        expect(Test00116_Rtn?.n_data26,1.252);
        expect(Test00116_Rtn?.n_data27,1.253);
        expect(Test00116_Rtn?.n_data28,1.254);
        expect(Test00116_Rtn?.n_data29,1.255);
        expect(Test00116_Rtn?.n_data30,1.256);
        expect(Test00116_Rtn?.d_data1,'abc57');
        expect(Test00116_Rtn?.d_data2,'abc58');
        expect(Test00116_Rtn?.d_data3,'abc59');
        expect(Test00116_Rtn?.d_data4,'abc60');
        expect(Test00116_Rtn?.d_data5,'abc61');
      }

      //selectAllDataをして件数取得。
      List<CDataLogFloating> Test00116_AllRtn2 = await db.selectAllData(Test00116_1);
      int count2 = Test00116_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00116_1);
      print('********** テスト終了：00116_CDataLogFloating_01 **********\n\n');
    });

    // ********************************************************
    // テスト00117 : CStatusLogFloating
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00117_CStatusLogFloating_01', () async {
      print('\n********** テスト実行：00117_CStatusLogFloating_01 **********');
      CStatusLogFloating Test00117_1 = CStatusLogFloating();
      Test00117_1.serial_no = 'abc12';
      Test00117_1.seq_no = 9913;
      Test00117_1.cnct_seq_no = 9914;
      Test00117_1.func_cd = 9915;
      Test00117_1.func_seq_no = 9916;
      Test00117_1.status_data = 'abc17';

      //selectAllDataをして件数取得。
      List<CStatusLogFloating> Test00117_AllRtn = await db.selectAllData(Test00117_1);
      int count = Test00117_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00117_1);

      //データ取得に必要なオブジェクトを用意
      CStatusLogFloating Test00117_2 = CStatusLogFloating();
      //Keyの値を設定する
      Test00117_2.serial_no = 'abc12';
      Test00117_2.seq_no = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStatusLogFloating? Test00117_Rtn = await db.selectDataByPrimaryKey(Test00117_2);
      //取得行がない場合、nullが返ってきます
      if (Test00117_Rtn == null) {
        print('\n********** 異常発生：00117_CStatusLogFloating_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00117_Rtn?.serial_no,'abc12');
        expect(Test00117_Rtn?.seq_no,9913);
        expect(Test00117_Rtn?.cnct_seq_no,9914);
        expect(Test00117_Rtn?.func_cd,9915);
        expect(Test00117_Rtn?.func_seq_no,9916);
        expect(Test00117_Rtn?.status_data,'abc17');
      }

      //selectAllDataをして件数取得。
      List<CStatusLogFloating> Test00117_AllRtn2 = await db.selectAllData(Test00117_1);
      int count2 = Test00117_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00117_1);
      print('********** テスト終了：00117_CStatusLogFloating_01 **********\n\n');
    });

    // ********************************************************
    // テスト00118 : CHitouchRcvLog
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00118_CHitouchRcvLog_01', () async {
      print('\n********** テスト実行：00118_CHitouchRcvLog_01 **********');
      CHitouchRcvLog Test00118_1 = CHitouchRcvLog();
      Test00118_1.rcv_datetime = 'abc12';
      Test00118_1.tag_id = 'abc13';
      Test00118_1.plu_cd = 'abc14';
      Test00118_1.upd_flg = 9915;

      //selectAllDataをして件数取得。
      List<CHitouchRcvLog> Test00118_AllRtn = await db.selectAllData(Test00118_1);
      int count = Test00118_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00118_1);

      //データ取得に必要なオブジェクトを用意
      CHitouchRcvLog Test00118_2 = CHitouchRcvLog();
      //Keyの値を設定する
      Test00118_2.rcv_datetime = 'abc12';
      Test00118_2.tag_id = 'abc13';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHitouchRcvLog? Test00118_Rtn = await db.selectDataByPrimaryKey(Test00118_2);
      //取得行がない場合、nullが返ってきます
      if (Test00118_Rtn == null) {
        print('\n********** 異常発生：00118_CHitouchRcvLog_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00118_Rtn?.rcv_datetime,'abc12');
        expect(Test00118_Rtn?.tag_id,'abc13');
        expect(Test00118_Rtn?.plu_cd,'abc14');
        expect(Test00118_Rtn?.upd_flg,9915);
      }

      //selectAllDataをして件数取得。
      List<CHitouchRcvLog> Test00118_AllRtn2 = await db.selectAllData(Test00118_1);
      int count2 = Test00118_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00118_1);
      print('********** テスト終了：00118_CHitouchRcvLog_01 **********\n\n');
    });

    // ********************************************************
    // テスト00119 : CPlanMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00119_CPlanMst_01', () async {
      print('\n********** テスト実行：00119_CPlanMst_01 **********');
      CPlanMst Test00119_1 = CPlanMst();
      Test00119_1.comp_cd = 9912;
      Test00119_1.stre_cd = 9913;
      Test00119_1.plan_cd = 9914;
      Test00119_1.name = 'abc15';
      Test00119_1.short_name = 'abc16';
      Test00119_1.loy_flg = 9917;
      Test00119_1.prom_typ = 9918;
      Test00119_1.start_datetime = 'abc19';
      Test00119_1.end_datetime = 'abc20';
      Test00119_1.trends_typ = 9921;
      Test00119_1.poptitle = 'abc22';
      Test00119_1.promo_ext_id = 'abc23';
      Test00119_1.ins_datetime = 'abc24';
      Test00119_1.upd_datetime = 'abc25';
      Test00119_1.status = 9926;
      Test00119_1.send_flg = 9927;
      Test00119_1.upd_user = 9928;
      Test00119_1.upd_system = 9929;

      //selectAllDataをして件数取得。
      List<CPlanMst> Test00119_AllRtn = await db.selectAllData(Test00119_1);
      int count = Test00119_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00119_1);

      //データ取得に必要なオブジェクトを用意
      CPlanMst Test00119_2 = CPlanMst();
      //Keyの値を設定する
      Test00119_2.comp_cd = 9912;
      Test00119_2.stre_cd = 9913;
      Test00119_2.plan_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPlanMst? Test00119_Rtn = await db.selectDataByPrimaryKey(Test00119_2);
      //取得行がない場合、nullが返ってきます
      if (Test00119_Rtn == null) {
        print('\n********** 異常発生：00119_CPlanMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00119_Rtn?.comp_cd,9912);
        expect(Test00119_Rtn?.stre_cd,9913);
        expect(Test00119_Rtn?.plan_cd,9914);
        expect(Test00119_Rtn?.name,'abc15');
        expect(Test00119_Rtn?.short_name,'abc16');
        expect(Test00119_Rtn?.loy_flg,9917);
        expect(Test00119_Rtn?.prom_typ,9918);
        expect(Test00119_Rtn?.start_datetime,'abc19');
        expect(Test00119_Rtn?.end_datetime,'abc20');
        expect(Test00119_Rtn?.trends_typ,9921);
        expect(Test00119_Rtn?.poptitle,'abc22');
        expect(Test00119_Rtn?.promo_ext_id,'abc23');
        expect(Test00119_Rtn?.ins_datetime,'abc24');
        expect(Test00119_Rtn?.upd_datetime,'abc25');
        expect(Test00119_Rtn?.status,9926);
        expect(Test00119_Rtn?.send_flg,9927);
        expect(Test00119_Rtn?.upd_user,9928);
        expect(Test00119_Rtn?.upd_system,9929);
      }

      //selectAllDataをして件数取得。
      List<CPlanMst> Test00119_AllRtn2 = await db.selectAllData(Test00119_1);
      int count2 = Test00119_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00119_1);
      print('********** テスト終了：00119_CPlanMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00120 : SBrgnMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00120_SBrgnMst_01', () async {
      print('\n********** テスト実行：00120_SBrgnMst_01 **********');
      SBrgnMst Test00120_1 = SBrgnMst();
      Test00120_1.comp_cd = 9912;
      Test00120_1.stre_cd = 9913;
      Test00120_1.plan_cd = 9914;
      Test00120_1.brgn_cd = 9915;
      Test00120_1.plu_cd = 'abc16';
      Test00120_1.showorder = 9917;
      Test00120_1.brgn_typ = 9918;
      Test00120_1.name = 'abc19';
      Test00120_1.short_name = 'abc20';
      Test00120_1.dsc_flg = 9921;
      Test00120_1.svs_typ = 9922;
      Test00120_1.dsc_typ = 9923;
      Test00120_1.start_datetime = 'abc24';
      Test00120_1.end_datetime = 'abc25';
      Test00120_1.timesch_flg = 9926;
      Test00120_1.sun_flg = 9927;
      Test00120_1.mon_flg = 9928;
      Test00120_1.tue_flg = 9929;
      Test00120_1.wed_flg = 9930;
      Test00120_1.thu_flg = 9931;
      Test00120_1.fri_flg = 9932;
      Test00120_1.sat_flg = 9933;
      Test00120_1.trends_typ = 9934;
      Test00120_1.brgn_prc = 9935;
      Test00120_1.brgncust_prc = 9936;
      Test00120_1.brgn_cost = 1.237;
      Test00120_1.consist_val1 = 9938;
      Test00120_1.gram_prc = 9939;
      Test00120_1.markdown_flg = 9940;
      Test00120_1.markdown = 9941;
      Test00120_1.imagedata_cd = 9942;
      Test00120_1.advantize_cd = 9943;
      Test00120_1.labelsize = 9944;
      Test00120_1.auto_order_flg = 9945;
      Test00120_1.div_cd = 9946;
      Test00120_1.promo_ext_id = 'abc47';
      Test00120_1.comment1 = 'abc48';
      Test00120_1.comment2 = 'abc49';
      Test00120_1.memo1 = 'abc50';
      Test00120_1.memo2 = 'abc51';
      Test00120_1.sale_cnt = 9952;
      Test00120_1.sale_unit = 'abc53';
      Test00120_1.limit_info = 'abc54';
      Test00120_1.first_service = 'abc55';
      Test00120_1.card1 = 9956;
      Test00120_1.card2 = 9957;
      Test00120_1.card3 = 9958;
      Test00120_1.card4 = 9959;
      Test00120_1.card5 = 9960;
      Test00120_1.timeprc_dsc_flg = 9961;
      Test00120_1.brgn_div = 9962;
      Test00120_1.brgn_costper = 1.263;
      Test00120_1.notes = 'abc64';
      Test00120_1.qty_flg = 9965;
      Test00120_1.row_order_cnt = 9966;
      Test00120_1.row_order_add_cnt = 9967;
      Test00120_1.stop_flg = 9968;
      Test00120_1.ins_datetime = 'abc69';
      Test00120_1.upd_datetime = 'abc70';
      Test00120_1.status = 9971;
      Test00120_1.send_flg = 9972;
      Test00120_1.upd_user = 9973;
      Test00120_1.upd_system = 9974;
      Test00120_1.date_flg1 = 9975;
      Test00120_1.date_flg2 = 9976;
      Test00120_1.date_flg3 = 9977;
      Test00120_1.date_flg4 = 9978;
      Test00120_1.date_flg5 = 9979;

      //selectAllDataをして件数取得。
      List<SBrgnMst> Test00120_AllRtn = await db.selectAllData(Test00120_1);
      int count = Test00120_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00120_1);

      //データ取得に必要なオブジェクトを用意
      SBrgnMst Test00120_2 = SBrgnMst();
      //Keyの値を設定する
      Test00120_2.comp_cd = 9912;
      Test00120_2.stre_cd = 9913;
      Test00120_2.plan_cd = 9914;
      Test00120_2.brgn_cd = 9915;
      Test00120_2.plu_cd = 'abc16';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SBrgnMst? Test00120_Rtn = await db.selectDataByPrimaryKey(Test00120_2);
      //取得行がない場合、nullが返ってきます
      if (Test00120_Rtn == null) {
        print('\n********** 異常発生：00120_SBrgnMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00120_Rtn?.comp_cd,9912);
        expect(Test00120_Rtn?.stre_cd,9913);
        expect(Test00120_Rtn?.plan_cd,9914);
        expect(Test00120_Rtn?.brgn_cd,9915);
        expect(Test00120_Rtn?.plu_cd,'abc16');
        expect(Test00120_Rtn?.showorder,9917);
        expect(Test00120_Rtn?.brgn_typ,9918);
        expect(Test00120_Rtn?.name,'abc19');
        expect(Test00120_Rtn?.short_name,'abc20');
        expect(Test00120_Rtn?.dsc_flg,9921);
        expect(Test00120_Rtn?.svs_typ,9922);
        expect(Test00120_Rtn?.dsc_typ,9923);
        expect(Test00120_Rtn?.start_datetime,'abc24');
        expect(Test00120_Rtn?.end_datetime,'abc25');
        expect(Test00120_Rtn?.timesch_flg,9926);
        expect(Test00120_Rtn?.sun_flg,9927);
        expect(Test00120_Rtn?.mon_flg,9928);
        expect(Test00120_Rtn?.tue_flg,9929);
        expect(Test00120_Rtn?.wed_flg,9930);
        expect(Test00120_Rtn?.thu_flg,9931);
        expect(Test00120_Rtn?.fri_flg,9932);
        expect(Test00120_Rtn?.sat_flg,9933);
        expect(Test00120_Rtn?.trends_typ,9934);
        expect(Test00120_Rtn?.brgn_prc,9935);
        expect(Test00120_Rtn?.brgncust_prc,9936);
        expect(Test00120_Rtn?.brgn_cost,1.237);
        expect(Test00120_Rtn?.consist_val1,9938);
        expect(Test00120_Rtn?.gram_prc,9939);
        expect(Test00120_Rtn?.markdown_flg,9940);
        expect(Test00120_Rtn?.markdown,9941);
        expect(Test00120_Rtn?.imagedata_cd,9942);
        expect(Test00120_Rtn?.advantize_cd,9943);
        expect(Test00120_Rtn?.labelsize,9944);
        expect(Test00120_Rtn?.auto_order_flg,9945);
        expect(Test00120_Rtn?.div_cd,9946);
        expect(Test00120_Rtn?.promo_ext_id,'abc47');
        expect(Test00120_Rtn?.comment1,'abc48');
        expect(Test00120_Rtn?.comment2,'abc49');
        expect(Test00120_Rtn?.memo1,'abc50');
        expect(Test00120_Rtn?.memo2,'abc51');
        expect(Test00120_Rtn?.sale_cnt,9952);
        expect(Test00120_Rtn?.sale_unit,'abc53');
        expect(Test00120_Rtn?.limit_info,'abc54');
        expect(Test00120_Rtn?.first_service,'abc55');
        expect(Test00120_Rtn?.card1,9956);
        expect(Test00120_Rtn?.card2,9957);
        expect(Test00120_Rtn?.card3,9958);
        expect(Test00120_Rtn?.card4,9959);
        expect(Test00120_Rtn?.card5,9960);
        expect(Test00120_Rtn?.timeprc_dsc_flg,9961);
        expect(Test00120_Rtn?.brgn_div,9962);
        expect(Test00120_Rtn?.brgn_costper,1.263);
        expect(Test00120_Rtn?.notes,'abc64');
        expect(Test00120_Rtn?.qty_flg,9965);
        expect(Test00120_Rtn?.row_order_cnt,9966);
        expect(Test00120_Rtn?.row_order_add_cnt,9967);
        expect(Test00120_Rtn?.stop_flg,9968);
        expect(Test00120_Rtn?.ins_datetime,'abc69');
        expect(Test00120_Rtn?.upd_datetime,'abc70');
        expect(Test00120_Rtn?.status,9971);
        expect(Test00120_Rtn?.send_flg,9972);
        expect(Test00120_Rtn?.upd_user,9973);
        expect(Test00120_Rtn?.upd_system,9974);
        expect(Test00120_Rtn?.date_flg1,9975);
        expect(Test00120_Rtn?.date_flg2,9976);
        expect(Test00120_Rtn?.date_flg3,9977);
        expect(Test00120_Rtn?.date_flg4,9978);
        expect(Test00120_Rtn?.date_flg5,9979);
      }

      //selectAllDataをして件数取得。
      List<SBrgnMst> Test00120_AllRtn2 = await db.selectAllData(Test00120_1);
      int count2 = Test00120_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00120_1);
      print('********** テスト終了：00120_SBrgnMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00121 : SBdlschMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00121_SBdlschMst_01', () async {
      print('\n********** テスト実行：00121_SBdlschMst_01 **********');
      SBdlschMst Test00121_1 = SBdlschMst();
      Test00121_1.comp_cd = 9912;
      Test00121_1.stre_cd = 9913;
      Test00121_1.plan_cd = 9914;
      Test00121_1.bdl_cd = 9915;
      Test00121_1.bdl_typ = 9916;
      Test00121_1.name = 'abc17';
      Test00121_1.short_name = 'abc18';
      Test00121_1.start_datetime = 'abc19';
      Test00121_1.end_datetime = 'abc20';
      Test00121_1.timesch_flg = 9921;
      Test00121_1.sun_flg = 9922;
      Test00121_1.mon_flg = 9923;
      Test00121_1.tue_flg = 9924;
      Test00121_1.wed_flg = 9925;
      Test00121_1.thu_flg = 9926;
      Test00121_1.fri_flg = 9927;
      Test00121_1.sat_flg = 9928;
      Test00121_1.trends_typ = 9929;
      Test00121_1.bdl_qty1 = 9930;
      Test00121_1.bdl_qty2 = 9931;
      Test00121_1.bdl_qty3 = 9932;
      Test00121_1.bdl_qty4 = 9933;
      Test00121_1.bdl_qty5 = 9934;
      Test00121_1.bdl_prc1 = 9935;
      Test00121_1.bdl_prc2 = 9936;
      Test00121_1.bdl_prc3 = 9937;
      Test00121_1.bdl_prc4 = 9938;
      Test00121_1.bdl_prc5 = 9939;
      Test00121_1.bdl_avprc = 9940;
      Test00121_1.limit_cnt = 9941;
      Test00121_1.low_limit = 9942;
      Test00121_1.mbdl_prc1 = 9943;
      Test00121_1.mbdl_prc2 = 9944;
      Test00121_1.mbdl_prc3 = 9945;
      Test00121_1.mbdl_prc4 = 9946;
      Test00121_1.mbdl_prc5 = 9947;
      Test00121_1.mbdl_avprc = 9948;
      Test00121_1.stop_flg = 9949;
      Test00121_1.dsc_flg = 9950;
      Test00121_1.div_cd = 9951;
      Test00121_1.avprc_adpt_flg = 9952;
      Test00121_1.avprc_util_flg = 9953;
      Test00121_1.comment1 = 'abc54';
      Test00121_1.comment2 = 'abc55';
      Test00121_1.memo1 = 'abc56';
      Test00121_1.memo2 = 'abc57';
      Test00121_1.sale_unit = 'abc58';
      Test00121_1.limit_info = 'abc59';
      Test00121_1.first_service = 'abc60';
      Test00121_1.card1 = 9961;
      Test00121_1.card2 = 9962;
      Test00121_1.card3 = 9963;
      Test00121_1.card4 = 9964;
      Test00121_1.card5 = 9965;
      Test00121_1.promo_ext_id = 'abc66';
      Test00121_1.ins_datetime = 'abc67';
      Test00121_1.upd_datetime = 'abc68';
      Test00121_1.status = 9969;
      Test00121_1.send_flg = 9970;
      Test00121_1.upd_user = 9971;
      Test00121_1.upd_system = 9972;
      Test00121_1.date_flg1 = 9973;
      Test00121_1.date_flg2 = 9974;
      Test00121_1.date_flg3 = 9975;
      Test00121_1.date_flg4 = 9976;
      Test00121_1.date_flg5 = 9977;

      //selectAllDataをして件数取得。
      List<SBdlschMst> Test00121_AllRtn = await db.selectAllData(Test00121_1);
      int count = Test00121_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00121_1);

      //データ取得に必要なオブジェクトを用意
      SBdlschMst Test00121_2 = SBdlschMst();
      //Keyの値を設定する
      Test00121_2.comp_cd = 9912;
      Test00121_2.stre_cd = 9913;
      Test00121_2.plan_cd = 9914;
      Test00121_2.bdl_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SBdlschMst? Test00121_Rtn = await db.selectDataByPrimaryKey(Test00121_2);
      //取得行がない場合、nullが返ってきます
      if (Test00121_Rtn == null) {
        print('\n********** 異常発生：00121_SBdlschMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00121_Rtn?.comp_cd,9912);
        expect(Test00121_Rtn?.stre_cd,9913);
        expect(Test00121_Rtn?.plan_cd,9914);
        expect(Test00121_Rtn?.bdl_cd,9915);
        expect(Test00121_Rtn?.bdl_typ,9916);
        expect(Test00121_Rtn?.name,'abc17');
        expect(Test00121_Rtn?.short_name,'abc18');
        expect(Test00121_Rtn?.start_datetime,'abc19');
        expect(Test00121_Rtn?.end_datetime,'abc20');
        expect(Test00121_Rtn?.timesch_flg,9921);
        expect(Test00121_Rtn?.sun_flg,9922);
        expect(Test00121_Rtn?.mon_flg,9923);
        expect(Test00121_Rtn?.tue_flg,9924);
        expect(Test00121_Rtn?.wed_flg,9925);
        expect(Test00121_Rtn?.thu_flg,9926);
        expect(Test00121_Rtn?.fri_flg,9927);
        expect(Test00121_Rtn?.sat_flg,9928);
        expect(Test00121_Rtn?.trends_typ,9929);
        expect(Test00121_Rtn?.bdl_qty1,9930);
        expect(Test00121_Rtn?.bdl_qty2,9931);
        expect(Test00121_Rtn?.bdl_qty3,9932);
        expect(Test00121_Rtn?.bdl_qty4,9933);
        expect(Test00121_Rtn?.bdl_qty5,9934);
        expect(Test00121_Rtn?.bdl_prc1,9935);
        expect(Test00121_Rtn?.bdl_prc2,9936);
        expect(Test00121_Rtn?.bdl_prc3,9937);
        expect(Test00121_Rtn?.bdl_prc4,9938);
        expect(Test00121_Rtn?.bdl_prc5,9939);
        expect(Test00121_Rtn?.bdl_avprc,9940);
        expect(Test00121_Rtn?.limit_cnt,9941);
        expect(Test00121_Rtn?.low_limit,9942);
        expect(Test00121_Rtn?.mbdl_prc1,9943);
        expect(Test00121_Rtn?.mbdl_prc2,9944);
        expect(Test00121_Rtn?.mbdl_prc3,9945);
        expect(Test00121_Rtn?.mbdl_prc4,9946);
        expect(Test00121_Rtn?.mbdl_prc5,9947);
        expect(Test00121_Rtn?.mbdl_avprc,9948);
        expect(Test00121_Rtn?.stop_flg,9949);
        expect(Test00121_Rtn?.dsc_flg,9950);
        expect(Test00121_Rtn?.div_cd,9951);
        expect(Test00121_Rtn?.avprc_adpt_flg,9952);
        expect(Test00121_Rtn?.avprc_util_flg,9953);
        expect(Test00121_Rtn?.comment1,'abc54');
        expect(Test00121_Rtn?.comment2,'abc55');
        expect(Test00121_Rtn?.memo1,'abc56');
        expect(Test00121_Rtn?.memo2,'abc57');
        expect(Test00121_Rtn?.sale_unit,'abc58');
        expect(Test00121_Rtn?.limit_info,'abc59');
        expect(Test00121_Rtn?.first_service,'abc60');
        expect(Test00121_Rtn?.card1,9961);
        expect(Test00121_Rtn?.card2,9962);
        expect(Test00121_Rtn?.card3,9963);
        expect(Test00121_Rtn?.card4,9964);
        expect(Test00121_Rtn?.card5,9965);
        expect(Test00121_Rtn?.promo_ext_id,'abc66');
        expect(Test00121_Rtn?.ins_datetime,'abc67');
        expect(Test00121_Rtn?.upd_datetime,'abc68');
        expect(Test00121_Rtn?.status,9969);
        expect(Test00121_Rtn?.send_flg,9970);
        expect(Test00121_Rtn?.upd_user,9971);
        expect(Test00121_Rtn?.upd_system,9972);
        expect(Test00121_Rtn?.date_flg1,9973);
        expect(Test00121_Rtn?.date_flg2,9974);
        expect(Test00121_Rtn?.date_flg3,9975);
        expect(Test00121_Rtn?.date_flg4,9976);
        expect(Test00121_Rtn?.date_flg5,9977);
      }

      //selectAllDataをして件数取得。
      List<SBdlschMst> Test00121_AllRtn2 = await db.selectAllData(Test00121_1);
      int count2 = Test00121_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00121_1);
      print('********** テスト終了：00121_SBdlschMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00122 : SBdlitemMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00122_SBdlitemMst_01', () async {
      print('\n********** テスト実行：00122_SBdlitemMst_01 **********');
      SBdlitemMst Test00122_1 = SBdlitemMst();
      Test00122_1.comp_cd = 9912;
      Test00122_1.stre_cd = 9913;
      Test00122_1.plan_cd = 9914;
      Test00122_1.bdl_cd = 9915;
      Test00122_1.plu_cd = 'abc16';
      Test00122_1.showorder = 9917;
      Test00122_1.stop_flg = 9918;
      Test00122_1.promo_ext_id = 'abc19';
      Test00122_1.comment1 = 'abc20';
      Test00122_1.comment2 = 'abc21';
      Test00122_1.memo1 = 'abc22';
      Test00122_1.memo2 = 'abc23';
      Test00122_1.ins_datetime = 'abc24';
      Test00122_1.upd_datetime = 'abc25';
      Test00122_1.status = 9926;
      Test00122_1.send_flg = 9927;
      Test00122_1.upd_user = 9928;
      Test00122_1.upd_system = 9929;

      //selectAllDataをして件数取得。
      List<SBdlitemMst> Test00122_AllRtn = await db.selectAllData(Test00122_1);
      int count = Test00122_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00122_1);

      //データ取得に必要なオブジェクトを用意
      SBdlitemMst Test00122_2 = SBdlitemMst();
      //Keyの値を設定する
      Test00122_2.comp_cd = 9912;
      Test00122_2.stre_cd = 9913;
      Test00122_2.plan_cd = 9914;
      Test00122_2.bdl_cd = 9915;
      Test00122_2.plu_cd = 'abc16';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SBdlitemMst? Test00122_Rtn = await db.selectDataByPrimaryKey(Test00122_2);
      //取得行がない場合、nullが返ってきます
      if (Test00122_Rtn == null) {
        print('\n********** 異常発生：00122_SBdlitemMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00122_Rtn?.comp_cd,9912);
        expect(Test00122_Rtn?.stre_cd,9913);
        expect(Test00122_Rtn?.plan_cd,9914);
        expect(Test00122_Rtn?.bdl_cd,9915);
        expect(Test00122_Rtn?.plu_cd,'abc16');
        expect(Test00122_Rtn?.showorder,9917);
        expect(Test00122_Rtn?.stop_flg,9918);
        expect(Test00122_Rtn?.promo_ext_id,'abc19');
        expect(Test00122_Rtn?.comment1,'abc20');
        expect(Test00122_Rtn?.comment2,'abc21');
        expect(Test00122_Rtn?.memo1,'abc22');
        expect(Test00122_Rtn?.memo2,'abc23');
        expect(Test00122_Rtn?.ins_datetime,'abc24');
        expect(Test00122_Rtn?.upd_datetime,'abc25');
        expect(Test00122_Rtn?.status,9926);
        expect(Test00122_Rtn?.send_flg,9927);
        expect(Test00122_Rtn?.upd_user,9928);
        expect(Test00122_Rtn?.upd_system,9929);
      }

      //selectAllDataをして件数取得。
      List<SBdlitemMst> Test00122_AllRtn2 = await db.selectAllData(Test00122_1);
      int count2 = Test00122_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00122_1);
      print('********** テスト終了：00122_SBdlitemMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00123 : SStmschMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00123_SStmschMst_01', () async {
      print('\n********** テスト実行：00123_SStmschMst_01 **********');
      SStmschMst Test00123_1 = SStmschMst();
      Test00123_1.comp_cd = 9912;
      Test00123_1.stre_cd = 9913;
      Test00123_1.plan_cd = 9914;
      Test00123_1.stm_cd = 9915;
      Test00123_1.name = 'abc16';
      Test00123_1.short_name = 'abc17';
      Test00123_1.start_datetime = 'abc18';
      Test00123_1.end_datetime = 'abc19';
      Test00123_1.timesch_flg = 9920;
      Test00123_1.sun_flg = 9921;
      Test00123_1.mon_flg = 9922;
      Test00123_1.tue_flg = 9923;
      Test00123_1.wed_flg = 9924;
      Test00123_1.thu_flg = 9925;
      Test00123_1.fri_flg = 9926;
      Test00123_1.sat_flg = 9927;
      Test00123_1.member_qty = 9928;
      Test00123_1.limit_cnt = 9929;
      Test00123_1.stop_flg = 9930;
      Test00123_1.trends_typ = 9931;
      Test00123_1.dsc_flg = 9932;
      Test00123_1.stm_prc = 9933;
      Test00123_1.stm_prc2 = 9934;
      Test00123_1.stm_prc3 = 9935;
      Test00123_1.stm_prc4 = 9936;
      Test00123_1.stm_prc5 = 9937;
      Test00123_1.mstm_prc = 9938;
      Test00123_1.mstm_prc2 = 9939;
      Test00123_1.mstm_prc3 = 9940;
      Test00123_1.mstm_prc4 = 9941;
      Test00123_1.mstm_prc5 = 9942;
      Test00123_1.div_cd = 9943;
      Test00123_1.promo_ext_id = 'abc44';
      Test00123_1.ins_datetime = 'abc45';
      Test00123_1.upd_datetime = 'abc46';
      Test00123_1.status = 9947;
      Test00123_1.send_flg = 9948;
      Test00123_1.upd_user = 9949;
      Test00123_1.upd_system = 9950;
      Test00123_1.date_flg1 = 9951;
      Test00123_1.date_flg2 = 9952;
      Test00123_1.date_flg3 = 9953;
      Test00123_1.date_flg4 = 9954;
      Test00123_1.date_flg5 = 9955;

      //selectAllDataをして件数取得。
      List<SStmschMst> Test00123_AllRtn = await db.selectAllData(Test00123_1);
      int count = Test00123_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00123_1);

      //データ取得に必要なオブジェクトを用意
      SStmschMst Test00123_2 = SStmschMst();
      //Keyの値を設定する
      Test00123_2.comp_cd = 9912;
      Test00123_2.stre_cd = 9913;
      Test00123_2.plan_cd = 9914;
      Test00123_2.stm_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SStmschMst? Test00123_Rtn = await db.selectDataByPrimaryKey(Test00123_2);
      //取得行がない場合、nullが返ってきます
      if (Test00123_Rtn == null) {
        print('\n********** 異常発生：00123_SStmschMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00123_Rtn?.comp_cd,9912);
        expect(Test00123_Rtn?.stre_cd,9913);
        expect(Test00123_Rtn?.plan_cd,9914);
        expect(Test00123_Rtn?.stm_cd,9915);
        expect(Test00123_Rtn?.name,'abc16');
        expect(Test00123_Rtn?.short_name,'abc17');
        expect(Test00123_Rtn?.start_datetime,'abc18');
        expect(Test00123_Rtn?.end_datetime,'abc19');
        expect(Test00123_Rtn?.timesch_flg,9920);
        expect(Test00123_Rtn?.sun_flg,9921);
        expect(Test00123_Rtn?.mon_flg,9922);
        expect(Test00123_Rtn?.tue_flg,9923);
        expect(Test00123_Rtn?.wed_flg,9924);
        expect(Test00123_Rtn?.thu_flg,9925);
        expect(Test00123_Rtn?.fri_flg,9926);
        expect(Test00123_Rtn?.sat_flg,9927);
        expect(Test00123_Rtn?.member_qty,9928);
        expect(Test00123_Rtn?.limit_cnt,9929);
        expect(Test00123_Rtn?.stop_flg,9930);
        expect(Test00123_Rtn?.trends_typ,9931);
        expect(Test00123_Rtn?.dsc_flg,9932);
        expect(Test00123_Rtn?.stm_prc,9933);
        expect(Test00123_Rtn?.stm_prc2,9934);
        expect(Test00123_Rtn?.stm_prc3,9935);
        expect(Test00123_Rtn?.stm_prc4,9936);
        expect(Test00123_Rtn?.stm_prc5,9937);
        expect(Test00123_Rtn?.mstm_prc,9938);
        expect(Test00123_Rtn?.mstm_prc2,9939);
        expect(Test00123_Rtn?.mstm_prc3,9940);
        expect(Test00123_Rtn?.mstm_prc4,9941);
        expect(Test00123_Rtn?.mstm_prc5,9942);
        expect(Test00123_Rtn?.div_cd,9943);
        expect(Test00123_Rtn?.promo_ext_id,'abc44');
        expect(Test00123_Rtn?.ins_datetime,'abc45');
        expect(Test00123_Rtn?.upd_datetime,'abc46');
        expect(Test00123_Rtn?.status,9947);
        expect(Test00123_Rtn?.send_flg,9948);
        expect(Test00123_Rtn?.upd_user,9949);
        expect(Test00123_Rtn?.upd_system,9950);
        expect(Test00123_Rtn?.date_flg1,9951);
        expect(Test00123_Rtn?.date_flg2,9952);
        expect(Test00123_Rtn?.date_flg3,9953);
        expect(Test00123_Rtn?.date_flg4,9954);
        expect(Test00123_Rtn?.date_flg5,9955);
      }

      //selectAllDataをして件数取得。
      List<SStmschMst> Test00123_AllRtn2 = await db.selectAllData(Test00123_1);
      int count2 = Test00123_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00123_1);
      print('********** テスト終了：00123_SStmschMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00124 : SStmitemMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00124_SStmitemMst_01', () async {
      print('\n********** テスト実行：00124_SStmitemMst_01 **********');
      SStmitemMst Test00124_1 = SStmitemMst();
      Test00124_1.comp_cd = 9912;
      Test00124_1.stre_cd = 9913;
      Test00124_1.plan_cd = 9914;
      Test00124_1.stm_cd = 9915;
      Test00124_1.plu_cd = 'abc16';
      Test00124_1.grpno = 9917;
      Test00124_1.stm_qty = 9918;
      Test00124_1.showorder = 9919;
      Test00124_1.poppy_flg = 9920;
      Test00124_1.stop_flg = 9921;
      Test00124_1.promo_ext_id = 'abc22';
      Test00124_1.ins_datetime = 'abc23';
      Test00124_1.upd_datetime = 'abc24';
      Test00124_1.status = 9925;
      Test00124_1.send_flg = 9926;
      Test00124_1.upd_user = 9927;
      Test00124_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<SStmitemMst> Test00124_AllRtn = await db.selectAllData(Test00124_1);
      int count = Test00124_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00124_1);

      //データ取得に必要なオブジェクトを用意
      SStmitemMst Test00124_2 = SStmitemMst();
      //Keyの値を設定する
      Test00124_2.comp_cd = 9912;
      Test00124_2.stre_cd = 9913;
      Test00124_2.plan_cd = 9914;
      Test00124_2.stm_cd = 9915;
      Test00124_2.plu_cd = 'abc16';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SStmitemMst? Test00124_Rtn = await db.selectDataByPrimaryKey(Test00124_2);
      //取得行がない場合、nullが返ってきます
      if (Test00124_Rtn == null) {
        print('\n********** 異常発生：00124_SStmitemMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00124_Rtn?.comp_cd,9912);
        expect(Test00124_Rtn?.stre_cd,9913);
        expect(Test00124_Rtn?.plan_cd,9914);
        expect(Test00124_Rtn?.stm_cd,9915);
        expect(Test00124_Rtn?.plu_cd,'abc16');
        expect(Test00124_Rtn?.grpno,9917);
        expect(Test00124_Rtn?.stm_qty,9918);
        expect(Test00124_Rtn?.showorder,9919);
        expect(Test00124_Rtn?.poppy_flg,9920);
        expect(Test00124_Rtn?.stop_flg,9921);
        expect(Test00124_Rtn?.promo_ext_id,'abc22');
        expect(Test00124_Rtn?.ins_datetime,'abc23');
        expect(Test00124_Rtn?.upd_datetime,'abc24');
        expect(Test00124_Rtn?.status,9925);
        expect(Test00124_Rtn?.send_flg,9926);
        expect(Test00124_Rtn?.upd_user,9927);
        expect(Test00124_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<SStmitemMst> Test00124_AllRtn2 = await db.selectAllData(Test00124_1);
      int count2 = Test00124_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00124_1);
      print('********** テスト終了：00124_SStmitemMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00125 : SPluPointMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00125_SPluPointMst_01', () async {
      print('\n********** テスト実行：00125_SPluPointMst_01 **********');
      SPluPointMst Test00125_1 = SPluPointMst();
      Test00125_1.comp_cd = 9912;
      Test00125_1.stre_cd = 9913;
      Test00125_1.plan_cd = 9914;
      Test00125_1.plusch_cd = 9915;
      Test00125_1.plu_cd = 'abc16';
      Test00125_1.name = 'abc17';
      Test00125_1.short_name = 'abc18';
      Test00125_1.showorder = 9919;
      Test00125_1.point_add = 9920;
      Test00125_1.prom_cd1 = 9921;
      Test00125_1.prom_cd2 = 9922;
      Test00125_1.prom_cd3 = 9923;
      Test00125_1.start_datetime = 'abc24';
      Test00125_1.end_datetime = 'abc25';
      Test00125_1.timesch_flg = 9926;
      Test00125_1.sun_flg = 9927;
      Test00125_1.mon_flg = 9928;
      Test00125_1.tue_flg = 9929;
      Test00125_1.wed_flg = 9930;
      Test00125_1.thu_flg = 9931;
      Test00125_1.fri_flg = 9932;
      Test00125_1.sat_flg = 9933;
      Test00125_1.stop_flg = 9934;
      Test00125_1.trends_typ = 9935;
      Test00125_1.acct_cd = 9936;
      Test00125_1.promo_ext_id = 'abc37';
      Test00125_1.ins_datetime = 'abc38';
      Test00125_1.upd_datetime = 'abc39';
      Test00125_1.status = 9940;
      Test00125_1.send_flg = 9941;
      Test00125_1.upd_user = 9942;
      Test00125_1.upd_system = 9943;
      Test00125_1.tnycls_cd = 9944;
      Test00125_1.plu_cls_flg = 9945;
      Test00125_1.pts_type = 9946;
      Test00125_1.pts_rate = 1.247;
      Test00125_1.lrgcls_cd = 9948;
      Test00125_1.mdlcls_cd = 9949;
      Test00125_1.smlcls_cd = 9950;

      //selectAllDataをして件数取得。
      List<SPluPointMst> Test00125_AllRtn = await db.selectAllData(Test00125_1);
      int count = Test00125_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00125_1);

      //データ取得に必要なオブジェクトを用意
      SPluPointMst Test00125_2 = SPluPointMst();
      //Keyの値を設定する
      Test00125_2.comp_cd = 9912;
      Test00125_2.stre_cd = 9913;
      Test00125_2.plan_cd = 9914;
      Test00125_2.plusch_cd = 9915;
      Test00125_2.plu_cd = 'abc16';
      Test00125_2.tnycls_cd = 9944;
      Test00125_2.plu_cls_flg = 9945;
      Test00125_2.pts_type = 9946;
      Test00125_2.lrgcls_cd = 9948;
      Test00125_2.mdlcls_cd = 9949;
      Test00125_2.smlcls_cd = 9950;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SPluPointMst? Test00125_Rtn = await db.selectDataByPrimaryKey(Test00125_2);
      //取得行がない場合、nullが返ってきます
      if (Test00125_Rtn == null) {
        print('\n********** 異常発生：00125_SPluPointMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00125_Rtn?.comp_cd,9912);
        expect(Test00125_Rtn?.stre_cd,9913);
        expect(Test00125_Rtn?.plan_cd,9914);
        expect(Test00125_Rtn?.plusch_cd,9915);
        expect(Test00125_Rtn?.plu_cd,'abc16');
        expect(Test00125_Rtn?.name,'abc17');
        expect(Test00125_Rtn?.short_name,'abc18');
        expect(Test00125_Rtn?.showorder,9919);
        expect(Test00125_Rtn?.point_add,9920);
        expect(Test00125_Rtn?.prom_cd1,9921);
        expect(Test00125_Rtn?.prom_cd2,9922);
        expect(Test00125_Rtn?.prom_cd3,9923);
        expect(Test00125_Rtn?.start_datetime,'abc24');
        expect(Test00125_Rtn?.end_datetime,'abc25');
        expect(Test00125_Rtn?.timesch_flg,9926);
        expect(Test00125_Rtn?.sun_flg,9927);
        expect(Test00125_Rtn?.mon_flg,9928);
        expect(Test00125_Rtn?.tue_flg,9929);
        expect(Test00125_Rtn?.wed_flg,9930);
        expect(Test00125_Rtn?.thu_flg,9931);
        expect(Test00125_Rtn?.fri_flg,9932);
        expect(Test00125_Rtn?.sat_flg,9933);
        expect(Test00125_Rtn?.stop_flg,9934);
        expect(Test00125_Rtn?.trends_typ,9935);
        expect(Test00125_Rtn?.acct_cd,9936);
        expect(Test00125_Rtn?.promo_ext_id,'abc37');
        expect(Test00125_Rtn?.ins_datetime,'abc38');
        expect(Test00125_Rtn?.upd_datetime,'abc39');
        expect(Test00125_Rtn?.status,9940);
        expect(Test00125_Rtn?.send_flg,9941);
        expect(Test00125_Rtn?.upd_user,9942);
        expect(Test00125_Rtn?.upd_system,9943);
        expect(Test00125_Rtn?.tnycls_cd,9944);
        expect(Test00125_Rtn?.plu_cls_flg,9945);
        expect(Test00125_Rtn?.pts_type,9946);
        expect(Test00125_Rtn?.pts_rate,1.247);
        expect(Test00125_Rtn?.lrgcls_cd,9948);
        expect(Test00125_Rtn?.mdlcls_cd,9949);
        expect(Test00125_Rtn?.smlcls_cd,9950);
      }

      //selectAllDataをして件数取得。
      List<SPluPointMst> Test00125_AllRtn2 = await db.selectAllData(Test00125_1);
      int count2 = Test00125_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00125_1);
      print('********** テスト終了：00125_SPluPointMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00126 : SSubtschMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00126_SSubtschMst_01', () async {
      print('\n********** テスト実行：00126_SSubtschMst_01 **********');
      SSubtschMst Test00126_1 = SSubtschMst();
      Test00126_1.comp_cd = 9912;
      Test00126_1.stre_cd = 9913;
      Test00126_1.plan_cd = 9914;
      Test00126_1.subt_cd = 9915;
      Test00126_1.name = 'abc16';
      Test00126_1.short_name = 'abc17';
      Test00126_1.svs_typ = 9918;
      Test00126_1.dsc_typ = 9919;
      Test00126_1.dsc_prc = 9920;
      Test00126_1.mdsc_prc = 9921;
      Test00126_1.stl_form_amt = 9922;
      Test00126_1.start_datetime = 'abc23';
      Test00126_1.end_datetime = 'abc24';
      Test00126_1.timesch_flg = 9925;
      Test00126_1.sun_flg = 9926;
      Test00126_1.mon_flg = 9927;
      Test00126_1.tue_flg = 9928;
      Test00126_1.wed_flg = 9929;
      Test00126_1.thu_flg = 9930;
      Test00126_1.fri_flg = 9931;
      Test00126_1.sat_flg = 9932;
      Test00126_1.trends_typ = 9933;
      Test00126_1.stop_flg = 9934;
      Test00126_1.div_cd = 9935;
      Test00126_1.promo_ext_id = 'abc36';
      Test00126_1.ins_datetime = 'abc37';
      Test00126_1.upd_datetime = 'abc38';
      Test00126_1.status = 9939;
      Test00126_1.send_flg = 9940;
      Test00126_1.upd_user = 9941;
      Test00126_1.upd_system = 9942;

      //selectAllDataをして件数取得。
      List<SSubtschMst> Test00126_AllRtn = await db.selectAllData(Test00126_1);
      int count = Test00126_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00126_1);

      //データ取得に必要なオブジェクトを用意
      SSubtschMst Test00126_2 = SSubtschMst();
      //Keyの値を設定する
      Test00126_2.comp_cd = 9912;
      Test00126_2.stre_cd = 9913;
      Test00126_2.plan_cd = 9914;
      Test00126_2.subt_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SSubtschMst? Test00126_Rtn = await db.selectDataByPrimaryKey(Test00126_2);
      //取得行がない場合、nullが返ってきます
      if (Test00126_Rtn == null) {
        print('\n********** 異常発生：00126_SSubtschMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00126_Rtn?.comp_cd,9912);
        expect(Test00126_Rtn?.stre_cd,9913);
        expect(Test00126_Rtn?.plan_cd,9914);
        expect(Test00126_Rtn?.subt_cd,9915);
        expect(Test00126_Rtn?.name,'abc16');
        expect(Test00126_Rtn?.short_name,'abc17');
        expect(Test00126_Rtn?.svs_typ,9918);
        expect(Test00126_Rtn?.dsc_typ,9919);
        expect(Test00126_Rtn?.dsc_prc,9920);
        expect(Test00126_Rtn?.mdsc_prc,9921);
        expect(Test00126_Rtn?.stl_form_amt,9922);
        expect(Test00126_Rtn?.start_datetime,'abc23');
        expect(Test00126_Rtn?.end_datetime,'abc24');
        expect(Test00126_Rtn?.timesch_flg,9925);
        expect(Test00126_Rtn?.sun_flg,9926);
        expect(Test00126_Rtn?.mon_flg,9927);
        expect(Test00126_Rtn?.tue_flg,9928);
        expect(Test00126_Rtn?.wed_flg,9929);
        expect(Test00126_Rtn?.thu_flg,9930);
        expect(Test00126_Rtn?.fri_flg,9931);
        expect(Test00126_Rtn?.sat_flg,9932);
        expect(Test00126_Rtn?.trends_typ,9933);
        expect(Test00126_Rtn?.stop_flg,9934);
        expect(Test00126_Rtn?.div_cd,9935);
        expect(Test00126_Rtn?.promo_ext_id,'abc36');
        expect(Test00126_Rtn?.ins_datetime,'abc37');
        expect(Test00126_Rtn?.upd_datetime,'abc38');
        expect(Test00126_Rtn?.status,9939);
        expect(Test00126_Rtn?.send_flg,9940);
        expect(Test00126_Rtn?.upd_user,9941);
        expect(Test00126_Rtn?.upd_system,9942);
      }

      //selectAllDataをして件数取得。
      List<SSubtschMst> Test00126_AllRtn2 = await db.selectAllData(Test00126_1);
      int count2 = Test00126_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00126_1);
      print('********** テスト終了：00126_SSubtschMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00127 : SClsschMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00127_SClsschMst_01', () async {
      print('\n********** テスト実行：00127_SClsschMst_01 **********');
      SClsschMst Test00127_1 = SClsschMst();
      Test00127_1.comp_cd = 9912;
      Test00127_1.stre_cd = 9913;
      Test00127_1.plan_cd = 9914;
      Test00127_1.sch_cd = 9915;
      Test00127_1.lrgcls_cd = 9916;
      Test00127_1.mdlcls_cd = 9917;
      Test00127_1.smlcls_cd = 9918;
      Test00127_1.tnycls_cd = 9919;
      Test00127_1.svs_class = 9920;
      Test00127_1.name = 'abc21';
      Test00127_1.short_name = 'abc22';
      Test00127_1.svs_typ = 9923;
      Test00127_1.dsc_typ = 9924;
      Test00127_1.dsc_prc = 9925;
      Test00127_1.mdsc_prc = 9926;
      Test00127_1.start_datetime = 'abc27';
      Test00127_1.end_datetime = 'abc28';
      Test00127_1.timesch_flg = 9929;
      Test00127_1.sun_flg = 9930;
      Test00127_1.mon_flg = 9931;
      Test00127_1.tue_flg = 9932;
      Test00127_1.wed_flg = 9933;
      Test00127_1.thu_flg = 9934;
      Test00127_1.fri_flg = 9935;
      Test00127_1.sat_flg = 9936;
      Test00127_1.trends_typ = 9937;
      Test00127_1.stop_flg = 9938;
      Test00127_1.div_cd = 9939;
      Test00127_1.promo_ext_id = 'abc40';
      Test00127_1.ins_datetime = 'abc41';
      Test00127_1.upd_datetime = 'abc42';
      Test00127_1.status = 9943;
      Test00127_1.send_flg = 9944;
      Test00127_1.upd_user = 9945;
      Test00127_1.upd_system = 9946;

      //selectAllDataをして件数取得。
      List<SClsschMst> Test00127_AllRtn = await db.selectAllData(Test00127_1);
      int count = Test00127_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00127_1);

      //データ取得に必要なオブジェクトを用意
      SClsschMst Test00127_2 = SClsschMst();
      //Keyの値を設定する
      Test00127_2.comp_cd = 9912;
      Test00127_2.stre_cd = 9913;
      Test00127_2.plan_cd = 9914;
      Test00127_2.sch_cd = 9915;
      Test00127_2.lrgcls_cd = 9916;
      Test00127_2.mdlcls_cd = 9917;
      Test00127_2.smlcls_cd = 9918;
      Test00127_2.tnycls_cd = 9919;
      Test00127_2.svs_class = 9920;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SClsschMst? Test00127_Rtn = await db.selectDataByPrimaryKey(Test00127_2);
      //取得行がない場合、nullが返ってきます
      if (Test00127_Rtn == null) {
        print('\n********** 異常発生：00127_SClsschMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00127_Rtn?.comp_cd,9912);
        expect(Test00127_Rtn?.stre_cd,9913);
        expect(Test00127_Rtn?.plan_cd,9914);
        expect(Test00127_Rtn?.sch_cd,9915);
        expect(Test00127_Rtn?.lrgcls_cd,9916);
        expect(Test00127_Rtn?.mdlcls_cd,9917);
        expect(Test00127_Rtn?.smlcls_cd,9918);
        expect(Test00127_Rtn?.tnycls_cd,9919);
        expect(Test00127_Rtn?.svs_class,9920);
        expect(Test00127_Rtn?.name,'abc21');
        expect(Test00127_Rtn?.short_name,'abc22');
        expect(Test00127_Rtn?.svs_typ,9923);
        expect(Test00127_Rtn?.dsc_typ,9924);
        expect(Test00127_Rtn?.dsc_prc,9925);
        expect(Test00127_Rtn?.mdsc_prc,9926);
        expect(Test00127_Rtn?.start_datetime,'abc27');
        expect(Test00127_Rtn?.end_datetime,'abc28');
        expect(Test00127_Rtn?.timesch_flg,9929);
        expect(Test00127_Rtn?.sun_flg,9930);
        expect(Test00127_Rtn?.mon_flg,9931);
        expect(Test00127_Rtn?.tue_flg,9932);
        expect(Test00127_Rtn?.wed_flg,9933);
        expect(Test00127_Rtn?.thu_flg,9934);
        expect(Test00127_Rtn?.fri_flg,9935);
        expect(Test00127_Rtn?.sat_flg,9936);
        expect(Test00127_Rtn?.trends_typ,9937);
        expect(Test00127_Rtn?.stop_flg,9938);
        expect(Test00127_Rtn?.div_cd,9939);
        expect(Test00127_Rtn?.promo_ext_id,'abc40');
        expect(Test00127_Rtn?.ins_datetime,'abc41');
        expect(Test00127_Rtn?.upd_datetime,'abc42');
        expect(Test00127_Rtn?.status,9943);
        expect(Test00127_Rtn?.send_flg,9944);
        expect(Test00127_Rtn?.upd_user,9945);
        expect(Test00127_Rtn?.upd_system,9946);
      }

      //selectAllDataをして件数取得。
      List<SClsschMst> Test00127_AllRtn2 = await db.selectAllData(Test00127_1);
      int count2 = Test00127_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00127_1);
      print('********** テスト終了：00127_SClsschMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00128 : SSvsSchMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00128_SSvsSchMst_01', () async {
      print('\n********** テスト実行：00128_SSvsSchMst_01 **********');
      SSvsSchMst Test00128_1 = SSvsSchMst();
      Test00128_1.comp_cd = 9912;
      Test00128_1.stre_cd = 9913;
      Test00128_1.plan_cd = 9914;
      Test00128_1.svs_cls_sch_cd = 9915;
      Test00128_1.svs_cls_cd = 9916;
      Test00128_1.svs_cls_sch_name = 'abc17';
      Test00128_1.point_add_magn = 1.218;
      Test00128_1.point_add_mem_typ = 9919;
      Test00128_1.f_data1 = 1.220;
      Test00128_1.s_data1 = 9921;
      Test00128_1.s_data2 = 9922;
      Test00128_1.s_data3 = 9923;
      Test00128_1.start_datetime = 'abc24';
      Test00128_1.end_datetime = 'abc25';
      Test00128_1.timesch_flg = 9926;
      Test00128_1.sun_flg = 9927;
      Test00128_1.mon_flg = 9928;
      Test00128_1.tue_flg = 9929;
      Test00128_1.wed_flg = 9930;
      Test00128_1.thu_flg = 9931;
      Test00128_1.fri_flg = 9932;
      Test00128_1.sat_flg = 9933;
      Test00128_1.stop_flg = 9934;
      Test00128_1.ins_datetime = 'abc35';
      Test00128_1.upd_datetime = 'abc36';
      Test00128_1.status = 9937;
      Test00128_1.send_flg = 9938;
      Test00128_1.upd_user = 9939;
      Test00128_1.upd_system = 9940;
      Test00128_1.acct_cd = 9941;

      //selectAllDataをして件数取得。
      List<SSvsSchMst> Test00128_AllRtn = await db.selectAllData(Test00128_1);
      int count = Test00128_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00128_1);

      //データ取得に必要なオブジェクトを用意
      SSvsSchMst Test00128_2 = SSvsSchMst();
      //Keyの値を設定する
      Test00128_2.comp_cd = 9912;
      Test00128_2.stre_cd = 9913;
      Test00128_2.plan_cd = 9914;
      Test00128_2.svs_cls_sch_cd = 9915;
      Test00128_2.svs_cls_cd = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SSvsSchMst? Test00128_Rtn = await db.selectDataByPrimaryKey(Test00128_2);
      //取得行がない場合、nullが返ってきます
      if (Test00128_Rtn == null) {
        print('\n********** 異常発生：00128_SSvsSchMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00128_Rtn?.comp_cd,9912);
        expect(Test00128_Rtn?.stre_cd,9913);
        expect(Test00128_Rtn?.plan_cd,9914);
        expect(Test00128_Rtn?.svs_cls_sch_cd,9915);
        expect(Test00128_Rtn?.svs_cls_cd,9916);
        expect(Test00128_Rtn?.svs_cls_sch_name,'abc17');
        expect(Test00128_Rtn?.point_add_magn,1.218);
        expect(Test00128_Rtn?.point_add_mem_typ,9919);
        expect(Test00128_Rtn?.f_data1,1.220);
        expect(Test00128_Rtn?.s_data1,9921);
        expect(Test00128_Rtn?.s_data2,9922);
        expect(Test00128_Rtn?.s_data3,9923);
        expect(Test00128_Rtn?.start_datetime,'abc24');
        expect(Test00128_Rtn?.end_datetime,'abc25');
        expect(Test00128_Rtn?.timesch_flg,9926);
        expect(Test00128_Rtn?.sun_flg,9927);
        expect(Test00128_Rtn?.mon_flg,9928);
        expect(Test00128_Rtn?.tue_flg,9929);
        expect(Test00128_Rtn?.wed_flg,9930);
        expect(Test00128_Rtn?.thu_flg,9931);
        expect(Test00128_Rtn?.fri_flg,9932);
        expect(Test00128_Rtn?.sat_flg,9933);
        expect(Test00128_Rtn?.stop_flg,9934);
        expect(Test00128_Rtn?.ins_datetime,'abc35');
        expect(Test00128_Rtn?.upd_datetime,'abc36');
        expect(Test00128_Rtn?.status,9937);
        expect(Test00128_Rtn?.send_flg,9938);
        expect(Test00128_Rtn?.upd_user,9939);
        expect(Test00128_Rtn?.upd_system,9940);
        expect(Test00128_Rtn?.acct_cd,9941);
      }

      //selectAllDataをして件数取得。
      List<SSvsSchMst> Test00128_AllRtn2 = await db.selectAllData(Test00128_1);
      int count2 = Test00128_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00128_1);
      print('********** テスト終了：00128_SSvsSchMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00129 : CAcctMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00129_CAcctMst_01', () async {
      print('\n********** テスト実行：00129_CAcctMst_01 **********');
      CAcctMst Test00129_1 = CAcctMst();
      Test00129_1.acct_cd = 9912;
      Test00129_1.mthr_acct_cd = 9913;
      Test00129_1.acct_name = 'abc14';
      Test00129_1.rcpt_prn_flg = 9915;
      Test00129_1.prn_seq_no = 9916;
      Test00129_1.acct_typ = 9917;
      Test00129_1.start_date = 'abc18';
      Test00129_1.end_date = 'abc19';
      Test00129_1.plus_end_date = 'abc20';
      Test00129_1.ins_datetime = 'abc21';
      Test00129_1.upd_datetime = 'abc22';
      Test00129_1.status = 9923;
      Test00129_1.send_flg = 9924;
      Test00129_1.upd_user = 9925;
      Test00129_1.upd_system = 9926;
      Test00129_1.comp_cd = 9927;
      Test00129_1.stre_cd = 9928;
      Test00129_1.acct_cal_typ = 9929;

      //selectAllDataをして件数取得。
      List<CAcctMst> Test00129_AllRtn = await db.selectAllData(Test00129_1);
      int count = Test00129_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00129_1);

      //データ取得に必要なオブジェクトを用意
      CAcctMst Test00129_2 = CAcctMst();
      //Keyの値を設定する
      Test00129_2.acct_cd = 9912;
      Test00129_2.comp_cd = 9927;
      Test00129_2.stre_cd = 9928;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CAcctMst? Test00129_Rtn = await db.selectDataByPrimaryKey(Test00129_2);
      //取得行がない場合、nullが返ってきます
      if (Test00129_Rtn == null) {
        print('\n********** 異常発生：00129_CAcctMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00129_Rtn?.acct_cd,9912);
        expect(Test00129_Rtn?.mthr_acct_cd,9913);
        expect(Test00129_Rtn?.acct_name,'abc14');
        expect(Test00129_Rtn?.rcpt_prn_flg,9915);
        expect(Test00129_Rtn?.prn_seq_no,9916);
        expect(Test00129_Rtn?.acct_typ,9917);
        expect(Test00129_Rtn?.start_date,'abc18');
        expect(Test00129_Rtn?.end_date,'abc19');
        expect(Test00129_Rtn?.plus_end_date,'abc20');
        expect(Test00129_Rtn?.ins_datetime,'abc21');
        expect(Test00129_Rtn?.upd_datetime,'abc22');
        expect(Test00129_Rtn?.status,9923);
        expect(Test00129_Rtn?.send_flg,9924);
        expect(Test00129_Rtn?.upd_user,9925);
        expect(Test00129_Rtn?.upd_system,9926);
        expect(Test00129_Rtn?.comp_cd,9927);
        expect(Test00129_Rtn?.stre_cd,9928);
        expect(Test00129_Rtn?.acct_cal_typ,9929);
      }

      //selectAllDataをして件数取得。
      List<CAcctMst> Test00129_AllRtn2 = await db.selectAllData(Test00129_1);
      int count2 = Test00129_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00129_1);
      print('********** テスト終了：00129_CAcctMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00130 : CCpnhdrMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00130_CCpnhdrMst_01', () async {
      print('\n********** テスト実行：00130_CCpnhdrMst_01 **********');
      CCpnhdrMst Test00130_1 = CCpnhdrMst();
      Test00130_1.cpn_id = 9912;
      Test00130_1.comp_cd = 9913;
      Test00130_1.stre_cd = 9914;
      Test00130_1.prn_stre_name = 'abc15';
      Test00130_1.prn_time = 'abc16';
      Test00130_1.start_date = 'abc17';
      Test00130_1.end_date = 'abc18';
      Test00130_1.template_id = 'abc19';
      Test00130_1.pict_path = 'abc20';
      Test00130_1.notes = 'abc21';
      Test00130_1.line = 9922;
      Test00130_1.stop_flg = 9923;
      Test00130_1.ins_datetime = 'abc24';
      Test00130_1.upd_datetime = 'abc25';
      Test00130_1.status = 9926;
      Test00130_1.send_flg = 9927;
      Test00130_1.upd_user = 9928;
      Test00130_1.upd_system = 9929;
      Test00130_1.all_cust_flg = 9930;
      Test00130_1.prn_val = 9931;
      Test00130_1.val_flg = 9932;
      Test00130_1.prn_qty = 9933;
      Test00130_1.tran_qty = 9934;
      Test00130_1.day_qty = 9935;
      Test00130_1.ttl_qty = 9936;
      Test00130_1.reward_prom_cd = 9937;
      Test00130_1.linked_prom_cd = 9938;
      Test00130_1.rec_srch_id = 9939;
      Test00130_1.prn_upp_lim = 9940;
      Test00130_1.ref_typ = 9941;
      Test00130_1.stp_acct_cd = 9942;
      Test00130_1.stp_red_amt = 9943;
      Test00130_1.sng_prn_flg = 9944;
      Test00130_1.cust_kind_flg = 9945;
      Test00130_1.timesch_flg = 9946;
      Test00130_1.sun_flg = 9947;
      Test00130_1.mon_flg = 9948;
      Test00130_1.tue_flg = 9949;
      Test00130_1.wed_flg = 9950;
      Test00130_1.thu_flg = 9951;
      Test00130_1.fri_flg = 9952;
      Test00130_1.sat_flg = 9953;
      Test00130_1.date_flg1 = 9954;
      Test00130_1.date_flg2 = 9955;
      Test00130_1.date_flg3 = 9956;
      Test00130_1.date_flg4 = 9957;
      Test00130_1.date_flg5 = 9958;
      Test00130_1.stp_cpn_id = 9959;
      Test00130_1.cust_kind_trgt = 'abc60';
      Test00130_1.ref_typ2 = 9961;
      Test00130_1.cust_card_kind = 9962;
      Test00130_1.n_custom1 = 9963;
      Test00130_1.n_custom2 = 9964;
      Test00130_1.n_custom3 = 9965;
      Test00130_1.n_custom4 = 9966;
      Test00130_1.n_custom5 = 9967;
      Test00130_1.n_custom6 = 9968;
      Test00130_1.n_custom7 = 9969;
      Test00130_1.n_custom8 = 9970;
      Test00130_1.s_custom1 = 9971;
      Test00130_1.s_custom2 = 9972;
      Test00130_1.s_custom3 = 9973;
      Test00130_1.s_custom4 = 9974;
      Test00130_1.s_custom5 = 9975;
      Test00130_1.s_custom6 = 9976;
      Test00130_1.s_custom7 = 9977;
      Test00130_1.s_custom8 = 9978;
      Test00130_1.c_custom1 = 'abc79';
      Test00130_1.c_custom2 = 'abc80';
      Test00130_1.c_custom3 = 'abc81';
      Test00130_1.c_custom4 = 'abc82';
      Test00130_1.d_custom1 = 'abc83';
      Test00130_1.d_custom2 = 'abc84';
      Test00130_1.d_custom3 = 'abc85';
      Test00130_1.d_custom4 = 'abc86';

      //selectAllDataをして件数取得。
      List<CCpnhdrMst> Test00130_AllRtn = await db.selectAllData(Test00130_1);
      int count = Test00130_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00130_1);

      //データ取得に必要なオブジェクトを用意
      CCpnhdrMst Test00130_2 = CCpnhdrMst();
      //Keyの値を設定する
      Test00130_2.cpn_id = 9912;
      Test00130_2.comp_cd = 9913;
      Test00130_2.stre_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCpnhdrMst? Test00130_Rtn = await db.selectDataByPrimaryKey(Test00130_2);
      //取得行がない場合、nullが返ってきます
      if (Test00130_Rtn == null) {
        print('\n********** 異常発生：00130_CCpnhdrMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00130_Rtn?.cpn_id,9912);
        expect(Test00130_Rtn?.comp_cd,9913);
        expect(Test00130_Rtn?.stre_cd,9914);
        expect(Test00130_Rtn?.prn_stre_name,'abc15');
        expect(Test00130_Rtn?.prn_time,'abc16');
        expect(Test00130_Rtn?.start_date,'abc17');
        expect(Test00130_Rtn?.end_date,'abc18');
        expect(Test00130_Rtn?.template_id,'abc19');
        expect(Test00130_Rtn?.pict_path,'abc20');
        expect(Test00130_Rtn?.notes,'abc21');
        expect(Test00130_Rtn?.line,9922);
        expect(Test00130_Rtn?.stop_flg,9923);
        expect(Test00130_Rtn?.ins_datetime,'abc24');
        expect(Test00130_Rtn?.upd_datetime,'abc25');
        expect(Test00130_Rtn?.status,9926);
        expect(Test00130_Rtn?.send_flg,9927);
        expect(Test00130_Rtn?.upd_user,9928);
        expect(Test00130_Rtn?.upd_system,9929);
        expect(Test00130_Rtn?.all_cust_flg,9930);
        expect(Test00130_Rtn?.prn_val,9931);
        expect(Test00130_Rtn?.val_flg,9932);
        expect(Test00130_Rtn?.prn_qty,9933);
        expect(Test00130_Rtn?.tran_qty,9934);
        expect(Test00130_Rtn?.day_qty,9935);
        expect(Test00130_Rtn?.ttl_qty,9936);
        expect(Test00130_Rtn?.reward_prom_cd,9937);
        expect(Test00130_Rtn?.linked_prom_cd,9938);
        expect(Test00130_Rtn?.rec_srch_id,9939);
        expect(Test00130_Rtn?.prn_upp_lim,9940);
        expect(Test00130_Rtn?.ref_typ,9941);
        expect(Test00130_Rtn?.stp_acct_cd,9942);
        expect(Test00130_Rtn?.stp_red_amt,9943);
        expect(Test00130_Rtn?.sng_prn_flg,9944);
        expect(Test00130_Rtn?.cust_kind_flg,9945);
        expect(Test00130_Rtn?.timesch_flg,9946);
        expect(Test00130_Rtn?.sun_flg,9947);
        expect(Test00130_Rtn?.mon_flg,9948);
        expect(Test00130_Rtn?.tue_flg,9949);
        expect(Test00130_Rtn?.wed_flg,9950);
        expect(Test00130_Rtn?.thu_flg,9951);
        expect(Test00130_Rtn?.fri_flg,9952);
        expect(Test00130_Rtn?.sat_flg,9953);
        expect(Test00130_Rtn?.date_flg1,9954);
        expect(Test00130_Rtn?.date_flg2,9955);
        expect(Test00130_Rtn?.date_flg3,9956);
        expect(Test00130_Rtn?.date_flg4,9957);
        expect(Test00130_Rtn?.date_flg5,9958);
        expect(Test00130_Rtn?.stp_cpn_id,9959);
        expect(Test00130_Rtn?.cust_kind_trgt,'abc60');
        expect(Test00130_Rtn?.ref_typ2,9961);
        expect(Test00130_Rtn?.cust_card_kind,9962);
        expect(Test00130_Rtn?.n_custom1,9963);
        expect(Test00130_Rtn?.n_custom2,9964);
        expect(Test00130_Rtn?.n_custom3,9965);
        expect(Test00130_Rtn?.n_custom4,9966);
        expect(Test00130_Rtn?.n_custom5,9967);
        expect(Test00130_Rtn?.n_custom6,9968);
        expect(Test00130_Rtn?.n_custom7,9969);
        expect(Test00130_Rtn?.n_custom8,9970);
        expect(Test00130_Rtn?.s_custom1,9971);
        expect(Test00130_Rtn?.s_custom2,9972);
        expect(Test00130_Rtn?.s_custom3,9973);
        expect(Test00130_Rtn?.s_custom4,9974);
        expect(Test00130_Rtn?.s_custom5,9975);
        expect(Test00130_Rtn?.s_custom6,9976);
        expect(Test00130_Rtn?.s_custom7,9977);
        expect(Test00130_Rtn?.s_custom8,9978);
        expect(Test00130_Rtn?.c_custom1,'abc79');
        expect(Test00130_Rtn?.c_custom2,'abc80');
        expect(Test00130_Rtn?.c_custom3,'abc81');
        expect(Test00130_Rtn?.c_custom4,'abc82');
        expect(Test00130_Rtn?.d_custom1,'abc83');
        expect(Test00130_Rtn?.d_custom2,'abc84');
        expect(Test00130_Rtn?.d_custom3,'abc85');
        expect(Test00130_Rtn?.d_custom4,'abc86');
      }

      //selectAllDataをして件数取得。
      List<CCpnhdrMst> Test00130_AllRtn2 = await db.selectAllData(Test00130_1);
      int count2 = Test00130_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00130_1);
      print('********** テスト終了：00130_CCpnhdrMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00131 : CCpnbdyMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00131_CCpnbdyMst_01', () async {
      print('\n********** テスト実行：00131_CCpnbdyMst_01 **********');
      CCpnbdyMst Test00131_1 = CCpnbdyMst();
      Test00131_1.plan_cd = 9912;
      Test00131_1.cpn_id = 9913;
      Test00131_1.cpn_content = 'abc14';
      Test00131_1.ins_datetime = 'abc15';
      Test00131_1.upd_datetime = 'abc16';
      Test00131_1.status = 9917;
      Test00131_1.send_flg = 9918;
      Test00131_1.upd_user = 9919;
      Test00131_1.upd_system = 9920;
      Test00131_1.comp_cd = 9921;

      //selectAllDataをして件数取得。
      List<CCpnbdyMst> Test00131_AllRtn = await db.selectAllData(Test00131_1);
      int count = Test00131_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00131_1);

      //データ取得に必要なオブジェクトを用意
      CCpnbdyMst Test00131_2 = CCpnbdyMst();
      //Keyの値を設定する
      Test00131_2.plan_cd = 9912;
      Test00131_2.comp_cd = 9921;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCpnbdyMst? Test00131_Rtn = await db.selectDataByPrimaryKey(Test00131_2);
      //取得行がない場合、nullが返ってきます
      if (Test00131_Rtn == null) {
        print('\n********** 異常発生：00131_CCpnbdyMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00131_Rtn?.plan_cd,9912);
        expect(Test00131_Rtn?.cpn_id,9913);
        expect(Test00131_Rtn?.cpn_content,'abc14');
        expect(Test00131_Rtn?.ins_datetime,'abc15');
        expect(Test00131_Rtn?.upd_datetime,'abc16');
        expect(Test00131_Rtn?.status,9917);
        expect(Test00131_Rtn?.send_flg,9918);
        expect(Test00131_Rtn?.upd_user,9919);
        expect(Test00131_Rtn?.upd_system,9920);
        expect(Test00131_Rtn?.comp_cd,9921);
      }

      //selectAllDataをして件数取得。
      List<CCpnbdyMst> Test00131_AllRtn2 = await db.selectAllData(Test00131_1);
      int count2 = Test00131_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00131_1);
      print('********** テスト終了：00131_CCpnbdyMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00132 : SCustCpnTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00132_SCustCpnTbl_01', () async {
      print('\n********** テスト実行：00132_SCustCpnTbl_01 **********');
      SCustCpnTbl Test00132_1 = SCustCpnTbl();
      Test00132_1.cust_no = 'abc12';
      Test00132_1.cpn_id = 9913;
      Test00132_1.comp_cd = 9914;
      Test00132_1.print_datetime = 'abc15';
      Test00132_1.cpn_data = 'abc16';
      Test00132_1.print_flg = 'abc17';
      Test00132_1.stop_flg = 9918;
      Test00132_1.prn_comp_cd = 9919;
      Test00132_1.prn_stre_cd = 9920;
      Test00132_1.prn_mac_no = 9921;
      Test00132_1.prn_staff_cd = 9922;
      Test00132_1.prn_datetime = 'abc23';
      Test00132_1.ins_datetime = 'abc24';
      Test00132_1.upd_datetime = 'abc25';
      Test00132_1.status = 9926;
      Test00132_1.send_flg = 9927;
      Test00132_1.upd_user = 9928;
      Test00132_1.upd_system = 9929;
      Test00132_1.tday_cnt = 9930;
      Test00132_1.total_cnt = 9931;

      //selectAllDataをして件数取得。
      List<SCustCpnTbl> Test00132_AllRtn = await db.selectAllData(Test00132_1);
      int count = Test00132_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00132_1);

      //データ取得に必要なオブジェクトを用意
      SCustCpnTbl Test00132_2 = SCustCpnTbl();
      //Keyの値を設定する
      Test00132_2.cust_no = 'abc12';
      Test00132_2.cpn_id = 9913;
      Test00132_2.comp_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SCustCpnTbl? Test00132_Rtn = await db.selectDataByPrimaryKey(Test00132_2);
      //取得行がない場合、nullが返ってきます
      if (Test00132_Rtn == null) {
        print('\n********** 異常発生：00132_SCustCpnTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00132_Rtn?.cust_no,'abc12');
        expect(Test00132_Rtn?.cpn_id,9913);
        expect(Test00132_Rtn?.comp_cd,9914);
        expect(Test00132_Rtn?.print_datetime,'abc15');
        expect(Test00132_Rtn?.cpn_data,'abc16');
        expect(Test00132_Rtn?.print_flg,'abc17');
        expect(Test00132_Rtn?.stop_flg,9918);
        expect(Test00132_Rtn?.prn_comp_cd,9919);
        expect(Test00132_Rtn?.prn_stre_cd,9920);
        expect(Test00132_Rtn?.prn_mac_no,9921);
        expect(Test00132_Rtn?.prn_staff_cd,9922);
        expect(Test00132_Rtn?.prn_datetime,'abc23');
        expect(Test00132_Rtn?.ins_datetime,'abc24');
        expect(Test00132_Rtn?.upd_datetime,'abc25');
        expect(Test00132_Rtn?.status,9926);
        expect(Test00132_Rtn?.send_flg,9927);
        expect(Test00132_Rtn?.upd_user,9928);
        expect(Test00132_Rtn?.upd_system,9929);
        expect(Test00132_Rtn?.tday_cnt,9930);
        expect(Test00132_Rtn?.total_cnt,9931);
      }

      //selectAllDataをして件数取得。
      List<SCustCpnTbl> Test00132_AllRtn2 = await db.selectAllData(Test00132_1);
      int count2 = Test00132_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00132_1);
      print('********** テスト終了：00132_SCustCpnTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00133 : CCpnCtrlMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00133_CCpnCtrlMst_01', () async {
      print('\n********** テスト実行：00133_CCpnCtrlMst_01 **********');
      CCpnCtrlMst Test00133_1 = CCpnCtrlMst();
      Test00133_1.cpn_id = 9912;
      Test00133_1.name = 'abc13';
      Test00133_1.start_datetime = 'abc14';
      Test00133_1.end_datetime = 'abc15';
      Test00133_1.cpn_start_datetime = 'abc16';
      Test00133_1.cpn_end_datetime = 'abc17';
      Test00133_1.stop_flg = 9918;
      Test00133_1.ins_datetime = 'abc19';
      Test00133_1.upd_datetime = 'abc20';
      Test00133_1.status = 9921;
      Test00133_1.send_flg = 9922;
      Test00133_1.upd_user = 9923;
      Test00133_1.upd_system = 9924;
      Test00133_1.comp_cd = 9925;

      //selectAllDataをして件数取得。
      List<CCpnCtrlMst> Test00133_AllRtn = await db.selectAllData(Test00133_1);
      int count = Test00133_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00133_1);

      //データ取得に必要なオブジェクトを用意
      CCpnCtrlMst Test00133_2 = CCpnCtrlMst();
      //Keyの値を設定する
      Test00133_2.cpn_id = 9912;
      Test00133_2.comp_cd = 9925;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCpnCtrlMst? Test00133_Rtn = await db.selectDataByPrimaryKey(Test00133_2);
      //取得行がない場合、nullが返ってきます
      if (Test00133_Rtn == null) {
        print('\n********** 異常発生：00133_CCpnCtrlMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00133_Rtn?.cpn_id,9912);
        expect(Test00133_Rtn?.name,'abc13');
        expect(Test00133_Rtn?.start_datetime,'abc14');
        expect(Test00133_Rtn?.end_datetime,'abc15');
        expect(Test00133_Rtn?.cpn_start_datetime,'abc16');
        expect(Test00133_Rtn?.cpn_end_datetime,'abc17');
        expect(Test00133_Rtn?.stop_flg,9918);
        expect(Test00133_Rtn?.ins_datetime,'abc19');
        expect(Test00133_Rtn?.upd_datetime,'abc20');
        expect(Test00133_Rtn?.status,9921);
        expect(Test00133_Rtn?.send_flg,9922);
        expect(Test00133_Rtn?.upd_user,9923);
        expect(Test00133_Rtn?.upd_system,9924);
        expect(Test00133_Rtn?.comp_cd,9925);
      }

      //selectAllDataをして件数取得。
      List<CCpnCtrlMst> Test00133_AllRtn2 = await db.selectAllData(Test00133_1);
      int count2 = Test00133_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00133_1);
      print('********** テスト終了：00133_CCpnCtrlMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00134 : CLoystreMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00134_CLoystreMst_01', () async {
      print('\n********** テスト実行：00134_CLoystreMst_01 **********');
      CLoystreMst Test00134_1 = CLoystreMst();
      Test00134_1.cpn_id = 9912;
      Test00134_1.comp_cd = 9913;
      Test00134_1.stre_cd = 9914;
      Test00134_1.stop_flg = 9915;
      Test00134_1.ins_datetime = 'abc16';
      Test00134_1.upd_datetime = 'abc17';
      Test00134_1.status = 9918;
      Test00134_1.send_flg = 9919;
      Test00134_1.upd_user = 9920;
      Test00134_1.upd_system = 9921;

      //selectAllDataをして件数取得。
      List<CLoystreMst> Test00134_AllRtn = await db.selectAllData(Test00134_1);
      int count = Test00134_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00134_1);

      //データ取得に必要なオブジェクトを用意
      CLoystreMst Test00134_2 = CLoystreMst();
      //Keyの値を設定する
      Test00134_2.cpn_id = 9912;
      Test00134_2.comp_cd = 9913;
      Test00134_2.stre_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CLoystreMst? Test00134_Rtn = await db.selectDataByPrimaryKey(Test00134_2);
      //取得行がない場合、nullが返ってきます
      if (Test00134_Rtn == null) {
        print('\n********** 異常発生：00134_CLoystreMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00134_Rtn?.cpn_id,9912);
        expect(Test00134_Rtn?.comp_cd,9913);
        expect(Test00134_Rtn?.stre_cd,9914);
        expect(Test00134_Rtn?.stop_flg,9915);
        expect(Test00134_Rtn?.ins_datetime,'abc16');
        expect(Test00134_Rtn?.upd_datetime,'abc17');
        expect(Test00134_Rtn?.status,9918);
        expect(Test00134_Rtn?.send_flg,9919);
        expect(Test00134_Rtn?.upd_user,9920);
        expect(Test00134_Rtn?.upd_system,9921);
      }

      //selectAllDataをして件数取得。
      List<CLoystreMst> Test00134_AllRtn2 = await db.selectAllData(Test00134_1);
      int count2 = Test00134_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00134_1);
      print('********** テスト終了：00134_CLoystreMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00135 : CLoyplnMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00135_CLoyplnMst_01', () async {
      print('\n********** テスト実行：00135_CLoyplnMst_01 **********');
      CLoyplnMst Test00135_1 = CLoyplnMst();
      Test00135_1.plan_cd = 9912;
      Test00135_1.cpn_id = 9913;
      Test00135_1.all_cust_flg = 9914;
      Test00135_1.all_stre_flg = 9915;
      Test00135_1.prom_name = 'abc16';
      Test00135_1.rcpt_name = 'abc17';
      Test00135_1.svs_class = 9918;
      Test00135_1.svs_typ = 9919;
      Test00135_1.reward_val = 9920;
      Test00135_1.bdl_prc_flg = 9921;
      Test00135_1.bdl_qty = 'abc22';
      Test00135_1.bdl_prc = 'abc23';
      Test00135_1.bdl_reward_val = 'abc24';
      Test00135_1.form_amt = 9925;
      Test00135_1.form_qty = 9926;
      Test00135_1.rec_limit = 9927;
      Test00135_1.day_limit = 9928;
      Test00135_1.max_limit = 9929;
      Test00135_1.start_datetime = 'abc30';
      Test00135_1.end_datetime = 'abc31';
      Test00135_1.stop_flg = 9932;
      Test00135_1.timesch_flg = 9933;
      Test00135_1.sun_flg = 9934;
      Test00135_1.mon_flg = 9935;
      Test00135_1.tue_flg = 9936;
      Test00135_1.wed_flg = 9937;
      Test00135_1.thu_flg = 9938;
      Test00135_1.fri_flg = 9939;
      Test00135_1.sat_flg = 9940;
      Test00135_1.acct_cd = 9941;
      Test00135_1.seq_no = 9942;
      Test00135_1.promo_ext_id = 'abc43';
      Test00135_1.ins_datetime = 'abc44';
      Test00135_1.upd_datetime = 'abc45';
      Test00135_1.status = 9946;
      Test00135_1.send_flg = 9947;
      Test00135_1.upd_user = 9948;
      Test00135_1.upd_system = 9949;
      Test00135_1.cpn_kind = 9950;
      Test00135_1.svs_kind = 9951;
      Test00135_1.refer_comp_cd = 9952;
      Test00135_1.comp_cd = 9953;
      Test00135_1.mul_val = 1.254;
      Test00135_1.reward_flg = 9955;
      Test00135_1.bcd_all_cust_flg = 9956;
      Test00135_1.loy_bcd = 'abc57';
      Test00135_1.low_lim = 9958;
      Test00135_1.upp_lim = 9959;
      Test00135_1.val_flg = 9960;
      Test00135_1.ref_typ = 9961;
      Test00135_1.apl_cnt = 9962;
      Test00135_1.stp_acct_cd = 9963;
      Test00135_1.stp_red_amt = 9964;
      Test00135_1.cust_kind_flg = 9965;
      Test00135_1.date_flg1 = 9966;
      Test00135_1.date_flg2 = 9967;
      Test00135_1.date_flg3 = 9968;
      Test00135_1.date_flg4 = 9969;
      Test00135_1.date_flg5 = 9970;
      Test00135_1.stp_cpn_id = 9971;
      Test00135_1.svs_content = 'abc72';
      Test00135_1.cust_kind_trgt = 'abc73';
      Test00135_1.ref_typ2 = 9974;
      Test00135_1.pay_key_cd = 9975;
      Test00135_1.cust_card_kind = 9976;
      Test00135_1.n_custom1 = 9977;
      Test00135_1.n_custom2 = 9978;
      Test00135_1.n_custom3 = 9979;
      Test00135_1.n_custom4 = 9980;
      Test00135_1.n_custom5 = 9981;
      Test00135_1.n_custom6 = 9982;
      Test00135_1.n_custom7 = 9983;
      Test00135_1.n_custom8 = 9984;
      Test00135_1.s_custom1 = 9985;
      Test00135_1.s_custom2 = 9986;
      Test00135_1.s_custom3 = 9987;
      Test00135_1.s_custom4 = 9988;
      Test00135_1.s_custom5 = 9989;
      Test00135_1.s_custom6 = 9990;
      Test00135_1.s_custom7 = 9991;
      Test00135_1.s_custom8 = 9992;
      Test00135_1.c_custom1 = 'abc93';
      Test00135_1.c_custom2 = 'abc94';
      Test00135_1.c_custom3 = 'abc95';
      Test00135_1.c_custom4 = 'abc96';
      Test00135_1.d_custom1 = 'abc97';
      Test00135_1.d_custom2 = 'abc98';
      Test00135_1.d_custom3 = 'abc99';
      Test00135_1.d_custom4 = 'abc100';

      //selectAllDataをして件数取得。
      List<CLoyplnMst> Test00135_AllRtn = await db.selectAllData(Test00135_1);
      int count = Test00135_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00135_1);

      //データ取得に必要なオブジェクトを用意
      CLoyplnMst Test00135_2 = CLoyplnMst();
      //Keyの値を設定する
      Test00135_2.plan_cd = 9912;
      Test00135_2.comp_cd = 9953;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CLoyplnMst? Test00135_Rtn = await db.selectDataByPrimaryKey(Test00135_2);
      //取得行がない場合、nullが返ってきます
      if (Test00135_Rtn == null) {
        print('\n********** 異常発生：00135_CLoyplnMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00135_Rtn?.plan_cd,9912);
        expect(Test00135_Rtn?.cpn_id,9913);
        expect(Test00135_Rtn?.all_cust_flg,9914);
        expect(Test00135_Rtn?.all_stre_flg,9915);
        expect(Test00135_Rtn?.prom_name,'abc16');
        expect(Test00135_Rtn?.rcpt_name,'abc17');
        expect(Test00135_Rtn?.svs_class,9918);
        expect(Test00135_Rtn?.svs_typ,9919);
        expect(Test00135_Rtn?.reward_val,9920);
        expect(Test00135_Rtn?.bdl_prc_flg,9921);
        expect(Test00135_Rtn?.bdl_qty,'abc22');
        expect(Test00135_Rtn?.bdl_prc,'abc23');
        expect(Test00135_Rtn?.bdl_reward_val,'abc24');
        expect(Test00135_Rtn?.form_amt,9925);
        expect(Test00135_Rtn?.form_qty,9926);
        expect(Test00135_Rtn?.rec_limit,9927);
        expect(Test00135_Rtn?.day_limit,9928);
        expect(Test00135_Rtn?.max_limit,9929);
        expect(Test00135_Rtn?.start_datetime,'abc30');
        expect(Test00135_Rtn?.end_datetime,'abc31');
        expect(Test00135_Rtn?.stop_flg,9932);
        expect(Test00135_Rtn?.timesch_flg,9933);
        expect(Test00135_Rtn?.sun_flg,9934);
        expect(Test00135_Rtn?.mon_flg,9935);
        expect(Test00135_Rtn?.tue_flg,9936);
        expect(Test00135_Rtn?.wed_flg,9937);
        expect(Test00135_Rtn?.thu_flg,9938);
        expect(Test00135_Rtn?.fri_flg,9939);
        expect(Test00135_Rtn?.sat_flg,9940);
        expect(Test00135_Rtn?.acct_cd,9941);
        expect(Test00135_Rtn?.seq_no,9942);
        expect(Test00135_Rtn?.promo_ext_id,'abc43');
        expect(Test00135_Rtn?.ins_datetime,'abc44');
        expect(Test00135_Rtn?.upd_datetime,'abc45');
        expect(Test00135_Rtn?.status,9946);
        expect(Test00135_Rtn?.send_flg,9947);
        expect(Test00135_Rtn?.upd_user,9948);
        expect(Test00135_Rtn?.upd_system,9949);
        expect(Test00135_Rtn?.cpn_kind,9950);
        expect(Test00135_Rtn?.svs_kind,9951);
        expect(Test00135_Rtn?.refer_comp_cd,9952);
        expect(Test00135_Rtn?.comp_cd,9953);
        expect(Test00135_Rtn?.mul_val,1.254);
        expect(Test00135_Rtn?.reward_flg,9955);
        expect(Test00135_Rtn?.bcd_all_cust_flg,9956);
        expect(Test00135_Rtn?.loy_bcd,'abc57');
        expect(Test00135_Rtn?.low_lim,9958);
        expect(Test00135_Rtn?.upp_lim,9959);
        expect(Test00135_Rtn?.val_flg,9960);
        expect(Test00135_Rtn?.ref_typ,9961);
        expect(Test00135_Rtn?.apl_cnt,9962);
        expect(Test00135_Rtn?.stp_acct_cd,9963);
        expect(Test00135_Rtn?.stp_red_amt,9964);
        expect(Test00135_Rtn?.cust_kind_flg,9965);
        expect(Test00135_Rtn?.date_flg1,9966);
        expect(Test00135_Rtn?.date_flg2,9967);
        expect(Test00135_Rtn?.date_flg3,9968);
        expect(Test00135_Rtn?.date_flg4,9969);
        expect(Test00135_Rtn?.date_flg5,9970);
        expect(Test00135_Rtn?.stp_cpn_id,9971);
        expect(Test00135_Rtn?.svs_content,'abc72');
        expect(Test00135_Rtn?.cust_kind_trgt,'abc73');
        expect(Test00135_Rtn?.ref_typ2,9974);
        expect(Test00135_Rtn?.pay_key_cd,9975);
        expect(Test00135_Rtn?.cust_card_kind,9976);
        expect(Test00135_Rtn?.n_custom1,9977);
        expect(Test00135_Rtn?.n_custom2,9978);
        expect(Test00135_Rtn?.n_custom3,9979);
        expect(Test00135_Rtn?.n_custom4,9980);
        expect(Test00135_Rtn?.n_custom5,9981);
        expect(Test00135_Rtn?.n_custom6,9982);
        expect(Test00135_Rtn?.n_custom7,9983);
        expect(Test00135_Rtn?.n_custom8,9984);
        expect(Test00135_Rtn?.s_custom1,9985);
        expect(Test00135_Rtn?.s_custom2,9986);
        expect(Test00135_Rtn?.s_custom3,9987);
        expect(Test00135_Rtn?.s_custom4,9988);
        expect(Test00135_Rtn?.s_custom5,9989);
        expect(Test00135_Rtn?.s_custom6,9990);
        expect(Test00135_Rtn?.s_custom7,9991);
        expect(Test00135_Rtn?.s_custom8,9992);
        expect(Test00135_Rtn?.c_custom1,'abc93');
        expect(Test00135_Rtn?.c_custom2,'abc94');
        expect(Test00135_Rtn?.c_custom3,'abc95');
        expect(Test00135_Rtn?.c_custom4,'abc96');
        expect(Test00135_Rtn?.d_custom1,'abc97');
        expect(Test00135_Rtn?.d_custom2,'abc98');
        expect(Test00135_Rtn?.d_custom3,'abc99');
        expect(Test00135_Rtn?.d_custom4,'abc100');
      }

      //selectAllDataをして件数取得。
      List<CLoyplnMst> Test00135_AllRtn2 = await db.selectAllData(Test00135_1);
      int count2 = Test00135_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00135_1);
      print('********** テスト終了：00135_CLoyplnMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00136 : CLoypluMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00136_CLoypluMst_01', () async {
      print('\n********** テスト実行：00136_CLoypluMst_01 **********');
      CLoypluMst Test00136_1 = CLoypluMst();
      Test00136_1.plan_cd = 9912;
      Test00136_1.prom_cd = 'abc13';
      Test00136_1.cpn_id = 9914;
      Test00136_1.stop_flg = 9915;
      Test00136_1.ins_datetime = 'abc16';
      Test00136_1.upd_datetime = 'abc17';
      Test00136_1.status = 9918;
      Test00136_1.send_flg = 9919;
      Test00136_1.upd_user = 9920;
      Test00136_1.upd_system = 9921;
      Test00136_1.comp_cd = 9922;
      Test00136_1.val = 1.223;
      Test00136_1.ref_flg = 9924;
      Test00136_1.exclude_flg = 9925;
      Test00136_1.prom_cd2 = 'abc26';
      Test00136_1.sub_cls_cd = 9927;

      //selectAllDataをして件数取得。
      List<CLoypluMst> Test00136_AllRtn = await db.selectAllData(Test00136_1);
      int count = Test00136_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00136_1);

      //データ取得に必要なオブジェクトを用意
      CLoypluMst Test00136_2 = CLoypluMst();
      //Keyの値を設定する
      Test00136_2.plan_cd = 9912;
      Test00136_2.prom_cd = 'abc13';
      Test00136_2.comp_cd = 9922;
      Test00136_2.ref_flg = 9924;
      Test00136_2.prom_cd2 = 'abc26';
      Test00136_2.sub_cls_cd = 9927;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CLoypluMst? Test00136_Rtn = await db.selectDataByPrimaryKey(Test00136_2);
      //取得行がない場合、nullが返ってきます
      if (Test00136_Rtn == null) {
        print('\n********** 異常発生：00136_CLoypluMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00136_Rtn?.plan_cd,9912);
        expect(Test00136_Rtn?.prom_cd,'abc13');
        expect(Test00136_Rtn?.cpn_id,9914);
        expect(Test00136_Rtn?.stop_flg,9915);
        expect(Test00136_Rtn?.ins_datetime,'abc16');
        expect(Test00136_Rtn?.upd_datetime,'abc17');
        expect(Test00136_Rtn?.status,9918);
        expect(Test00136_Rtn?.send_flg,9919);
        expect(Test00136_Rtn?.upd_user,9920);
        expect(Test00136_Rtn?.upd_system,9921);
        expect(Test00136_Rtn?.comp_cd,9922);
        expect(Test00136_Rtn?.val,1.223);
        expect(Test00136_Rtn?.ref_flg,9924);
        expect(Test00136_Rtn?.exclude_flg,9925);
        expect(Test00136_Rtn?.prom_cd2,'abc26');
        expect(Test00136_Rtn?.sub_cls_cd,9927);
      }

      //selectAllDataをして件数取得。
      List<CLoypluMst> Test00136_AllRtn2 = await db.selectAllData(Test00136_1);
      int count2 = Test00136_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00136_1);
      print('********** テスト終了：00136_CLoypluMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00137 : CLoytgtMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00137_CLoytgtMst_01', () async {
      print('\n********** テスト実行：00137_CLoytgtMst_01 **********');
      CLoytgtMst Test00137_1 = CLoytgtMst();
      Test00137_1.plan_cd = 9912;
      Test00137_1.cpn_id = 9913;
      Test00137_1.title_data = 'abc14';
      Test00137_1.title_col = 9915;
      Test00137_1.title_siz = 9916;
      Test00137_1.message1 = 'abc17';
      Test00137_1.message1_col = 9918;
      Test00137_1.message1_siz = 9919;
      Test00137_1.message2 = 'abc20';
      Test00137_1.message2_col = 9921;
      Test00137_1.message2_siz = 9922;
      Test00137_1.message3 = 'abc23';
      Test00137_1.message3_col = 9924;
      Test00137_1.message3_siz = 9925;
      Test00137_1.message4 = 'abc26';
      Test00137_1.message4_col = 9927;
      Test00137_1.message4_siz = 9928;
      Test00137_1.message5 = 'abc29';
      Test00137_1.message5_col = 9930;
      Test00137_1.message5_siz = 9931;
      Test00137_1.dialog_typ = 9932;
      Test00137_1.dialog_img_cd = 9933;
      Test00137_1.dialog_icon_cd = 9934;
      Test00137_1.dialog_sound_cd = 9935;
      Test00137_1.ins_datetime = 'abc36';
      Test00137_1.upd_datetime = 'abc37';
      Test00137_1.status = 9938;
      Test00137_1.send_flg = 9939;
      Test00137_1.upd_user = 9940;
      Test00137_1.upd_system = 9941;
      Test00137_1.comp_cd = 9942;

      //selectAllDataをして件数取得。
      List<CLoytgtMst> Test00137_AllRtn = await db.selectAllData(Test00137_1);
      int count = Test00137_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00137_1);

      //データ取得に必要なオブジェクトを用意
      CLoytgtMst Test00137_2 = CLoytgtMst();
      //Keyの値を設定する
      Test00137_2.plan_cd = 9912;
      Test00137_2.comp_cd = 9942;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CLoytgtMst? Test00137_Rtn = await db.selectDataByPrimaryKey(Test00137_2);
      //取得行がない場合、nullが返ってきます
      if (Test00137_Rtn == null) {
        print('\n********** 異常発生：00137_CLoytgtMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00137_Rtn?.plan_cd,9912);
        expect(Test00137_Rtn?.cpn_id,9913);
        expect(Test00137_Rtn?.title_data,'abc14');
        expect(Test00137_Rtn?.title_col,9915);
        expect(Test00137_Rtn?.title_siz,9916);
        expect(Test00137_Rtn?.message1,'abc17');
        expect(Test00137_Rtn?.message1_col,9918);
        expect(Test00137_Rtn?.message1_siz,9919);
        expect(Test00137_Rtn?.message2,'abc20');
        expect(Test00137_Rtn?.message2_col,9921);
        expect(Test00137_Rtn?.message2_siz,9922);
        expect(Test00137_Rtn?.message3,'abc23');
        expect(Test00137_Rtn?.message3_col,9924);
        expect(Test00137_Rtn?.message3_siz,9925);
        expect(Test00137_Rtn?.message4,'abc26');
        expect(Test00137_Rtn?.message4_col,9927);
        expect(Test00137_Rtn?.message4_siz,9928);
        expect(Test00137_Rtn?.message5,'abc29');
        expect(Test00137_Rtn?.message5_col,9930);
        expect(Test00137_Rtn?.message5_siz,9931);
        expect(Test00137_Rtn?.dialog_typ,9932);
        expect(Test00137_Rtn?.dialog_img_cd,9933);
        expect(Test00137_Rtn?.dialog_icon_cd,9934);
        expect(Test00137_Rtn?.dialog_sound_cd,9935);
        expect(Test00137_Rtn?.ins_datetime,'abc36');
        expect(Test00137_Rtn?.upd_datetime,'abc37');
        expect(Test00137_Rtn?.status,9938);
        expect(Test00137_Rtn?.send_flg,9939);
        expect(Test00137_Rtn?.upd_user,9940);
        expect(Test00137_Rtn?.upd_system,9941);
        expect(Test00137_Rtn?.comp_cd,9942);
      }

      //selectAllDataをして件数取得。
      List<CLoytgtMst> Test00137_AllRtn2 = await db.selectAllData(Test00137_1);
      int count2 = Test00137_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00137_1);
      print('********** テスト終了：00137_CLoytgtMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00138 : SCustLoyTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00138_SCustLoyTbl_01', () async {
      print('\n********** テスト実行：00138_SCustLoyTbl_01 **********');
      SCustLoyTbl Test00138_1 = SCustLoyTbl();
      Test00138_1.cust_no = 'abc12';
      Test00138_1.cpn_id = 9913;
      Test00138_1.comp_cd = 9914;
      Test00138_1.plan_cd = 'abc15';
      Test00138_1.tday_cnt = 'abc16';
      Test00138_1.total_cnt = 'abc17';
      Test00138_1.last_sellday = 'abc18';
      Test00138_1.prn_seq_no = 'abc19';
      Test00138_1.prn_flg = 'abc20';
      Test00138_1.target_flg = 'abc21';
      Test00138_1.stop_flg = 'abc22';
      Test00138_1.ins_datetime = 'abc23';
      Test00138_1.upd_datetime = 'abc24';
      Test00138_1.status = 9925;
      Test00138_1.send_flg = 9926;
      Test00138_1.upd_user = 9927;
      Test00138_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<SCustLoyTbl> Test00138_AllRtn = await db.selectAllData(Test00138_1);
      int count = Test00138_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00138_1);

      //データ取得に必要なオブジェクトを用意
      SCustLoyTbl Test00138_2 = SCustLoyTbl();
      //Keyの値を設定する
      Test00138_2.cust_no = 'abc12';
      Test00138_2.cpn_id = 9913;
      Test00138_2.comp_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SCustLoyTbl? Test00138_Rtn = await db.selectDataByPrimaryKey(Test00138_2);
      //取得行がない場合、nullが返ってきます
      if (Test00138_Rtn == null) {
        print('\n********** 異常発生：00138_SCustLoyTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00138_Rtn?.cust_no,'abc12');
        expect(Test00138_Rtn?.cpn_id,9913);
        expect(Test00138_Rtn?.comp_cd,9914);
        expect(Test00138_Rtn?.plan_cd,'abc15');
        expect(Test00138_Rtn?.tday_cnt,'abc16');
        expect(Test00138_Rtn?.total_cnt,'abc17');
        expect(Test00138_Rtn?.last_sellday,'abc18');
        expect(Test00138_Rtn?.prn_seq_no,'abc19');
        expect(Test00138_Rtn?.prn_flg,'abc20');
        expect(Test00138_Rtn?.target_flg,'abc21');
        expect(Test00138_Rtn?.stop_flg,'abc22');
        expect(Test00138_Rtn?.ins_datetime,'abc23');
        expect(Test00138_Rtn?.upd_datetime,'abc24');
        expect(Test00138_Rtn?.status,9925);
        expect(Test00138_Rtn?.send_flg,9926);
        expect(Test00138_Rtn?.upd_user,9927);
        expect(Test00138_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<SCustLoyTbl> Test00138_AllRtn2 = await db.selectAllData(Test00138_1);
      int count2 = Test00138_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00138_1);
      print('********** テスト終了：00138_SCustLoyTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00139 : SCustTtlTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00139_SCustTtlTbl_01', () async {
      print('\n********** テスト実行：00139_SCustTtlTbl_01 **********');
      SCustTtlTbl Test00139_1 = SCustTtlTbl();
      Test00139_1.cust_no = 'abc12';
      Test00139_1.comp_cd = 9913;
      Test00139_1.stre_cd = 9914;
      Test00139_1.srch_cust_no = 'abc15';
      Test00139_1.acct_cd_1 = 9916;
      Test00139_1.acct_totalpnt_1 = 9917;
      Test00139_1.acct_totalamt_1 = 9918;
      Test00139_1.acct_totalqty_1 = 9919;
      Test00139_1.acct_cd_2 = 9920;
      Test00139_1.acct_totalpnt_2 = 9921;
      Test00139_1.acct_totalamt_2 = 9922;
      Test00139_1.acct_totalqty_2 = 9923;
      Test00139_1.acct_cd_3 = 9924;
      Test00139_1.acct_totalpnt_3 = 9925;
      Test00139_1.acct_totalamt_3 = 9926;
      Test00139_1.acct_totalqty_3 = 9927;
      Test00139_1.acct_cd_4 = 9928;
      Test00139_1.acct_totalpnt_4 = 9929;
      Test00139_1.acct_totalamt_4 = 9930;
      Test00139_1.acct_totalqty_4 = 9931;
      Test00139_1.acct_cd_5 = 9932;
      Test00139_1.acct_totalpnt_5 = 9933;
      Test00139_1.acct_totalamt_5 = 9934;
      Test00139_1.acct_totalqty_5 = 9935;
      Test00139_1.month_amt_1 = 9936;
      Test00139_1.month_amt_2 = 9937;
      Test00139_1.month_amt_3 = 9938;
      Test00139_1.month_amt_4 = 9939;
      Test00139_1.month_amt_5 = 9940;
      Test00139_1.month_amt_6 = 9941;
      Test00139_1.month_amt_7 = 9942;
      Test00139_1.month_amt_8 = 9943;
      Test00139_1.month_amt_9 = 9944;
      Test00139_1.month_amt_10 = 9945;
      Test00139_1.month_amt_11 = 9946;
      Test00139_1.month_amt_12 = 9947;
      Test00139_1.month_visit_date_1 = 'abc48';
      Test00139_1.month_visit_date_2 = 'abc49';
      Test00139_1.month_visit_date_3 = 'abc50';
      Test00139_1.month_visit_date_4 = 'abc51';
      Test00139_1.month_visit_date_5 = 'abc52';
      Test00139_1.month_visit_date_6 = 'abc53';
      Test00139_1.month_visit_date_7 = 'abc54';
      Test00139_1.month_visit_date_8 = 'abc55';
      Test00139_1.month_visit_date_9 = 'abc56';
      Test00139_1.month_visit_date_10 = 'abc57';
      Test00139_1.month_visit_date_11 = 'abc58';
      Test00139_1.month_visit_date_12 = 'abc59';
      Test00139_1.month_visit_cnt_1 = 9960;
      Test00139_1.month_visit_cnt_2 = 9961;
      Test00139_1.month_visit_cnt_3 = 9962;
      Test00139_1.month_visit_cnt_4 = 9963;
      Test00139_1.month_visit_cnt_5 = 9964;
      Test00139_1.month_visit_cnt_6 = 9965;
      Test00139_1.month_visit_cnt_7 = 9966;
      Test00139_1.month_visit_cnt_8 = 9967;
      Test00139_1.month_visit_cnt_9 = 9968;
      Test00139_1.month_visit_cnt_10 = 9969;
      Test00139_1.month_visit_cnt_11 = 9970;
      Test00139_1.month_visit_cnt_12 = 9971;
      Test00139_1.bnsdsc_amt = 9972;
      Test00139_1.bnsdsc_visit_date = 'abc73';
      Test00139_1.ttl_amt = 9974;
      Test00139_1.delivery_date = 'abc75';
      Test00139_1.last_name = 'abc76';
      Test00139_1.first_name = 'abc77';
      Test00139_1.birth_day = 'abc78';
      Test00139_1.tel_no1 = 'abc79';
      Test00139_1.tel_no2 = 'abc80';
      Test00139_1.last_visit_date = 'abc81';
      Test00139_1.pnt_service_type = 9982;
      Test00139_1.pnt_service_limit = 9983;
      Test00139_1.portal_flg = 9984;
      Test00139_1.enq_comp_cd = 9985;
      Test00139_1.enq_stre_cd = 9986;
      Test00139_1.enq_mac_no = 9987;
      Test00139_1.enq_datetime = 'abc88';
      Test00139_1.cust_status = 9989;
      Test00139_1.ins_datetime = 'abc90';
      Test00139_1.upd_datetime = 'abc91';
      Test00139_1.status = 9992;
      Test00139_1.send_flg = 9993;
      Test00139_1.upd_user = 9994;
      Test00139_1.upd_system = 9995;
      Test00139_1.targ_typ = 9996;
      Test00139_1.staff_flg = 9997;
      Test00139_1.cust_prc_type = 9998;
      Test00139_1.sch_acct_cd_1 = 9999;
      Test00139_1.acct_accval_1 = 99100;
      Test00139_1.acct_optotal_1 = 99101;
      Test00139_1.sch_acct_cd_2 = 99102;
      Test00139_1.acct_accval_2 = 99103;
      Test00139_1.acct_optotal_2 = 99104;
      Test00139_1.sch_acct_cd_3 = 99105;
      Test00139_1.acct_accval_3 = 99106;
      Test00139_1.acct_optotal_3 = 99107;
      Test00139_1.sch_acct_cd_4 = 99108;
      Test00139_1.acct_accval_4 = 99109;
      Test00139_1.acct_optotal_4 = 99110;
      Test00139_1.sch_acct_cd_5 = 99111;
      Test00139_1.acct_accval_5 = 99112;
      Test00139_1.acct_optotal_5 = 99113;
      Test00139_1.c_data1 = 'abc114';
      Test00139_1.n_data1 = 99115;
      Test00139_1.n_data2 = 99116;
      Test00139_1.n_data3 = 99117;
      Test00139_1.n_data4 = 99118;
      Test00139_1.n_data5 = 99119;
      Test00139_1.n_data6 = 99120;
      Test00139_1.n_data7 = 99121;
      Test00139_1.n_data8 = 99122;
      Test00139_1.n_data9 = 99123;
      Test00139_1.n_data10 = 99124;
      Test00139_1.n_data11 = 99125;
      Test00139_1.n_data12 = 99126;
      Test00139_1.n_data13 = 99127;
      Test00139_1.n_data14 = 99128;
      Test00139_1.n_data15 = 99129;
      Test00139_1.n_data16 = 99130;
      Test00139_1.s_data1 = 99131;
      Test00139_1.s_data2 = 99132;
      Test00139_1.s_data3 = 99133;
      Test00139_1.d_data1 = 'abc134';
      Test00139_1.d_data2 = 'abc135';
      Test00139_1.d_data3 = 'abc136';
      Test00139_1.d_data4 = 'abc137';
      Test00139_1.d_data5 = 'abc138';
      Test00139_1.d_data6 = 'abc139';
      Test00139_1.d_data7 = 'abc140';
      Test00139_1.d_data8 = 'abc141';
      Test00139_1.d_data9 = 'abc142';
      Test00139_1.d_data10 = 'abc143';

      //selectAllDataをして件数取得。
      List<SCustTtlTbl> Test00139_AllRtn = await db.selectAllData(Test00139_1);
      int count = Test00139_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00139_1);

      //データ取得に必要なオブジェクトを用意
      SCustTtlTbl Test00139_2 = SCustTtlTbl();
      //Keyの値を設定する
      Test00139_2.cust_no = 'abc12';
      Test00139_2.comp_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SCustTtlTbl? Test00139_Rtn = await db.selectDataByPrimaryKey(Test00139_2);
      //取得行がない場合、nullが返ってきます
      if (Test00139_Rtn == null) {
        print('\n********** 異常発生：00139_SCustTtlTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00139_Rtn?.cust_no,'abc12');
        expect(Test00139_Rtn?.comp_cd,9913);
        expect(Test00139_Rtn?.stre_cd,9914);
        expect(Test00139_Rtn?.srch_cust_no,'abc15');
        expect(Test00139_Rtn?.acct_cd_1,9916);
        expect(Test00139_Rtn?.acct_totalpnt_1,9917);
        expect(Test00139_Rtn?.acct_totalamt_1,9918);
        expect(Test00139_Rtn?.acct_totalqty_1,9919);
        expect(Test00139_Rtn?.acct_cd_2,9920);
        expect(Test00139_Rtn?.acct_totalpnt_2,9921);
        expect(Test00139_Rtn?.acct_totalamt_2,9922);
        expect(Test00139_Rtn?.acct_totalqty_2,9923);
        expect(Test00139_Rtn?.acct_cd_3,9924);
        expect(Test00139_Rtn?.acct_totalpnt_3,9925);
        expect(Test00139_Rtn?.acct_totalamt_3,9926);
        expect(Test00139_Rtn?.acct_totalqty_3,9927);
        expect(Test00139_Rtn?.acct_cd_4,9928);
        expect(Test00139_Rtn?.acct_totalpnt_4,9929);
        expect(Test00139_Rtn?.acct_totalamt_4,9930);
        expect(Test00139_Rtn?.acct_totalqty_4,9931);
        expect(Test00139_Rtn?.acct_cd_5,9932);
        expect(Test00139_Rtn?.acct_totalpnt_5,9933);
        expect(Test00139_Rtn?.acct_totalamt_5,9934);
        expect(Test00139_Rtn?.acct_totalqty_5,9935);
        expect(Test00139_Rtn?.month_amt_1,9936);
        expect(Test00139_Rtn?.month_amt_2,9937);
        expect(Test00139_Rtn?.month_amt_3,9938);
        expect(Test00139_Rtn?.month_amt_4,9939);
        expect(Test00139_Rtn?.month_amt_5,9940);
        expect(Test00139_Rtn?.month_amt_6,9941);
        expect(Test00139_Rtn?.month_amt_7,9942);
        expect(Test00139_Rtn?.month_amt_8,9943);
        expect(Test00139_Rtn?.month_amt_9,9944);
        expect(Test00139_Rtn?.month_amt_10,9945);
        expect(Test00139_Rtn?.month_amt_11,9946);
        expect(Test00139_Rtn?.month_amt_12,9947);
        expect(Test00139_Rtn?.month_visit_date_1,'abc48');
        expect(Test00139_Rtn?.month_visit_date_2,'abc49');
        expect(Test00139_Rtn?.month_visit_date_3,'abc50');
        expect(Test00139_Rtn?.month_visit_date_4,'abc51');
        expect(Test00139_Rtn?.month_visit_date_5,'abc52');
        expect(Test00139_Rtn?.month_visit_date_6,'abc53');
        expect(Test00139_Rtn?.month_visit_date_7,'abc54');
        expect(Test00139_Rtn?.month_visit_date_8,'abc55');
        expect(Test00139_Rtn?.month_visit_date_9,'abc56');
        expect(Test00139_Rtn?.month_visit_date_10,'abc57');
        expect(Test00139_Rtn?.month_visit_date_11,'abc58');
        expect(Test00139_Rtn?.month_visit_date_12,'abc59');
        expect(Test00139_Rtn?.month_visit_cnt_1,9960);
        expect(Test00139_Rtn?.month_visit_cnt_2,9961);
        expect(Test00139_Rtn?.month_visit_cnt_3,9962);
        expect(Test00139_Rtn?.month_visit_cnt_4,9963);
        expect(Test00139_Rtn?.month_visit_cnt_5,9964);
        expect(Test00139_Rtn?.month_visit_cnt_6,9965);
        expect(Test00139_Rtn?.month_visit_cnt_7,9966);
        expect(Test00139_Rtn?.month_visit_cnt_8,9967);
        expect(Test00139_Rtn?.month_visit_cnt_9,9968);
        expect(Test00139_Rtn?.month_visit_cnt_10,9969);
        expect(Test00139_Rtn?.month_visit_cnt_11,9970);
        expect(Test00139_Rtn?.month_visit_cnt_12,9971);
        expect(Test00139_Rtn?.bnsdsc_amt,9972);
        expect(Test00139_Rtn?.bnsdsc_visit_date,'abc73');
        expect(Test00139_Rtn?.ttl_amt,9974);
        expect(Test00139_Rtn?.delivery_date,'abc75');
        expect(Test00139_Rtn?.last_name,'abc76');
        expect(Test00139_Rtn?.first_name,'abc77');
        expect(Test00139_Rtn?.birth_day,'abc78');
        expect(Test00139_Rtn?.tel_no1,'abc79');
        expect(Test00139_Rtn?.tel_no2,'abc80');
        expect(Test00139_Rtn?.last_visit_date,'abc81');
        expect(Test00139_Rtn?.pnt_service_type,9982);
        expect(Test00139_Rtn?.pnt_service_limit,9983);
        expect(Test00139_Rtn?.portal_flg,9984);
        expect(Test00139_Rtn?.enq_comp_cd,9985);
        expect(Test00139_Rtn?.enq_stre_cd,9986);
        expect(Test00139_Rtn?.enq_mac_no,9987);
        expect(Test00139_Rtn?.enq_datetime,'abc88');
        expect(Test00139_Rtn?.cust_status,9989);
        expect(Test00139_Rtn?.ins_datetime,'abc90');
        expect(Test00139_Rtn?.upd_datetime,'abc91');
        expect(Test00139_Rtn?.status,9992);
        expect(Test00139_Rtn?.send_flg,9993);
        expect(Test00139_Rtn?.upd_user,9994);
        expect(Test00139_Rtn?.upd_system,9995);
        expect(Test00139_Rtn?.targ_typ,9996);
        expect(Test00139_Rtn?.staff_flg,9997);
        expect(Test00139_Rtn?.cust_prc_type,9998);
        expect(Test00139_Rtn?.sch_acct_cd_1,9999);
        expect(Test00139_Rtn?.acct_accval_1,99100);
        expect(Test00139_Rtn?.acct_optotal_1,99101);
        expect(Test00139_Rtn?.sch_acct_cd_2,99102);
        expect(Test00139_Rtn?.acct_accval_2,99103);
        expect(Test00139_Rtn?.acct_optotal_2,99104);
        expect(Test00139_Rtn?.sch_acct_cd_3,99105);
        expect(Test00139_Rtn?.acct_accval_3,99106);
        expect(Test00139_Rtn?.acct_optotal_3,99107);
        expect(Test00139_Rtn?.sch_acct_cd_4,99108);
        expect(Test00139_Rtn?.acct_accval_4,99109);
        expect(Test00139_Rtn?.acct_optotal_4,99110);
        expect(Test00139_Rtn?.sch_acct_cd_5,99111);
        expect(Test00139_Rtn?.acct_accval_5,99112);
        expect(Test00139_Rtn?.acct_optotal_5,99113);
        expect(Test00139_Rtn?.c_data1,'abc114');
        expect(Test00139_Rtn?.n_data1,99115);
        expect(Test00139_Rtn?.n_data2,99116);
        expect(Test00139_Rtn?.n_data3,99117);
        expect(Test00139_Rtn?.n_data4,99118);
        expect(Test00139_Rtn?.n_data5,99119);
        expect(Test00139_Rtn?.n_data6,99120);
        expect(Test00139_Rtn?.n_data7,99121);
        expect(Test00139_Rtn?.n_data8,99122);
        expect(Test00139_Rtn?.n_data9,99123);
        expect(Test00139_Rtn?.n_data10,99124);
        expect(Test00139_Rtn?.n_data11,99125);
        expect(Test00139_Rtn?.n_data12,99126);
        expect(Test00139_Rtn?.n_data13,99127);
        expect(Test00139_Rtn?.n_data14,99128);
        expect(Test00139_Rtn?.n_data15,99129);
        expect(Test00139_Rtn?.n_data16,99130);
        expect(Test00139_Rtn?.s_data1,99131);
        expect(Test00139_Rtn?.s_data2,99132);
        expect(Test00139_Rtn?.s_data3,99133);
        expect(Test00139_Rtn?.d_data1,'abc134');
        expect(Test00139_Rtn?.d_data2,'abc135');
        expect(Test00139_Rtn?.d_data3,'abc136');
        expect(Test00139_Rtn?.d_data4,'abc137');
        expect(Test00139_Rtn?.d_data5,'abc138');
        expect(Test00139_Rtn?.d_data6,'abc139');
        expect(Test00139_Rtn?.d_data7,'abc140');
        expect(Test00139_Rtn?.d_data8,'abc141');
        expect(Test00139_Rtn?.d_data9,'abc142');
        expect(Test00139_Rtn?.d_data10,'abc143');
      }

      //selectAllDataをして件数取得。
      List<SCustTtlTbl> Test00139_AllRtn2 = await db.selectAllData(Test00139_1);
      int count2 = Test00139_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00139_1);
      print('********** テスト終了：00139_SCustTtlTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00140 : CRankMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00140_CRankMst_01', () async {
      print('\n********** テスト実行：00140_CRankMst_01 **********');
      CRankMst Test00140_1 = CRankMst();
      Test00140_1.comp_cd = 9912;
      Test00140_1.rank_cd = 9913;
      Test00140_1.rank_kind = 9914;
      Test00140_1.rank_name = 'abc15';
      Test00140_1.reward_typ = 9916;
      Test00140_1.rank_judge_1 = 9917;
      Test00140_1.rank_judge_2 = 9918;
      Test00140_1.rank_judge_3 = 9919;
      Test00140_1.rank_judge_4 = 9920;
      Test00140_1.rank_judge_5 = 9921;
      Test00140_1.rank_judge_6 = 9922;
      Test00140_1.rank_judge_7 = 9923;
      Test00140_1.rank_judge_8 = 9924;
      Test00140_1.rank_judge_9 = 9925;
      Test00140_1.rank_judge_10 = 9926;
      Test00140_1.rank_reward_1 = 9927;
      Test00140_1.rank_reward_2 = 9928;
      Test00140_1.rank_reward_3 = 9929;
      Test00140_1.rank_reward_4 = 9930;
      Test00140_1.rank_reward_5 = 9931;
      Test00140_1.rank_reward_6 = 9932;
      Test00140_1.rank_reward_7 = 9933;
      Test00140_1.rank_reward_8 = 9934;
      Test00140_1.rank_reward_9 = 9935;
      Test00140_1.rank_reward_10 = 9936;
      Test00140_1.start_datetime = 'abc37';
      Test00140_1.end_datetime = 'abc38';
      Test00140_1.timesch_flg = 9939;
      Test00140_1.sun_flg = 9940;
      Test00140_1.mon_flg = 9941;
      Test00140_1.tue_flg = 9942;
      Test00140_1.wed_flg = 9943;
      Test00140_1.thu_flg = 9944;
      Test00140_1.fri_flg = 9945;
      Test00140_1.sat_flg = 9946;
      Test00140_1.seq_no = 9947;
      Test00140_1.promo_ext_id = 'abc48';
      Test00140_1.acct_cd = 9949;
      Test00140_1.stop_flg = 9950;
      Test00140_1.ins_datetime = 'abc51';
      Test00140_1.upd_datetime = 'abc52';
      Test00140_1.status = 9953;
      Test00140_1.send_flg = 9954;
      Test00140_1.upd_user = 9955;
      Test00140_1.upd_system = 9956;

      //selectAllDataをして件数取得。
      List<CRankMst> Test00140_AllRtn = await db.selectAllData(Test00140_1);
      int count = Test00140_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00140_1);

      //データ取得に必要なオブジェクトを用意
      CRankMst Test00140_2 = CRankMst();
      //Keyの値を設定する
      Test00140_2.comp_cd = 9912;
      Test00140_2.rank_cd = 9913;
      Test00140_2.rank_kind = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CRankMst? Test00140_Rtn = await db.selectDataByPrimaryKey(Test00140_2);
      //取得行がない場合、nullが返ってきます
      if (Test00140_Rtn == null) {
        print('\n********** 異常発生：00140_CRankMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00140_Rtn?.comp_cd,9912);
        expect(Test00140_Rtn?.rank_cd,9913);
        expect(Test00140_Rtn?.rank_kind,9914);
        expect(Test00140_Rtn?.rank_name,'abc15');
        expect(Test00140_Rtn?.reward_typ,9916);
        expect(Test00140_Rtn?.rank_judge_1,9917);
        expect(Test00140_Rtn?.rank_judge_2,9918);
        expect(Test00140_Rtn?.rank_judge_3,9919);
        expect(Test00140_Rtn?.rank_judge_4,9920);
        expect(Test00140_Rtn?.rank_judge_5,9921);
        expect(Test00140_Rtn?.rank_judge_6,9922);
        expect(Test00140_Rtn?.rank_judge_7,9923);
        expect(Test00140_Rtn?.rank_judge_8,9924);
        expect(Test00140_Rtn?.rank_judge_9,9925);
        expect(Test00140_Rtn?.rank_judge_10,9926);
        expect(Test00140_Rtn?.rank_reward_1,9927);
        expect(Test00140_Rtn?.rank_reward_2,9928);
        expect(Test00140_Rtn?.rank_reward_3,9929);
        expect(Test00140_Rtn?.rank_reward_4,9930);
        expect(Test00140_Rtn?.rank_reward_5,9931);
        expect(Test00140_Rtn?.rank_reward_6,9932);
        expect(Test00140_Rtn?.rank_reward_7,9933);
        expect(Test00140_Rtn?.rank_reward_8,9934);
        expect(Test00140_Rtn?.rank_reward_9,9935);
        expect(Test00140_Rtn?.rank_reward_10,9936);
        expect(Test00140_Rtn?.start_datetime,'abc37');
        expect(Test00140_Rtn?.end_datetime,'abc38');
        expect(Test00140_Rtn?.timesch_flg,9939);
        expect(Test00140_Rtn?.sun_flg,9940);
        expect(Test00140_Rtn?.mon_flg,9941);
        expect(Test00140_Rtn?.tue_flg,9942);
        expect(Test00140_Rtn?.wed_flg,9943);
        expect(Test00140_Rtn?.thu_flg,9944);
        expect(Test00140_Rtn?.fri_flg,9945);
        expect(Test00140_Rtn?.sat_flg,9946);
        expect(Test00140_Rtn?.seq_no,9947);
        expect(Test00140_Rtn?.promo_ext_id,'abc48');
        expect(Test00140_Rtn?.acct_cd,9949);
        expect(Test00140_Rtn?.stop_flg,9950);
        expect(Test00140_Rtn?.ins_datetime,'abc51');
        expect(Test00140_Rtn?.upd_datetime,'abc52');
        expect(Test00140_Rtn?.status,9953);
        expect(Test00140_Rtn?.send_flg,9954);
        expect(Test00140_Rtn?.upd_user,9955);
        expect(Test00140_Rtn?.upd_system,9956);
      }

      //selectAllDataをして件数取得。
      List<CRankMst> Test00140_AllRtn2 = await db.selectAllData(Test00140_1);
      int count2 = Test00140_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00140_1);
      print('********** テスト終了：00140_CRankMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00141 : CTrmRsrvMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00141_CTrmRsrvMst_01', () async {
      print('\n********** テスト実行：00141_CTrmRsrvMst_01 **********');
      CTrmRsrvMst Test00141_1 = CTrmRsrvMst();
      Test00141_1.comp_cd = 9912;
      Test00141_1.stre_cd = 9913;
      Test00141_1.trm_cd = 9914;
      Test00141_1.kopt_cd = 9915;
      Test00141_1.rsrv_datetime = 'abc16';
      Test00141_1.trm_data = 1.217;
      Test00141_1.trm_data_str = 'abc18';
      Test00141_1.trm_data_typ = 9919;
      Test00141_1.trm_ref_flg = 9920;
      Test00141_1.seq_no = 9921;
      Test00141_1.promo_ext_id = 'abc22';
      Test00141_1.ins_datetime = 'abc23';
      Test00141_1.upd_datetime = 'abc24';
      Test00141_1.status = 9925;
      Test00141_1.send_flg = 9926;
      Test00141_1.upd_user = 9927;
      Test00141_1.upd_system = 9928;
      Test00141_1.stop_flg = 9929;

      //selectAllDataをして件数取得。
      List<CTrmRsrvMst> Test00141_AllRtn = await db.selectAllData(Test00141_1);
      int count = Test00141_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00141_1);

      //データ取得に必要なオブジェクトを用意
      CTrmRsrvMst Test00141_2 = CTrmRsrvMst();
      //Keyの値を設定する
      Test00141_2.comp_cd = 9912;
      Test00141_2.stre_cd = 9913;
      Test00141_2.trm_cd = 9914;
      Test00141_2.kopt_cd = 9915;
      Test00141_2.rsrv_datetime = 'abc16';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTrmRsrvMst? Test00141_Rtn = await db.selectDataByPrimaryKey(Test00141_2);
      //取得行がない場合、nullが返ってきます
      if (Test00141_Rtn == null) {
        print('\n********** 異常発生：00141_CTrmRsrvMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00141_Rtn?.comp_cd,9912);
        expect(Test00141_Rtn?.stre_cd,9913);
        expect(Test00141_Rtn?.trm_cd,9914);
        expect(Test00141_Rtn?.kopt_cd,9915);
        expect(Test00141_Rtn?.rsrv_datetime,'abc16');
        expect(Test00141_Rtn?.trm_data,1.217);
        expect(Test00141_Rtn?.trm_data_str,'abc18');
        expect(Test00141_Rtn?.trm_data_typ,9919);
        expect(Test00141_Rtn?.trm_ref_flg,9920);
        expect(Test00141_Rtn?.seq_no,9921);
        expect(Test00141_Rtn?.promo_ext_id,'abc22');
        expect(Test00141_Rtn?.ins_datetime,'abc23');
        expect(Test00141_Rtn?.upd_datetime,'abc24');
        expect(Test00141_Rtn?.status,9925);
        expect(Test00141_Rtn?.send_flg,9926);
        expect(Test00141_Rtn?.upd_user,9927);
        expect(Test00141_Rtn?.upd_system,9928);
        expect(Test00141_Rtn?.stop_flg,9929);
      }

      //selectAllDataをして件数取得。
      List<CTrmRsrvMst> Test00141_AllRtn2 = await db.selectAllData(Test00141_1);
      int count2 = Test00141_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00141_1);
      print('********** テスト終了：00141_CTrmRsrvMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00142 : CPntschMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00142_CPntschMst_01', () async {
      print('\n********** テスト実行：00142_CPntschMst_01 **********');
      CPntschMst Test00142_1 = CPntschMst();
      Test00142_1.comp_cd = 9912;
      Test00142_1.stre_cd = 9913;
      Test00142_1.pntsch_cd = 9914;
      Test00142_1.name = 'abc15';
      Test00142_1.start_datetime = 'abc16';
      Test00142_1.end_datetime = 'abc17';
      Test00142_1.timesch_flg = 9918;
      Test00142_1.sun_flg = 9919;
      Test00142_1.mon_flg = 9920;
      Test00142_1.tue_flg = 9921;
      Test00142_1.wed_flg = 9922;
      Test00142_1.thu_flg = 9923;
      Test00142_1.fri_flg = 9924;
      Test00142_1.sat_flg = 9925;
      Test00142_1.stop_flg = 9926;
      Test00142_1.seq_no = 9927;
      Test00142_1.promo_ext_id = 'abc28';
      Test00142_1.acct_cd = 9929;
      Test00142_1.ins_datetime = 'abc30';
      Test00142_1.upd_datetime = 'abc31';
      Test00142_1.status = 9932;
      Test00142_1.send_flg = 9933;
      Test00142_1.upd_user = 9934;
      Test00142_1.upd_system = 9935;

      //selectAllDataをして件数取得。
      List<CPntschMst> Test00142_AllRtn = await db.selectAllData(Test00142_1);
      int count = Test00142_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00142_1);

      //データ取得に必要なオブジェクトを用意
      CPntschMst Test00142_2 = CPntschMst();
      //Keyの値を設定する
      Test00142_2.comp_cd = 9912;
      Test00142_2.stre_cd = 9913;
      Test00142_2.pntsch_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPntschMst? Test00142_Rtn = await db.selectDataByPrimaryKey(Test00142_2);
      //取得行がない場合、nullが返ってきます
      if (Test00142_Rtn == null) {
        print('\n********** 異常発生：00142_CPntschMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00142_Rtn?.comp_cd,9912);
        expect(Test00142_Rtn?.stre_cd,9913);
        expect(Test00142_Rtn?.pntsch_cd,9914);
        expect(Test00142_Rtn?.name,'abc15');
        expect(Test00142_Rtn?.start_datetime,'abc16');
        expect(Test00142_Rtn?.end_datetime,'abc17');
        expect(Test00142_Rtn?.timesch_flg,9918);
        expect(Test00142_Rtn?.sun_flg,9919);
        expect(Test00142_Rtn?.mon_flg,9920);
        expect(Test00142_Rtn?.tue_flg,9921);
        expect(Test00142_Rtn?.wed_flg,9922);
        expect(Test00142_Rtn?.thu_flg,9923);
        expect(Test00142_Rtn?.fri_flg,9924);
        expect(Test00142_Rtn?.sat_flg,9925);
        expect(Test00142_Rtn?.stop_flg,9926);
        expect(Test00142_Rtn?.seq_no,9927);
        expect(Test00142_Rtn?.promo_ext_id,'abc28');
        expect(Test00142_Rtn?.acct_cd,9929);
        expect(Test00142_Rtn?.ins_datetime,'abc30');
        expect(Test00142_Rtn?.upd_datetime,'abc31');
        expect(Test00142_Rtn?.status,9932);
        expect(Test00142_Rtn?.send_flg,9933);
        expect(Test00142_Rtn?.upd_user,9934);
        expect(Test00142_Rtn?.upd_system,9935);
      }

      //selectAllDataをして件数取得。
      List<CPntschMst> Test00142_AllRtn2 = await db.selectAllData(Test00142_1);
      int count2 = Test00142_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00142_1);
      print('********** テスト終了：00142_CPntschMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00143 : CPntschgrpMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00143_CPntschgrpMst_01', () async {
      print('\n********** テスト実行：00143_CPntschgrpMst_01 **********');
      CPntschgrpMst Test00143_1 = CPntschgrpMst();
      Test00143_1.comp_cd = 9912;
      Test00143_1.stre_cd = 9913;
      Test00143_1.pntsch_cd = 9914;
      Test00143_1.trm_grp_cd = 9915;
      Test00143_1.trm_cd = 9916;
      Test00143_1.trm_data = 1.217;
      Test00143_1.stop_flg = 9918;
      Test00143_1.ins_datetime = 'abc19';
      Test00143_1.upd_datetime = 'abc20';
      Test00143_1.status = 9921;
      Test00143_1.send_flg = 9922;
      Test00143_1.upd_user = 9923;
      Test00143_1.upd_system = 9924;
      Test00143_1.low_lim = 9925;
      Test00143_1.acct_cd = 9926;

      //selectAllDataをして件数取得。
      List<CPntschgrpMst> Test00143_AllRtn = await db.selectAllData(Test00143_1);
      int count = Test00143_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00143_1);

      //データ取得に必要なオブジェクトを用意
      CPntschgrpMst Test00143_2 = CPntschgrpMst();
      //Keyの値を設定する
      Test00143_2.comp_cd = 9912;
      Test00143_2.stre_cd = 9913;
      Test00143_2.pntsch_cd = 9914;
      Test00143_2.trm_grp_cd = 9915;
      Test00143_2.trm_cd = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CPntschgrpMst? Test00143_Rtn = await db.selectDataByPrimaryKey(Test00143_2);
      //取得行がない場合、nullが返ってきます
      if (Test00143_Rtn == null) {
        print('\n********** 異常発生：00143_CPntschgrpMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00143_Rtn?.comp_cd,9912);
        expect(Test00143_Rtn?.stre_cd,9913);
        expect(Test00143_Rtn?.pntsch_cd,9914);
        expect(Test00143_Rtn?.trm_grp_cd,9915);
        expect(Test00143_Rtn?.trm_cd,9916);
        expect(Test00143_Rtn?.trm_data,1.217);
        expect(Test00143_Rtn?.stop_flg,9918);
        expect(Test00143_Rtn?.ins_datetime,'abc19');
        expect(Test00143_Rtn?.upd_datetime,'abc20');
        expect(Test00143_Rtn?.status,9921);
        expect(Test00143_Rtn?.send_flg,9922);
        expect(Test00143_Rtn?.upd_user,9923);
        expect(Test00143_Rtn?.upd_system,9924);
        expect(Test00143_Rtn?.low_lim,9925);
        expect(Test00143_Rtn?.acct_cd,9926);
      }

      //selectAllDataをして件数取得。
      List<CPntschgrpMst> Test00143_AllRtn2 = await db.selectAllData(Test00143_1);
      int count2 = Test00143_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00143_1);
      print('********** テスト終了：00143_CPntschgrpMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00144 : CTrmPlanMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00144_CTrmPlanMst_01', () async {
      print('\n********** テスト実行：00144_CTrmPlanMst_01 **********');
      CTrmPlanMst Test00144_1 = CTrmPlanMst();
      Test00144_1.comp_cd = 9912;
      Test00144_1.stre_cd = 9913;
      Test00144_1.acct_cd = 9914;
      Test00144_1.acct_flg = 9915;
      Test00144_1.seq_no = 9916;
      Test00144_1.promo_ext_id = 'abc17';
      Test00144_1.ins_datetime = 'abc18';
      Test00144_1.upd_datetime = 'abc19';
      Test00144_1.status = 9920;
      Test00144_1.send_flg = 9921;
      Test00144_1.upd_user = 9922;
      Test00144_1.upd_system = 9923;

      //selectAllDataをして件数取得。
      List<CTrmPlanMst> Test00144_AllRtn = await db.selectAllData(Test00144_1);
      int count = Test00144_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00144_1);

      //データ取得に必要なオブジェクトを用意
      CTrmPlanMst Test00144_2 = CTrmPlanMst();
      //Keyの値を設定する
      Test00144_2.comp_cd = 9912;
      Test00144_2.stre_cd = 9913;
      Test00144_2.acct_cd = 9914;
      Test00144_2.acct_flg = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CTrmPlanMst? Test00144_Rtn = await db.selectDataByPrimaryKey(Test00144_2);
      //取得行がない場合、nullが返ってきます
      if (Test00144_Rtn == null) {
        print('\n********** 異常発生：00144_CTrmPlanMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00144_Rtn?.comp_cd,9912);
        expect(Test00144_Rtn?.stre_cd,9913);
        expect(Test00144_Rtn?.acct_cd,9914);
        expect(Test00144_Rtn?.acct_flg,9915);
        expect(Test00144_Rtn?.seq_no,9916);
        expect(Test00144_Rtn?.promo_ext_id,'abc17');
        expect(Test00144_Rtn?.ins_datetime,'abc18');
        expect(Test00144_Rtn?.upd_datetime,'abc19');
        expect(Test00144_Rtn?.status,9920);
        expect(Test00144_Rtn?.send_flg,9921);
        expect(Test00144_Rtn?.upd_user,9922);
        expect(Test00144_Rtn?.upd_system,9923);
      }

      //selectAllDataをして件数取得。
      List<CTrmPlanMst> Test00144_AllRtn2 = await db.selectAllData(Test00144_1);
      int count2 = Test00144_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00144_1);
      print('********** テスト終了：00144_CTrmPlanMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00145 : SCustStpTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00145_SCustStpTbl_01', () async {
      print('\n********** テスト実行：00145_SCustStpTbl_01 **********');
      SCustStpTbl Test00145_1 = SCustStpTbl();
      Test00145_1.cust_no = 'abc12';
      Test00145_1.comp_cd = 9913;
      Test00145_1.acct_cd = 9914;
      Test00145_1.acc_amt = 9915;
      Test00145_1.red_amt = 9916;
      Test00145_1.last_upd_date = 'abc17';
      Test00145_1.stop_flg = 9918;
      Test00145_1.ins_datetime = 'abc19';
      Test00145_1.upd_datetime = 'abc20';
      Test00145_1.status = 9921;
      Test00145_1.send_flg = 9922;
      Test00145_1.upd_user = 9923;
      Test00145_1.upd_system = 9924;
      Test00145_1.cpn_id = 9925;
      Test00145_1.tday_acc_amt = 9926;

      //selectAllDataをして件数取得。
      List<SCustStpTbl> Test00145_AllRtn = await db.selectAllData(Test00145_1);
      int count = Test00145_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00145_1);

      //データ取得に必要なオブジェクトを用意
      SCustStpTbl Test00145_2 = SCustStpTbl();
      //Keyの値を設定する
      Test00145_2.cust_no = 'abc12';
      Test00145_2.comp_cd = 9913;
      Test00145_2.acct_cd = 9914;
      Test00145_2.cpn_id = 9925;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SCustStpTbl? Test00145_Rtn = await db.selectDataByPrimaryKey(Test00145_2);
      //取得行がない場合、nullが返ってきます
      if (Test00145_Rtn == null) {
        print('\n********** 異常発生：00145_SCustStpTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00145_Rtn?.cust_no,'abc12');
        expect(Test00145_Rtn?.comp_cd,9913);
        expect(Test00145_Rtn?.acct_cd,9914);
        expect(Test00145_Rtn?.acc_amt,9915);
        expect(Test00145_Rtn?.red_amt,9916);
        expect(Test00145_Rtn?.last_upd_date,'abc17');
        expect(Test00145_Rtn?.stop_flg,9918);
        expect(Test00145_Rtn?.ins_datetime,'abc19');
        expect(Test00145_Rtn?.upd_datetime,'abc20');
        expect(Test00145_Rtn?.status,9921);
        expect(Test00145_Rtn?.send_flg,9922);
        expect(Test00145_Rtn?.upd_user,9923);
        expect(Test00145_Rtn?.upd_system,9924);
        expect(Test00145_Rtn?.cpn_id,9925);
        expect(Test00145_Rtn?.tday_acc_amt,9926);
      }

      //selectAllDataをして件数取得。
      List<SCustStpTbl> Test00145_AllRtn2 = await db.selectAllData(Test00145_1);
      int count2 = Test00145_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00145_1);
      print('********** テスト終了：00145_SCustStpTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00146 : CStpplnMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00146_CStpplnMst_01', () async {
      print('\n********** テスト実行：00146_CStpplnMst_01 **********');
      CStpplnMst Test00146_1 = CStpplnMst();
      Test00146_1.cpn_id = 9912;
      Test00146_1.plan_cd = 9913;
      Test00146_1.comp_cd = 9914;
      Test00146_1.stre_cd = 9915;
      Test00146_1.all_cust_flg = 9916;
      Test00146_1.cust_kind_flg = 9917;
      Test00146_1.plan_name = 'abc18';
      Test00146_1.rcpt_name = 'abc19';
      Test00146_1.format_flg = 9920;
      Test00146_1.pict_path = 'abc21';
      Test00146_1.notes = 'abc22';
      Test00146_1.prn_stre_name = 'abc23';
      Test00146_1.prn_time = 'abc24';
      Test00146_1.c_data1 = 'abc25';
      Test00146_1.c_data2 = 'abc26';
      Test00146_1.c_data3 = 'abc27';
      Test00146_1.c_data4 = 'abc28';
      Test00146_1.c_data5 = 'abc29';
      Test00146_1.c_data6 = 'abc30';
      Test00146_1.s_data1 = 9931;
      Test00146_1.s_data2 = 9932;
      Test00146_1.s_data3 = 9933;
      Test00146_1.ref_unit_flg = 9934;
      Test00146_1.cond_class_flg = 9935;
      Test00146_1.low_lim = 9936;
      Test00146_1.upp_lim = 9937;
      Test00146_1.rec_limit = 9938;
      Test00146_1.day_limit = 9939;
      Test00146_1.max_limit = 9940;
      Test00146_1.start_datetime = 'abc41';
      Test00146_1.end_datetime = 'abc42';
      Test00146_1.svs_start_datetime = 'abc43';
      Test00146_1.svs_end_datetime = 'abc44';
      Test00146_1.stop_flg = 9945;
      Test00146_1.timesch_flg = 9946;
      Test00146_1.sun_flg = 9947;
      Test00146_1.mon_flg = 9948;
      Test00146_1.tue_flg = 9949;
      Test00146_1.wed_flg = 9950;
      Test00146_1.thu_flg = 9951;
      Test00146_1.fri_flg = 9952;
      Test00146_1.sat_flg = 9953;
      Test00146_1.date_flg1 = 9954;
      Test00146_1.date_flg2 = 9955;
      Test00146_1.date_flg3 = 9956;
      Test00146_1.date_flg4 = 9957;
      Test00146_1.date_flg5 = 9958;
      Test00146_1.ins_datetime = 'abc59';
      Test00146_1.upd_datetime = 'abc60';
      Test00146_1.status = 9961;
      Test00146_1.send_flg = 9962;
      Test00146_1.upd_user = 9963;
      Test00146_1.upd_system = 9964;
      Test00146_1.cust_kind_trgt = 'abc65';
      Test00146_1.n_custom1 = 9966;
      Test00146_1.n_custom2 = 9967;
      Test00146_1.n_custom3 = 9968;
      Test00146_1.n_custom4 = 9969;
      Test00146_1.n_custom5 = 9970;
      Test00146_1.n_custom6 = 9971;
      Test00146_1.n_custom7 = 9972;
      Test00146_1.n_custom8 = 9973;
      Test00146_1.s_custom1 = 9974;
      Test00146_1.s_custom2 = 9975;
      Test00146_1.s_custom3 = 9976;
      Test00146_1.s_custom4 = 9977;
      Test00146_1.s_custom5 = 9978;
      Test00146_1.s_custom6 = 9979;
      Test00146_1.s_custom7 = 9980;
      Test00146_1.s_custom8 = 9981;
      Test00146_1.c_custom1 = 'abc82';
      Test00146_1.c_custom2 = 'abc83';
      Test00146_1.c_custom3 = 'abc84';
      Test00146_1.c_custom4 = 'abc85';
      Test00146_1.d_custom1 = 'abc86';
      Test00146_1.d_custom2 = 'abc87';
      Test00146_1.d_custom3 = 'abc88';
      Test00146_1.d_custom4 = 'abc89';

      //selectAllDataをして件数取得。
      List<CStpplnMst> Test00146_AllRtn = await db.selectAllData(Test00146_1);
      int count = Test00146_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00146_1);

      //データ取得に必要なオブジェクトを用意
      CStpplnMst Test00146_2 = CStpplnMst();
      //Keyの値を設定する
      Test00146_2.cpn_id = 9912;
      Test00146_2.plan_cd = 9913;
      Test00146_2.comp_cd = 9914;
      Test00146_2.stre_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStpplnMst? Test00146_Rtn = await db.selectDataByPrimaryKey(Test00146_2);
      //取得行がない場合、nullが返ってきます
      if (Test00146_Rtn == null) {
        print('\n********** 異常発生：00146_CStpplnMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00146_Rtn?.cpn_id,9912);
        expect(Test00146_Rtn?.plan_cd,9913);
        expect(Test00146_Rtn?.comp_cd,9914);
        expect(Test00146_Rtn?.stre_cd,9915);
        expect(Test00146_Rtn?.all_cust_flg,9916);
        expect(Test00146_Rtn?.cust_kind_flg,9917);
        expect(Test00146_Rtn?.plan_name,'abc18');
        expect(Test00146_Rtn?.rcpt_name,'abc19');
        expect(Test00146_Rtn?.format_flg,9920);
        expect(Test00146_Rtn?.pict_path,'abc21');
        expect(Test00146_Rtn?.notes,'abc22');
        expect(Test00146_Rtn?.prn_stre_name,'abc23');
        expect(Test00146_Rtn?.prn_time,'abc24');
        expect(Test00146_Rtn?.c_data1,'abc25');
        expect(Test00146_Rtn?.c_data2,'abc26');
        expect(Test00146_Rtn?.c_data3,'abc27');
        expect(Test00146_Rtn?.c_data4,'abc28');
        expect(Test00146_Rtn?.c_data5,'abc29');
        expect(Test00146_Rtn?.c_data6,'abc30');
        expect(Test00146_Rtn?.s_data1,9931);
        expect(Test00146_Rtn?.s_data2,9932);
        expect(Test00146_Rtn?.s_data3,9933);
        expect(Test00146_Rtn?.ref_unit_flg,9934);
        expect(Test00146_Rtn?.cond_class_flg,9935);
        expect(Test00146_Rtn?.low_lim,9936);
        expect(Test00146_Rtn?.upp_lim,9937);
        expect(Test00146_Rtn?.rec_limit,9938);
        expect(Test00146_Rtn?.day_limit,9939);
        expect(Test00146_Rtn?.max_limit,9940);
        expect(Test00146_Rtn?.start_datetime,'abc41');
        expect(Test00146_Rtn?.end_datetime,'abc42');
        expect(Test00146_Rtn?.svs_start_datetime,'abc43');
        expect(Test00146_Rtn?.svs_end_datetime,'abc44');
        expect(Test00146_Rtn?.stop_flg,9945);
        expect(Test00146_Rtn?.timesch_flg,9946);
        expect(Test00146_Rtn?.sun_flg,9947);
        expect(Test00146_Rtn?.mon_flg,9948);
        expect(Test00146_Rtn?.tue_flg,9949);
        expect(Test00146_Rtn?.wed_flg,9950);
        expect(Test00146_Rtn?.thu_flg,9951);
        expect(Test00146_Rtn?.fri_flg,9952);
        expect(Test00146_Rtn?.sat_flg,9953);
        expect(Test00146_Rtn?.date_flg1,9954);
        expect(Test00146_Rtn?.date_flg2,9955);
        expect(Test00146_Rtn?.date_flg3,9956);
        expect(Test00146_Rtn?.date_flg4,9957);
        expect(Test00146_Rtn?.date_flg5,9958);
        expect(Test00146_Rtn?.ins_datetime,'abc59');
        expect(Test00146_Rtn?.upd_datetime,'abc60');
        expect(Test00146_Rtn?.status,9961);
        expect(Test00146_Rtn?.send_flg,9962);
        expect(Test00146_Rtn?.upd_user,9963);
        expect(Test00146_Rtn?.upd_system,9964);
        expect(Test00146_Rtn?.cust_kind_trgt,'abc65');
        expect(Test00146_Rtn?.n_custom1,9966);
        expect(Test00146_Rtn?.n_custom2,9967);
        expect(Test00146_Rtn?.n_custom3,9968);
        expect(Test00146_Rtn?.n_custom4,9969);
        expect(Test00146_Rtn?.n_custom5,9970);
        expect(Test00146_Rtn?.n_custom6,9971);
        expect(Test00146_Rtn?.n_custom7,9972);
        expect(Test00146_Rtn?.n_custom8,9973);
        expect(Test00146_Rtn?.s_custom1,9974);
        expect(Test00146_Rtn?.s_custom2,9975);
        expect(Test00146_Rtn?.s_custom3,9976);
        expect(Test00146_Rtn?.s_custom4,9977);
        expect(Test00146_Rtn?.s_custom5,9978);
        expect(Test00146_Rtn?.s_custom6,9979);
        expect(Test00146_Rtn?.s_custom7,9980);
        expect(Test00146_Rtn?.s_custom8,9981);
        expect(Test00146_Rtn?.c_custom1,'abc82');
        expect(Test00146_Rtn?.c_custom2,'abc83');
        expect(Test00146_Rtn?.c_custom3,'abc84');
        expect(Test00146_Rtn?.c_custom4,'abc85');
        expect(Test00146_Rtn?.d_custom1,'abc86');
        expect(Test00146_Rtn?.d_custom2,'abc87');
        expect(Test00146_Rtn?.d_custom3,'abc88');
        expect(Test00146_Rtn?.d_custom4,'abc89');
      }

      //selectAllDataをして件数取得。
      List<CStpplnMst> Test00146_AllRtn2 = await db.selectAllData(Test00146_1);
      int count2 = Test00146_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00146_1);
      print('********** テスト終了：00146_CStpplnMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00148 : CCustMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00148_CCustMst_01', () async {
      print('\n********** テスト実行：00148_CCustMst_01 **********');
      CCustMst Test00148_1 = CCustMst();
      Test00148_1.cust_no = 'abc12';
      Test00148_1.comp_cd = 9913;
      Test00148_1.stre_cd = 9914;
      Test00148_1.last_name = 'abc15';
      Test00148_1.first_name = 'abc16';
      Test00148_1.kana_last_name = 'abc17';
      Test00148_1.kana_first_name = 'abc18';
      Test00148_1.birth_day = 'abc19';
      Test00148_1.tel_no1 = 'abc20';
      Test00148_1.tel_no2 = 'abc21';
      Test00148_1.sex = 9922;
      Test00148_1.cust_status = 9923;
      Test00148_1.admission_date = 'abc24';
      Test00148_1.withdraw_date = 'abc25';
      Test00148_1.withdraw_typ = 9926;
      Test00148_1.withdraw_resn = 'abc27';
      Test00148_1.card_clct_typ = 9928;
      Test00148_1.custzone_cd = 9929;
      Test00148_1.post_no = 'abc30';
      Test00148_1.address1 = 'abc31';
      Test00148_1.address2 = 'abc32';
      Test00148_1.address3 = 'abc33';
      Test00148_1.mail_addr = 'abc34';
      Test00148_1.mail_flg = 9935;
      Test00148_1.dm_flg = 9936;
      Test00148_1.password = 'abc37';
      Test00148_1.targ_typ = 9938;
      Test00148_1.attrib1 = 9939;
      Test00148_1.attrib2 = 9940;
      Test00148_1.attrib3 = 9941;
      Test00148_1.attrib4 = 9942;
      Test00148_1.attrib5 = 9943;
      Test00148_1.attrib6 = 9944;
      Test00148_1.attrib7 = 9945;
      Test00148_1.attrib8 = 9946;
      Test00148_1.attrib9 = 9947;
      Test00148_1.attrib10 = 9948;
      Test00148_1.mov_flg = 9949;
      Test00148_1.pre_cust_no = 'abc50';
      Test00148_1.remark = 'abc51';
      Test00148_1.ins_datetime = 'abc52';
      Test00148_1.upd_datetime = 'abc53';
      Test00148_1.status = 9954;
      Test00148_1.send_flg = 9955;
      Test00148_1.upd_user = 9956;
      Test00148_1.upd_system = 9957;
      Test00148_1.svs_cls_cd = 9958;
      Test00148_1.staff_flg = 9959;
      Test00148_1.cust_prc_type = 9960;
      Test00148_1.address4 = 'abc61';
      Test00148_1.tel_flg = 9962;

      //selectAllDataをして件数取得。
      List<CCustMst> Test00148_AllRtn = await db.selectAllData(Test00148_1);
      int count = Test00148_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00148_1);

      //データ取得に必要なオブジェクトを用意
      CCustMst Test00148_2 = CCustMst();
      //Keyの値を設定する
      Test00148_2.cust_no = 'abc12';
      Test00148_2.comp_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCustMst? Test00148_Rtn = await db.selectDataByPrimaryKey(Test00148_2);
      //取得行がない場合、nullが返ってきます
      if (Test00148_Rtn == null) {
        print('\n********** 異常発生：00148_CCustMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00148_Rtn?.cust_no,'abc12');
        expect(Test00148_Rtn?.comp_cd,9913);
        expect(Test00148_Rtn?.stre_cd,9914);
        expect(Test00148_Rtn?.last_name,'abc15');
        expect(Test00148_Rtn?.first_name,'abc16');
        expect(Test00148_Rtn?.kana_last_name,'abc17');
        expect(Test00148_Rtn?.kana_first_name,'abc18');
        expect(Test00148_Rtn?.birth_day,'abc19');
        expect(Test00148_Rtn?.tel_no1,'abc20');
        expect(Test00148_Rtn?.tel_no2,'abc21');
        expect(Test00148_Rtn?.sex,9922);
        expect(Test00148_Rtn?.cust_status,9923);
        expect(Test00148_Rtn?.admission_date,'abc24');
        expect(Test00148_Rtn?.withdraw_date,'abc25');
        expect(Test00148_Rtn?.withdraw_typ,9926);
        expect(Test00148_Rtn?.withdraw_resn,'abc27');
        expect(Test00148_Rtn?.card_clct_typ,9928);
        expect(Test00148_Rtn?.custzone_cd,9929);
        expect(Test00148_Rtn?.post_no,'abc30');
        expect(Test00148_Rtn?.address1,'abc31');
        expect(Test00148_Rtn?.address2,'abc32');
        expect(Test00148_Rtn?.address3,'abc33');
        expect(Test00148_Rtn?.mail_addr,'abc34');
        expect(Test00148_Rtn?.mail_flg,9935);
        expect(Test00148_Rtn?.dm_flg,9936);
        expect(Test00148_Rtn?.password,'abc37');
        expect(Test00148_Rtn?.targ_typ,9938);
        expect(Test00148_Rtn?.attrib1,9939);
        expect(Test00148_Rtn?.attrib2,9940);
        expect(Test00148_Rtn?.attrib3,9941);
        expect(Test00148_Rtn?.attrib4,9942);
        expect(Test00148_Rtn?.attrib5,9943);
        expect(Test00148_Rtn?.attrib6,9944);
        expect(Test00148_Rtn?.attrib7,9945);
        expect(Test00148_Rtn?.attrib8,9946);
        expect(Test00148_Rtn?.attrib9,9947);
        expect(Test00148_Rtn?.attrib10,9948);
        expect(Test00148_Rtn?.mov_flg,9949);
        expect(Test00148_Rtn?.pre_cust_no,'abc50');
        expect(Test00148_Rtn?.remark,'abc51');
        expect(Test00148_Rtn?.ins_datetime,'abc52');
        expect(Test00148_Rtn?.upd_datetime,'abc53');
        expect(Test00148_Rtn?.status,9954);
        expect(Test00148_Rtn?.send_flg,9955);
        expect(Test00148_Rtn?.upd_user,9956);
        expect(Test00148_Rtn?.upd_system,9957);
        expect(Test00148_Rtn?.svs_cls_cd,9958);
        expect(Test00148_Rtn?.staff_flg,9959);
        expect(Test00148_Rtn?.cust_prc_type,9960);
        expect(Test00148_Rtn?.address4,'abc61');
        expect(Test00148_Rtn?.tel_flg,9962);
      }

      //selectAllDataをして件数取得。
      List<CCustMst> Test00148_AllRtn2 = await db.selectAllData(Test00148_1);
      int count2 = Test00148_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00148_1);
      print('********** テスト終了：00148_CCustMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00149 : SDaybookSppluTbl
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00149_SDaybookSppluTbl_01', () async {
      print('\n********** テスト実行：00149_SDaybookSppluTbl_01 **********');
      SDaybookSppluTbl Test00149_1 = SDaybookSppluTbl();
      Test00149_1.plu_cd = 'abc12';
      Test00149_1.ins_datetime = 'abc13';
      Test00149_1.upd_datetime = 'abc14';
      Test00149_1.status = 9915;
      Test00149_1.send_flg = 9916;
      Test00149_1.upd_user = 9917;
      Test00149_1.upd_system = 9918;

      //selectAllDataをして件数取得。
      List<SDaybookSppluTbl> Test00149_AllRtn = await db.selectAllData(Test00149_1);
      int count = Test00149_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00149_1);

      //データ取得に必要なオブジェクトを用意
      SDaybookSppluTbl Test00149_2 = SDaybookSppluTbl();
      //Keyの値を設定する
      Test00149_2.plu_cd = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SDaybookSppluTbl? Test00149_Rtn = await db.selectDataByPrimaryKey(Test00149_2);
      //取得行がない場合、nullが返ってきます
      if (Test00149_Rtn == null) {
        print('\n********** 異常発生：00149_SDaybookSppluTbl_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00149_Rtn?.plu_cd,'abc12');
        expect(Test00149_Rtn?.ins_datetime,'abc13');
        expect(Test00149_Rtn?.upd_datetime,'abc14');
        expect(Test00149_Rtn?.status,9915);
        expect(Test00149_Rtn?.send_flg,9916);
        expect(Test00149_Rtn?.upd_user,9917);
        expect(Test00149_Rtn?.upd_system,9918);
      }

      //selectAllDataをして件数取得。
      List<SDaybookSppluTbl> Test00149_AllRtn2 = await db.selectAllData(Test00149_1);
      int count2 = Test00149_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00149_1);
      print('********** テスト終了：00149_SDaybookSppluTbl_01 **********\n\n');
    });

    // ********************************************************
    // テスト00150 : CCustJdgMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00150_CCustJdgMst_01', () async {
      print('\n********** テスト実行：00150_CCustJdgMst_01 **********');
      CCustJdgMst Test00150_1 = CCustJdgMst();
      Test00150_1.comp_cd = 9912;
      Test00150_1.refer_stre_cd = 9913;
      Test00150_1.stop_flg = 9914;
      Test00150_1.ins_datetime = 'abc15';
      Test00150_1.upd_datetime = 'abc16';
      Test00150_1.status = 9917;
      Test00150_1.send_flg = 9918;
      Test00150_1.upd_user = 9919;
      Test00150_1.upd_system = 9920;

      //selectAllDataをして件数取得。
      List<CCustJdgMst> Test00150_AllRtn = await db.selectAllData(Test00150_1);
      int count = Test00150_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00150_1);

      //データ取得に必要なオブジェクトを用意
      CCustJdgMst Test00150_2 = CCustJdgMst();
      //Keyの値を設定する
      Test00150_2.comp_cd = 9912;
      Test00150_2.refer_stre_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CCustJdgMst? Test00150_Rtn = await db.selectDataByPrimaryKey(Test00150_2);
      //取得行がない場合、nullが返ってきます
      if (Test00150_Rtn == null) {
        print('\n********** 異常発生：00150_CCustJdgMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00150_Rtn?.comp_cd,9912);
        expect(Test00150_Rtn?.refer_stre_cd,9913);
        expect(Test00150_Rtn?.stop_flg,9914);
        expect(Test00150_Rtn?.ins_datetime,'abc15');
        expect(Test00150_Rtn?.upd_datetime,'abc16');
        expect(Test00150_Rtn?.status,9917);
        expect(Test00150_Rtn?.send_flg,9918);
        expect(Test00150_Rtn?.upd_user,9919);
        expect(Test00150_Rtn?.upd_system,9920);
      }

      //selectAllDataをして件数取得。
      List<CCustJdgMst> Test00150_AllRtn2 = await db.selectAllData(Test00150_1);
      int count2 = Test00150_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00150_1);
      print('********** テスト終了：00150_CCustJdgMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00151 : CMbrcardMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00151_CMbrcardMst_01', () async {
      print('\n********** テスト実行：00151_CMbrcardMst_01 **********');
      CMbrcardMst Test00151_1 = CMbrcardMst();
      Test00151_1.seq_no = 9912;
      Test00151_1.comp_cd = 9913;
      Test00151_1.code_from = 'abc14';
      Test00151_1.code_to = 'abc15';
      Test00151_1.c_data1 = 'abc16';
      Test00151_1.c_data2 = 'abc17';
      Test00151_1.c_data3 = 'abc18';
      Test00151_1.s_data1 = 9919;
      Test00151_1.s_data2 = 9920;
      Test00151_1.n_data1 = 9921;
      Test00151_1.n_data2 = 9922;
      Test00151_1.ins_datetime = 'abc23';
      Test00151_1.upd_datetime = 'abc24';
      Test00151_1.status = 9925;
      Test00151_1.send_flg = 9926;
      Test00151_1.upd_user = 9927;
      Test00151_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<CMbrcardMst> Test00151_AllRtn = await db.selectAllData(Test00151_1);
      int count = Test00151_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00151_1);

      //データ取得に必要なオブジェクトを用意
      CMbrcardMst Test00151_2 = CMbrcardMst();
      //Keyの値を設定する
      Test00151_2.seq_no = 9912;
      Test00151_2.comp_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMbrcardMst? Test00151_Rtn = await db.selectDataByPrimaryKey(Test00151_2);
      //取得行がない場合、nullが返ってきます
      if (Test00151_Rtn == null) {
        print('\n********** 異常発生：00151_CMbrcardMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00151_Rtn?.seq_no,9912);
        expect(Test00151_Rtn?.comp_cd,9913);
        expect(Test00151_Rtn?.code_from,'abc14');
        expect(Test00151_Rtn?.code_to,'abc15');
        expect(Test00151_Rtn?.c_data1,'abc16');
        expect(Test00151_Rtn?.c_data2,'abc17');
        expect(Test00151_Rtn?.c_data3,'abc18');
        expect(Test00151_Rtn?.s_data1,9919);
        expect(Test00151_Rtn?.s_data2,9920);
        expect(Test00151_Rtn?.n_data1,9921);
        expect(Test00151_Rtn?.n_data2,9922);
        expect(Test00151_Rtn?.ins_datetime,'abc23');
        expect(Test00151_Rtn?.upd_datetime,'abc24');
        expect(Test00151_Rtn?.status,9925);
        expect(Test00151_Rtn?.send_flg,9926);
        expect(Test00151_Rtn?.upd_user,9927);
        expect(Test00151_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<CMbrcardMst> Test00151_AllRtn2 = await db.selectAllData(Test00151_1);
      int count2 = Test00151_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00151_1);
      print('********** テスト終了：00151_CMbrcardMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00152 : CMbrcardSvsMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00152_CMbrcardSvsMst_01', () async {
      print('\n********** テスト実行：00152_CMbrcardSvsMst_01 **********');
      CMbrcardSvsMst Test00152_1 = CMbrcardSvsMst();
      Test00152_1.rec_id = 9912;
      Test00152_1.comp_cd = 9913;
      Test00152_1.card_kind = 9914;
      Test00152_1.svs_cd = 9915;
      Test00152_1.c_data1 = 'abc16';
      Test00152_1.c_data2 = 'abc17';
      Test00152_1.c_data3 = 'abc18';
      Test00152_1.s_data1 = 9919;
      Test00152_1.s_data2 = 9920;
      Test00152_1.n_data1 = 9921;
      Test00152_1.n_data2 = 9922;
      Test00152_1.ins_datetime = 'abc23';
      Test00152_1.upd_datetime = 'abc24';
      Test00152_1.status = 9925;
      Test00152_1.send_flg = 9926;
      Test00152_1.upd_user = 9927;
      Test00152_1.upd_system = 9928;

      //selectAllDataをして件数取得。
      List<CMbrcardSvsMst> Test00152_AllRtn = await db.selectAllData(Test00152_1);
      int count = Test00152_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00152_1);

      //データ取得に必要なオブジェクトを用意
      CMbrcardSvsMst Test00152_2 = CMbrcardSvsMst();
      //Keyの値を設定する
      Test00152_2.rec_id = 9912;
      Test00152_2.comp_cd = 9913;
      Test00152_2.card_kind = 9914;
      Test00152_2.svs_cd = 9915;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMbrcardSvsMst? Test00152_Rtn = await db.selectDataByPrimaryKey(Test00152_2);
      //取得行がない場合、nullが返ってきます
      if (Test00152_Rtn == null) {
        print('\n********** 異常発生：00152_CMbrcardSvsMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00152_Rtn?.rec_id,9912);
        expect(Test00152_Rtn?.comp_cd,9913);
        expect(Test00152_Rtn?.card_kind,9914);
        expect(Test00152_Rtn?.svs_cd,9915);
        expect(Test00152_Rtn?.c_data1,'abc16');
        expect(Test00152_Rtn?.c_data2,'abc17');
        expect(Test00152_Rtn?.c_data3,'abc18');
        expect(Test00152_Rtn?.s_data1,9919);
        expect(Test00152_Rtn?.s_data2,9920);
        expect(Test00152_Rtn?.n_data1,9921);
        expect(Test00152_Rtn?.n_data2,9922);
        expect(Test00152_Rtn?.ins_datetime,'abc23');
        expect(Test00152_Rtn?.upd_datetime,'abc24');
        expect(Test00152_Rtn?.status,9925);
        expect(Test00152_Rtn?.send_flg,9926);
        expect(Test00152_Rtn?.upd_user,9927);
        expect(Test00152_Rtn?.upd_system,9928);
      }

      //selectAllDataをして件数取得。
      List<CMbrcardSvsMst> Test00152_AllRtn2 = await db.selectAllData(Test00152_1);
      int count2 = Test00152_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00152_1);
      print('********** テスト終了：00152_CMbrcardSvsMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00153 : CStaffMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00153_CStaffMst_01', () async {
      print('\n********** テスト実行：00153_CStaffMst_01 **********');
      CStaffMst Test00153_1 = CStaffMst();
      Test00153_1.comp_cd = 9912;
      Test00153_1.staff_cd = 9913;
      Test00153_1.stre_cd = 9914;
      Test00153_1.name = 'abc15';
      Test00153_1.passwd = 'abc16';
      Test00153_1.auth_lvl = 9917;
      Test00153_1.svr_auth_lvl = 9918;
      Test00153_1.ins_datetime = 'abc19';
      Test00153_1.upd_datetime = 'abc20';
      Test00153_1.status = 9921;
      Test00153_1.send_flg = 9922;
      Test00153_1.upd_user = 9923;
      Test00153_1.upd_system = 9924;
      Test00153_1.nochk_overlap = 9925;

      //selectAllDataをして件数取得。
      List<CStaffMst> Test00153_AllRtn = await db.selectAllData(Test00153_1);
      int count = Test00153_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00153_1);

      //データ取得に必要なオブジェクトを用意
      CStaffMst Test00153_2 = CStaffMst();
      //Keyの値を設定する
      Test00153_2.comp_cd = 9912;
      Test00153_2.staff_cd = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStaffMst? Test00153_Rtn = await db.selectDataByPrimaryKey(Test00153_2);
      //取得行がない場合、nullが返ってきます
      if (Test00153_Rtn == null) {
        print('\n********** 異常発生：00153_CStaffMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00153_Rtn?.comp_cd,9912);
        expect(Test00153_Rtn?.staff_cd,9913);
        expect(Test00153_Rtn?.stre_cd,9914);
        expect(Test00153_Rtn?.name,'abc15');
        expect(Test00153_Rtn?.passwd,'abc16');
        expect(Test00153_Rtn?.auth_lvl,9917);
        expect(Test00153_Rtn?.svr_auth_lvl,9918);
        expect(Test00153_Rtn?.ins_datetime,'abc19');
        expect(Test00153_Rtn?.upd_datetime,'abc20');
        expect(Test00153_Rtn?.status,9921);
        expect(Test00153_Rtn?.send_flg,9922);
        expect(Test00153_Rtn?.upd_user,9923);
        expect(Test00153_Rtn?.upd_system,9924);
        expect(Test00153_Rtn?.nochk_overlap,9925);
      }

      //selectAllDataをして件数取得。
      List<CStaffMst> Test00153_AllRtn2 = await db.selectAllData(Test00153_1);
      int count2 = Test00153_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00153_1);
      print('********** テスト終了：00153_CStaffMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00154 : CStaffauthMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00154_CStaffauthMst_01', () async {
      print('\n********** テスト実行：00154_CStaffauthMst_01 **********');
      CStaffauthMst Test00154_1 = CStaffauthMst();
      Test00154_1.comp_cd = 9912;
      Test00154_1.auth_lvl = 9913;
      Test00154_1.auth_name = 'abc14';
      Test00154_1.ins_datetime = 'abc15';
      Test00154_1.upd_datetime = 'abc16';
      Test00154_1.status = 9917;
      Test00154_1.send_flg = 9918;
      Test00154_1.upd_user = 9919;
      Test00154_1.upd_system = 9920;

      //selectAllDataをして件数取得。
      List<CStaffauthMst> Test00154_AllRtn = await db.selectAllData(Test00154_1);
      int count = Test00154_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00154_1);

      //データ取得に必要なオブジェクトを用意
      CStaffauthMst Test00154_2 = CStaffauthMst();
      //Keyの値を設定する
      Test00154_2.comp_cd = 9912;
      Test00154_2.auth_lvl = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStaffauthMst? Test00154_Rtn = await db.selectDataByPrimaryKey(Test00154_2);
      //取得行がない場合、nullが返ってきます
      if (Test00154_Rtn == null) {
        print('\n********** 異常発生：00154_CStaffauthMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00154_Rtn?.comp_cd,9912);
        expect(Test00154_Rtn?.auth_lvl,9913);
        expect(Test00154_Rtn?.auth_name,'abc14');
        expect(Test00154_Rtn?.ins_datetime,'abc15');
        expect(Test00154_Rtn?.upd_datetime,'abc16');
        expect(Test00154_Rtn?.status,9917);
        expect(Test00154_Rtn?.send_flg,9918);
        expect(Test00154_Rtn?.upd_user,9919);
        expect(Test00154_Rtn?.upd_system,9920);
      }

      //selectAllDataをして件数取得。
      List<CStaffauthMst> Test00154_AllRtn2 = await db.selectAllData(Test00154_1);
      int count2 = Test00154_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00154_1);
      print('********** テスト終了：00154_CStaffauthMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00155 : SSvrStaffauthMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00155_SSvrStaffauthMst_01', () async {
      print('\n********** テスト実行：00155_SSvrStaffauthMst_01 **********');
      SSvrStaffauthMst Test00155_1 = SSvrStaffauthMst();
      Test00155_1.comp_cd = 9912;
      Test00155_1.svr_auth_lvl = 9913;
      Test00155_1.svr_auth_name = 'abc14';
      Test00155_1.ins_datetime = 'abc15';
      Test00155_1.upd_datetime = 'abc16';
      Test00155_1.status = 9917;
      Test00155_1.send_flg = 9918;
      Test00155_1.upd_user = 9919;
      Test00155_1.upd_system = 9920;

      //selectAllDataをして件数取得。
      List<SSvrStaffauthMst> Test00155_AllRtn = await db.selectAllData(Test00155_1);
      int count = Test00155_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00155_1);

      //データ取得に必要なオブジェクトを用意
      SSvrStaffauthMst Test00155_2 = SSvrStaffauthMst();
      //Keyの値を設定する
      Test00155_2.comp_cd = 9912;
      Test00155_2.svr_auth_lvl = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      SSvrStaffauthMst? Test00155_Rtn = await db.selectDataByPrimaryKey(Test00155_2);
      //取得行がない場合、nullが返ってきます
      if (Test00155_Rtn == null) {
        print('\n********** 異常発生：00155_SSvrStaffauthMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00155_Rtn?.comp_cd,9912);
        expect(Test00155_Rtn?.svr_auth_lvl,9913);
        expect(Test00155_Rtn?.svr_auth_name,'abc14');
        expect(Test00155_Rtn?.ins_datetime,'abc15');
        expect(Test00155_Rtn?.upd_datetime,'abc16');
        expect(Test00155_Rtn?.status,9917);
        expect(Test00155_Rtn?.send_flg,9918);
        expect(Test00155_Rtn?.upd_user,9919);
        expect(Test00155_Rtn?.upd_system,9920);
      }

      //selectAllDataをして件数取得。
      List<SSvrStaffauthMst> Test00155_AllRtn2 = await db.selectAllData(Test00155_1);
      int count2 = Test00155_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00155_1);
      print('********** テスト終了：00155_SSvrStaffauthMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00156 : CKeyauthMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00156_CKeyauthMst_01', () async {
      print('\n********** テスト実行：00156_CKeyauthMst_01 **********');
      CKeyauthMst Test00156_1 = CKeyauthMst();
      Test00156_1.comp_cd = 9912;
      Test00156_1.auth_lvl = 9913;
      Test00156_1.fnc_cd = 9914;
      Test00156_1.ins_datetime = 'abc15';
      Test00156_1.upd_datetime = 'abc16';
      Test00156_1.status = 9917;
      Test00156_1.send_flg = 9918;
      Test00156_1.upd_user = 9919;
      Test00156_1.upd_system = 9920;

      //selectAllDataをして件数取得。
      List<CKeyauthMst> Test00156_AllRtn = await db.selectAllData(Test00156_1);
      int count = Test00156_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00156_1);

      //データ取得に必要なオブジェクトを用意
      CKeyauthMst Test00156_2 = CKeyauthMst();
      //Keyの値を設定する
      Test00156_2.comp_cd = 9912;
      Test00156_2.auth_lvl = 9913;
      Test00156_2.fnc_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CKeyauthMst? Test00156_Rtn = await db.selectDataByPrimaryKey(Test00156_2);
      //取得行がない場合、nullが返ってきます
      if (Test00156_Rtn == null) {
        print('\n********** 異常発生：00156_CKeyauthMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00156_Rtn?.comp_cd,9912);
        expect(Test00156_Rtn?.auth_lvl,9913);
        expect(Test00156_Rtn?.fnc_cd,9914);
        expect(Test00156_Rtn?.ins_datetime,'abc15');
        expect(Test00156_Rtn?.upd_datetime,'abc16');
        expect(Test00156_Rtn?.status,9917);
        expect(Test00156_Rtn?.send_flg,9918);
        expect(Test00156_Rtn?.upd_user,9919);
        expect(Test00156_Rtn?.upd_system,9920);
      }

      //selectAllDataをして件数取得。
      List<CKeyauthMst> Test00156_AllRtn2 = await db.selectAllData(Test00156_1);
      int count2 = Test00156_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00156_1);
      print('********** テスト終了：00156_CKeyauthMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00157 : CMenuauthMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00157_CMenuauthMst_01', () async {
      print('\n********** テスト実行：00157_CMenuauthMst_01 **********');
      CMenuauthMst Test00157_1 = CMenuauthMst();
      Test00157_1.comp_cd = 9912;
      Test00157_1.auth_lvl = 9913;
      Test00157_1.appl_grp_cd = 9914;
      Test00157_1.ins_datetime = 'abc15';
      Test00157_1.upd_datetime = 'abc16';
      Test00157_1.status = 9917;
      Test00157_1.send_flg = 9918;
      Test00157_1.upd_user = 9919;
      Test00157_1.upd_system = 9920;
      Test00157_1.menu_chk_flg = 9921;

      //selectAllDataをして件数取得。
      List<CMenuauthMst> Test00157_AllRtn = await db.selectAllData(Test00157_1);
      int count = Test00157_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00157_1);

      //データ取得に必要なオブジェクトを用意
      CMenuauthMst Test00157_2 = CMenuauthMst();
      //Keyの値を設定する
      Test00157_2.comp_cd = 9912;
      Test00157_2.auth_lvl = 9913;
      Test00157_2.appl_grp_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CMenuauthMst? Test00157_Rtn = await db.selectDataByPrimaryKey(Test00157_2);
      //取得行がない場合、nullが返ってきます
      if (Test00157_Rtn == null) {
        print('\n********** 異常発生：00157_CMenuauthMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00157_Rtn?.comp_cd,9912);
        expect(Test00157_Rtn?.auth_lvl,9913);
        expect(Test00157_Rtn?.appl_grp_cd,9914);
        expect(Test00157_Rtn?.ins_datetime,'abc15');
        expect(Test00157_Rtn?.upd_datetime,'abc16');
        expect(Test00157_Rtn?.status,9917);
        expect(Test00157_Rtn?.send_flg,9918);
        expect(Test00157_Rtn?.upd_user,9919);
        expect(Test00157_Rtn?.upd_system,9920);
        expect(Test00157_Rtn?.menu_chk_flg,9921);
      }

      //selectAllDataをして件数取得。
      List<CMenuauthMst> Test00157_AllRtn2 = await db.selectAllData(Test00157_1);
      int count2 = Test00157_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00157_1);
      print('********** テスト終了：00157_CMenuauthMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00158 : CStaffopenMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00158_CStaffopenMst_01', () async {
      print('\n********** テスト実行：00158_CStaffopenMst_01 **********');
      CStaffopenMst Test00158_1 = CStaffopenMst();
      Test00158_1.comp_cd = 9912;
      Test00158_1.stre_cd = 9913;
      Test00158_1.mac_no = 9914;
      Test00158_1.chkr_cd = 'abc15';
      Test00158_1.chkr_name = 'abc16';
      Test00158_1.chkr_status = 9917;
      Test00158_1.chkr_open_time = 'abc18';
      Test00158_1.chkr_start_no = 9919;
      Test00158_1.chkr_end_no = 9920;
      Test00158_1.cshr_cd = 'abc21';
      Test00158_1.cshr_name = 'abc22';
      Test00158_1.cshr_status = 9923;
      Test00158_1.cshr_open_time = 'abc24';
      Test00158_1.cshr_start_no = 9925;
      Test00158_1.cshr_end_no = 9926;
      Test00158_1.ins_datetime = 'abc27';
      Test00158_1.upd_datetime = 'abc28';
      Test00158_1.status = 9929;
      Test00158_1.send_flg = 9930;
      Test00158_1.upd_user = 9931;
      Test00158_1.upd_system = 9932;

      //selectAllDataをして件数取得。
      List<CStaffopenMst> Test00158_AllRtn = await db.selectAllData(Test00158_1);
      int count = Test00158_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00158_1);

      //データ取得に必要なオブジェクトを用意
      CStaffopenMst Test00158_2 = CStaffopenMst();
      //Keyの値を設定する
      Test00158_2.comp_cd = 9912;
      Test00158_2.stre_cd = 9913;
      Test00158_2.mac_no = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CStaffopenMst? Test00158_Rtn = await db.selectDataByPrimaryKey(Test00158_2);
      //取得行がない場合、nullが返ってきます
      if (Test00158_Rtn == null) {
        print('\n********** 異常発生：00158_CStaffopenMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00158_Rtn?.comp_cd,9912);
        expect(Test00158_Rtn?.stre_cd,9913);
        expect(Test00158_Rtn?.mac_no,9914);
        expect(Test00158_Rtn?.chkr_cd,'abc15');
        expect(Test00158_Rtn?.chkr_name,'abc16');
        expect(Test00158_Rtn?.chkr_status,9917);
        expect(Test00158_Rtn?.chkr_open_time,'abc18');
        expect(Test00158_Rtn?.chkr_start_no,9919);
        expect(Test00158_Rtn?.chkr_end_no,9920);
        expect(Test00158_Rtn?.cshr_cd,'abc21');
        expect(Test00158_Rtn?.cshr_name,'abc22');
        expect(Test00158_Rtn?.cshr_status,9923);
        expect(Test00158_Rtn?.cshr_open_time,'abc24');
        expect(Test00158_Rtn?.cshr_start_no,9925);
        expect(Test00158_Rtn?.cshr_end_no,9926);
        expect(Test00158_Rtn?.ins_datetime,'abc27');
        expect(Test00158_Rtn?.upd_datetime,'abc28');
        expect(Test00158_Rtn?.status,9929);
        expect(Test00158_Rtn?.send_flg,9930);
        expect(Test00158_Rtn?.upd_user,9931);
        expect(Test00158_Rtn?.upd_system,9932);
      }

      //selectAllDataをして件数取得。
      List<CStaffopenMst> Test00158_AllRtn2 = await db.selectAllData(Test00158_1);
      int count2 = Test00158_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00158_1);
      print('********** テスト終了：00158_CStaffopenMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00159 : COperationMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00159_COperationMst_01', () async {
      print('\n********** テスト実行：00159_COperationMst_01 **********');
      COperationMst Test00159_1 = COperationMst();
      Test00159_1.comp_cd = 9912;
      Test00159_1.stre_cd = 9913;
      Test00159_1.ope_cd = 9914;
      Test00159_1.ope_name = 'abc15';
      Test00159_1.ins_datetime = 'abc16';
      Test00159_1.upd_datetime = 'abc17';
      Test00159_1.status = 9918;
      Test00159_1.send_flg = 9919;
      Test00159_1.upd_user = 9920;
      Test00159_1.upd_system = 9921;

      //selectAllDataをして件数取得。
      List<COperationMst> Test00159_AllRtn = await db.selectAllData(Test00159_1);
      int count = Test00159_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00159_1);

      //データ取得に必要なオブジェクトを用意
      COperationMst Test00159_2 = COperationMst();
      //Keyの値を設定する
      Test00159_2.comp_cd = 9912;
      Test00159_2.stre_cd = 9913;
      Test00159_2.ope_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      COperationMst? Test00159_Rtn = await db.selectDataByPrimaryKey(Test00159_2);
      //取得行がない場合、nullが返ってきます
      if (Test00159_Rtn == null) {
        print('\n********** 異常発生：00159_COperationMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00159_Rtn?.comp_cd,9912);
        expect(Test00159_Rtn?.stre_cd,9913);
        expect(Test00159_Rtn?.ope_cd,9914);
        expect(Test00159_Rtn?.ope_name,'abc15');
        expect(Test00159_Rtn?.ins_datetime,'abc16');
        expect(Test00159_Rtn?.upd_datetime,'abc17');
        expect(Test00159_Rtn?.status,9918);
        expect(Test00159_Rtn?.send_flg,9919);
        expect(Test00159_Rtn?.upd_user,9920);
        expect(Test00159_Rtn?.upd_system,9921);
      }

      //selectAllDataをして件数取得。
      List<COperationMst> Test00159_AllRtn2 = await db.selectAllData(Test00159_1);
      int count2 = Test00159_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00159_1);
      print('********** テスト終了：00159_COperationMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00160 : COperationauthMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00160_COperationauthMst_01', () async {
      print('\n********** テスト実行：00160_COperationauthMst_01 **********');
      COperationauthMst Test00160_1 = COperationauthMst();
      Test00160_1.comp_cd = 9912;
      Test00160_1.auth_lvl = 9913;
      Test00160_1.ope_cd = 9914;
      Test00160_1.ins_datetime = 'abc15';
      Test00160_1.upd_datetime = 'abc16';
      Test00160_1.status = 9917;
      Test00160_1.send_flg = 9918;
      Test00160_1.upd_user = 9919;
      Test00160_1.upd_system = 9920;

      //selectAllDataをして件数取得。
      List<COperationauthMst> Test00160_AllRtn = await db.selectAllData(Test00160_1);
      int count = Test00160_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00160_1);

      //データ取得に必要なオブジェクトを用意
      COperationauthMst Test00160_2 = COperationauthMst();
      //Keyの値を設定する
      Test00160_2.comp_cd = 9912;
      Test00160_2.auth_lvl = 9913;
      Test00160_2.ope_cd = 9914;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      COperationauthMst? Test00160_Rtn = await db.selectDataByPrimaryKey(Test00160_2);
      //取得行がない場合、nullが返ってきます
      if (Test00160_Rtn == null) {
        print('\n********** 異常発生：00160_COperationauthMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00160_Rtn?.comp_cd,9912);
        expect(Test00160_Rtn?.auth_lvl,9913);
        expect(Test00160_Rtn?.ope_cd,9914);
        expect(Test00160_Rtn?.ins_datetime,'abc15');
        expect(Test00160_Rtn?.upd_datetime,'abc16');
        expect(Test00160_Rtn?.status,9917);
        expect(Test00160_Rtn?.send_flg,9918);
        expect(Test00160_Rtn?.upd_user,9919);
        expect(Test00160_Rtn?.upd_system,9920);
      }

      //selectAllDataをして件数取得。
      List<COperationauthMst> Test00160_AllRtn2 = await db.selectAllData(Test00160_1);
      int count2 = Test00160_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00160_1);
      print('********** テスト終了：00160_COperationauthMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00161 : CHistlogMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00161_CHistlogMst_01', () async {
      print('\n********** テスト実行：00161_CHistlogMst_01 **********');
      CHistlogMst Test00161_1 = CHistlogMst();
      Test00161_1.hist_cd = 9912;
      Test00161_1.ins_datetime = 'abc13';
      Test00161_1.comp_cd = 9914;
      Test00161_1.stre_cd = 9915;
      Test00161_1.table_name = 'abc16';
      Test00161_1.mode = 9917;
      Test00161_1.mac_flg = 9918;
      Test00161_1.data1 = 'abc19';
      Test00161_1.data2 = 'abc20';

      //selectAllDataをして件数取得。
      List<CHistlogMst> Test00161_AllRtn = await db.selectAllData(Test00161_1);
      int count = Test00161_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00161_1);

      //データ取得に必要なオブジェクトを用意
      CHistlogMst Test00161_2 = CHistlogMst();
      //Keyの値を設定する
      Test00161_2.hist_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHistlogMst? Test00161_Rtn = await db.selectDataByPrimaryKey(Test00161_2);
      //取得行がない場合、nullが返ってきます
      if (Test00161_Rtn == null) {
        print('\n********** 異常発生：00161_CHistlogMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00161_Rtn?.hist_cd,9912);
        expect(Test00161_Rtn?.ins_datetime,'abc13');
        expect(Test00161_Rtn?.comp_cd,9914);
        expect(Test00161_Rtn?.stre_cd,9915);
        expect(Test00161_Rtn?.table_name,'abc16');
        expect(Test00161_Rtn?.mode,9917);
        expect(Test00161_Rtn?.mac_flg,9918);
        expect(Test00161_Rtn?.data1,'abc19');
        expect(Test00161_Rtn?.data2,'abc20');
      }

      //selectAllDataをして件数取得。
      List<CHistlogMst> Test00161_AllRtn2 = await db.selectAllData(Test00161_1);
      int count2 = Test00161_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00161_1);
      print('********** テスト終了：00161_CHistlogMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00162 : CHistlogChgCnt
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00162_CHistlogChgCnt_01', () async {
      print('\n********** テスト実行：00162_CHistlogChgCnt_01 **********');
      CHistlogChgCnt Test00162_1 = CHistlogChgCnt();
      Test00162_1.counter_cd = 9912;
      Test00162_1.hist_cd = 9913;
      Test00162_1.ins_datetime = 'abc14';

      //selectAllDataをして件数取得。
      List<CHistlogChgCnt> Test00162_AllRtn = await db.selectAllData(Test00162_1);
      int count = Test00162_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00162_1);

      //データ取得に必要なオブジェクトを用意
      CHistlogChgCnt Test00162_2 = CHistlogChgCnt();
      //Keyの値を設定する
      Test00162_2.counter_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      CHistlogChgCnt? Test00162_Rtn = await db.selectDataByPrimaryKey(Test00162_2);
      //取得行がない場合、nullが返ってきます
      if (Test00162_Rtn == null) {
        print('\n********** 異常発生：00162_CHistlogChgCnt_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00162_Rtn?.counter_cd,9912);
        expect(Test00162_Rtn?.hist_cd,9913);
        expect(Test00162_Rtn?.ins_datetime,'abc14');
      }

      //selectAllDataをして件数取得。
      List<CHistlogChgCnt> Test00162_AllRtn2 = await db.selectAllData(Test00162_1);
      int count2 = Test00162_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00162_1);
      print('********** テスト終了：00162_CHistlogChgCnt_01 **********\n\n');
    });

    // ********************************************************
    // テスト00163 : HistCtrlMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00163_HistCtrlMst_01', () async {
      print('\n********** テスト実行：00163_HistCtrlMst_01 **********');
      HistCtrlMst Test00163_1 = HistCtrlMst();
      Test00163_1.ctrl_cd = 9912;
      Test00163_1.flg1 = 9913;
      Test00163_1.flg2 = 9914;
      Test00163_1.flg3 = 9915;
      Test00163_1.flg4 = 9916;
      Test00163_1.flg5 = 9917;
      Test00163_1.flg6 = 9918;
      Test00163_1.flg7 = 9919;
      Test00163_1.flg8 = 9920;
      Test00163_1.flg9 = 9921;
      Test00163_1.flg10 = 9922;

      //selectAllDataをして件数取得。
      List<HistCtrlMst> Test00163_AllRtn = await db.selectAllData(Test00163_1);
      int count = Test00163_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00163_1);

      //データ取得に必要なオブジェクトを用意
      HistCtrlMst Test00163_2 = HistCtrlMst();
      //Keyの値を設定する
      Test00163_2.ctrl_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      HistCtrlMst? Test00163_Rtn = await db.selectDataByPrimaryKey(Test00163_2);
      //取得行がない場合、nullが返ってきます
      if (Test00163_Rtn == null) {
        print('\n********** 異常発生：00163_HistCtrlMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00163_Rtn?.ctrl_cd,9912);
        expect(Test00163_Rtn?.flg1,9913);
        expect(Test00163_Rtn?.flg2,9914);
        expect(Test00163_Rtn?.flg3,9915);
        expect(Test00163_Rtn?.flg4,9916);
        expect(Test00163_Rtn?.flg5,9917);
        expect(Test00163_Rtn?.flg6,9918);
        expect(Test00163_Rtn?.flg7,9919);
        expect(Test00163_Rtn?.flg8,9920);
        expect(Test00163_Rtn?.flg9,9921);
        expect(Test00163_Rtn?.flg10,9922);
      }

      //selectAllDataをして件数取得。
      List<HistCtrlMst> Test00163_AllRtn2 = await db.selectAllData(Test00163_1);
      int count2 = Test00163_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00163_1);
      print('********** テスト終了：00163_HistCtrlMst_01 **********\n\n');
    });

    // ********************************************************
    // テスト00164 : HistlogSkipNum
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00164_HistlogSkipNum_01', () async {
      print('\n********** テスト実行：00164_HistlogSkipNum_01 **********');
      HistlogSkipNum Test00164_1 = HistlogSkipNum();
      Test00164_1.hist_cd = 9912;

      //selectAllDataをして件数取得。
      List<HistlogSkipNum> Test00164_AllRtn = await db.selectAllData(Test00164_1);
      int count = Test00164_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00164_1);

      //データ取得に必要なオブジェクトを用意
      HistlogSkipNum Test00164_2 = HistlogSkipNum();
      //Keyの値を設定する
      Test00164_2.hist_cd = 9912;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      HistlogSkipNum? Test00164_Rtn = await db.selectDataByPrimaryKey(Test00164_2);
      //取得行がない場合、nullが返ってきます
      if (Test00164_Rtn == null) {
        print('\n********** 異常発生：00164_HistlogSkipNum_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00164_Rtn?.hist_cd,9912);
      }

      //selectAllDataをして件数取得。
      List<HistlogSkipNum> Test00164_AllRtn2 = await db.selectAllData(Test00164_1);
      int count2 = Test00164_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00164_1);
      print('********** テスト終了：00164_HistlogSkipNum_01 **********\n\n');
    });

    // ********************************************************
    // テスト00165 : RdlyDeal
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00165_RdlyDeal_01', () async {
      print('\n********** テスト実行：00165_RdlyDeal_01 **********');
      RdlyDeal Test00165_1 = RdlyDeal();
      Test00165_1.comp_cd = 9912;
      Test00165_1.stre_cd = 9913;
      Test00165_1.mac_no = 9914;
      Test00165_1.chkr_no = 9915;
      Test00165_1.cshr_no = 9916;
      Test00165_1.sale_date = 'abc17';
      Test00165_1.kind_cd = 'abc18';
      Test00165_1.sub = 9919;
      Test00165_1.data1 = 9920;
      Test00165_1.data2 = 9921;
      Test00165_1.data3 = 9922;
      Test00165_1.data4 = 9923;
      Test00165_1.data5 = 9924;
      Test00165_1.data6 = 9925;
      Test00165_1.data7 = 9926;
      Test00165_1.data8 = 9927;
      Test00165_1.data9 = 9928;
      Test00165_1.data10 = 1.229;

      //selectAllDataをして件数取得。
      List<RdlyDeal> Test00165_AllRtn = await db.selectAllData(Test00165_1);
      int count = Test00165_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00165_1);

      //データ取得に必要なオブジェクトを用意
      RdlyDeal Test00165_2 = RdlyDeal();
      //Keyの値を設定する
      Test00165_2.comp_cd = 9912;
      Test00165_2.stre_cd = 9913;
      Test00165_2.mac_no = 9914;
      Test00165_2.chkr_no = 9915;
      Test00165_2.cshr_no = 9916;
      Test00165_2.sale_date = 'abc17';
      Test00165_2.kind_cd = 'abc18';
      Test00165_2.sub = 9919;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyDeal? Test00165_Rtn = await db.selectDataByPrimaryKey(Test00165_2);
      //取得行がない場合、nullが返ってきます
      if (Test00165_Rtn == null) {
        print('\n********** 異常発生：00165_RdlyDeal_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00165_Rtn?.comp_cd,9912);
        expect(Test00165_Rtn?.stre_cd,9913);
        expect(Test00165_Rtn?.mac_no,9914);
        expect(Test00165_Rtn?.chkr_no,9915);
        expect(Test00165_Rtn?.cshr_no,9916);
        expect(Test00165_Rtn?.sale_date,'abc17');
        expect(Test00165_Rtn?.kind_cd,'abc18');
        expect(Test00165_Rtn?.sub,9919);
        expect(Test00165_Rtn?.data1,9920);
        expect(Test00165_Rtn?.data2,9921);
        expect(Test00165_Rtn?.data3,9922);
        expect(Test00165_Rtn?.data4,9923);
        expect(Test00165_Rtn?.data5,9924);
        expect(Test00165_Rtn?.data6,9925);
        expect(Test00165_Rtn?.data7,9926);
        expect(Test00165_Rtn?.data8,9927);
        expect(Test00165_Rtn?.data9,9928);
        expect(Test00165_Rtn?.data10,1.229);
      }

      //selectAllDataをして件数取得。
      List<RdlyDeal> Test00165_AllRtn2 = await db.selectAllData(Test00165_1);
      int count2 = Test00165_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00165_1);
      print('********** テスト終了：00165_RdlyDeal_01 **********\n\n');
    });

    // ********************************************************
    // テスト00166 : RdlyDealHour
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00166_RdlyDealHour_01', () async {
      print('\n********** テスト実行：00166_RdlyDealHour_01 **********');
      RdlyDealHour Test00166_1 = RdlyDealHour();
      Test00166_1.comp_cd = 9912;
      Test00166_1.stre_cd = 9913;
      Test00166_1.mac_no = 9914;
      Test00166_1.chkr_no = 9915;
      Test00166_1.cshr_no = 9916;
      Test00166_1.sale_date = 'abc17';
      Test00166_1.date_hour = 'abc18';
      Test00166_1.mode = 9919;
      Test00166_1.sub = 9920;
      Test00166_1.data1 = 9921;
      Test00166_1.data2 = 9922;
      Test00166_1.data3 = 9923;
      Test00166_1.data4 = 9924;
      Test00166_1.data5 = 9925;
      Test00166_1.data6 = 9926;
      Test00166_1.data7 = 9927;
      Test00166_1.data8 = 9928;
      Test00166_1.data9 = 9929;
      Test00166_1.data10 = 1.230;
      Test00166_1.data11 = 1.231;

      //selectAllDataをして件数取得。
      List<RdlyDealHour> Test00166_AllRtn = await db.selectAllData(Test00166_1);
      int count = Test00166_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00166_1);

      //データ取得に必要なオブジェクトを用意
      RdlyDealHour Test00166_2 = RdlyDealHour();
      //Keyの値を設定する
      Test00166_2.comp_cd = 9912;
      Test00166_2.stre_cd = 9913;
      Test00166_2.mac_no = 9914;
      Test00166_2.chkr_no = 9915;
      Test00166_2.cshr_no = 9916;
      Test00166_2.sale_date = 'abc17';
      Test00166_2.date_hour = 'abc18';
      Test00166_2.mode = 9919;
      Test00166_2.sub = 9920;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyDealHour? Test00166_Rtn = await db.selectDataByPrimaryKey(Test00166_2);
      //取得行がない場合、nullが返ってきます
      if (Test00166_Rtn == null) {
        print('\n********** 異常発生：00166_RdlyDealHour_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00166_Rtn?.comp_cd,9912);
        expect(Test00166_Rtn?.stre_cd,9913);
        expect(Test00166_Rtn?.mac_no,9914);
        expect(Test00166_Rtn?.chkr_no,9915);
        expect(Test00166_Rtn?.cshr_no,9916);
        expect(Test00166_Rtn?.sale_date,'abc17');
        expect(Test00166_Rtn?.date_hour,'abc18');
        expect(Test00166_Rtn?.mode,9919);
        expect(Test00166_Rtn?.sub,9920);
        expect(Test00166_Rtn?.data1,9921);
        expect(Test00166_Rtn?.data2,9922);
        expect(Test00166_Rtn?.data3,9923);
        expect(Test00166_Rtn?.data4,9924);
        expect(Test00166_Rtn?.data5,9925);
        expect(Test00166_Rtn?.data6,9926);
        expect(Test00166_Rtn?.data7,9927);
        expect(Test00166_Rtn?.data8,9928);
        expect(Test00166_Rtn?.data9,9929);
        expect(Test00166_Rtn?.data10,1.230);
        expect(Test00166_Rtn?.data11,1.231);
      }

      //selectAllDataをして件数取得。
      List<RdlyDealHour> Test00166_AllRtn2 = await db.selectAllData(Test00166_1);
      int count2 = Test00166_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00166_1);
      print('********** テスト終了：00166_RdlyDealHour_01 **********\n\n');
    });

    // ********************************************************
    // テスト00167 : RdlyFlow
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00167_RdlyFlow_01', () async {
      print('\n********** テスト実行：00167_RdlyFlow_01 **********');
      RdlyFlow Test00167_1 = RdlyFlow();
      Test00167_1.comp_cd = 9912;
      Test00167_1.stre_cd = 9913;
      Test00167_1.mac_no = 9914;
      Test00167_1.chkr_no = 9915;
      Test00167_1.cshr_no = 9916;
      Test00167_1.sale_date = 'abc17';
      Test00167_1.kind = 9918;
      Test00167_1.sub = 9919;
      Test00167_1.data1 = 9920;
      Test00167_1.data2 = 9921;
      Test00167_1.data3 = 9922;
      Test00167_1.data4 = 9923;
      Test00167_1.data5 = 9924;
      Test00167_1.data6 = 9925;

      //selectAllDataをして件数取得。
      List<RdlyFlow> Test00167_AllRtn = await db.selectAllData(Test00167_1);
      int count = Test00167_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00167_1);

      //データ取得に必要なオブジェクトを用意
      RdlyFlow Test00167_2 = RdlyFlow();
      //Keyの値を設定する
      Test00167_2.comp_cd = 9912;
      Test00167_2.stre_cd = 9913;
      Test00167_2.mac_no = 9914;
      Test00167_2.chkr_no = 9915;
      Test00167_2.cshr_no = 9916;
      Test00167_2.sale_date = 'abc17';
      Test00167_2.kind = 9918;
      Test00167_2.sub = 9919;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyFlow? Test00167_Rtn = await db.selectDataByPrimaryKey(Test00167_2);
      //取得行がない場合、nullが返ってきます
      if (Test00167_Rtn == null) {
        print('\n********** 異常発生：00167_RdlyFlow_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00167_Rtn?.comp_cd,9912);
        expect(Test00167_Rtn?.stre_cd,9913);
        expect(Test00167_Rtn?.mac_no,9914);
        expect(Test00167_Rtn?.chkr_no,9915);
        expect(Test00167_Rtn?.cshr_no,9916);
        expect(Test00167_Rtn?.sale_date,'abc17');
        expect(Test00167_Rtn?.kind,9918);
        expect(Test00167_Rtn?.sub,9919);
        expect(Test00167_Rtn?.data1,9920);
        expect(Test00167_Rtn?.data2,9921);
        expect(Test00167_Rtn?.data3,9922);
        expect(Test00167_Rtn?.data4,9923);
        expect(Test00167_Rtn?.data5,9924);
        expect(Test00167_Rtn?.data6,9925);
      }

      //selectAllDataをして件数取得。
      List<RdlyFlow> Test00167_AllRtn2 = await db.selectAllData(Test00167_1);
      int count2 = Test00167_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00167_1);
      print('********** テスト終了：00167_RdlyFlow_01 **********\n\n');
    });

    // ********************************************************
    // テスト00168 : RdlyAcr
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00168_RdlyAcr_01', () async {
      print('\n********** テスト実行：00168_RdlyAcr_01 **********');
      RdlyAcr Test00168_1 = RdlyAcr();
      Test00168_1.comp_cd = 9912;
      Test00168_1.stre_cd = 9913;
      Test00168_1.mac_no = 9914;
      Test00168_1.sale_date = 'abc15';
      Test00168_1.acr_1_sht = 9916;
      Test00168_1.acr_5_sht = 9917;
      Test00168_1.acr_10_sht = 9918;
      Test00168_1.acr_50_sht = 9919;
      Test00168_1.acr_100_sht = 9920;
      Test00168_1.acr_500_sht = 9921;
      Test00168_1.acb_1000_sht = 9922;
      Test00168_1.acb_2000_sht = 9923;
      Test00168_1.acb_5000_sht = 9924;
      Test00168_1.acb_10000_sht = 9925;
      Test00168_1.acr_1_pol_sht = 9926;
      Test00168_1.acr_5_pol_sht = 9927;
      Test00168_1.acr_10_pol_sht = 9928;
      Test00168_1.acr_50_pol_sht = 9929;
      Test00168_1.acr_100_pol_sht = 9930;
      Test00168_1.acr_500_pol_sht = 9931;
      Test00168_1.acr_oth_pol_sht = 9932;
      Test00168_1.acb_1000_pol_sht = 9933;
      Test00168_1.acb_2000_pol_sht = 9934;
      Test00168_1.acb_5000_pol_sht = 9935;
      Test00168_1.acb_10000_pol_sht = 9936;
      Test00168_1.acb_fill_pol_sht = 9937;
      Test00168_1.acb_reject_cnt = 9938;

      //selectAllDataをして件数取得。
      List<RdlyAcr> Test00168_AllRtn = await db.selectAllData(Test00168_1);
      int count = Test00168_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00168_1);

      //データ取得に必要なオブジェクトを用意
      RdlyAcr Test00168_2 = RdlyAcr();
      //Keyの値を設定する
      Test00168_2.comp_cd = 9912;
      Test00168_2.stre_cd = 9913;
      Test00168_2.mac_no = 9914;
      Test00168_2.sale_date = 'abc15';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyAcr? Test00168_Rtn = await db.selectDataByPrimaryKey(Test00168_2);
      //取得行がない場合、nullが返ってきます
      if (Test00168_Rtn == null) {
        print('\n********** 異常発生：00168_RdlyAcr_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00168_Rtn?.comp_cd,9912);
        expect(Test00168_Rtn?.stre_cd,9913);
        expect(Test00168_Rtn?.mac_no,9914);
        expect(Test00168_Rtn?.sale_date,'abc15');
        expect(Test00168_Rtn?.acr_1_sht,9916);
        expect(Test00168_Rtn?.acr_5_sht,9917);
        expect(Test00168_Rtn?.acr_10_sht,9918);
        expect(Test00168_Rtn?.acr_50_sht,9919);
        expect(Test00168_Rtn?.acr_100_sht,9920);
        expect(Test00168_Rtn?.acr_500_sht,9921);
        expect(Test00168_Rtn?.acb_1000_sht,9922);
        expect(Test00168_Rtn?.acb_2000_sht,9923);
        expect(Test00168_Rtn?.acb_5000_sht,9924);
        expect(Test00168_Rtn?.acb_10000_sht,9925);
        expect(Test00168_Rtn?.acr_1_pol_sht,9926);
        expect(Test00168_Rtn?.acr_5_pol_sht,9927);
        expect(Test00168_Rtn?.acr_10_pol_sht,9928);
        expect(Test00168_Rtn?.acr_50_pol_sht,9929);
        expect(Test00168_Rtn?.acr_100_pol_sht,9930);
        expect(Test00168_Rtn?.acr_500_pol_sht,9931);
        expect(Test00168_Rtn?.acr_oth_pol_sht,9932);
        expect(Test00168_Rtn?.acb_1000_pol_sht,9933);
        expect(Test00168_Rtn?.acb_2000_pol_sht,9934);
        expect(Test00168_Rtn?.acb_5000_pol_sht,9935);
        expect(Test00168_Rtn?.acb_10000_pol_sht,9936);
        expect(Test00168_Rtn?.acb_fill_pol_sht,9937);
        expect(Test00168_Rtn?.acb_reject_cnt,9938);
      }

      //selectAllDataをして件数取得。
      List<RdlyAcr> Test00168_AllRtn2 = await db.selectAllData(Test00168_1);
      int count2 = Test00168_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00168_1);
      print('********** テスト終了：00168_RdlyAcr_01 **********\n\n');
    });

    // ********************************************************
    // テスト00169 : RdlyClass
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00169_RdlyClass_01', () async {
      print('\n********** テスト実行：00169_RdlyClass_01 **********');
      RdlyClass Test00169_1 = RdlyClass();
      Test00169_1.comp_cd = 9912;
      Test00169_1.stre_cd = 9913;
      Test00169_1.mac_no = 9914;
      Test00169_1.lgpcls_cd = 9915;
      Test00169_1.grpcls_cd = 9916;
      Test00169_1.lrgcls_cd = 9917;
      Test00169_1.mdlcls_cd = 9918;
      Test00169_1.smlcls_cd = 9919;
      Test00169_1.tnycls_cd = 9920;
      Test00169_1.sale_date = 'abc21';
      Test00169_1.mode = 9922;
      Test00169_1.sub = 9923;
      Test00169_1.data1 = 9924;
      Test00169_1.data2 = 9925;
      Test00169_1.data3 = 9926;
      Test00169_1.data4 = 9927;
      Test00169_1.data5 = 9928;
      Test00169_1.data6 = 9929;
      Test00169_1.data7 = 9930;
      Test00169_1.data8 = 9931;
      Test00169_1.data9 = 9932;
      Test00169_1.data10 = 9933;
      Test00169_1.data11 = 9934;
      Test00169_1.data12 = 9935;
      Test00169_1.data13 = 9936;
      Test00169_1.data14 = 9937;
      Test00169_1.data15 = 9938;
      Test00169_1.data16 = 9939;
      Test00169_1.data17 = 9940;
      Test00169_1.data18 = 9941;
      Test00169_1.data19 = 9942;
      Test00169_1.data20 = 1.243;
      Test00169_1.data21 = 1.244;
      Test00169_1.data22 = 'abc45';

      //selectAllDataをして件数取得。
      List<RdlyClass> Test00169_AllRtn = await db.selectAllData(Test00169_1);
      int count = Test00169_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00169_1);

      //データ取得に必要なオブジェクトを用意
      RdlyClass Test00169_2 = RdlyClass();
      //Keyの値を設定する
      Test00169_2.comp_cd = 9912;
      Test00169_2.stre_cd = 9913;
      Test00169_2.mac_no = 9914;
      Test00169_2.lgpcls_cd = 9915;
      Test00169_2.grpcls_cd = 9916;
      Test00169_2.lrgcls_cd = 9917;
      Test00169_2.mdlcls_cd = 9918;
      Test00169_2.smlcls_cd = 9919;
      Test00169_2.tnycls_cd = 9920;
      Test00169_2.sale_date = 'abc21';
      Test00169_2.mode = 9922;
      Test00169_2.sub = 9923;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyClass? Test00169_Rtn = await db.selectDataByPrimaryKey(Test00169_2);
      //取得行がない場合、nullが返ってきます
      if (Test00169_Rtn == null) {
        print('\n********** 異常発生：00169_RdlyClass_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00169_Rtn?.comp_cd,9912);
        expect(Test00169_Rtn?.stre_cd,9913);
        expect(Test00169_Rtn?.mac_no,9914);
        expect(Test00169_Rtn?.lgpcls_cd,9915);
        expect(Test00169_Rtn?.grpcls_cd,9916);
        expect(Test00169_Rtn?.lrgcls_cd,9917);
        expect(Test00169_Rtn?.mdlcls_cd,9918);
        expect(Test00169_Rtn?.smlcls_cd,9919);
        expect(Test00169_Rtn?.tnycls_cd,9920);
        expect(Test00169_Rtn?.sale_date,'abc21');
        expect(Test00169_Rtn?.mode,9922);
        expect(Test00169_Rtn?.sub,9923);
        expect(Test00169_Rtn?.data1,9924);
        expect(Test00169_Rtn?.data2,9925);
        expect(Test00169_Rtn?.data3,9926);
        expect(Test00169_Rtn?.data4,9927);
        expect(Test00169_Rtn?.data5,9928);
        expect(Test00169_Rtn?.data6,9929);
        expect(Test00169_Rtn?.data7,9930);
        expect(Test00169_Rtn?.data8,9931);
        expect(Test00169_Rtn?.data9,9932);
        expect(Test00169_Rtn?.data10,9933);
        expect(Test00169_Rtn?.data11,9934);
        expect(Test00169_Rtn?.data12,9935);
        expect(Test00169_Rtn?.data13,9936);
        expect(Test00169_Rtn?.data14,9937);
        expect(Test00169_Rtn?.data15,9938);
        expect(Test00169_Rtn?.data16,9939);
        expect(Test00169_Rtn?.data17,9940);
        expect(Test00169_Rtn?.data18,9941);
        expect(Test00169_Rtn?.data19,9942);
        expect(Test00169_Rtn?.data20,1.243);
        expect(Test00169_Rtn?.data21,1.244);
        expect(Test00169_Rtn?.data22,'abc45');
      }

      //selectAllDataをして件数取得。
      List<RdlyClass> Test00169_AllRtn2 = await db.selectAllData(Test00169_1);
      int count2 = Test00169_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00169_1);
      print('********** テスト終了：00169_RdlyClass_01 **********\n\n');
    });

    // ********************************************************
    // テスト00170 : RdlyClassHour
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00170_RdlyClassHour_01', () async {
      print('\n********** テスト実行：00170_RdlyClassHour_01 **********');
      RdlyClassHour Test00170_1 = RdlyClassHour();
      Test00170_1.comp_cd = 9912;
      Test00170_1.stre_cd = 9913;
      Test00170_1.mac_no = 9914;
      Test00170_1.lgpcls_cd = 9915;
      Test00170_1.grpcls_cd = 9916;
      Test00170_1.lrgcls_cd = 9917;
      Test00170_1.mdlcls_cd = 9918;
      Test00170_1.smlcls_cd = 9919;
      Test00170_1.tnycls_cd = 9920;
      Test00170_1.sale_date = 'abc21';
      Test00170_1.date_hour = 'abc22';
      Test00170_1.mode = 9923;
      Test00170_1.sub = 9924;
      Test00170_1.data1 = 9925;
      Test00170_1.data2 = 9926;
      Test00170_1.data3 = 9927;
      Test00170_1.data4 = 9928;
      Test00170_1.data5 = 9929;
      Test00170_1.data6 = 9930;
      Test00170_1.data7 = 9931;
      Test00170_1.data8 = 9932;
      Test00170_1.data9 = 9933;
      Test00170_1.data10 = 9934;
      Test00170_1.data11 = 9935;
      Test00170_1.data12 = 9936;
      Test00170_1.data13 = 9937;
      Test00170_1.data14 = 9938;
      Test00170_1.data15 = 9939;
      Test00170_1.data16 = 9940;
      Test00170_1.data17 = 9941;
      Test00170_1.data18 = 9942;
      Test00170_1.data19 = 9943;
      Test00170_1.data20 = 1.244;
      Test00170_1.data21 = 1.245;
      Test00170_1.data22 = 'abc46';

      //selectAllDataをして件数取得。
      List<RdlyClassHour> Test00170_AllRtn = await db.selectAllData(Test00170_1);
      int count = Test00170_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00170_1);

      //データ取得に必要なオブジェクトを用意
      RdlyClassHour Test00170_2 = RdlyClassHour();
      //Keyの値を設定する
      Test00170_2.comp_cd = 9912;
      Test00170_2.stre_cd = 9913;
      Test00170_2.mac_no = 9914;
      Test00170_2.lgpcls_cd = 9915;
      Test00170_2.grpcls_cd = 9916;
      Test00170_2.lrgcls_cd = 9917;
      Test00170_2.mdlcls_cd = 9918;
      Test00170_2.smlcls_cd = 9919;
      Test00170_2.tnycls_cd = 9920;
      Test00170_2.sale_date = 'abc21';
      Test00170_2.date_hour = 'abc22';
      Test00170_2.mode = 9923;
      Test00170_2.sub = 9924;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyClassHour? Test00170_Rtn = await db.selectDataByPrimaryKey(Test00170_2);
      //取得行がない場合、nullが返ってきます
      if (Test00170_Rtn == null) {
        print('\n********** 異常発生：00170_RdlyClassHour_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00170_Rtn?.comp_cd,9912);
        expect(Test00170_Rtn?.stre_cd,9913);
        expect(Test00170_Rtn?.mac_no,9914);
        expect(Test00170_Rtn?.lgpcls_cd,9915);
        expect(Test00170_Rtn?.grpcls_cd,9916);
        expect(Test00170_Rtn?.lrgcls_cd,9917);
        expect(Test00170_Rtn?.mdlcls_cd,9918);
        expect(Test00170_Rtn?.smlcls_cd,9919);
        expect(Test00170_Rtn?.tnycls_cd,9920);
        expect(Test00170_Rtn?.sale_date,'abc21');
        expect(Test00170_Rtn?.date_hour,'abc22');
        expect(Test00170_Rtn?.mode,9923);
        expect(Test00170_Rtn?.sub,9924);
        expect(Test00170_Rtn?.data1,9925);
        expect(Test00170_Rtn?.data2,9926);
        expect(Test00170_Rtn?.data3,9927);
        expect(Test00170_Rtn?.data4,9928);
        expect(Test00170_Rtn?.data5,9929);
        expect(Test00170_Rtn?.data6,9930);
        expect(Test00170_Rtn?.data7,9931);
        expect(Test00170_Rtn?.data8,9932);
        expect(Test00170_Rtn?.data9,9933);
        expect(Test00170_Rtn?.data10,9934);
        expect(Test00170_Rtn?.data11,9935);
        expect(Test00170_Rtn?.data12,9936);
        expect(Test00170_Rtn?.data13,9937);
        expect(Test00170_Rtn?.data14,9938);
        expect(Test00170_Rtn?.data15,9939);
        expect(Test00170_Rtn?.data16,9940);
        expect(Test00170_Rtn?.data17,9941);
        expect(Test00170_Rtn?.data18,9942);
        expect(Test00170_Rtn?.data19,9943);
        expect(Test00170_Rtn?.data20,1.244);
        expect(Test00170_Rtn?.data21,1.245);
        expect(Test00170_Rtn?.data22,'abc46');
      }

      //selectAllDataをして件数取得。
      List<RdlyClassHour> Test00170_AllRtn2 = await db.selectAllData(Test00170_1);
      int count2 = Test00170_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00170_1);
      print('********** テスト終了：00170_RdlyClassHour_01 **********\n\n');
    });

    // ********************************************************
    // テスト00171 : RdlyPlu
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00171_RdlyPlu_01', () async {
      print('\n********** テスト実行：00171_RdlyPlu_01 **********');
      RdlyPlu Test00171_1 = RdlyPlu();
      Test00171_1.comp_cd = 9912;
      Test00171_1.stre_cd = 9913;
      Test00171_1.mac_no = 9914;
      Test00171_1.plu_cd = 'abc15';
      Test00171_1.smlcls_cd = 9916;
      Test00171_1.sale_date = 'abc17';
      Test00171_1.mode = 9918;
      Test00171_1.sub = 9919;
      Test00171_1.data1 = 9920;
      Test00171_1.data2 = 9921;
      Test00171_1.data3 = 9922;
      Test00171_1.data4 = 9923;
      Test00171_1.data5 = 9924;
      Test00171_1.data6 = 9925;
      Test00171_1.data7 = 9926;
      Test00171_1.data8 = 9927;
      Test00171_1.data9 = 9928;
      Test00171_1.data10 = 9929;
      Test00171_1.data11 = 9930;
      Test00171_1.data12 = 9931;
      Test00171_1.data13 = 9932;
      Test00171_1.data14 = 9933;
      Test00171_1.data15 = 9934;
      Test00171_1.data16 = 9935;
      Test00171_1.data17 = 9936;
      Test00171_1.data18 = 9937;
      Test00171_1.data19 = 9938;
      Test00171_1.data20 = 1.239;
      Test00171_1.data21 = 1.240;
      Test00171_1.data22 = 'abc41';

      //selectAllDataをして件数取得。
      List<RdlyPlu> Test00171_AllRtn = await db.selectAllData(Test00171_1);
      int count = Test00171_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00171_1);

      //データ取得に必要なオブジェクトを用意
      RdlyPlu Test00171_2 = RdlyPlu();
      //Keyの値を設定する
      Test00171_2.comp_cd = 9912;
      Test00171_2.stre_cd = 9913;
      Test00171_2.mac_no = 9914;
      Test00171_2.plu_cd = 'abc15';
      Test00171_2.smlcls_cd = 9916;
      Test00171_2.sale_date = 'abc17';
      Test00171_2.mode = 9918;
      Test00171_2.sub = 9919;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyPlu? Test00171_Rtn = await db.selectDataByPrimaryKey(Test00171_2);
      //取得行がない場合、nullが返ってきます
      if (Test00171_Rtn == null) {
        print('\n********** 異常発生：00171_RdlyPlu_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00171_Rtn?.comp_cd,9912);
        expect(Test00171_Rtn?.stre_cd,9913);
        expect(Test00171_Rtn?.mac_no,9914);
        expect(Test00171_Rtn?.plu_cd,'abc15');
        expect(Test00171_Rtn?.smlcls_cd,9916);
        expect(Test00171_Rtn?.sale_date,'abc17');
        expect(Test00171_Rtn?.mode,9918);
        expect(Test00171_Rtn?.sub,9919);
        expect(Test00171_Rtn?.data1,9920);
        expect(Test00171_Rtn?.data2,9921);
        expect(Test00171_Rtn?.data3,9922);
        expect(Test00171_Rtn?.data4,9923);
        expect(Test00171_Rtn?.data5,9924);
        expect(Test00171_Rtn?.data6,9925);
        expect(Test00171_Rtn?.data7,9926);
        expect(Test00171_Rtn?.data8,9927);
        expect(Test00171_Rtn?.data9,9928);
        expect(Test00171_Rtn?.data10,9929);
        expect(Test00171_Rtn?.data11,9930);
        expect(Test00171_Rtn?.data12,9931);
        expect(Test00171_Rtn?.data13,9932);
        expect(Test00171_Rtn?.data14,9933);
        expect(Test00171_Rtn?.data15,9934);
        expect(Test00171_Rtn?.data16,9935);
        expect(Test00171_Rtn?.data17,9936);
        expect(Test00171_Rtn?.data18,9937);
        expect(Test00171_Rtn?.data19,9938);
        expect(Test00171_Rtn?.data20,1.239);
        expect(Test00171_Rtn?.data21,1.240);
        expect(Test00171_Rtn?.data22,'abc41');
      }

      //selectAllDataをして件数取得。
      List<RdlyPlu> Test00171_AllRtn2 = await db.selectAllData(Test00171_1);
      int count2 = Test00171_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00171_1);
      print('********** テスト終了：00171_RdlyPlu_01 **********\n\n');
    });

    // ********************************************************
    // テスト00172 : RdlyPluHour
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00172_RdlyPluHour_01', () async {
      print('\n********** テスト実行：00172_RdlyPluHour_01 **********');
      RdlyPluHour Test00172_1 = RdlyPluHour();
      Test00172_1.comp_cd = 9912;
      Test00172_1.stre_cd = 9913;
      Test00172_1.mac_no = 9914;
      Test00172_1.plu_cd = 'abc15';
      Test00172_1.smlcls_cd = 9916;
      Test00172_1.sale_date = 'abc17';
      Test00172_1.date_hour = 'abc18';
      Test00172_1.mode = 9919;
      Test00172_1.sub = 9920;
      Test00172_1.data1 = 9921;
      Test00172_1.data2 = 9922;
      Test00172_1.data3 = 9923;
      Test00172_1.data4 = 9924;
      Test00172_1.data5 = 9925;
      Test00172_1.data6 = 9926;
      Test00172_1.data7 = 9927;
      Test00172_1.data8 = 9928;
      Test00172_1.data9 = 9929;
      Test00172_1.data10 = 9930;
      Test00172_1.data11 = 9931;
      Test00172_1.data12 = 9932;
      Test00172_1.data13 = 9933;
      Test00172_1.data14 = 9934;
      Test00172_1.data15 = 9935;
      Test00172_1.data16 = 9936;
      Test00172_1.data17 = 9937;
      Test00172_1.data18 = 9938;
      Test00172_1.data19 = 9939;
      Test00172_1.data20 = 1.240;
      Test00172_1.data21 = 1.241;
      Test00172_1.data22 = 'abc42';

      //selectAllDataをして件数取得。
      List<RdlyPluHour> Test00172_AllRtn = await db.selectAllData(Test00172_1);
      int count = Test00172_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00172_1);

      //データ取得に必要なオブジェクトを用意
      RdlyPluHour Test00172_2 = RdlyPluHour();
      //Keyの値を設定する
      Test00172_2.comp_cd = 9912;
      Test00172_2.stre_cd = 9913;
      Test00172_2.mac_no = 9914;
      Test00172_2.plu_cd = 'abc15';
      Test00172_2.smlcls_cd = 9916;
      Test00172_2.sale_date = 'abc17';
      Test00172_2.date_hour = 'abc18';
      Test00172_2.mode = 9919;
      Test00172_2.sub = 9920;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyPluHour? Test00172_Rtn = await db.selectDataByPrimaryKey(Test00172_2);
      //取得行がない場合、nullが返ってきます
      if (Test00172_Rtn == null) {
        print('\n********** 異常発生：00172_RdlyPluHour_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00172_Rtn?.comp_cd,9912);
        expect(Test00172_Rtn?.stre_cd,9913);
        expect(Test00172_Rtn?.mac_no,9914);
        expect(Test00172_Rtn?.plu_cd,'abc15');
        expect(Test00172_Rtn?.smlcls_cd,9916);
        expect(Test00172_Rtn?.sale_date,'abc17');
        expect(Test00172_Rtn?.date_hour,'abc18');
        expect(Test00172_Rtn?.mode,9919);
        expect(Test00172_Rtn?.sub,9920);
        expect(Test00172_Rtn?.data1,9921);
        expect(Test00172_Rtn?.data2,9922);
        expect(Test00172_Rtn?.data3,9923);
        expect(Test00172_Rtn?.data4,9924);
        expect(Test00172_Rtn?.data5,9925);
        expect(Test00172_Rtn?.data6,9926);
        expect(Test00172_Rtn?.data7,9927);
        expect(Test00172_Rtn?.data8,9928);
        expect(Test00172_Rtn?.data9,9929);
        expect(Test00172_Rtn?.data10,9930);
        expect(Test00172_Rtn?.data11,9931);
        expect(Test00172_Rtn?.data12,9932);
        expect(Test00172_Rtn?.data13,9933);
        expect(Test00172_Rtn?.data14,9934);
        expect(Test00172_Rtn?.data15,9935);
        expect(Test00172_Rtn?.data16,9936);
        expect(Test00172_Rtn?.data17,9937);
        expect(Test00172_Rtn?.data18,9938);
        expect(Test00172_Rtn?.data19,9939);
        expect(Test00172_Rtn?.data20,1.240);
        expect(Test00172_Rtn?.data21,1.241);
        expect(Test00172_Rtn?.data22,'abc42');
      }

      //selectAllDataをして件数取得。
      List<RdlyPluHour> Test00172_AllRtn2 = await db.selectAllData(Test00172_1);
      int count2 = Test00172_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00172_1);
      print('********** テスト終了：00172_RdlyPluHour_01 **********\n\n');
    });

    // ********************************************************
    // テスト00173 : RdlyDsc
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00173_RdlyDsc_01', () async {
      print('\n********** テスト実行：00173_RdlyDsc_01 **********');
      RdlyDsc Test00173_1 = RdlyDsc();
      Test00173_1.comp_cd = 9912;
      Test00173_1.stre_cd = 9913;
      Test00173_1.mac_no = 9914;
      Test00173_1.plu_cd = 'abc15';
      Test00173_1.smlcls_cd = 9916;
      Test00173_1.sale_date = 'abc17';
      Test00173_1.mode = 9918;
      Test00173_1.kind = 9919;
      Test00173_1.sub = 9920;
      Test00173_1.data1 = 9921;
      Test00173_1.data2 = 9922;
      Test00173_1.data3 = 9923;
      Test00173_1.data4 = 9924;
      Test00173_1.data5 = 9925;
      Test00173_1.data6 = 9926;

      //selectAllDataをして件数取得。
      List<RdlyDsc> Test00173_AllRtn = await db.selectAllData(Test00173_1);
      int count = Test00173_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00173_1);

      //データ取得に必要なオブジェクトを用意
      RdlyDsc Test00173_2 = RdlyDsc();
      //Keyの値を設定する
      Test00173_2.comp_cd = 9912;
      Test00173_2.stre_cd = 9913;
      Test00173_2.mac_no = 9914;
      Test00173_2.plu_cd = 'abc15';
      Test00173_2.smlcls_cd = 9916;
      Test00173_2.sale_date = 'abc17';
      Test00173_2.mode = 9918;
      Test00173_2.kind = 9919;
      Test00173_2.sub = 9920;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyDsc? Test00173_Rtn = await db.selectDataByPrimaryKey(Test00173_2);
      //取得行がない場合、nullが返ってきます
      if (Test00173_Rtn == null) {
        print('\n********** 異常発生：00173_RdlyDsc_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00173_Rtn?.comp_cd,9912);
        expect(Test00173_Rtn?.stre_cd,9913);
        expect(Test00173_Rtn?.mac_no,9914);
        expect(Test00173_Rtn?.plu_cd,'abc15');
        expect(Test00173_Rtn?.smlcls_cd,9916);
        expect(Test00173_Rtn?.sale_date,'abc17');
        expect(Test00173_Rtn?.mode,9918);
        expect(Test00173_Rtn?.kind,9919);
        expect(Test00173_Rtn?.sub,9920);
        expect(Test00173_Rtn?.data1,9921);
        expect(Test00173_Rtn?.data2,9922);
        expect(Test00173_Rtn?.data3,9923);
        expect(Test00173_Rtn?.data4,9924);
        expect(Test00173_Rtn?.data5,9925);
        expect(Test00173_Rtn?.data6,9926);
      }

      //selectAllDataをして件数取得。
      List<RdlyDsc> Test00173_AllRtn2 = await db.selectAllData(Test00173_1);
      int count2 = Test00173_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00173_1);
      print('********** テスト終了：00173_RdlyDsc_01 **********\n\n');
    });

    // ********************************************************
    // テスト00174 : RdlyProm
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00174_RdlyProm_01', () async {
      print('\n********** テスト実行：00174_RdlyProm_01 **********');
      RdlyProm Test00174_1 = RdlyProm();
      Test00174_1.comp_cd = 9912;
      Test00174_1.stre_cd = 9913;
      Test00174_1.mac_no = 9914;
      Test00174_1.sch_cd = 9915;
      Test00174_1.plu_cd = 'abc16';
      Test00174_1.cls_cd = 9917;
      Test00174_1.sale_date = 'abc18';
      Test00174_1.mode = 9919;
      Test00174_1.prom_typ = 9920;
      Test00174_1.sch_typ = 9921;
      Test00174_1.kind = 9922;
      Test00174_1.data1 = 9923;
      Test00174_1.data2 = 9924;
      Test00174_1.data3 = 9925;
      Test00174_1.data4 = 9926;
      Test00174_1.data5 = 9927;
      Test00174_1.data6 = 9928;

      //selectAllDataをして件数取得。
      List<RdlyProm> Test00174_AllRtn = await db.selectAllData(Test00174_1);
      int count = Test00174_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00174_1);

      //データ取得に必要なオブジェクトを用意
      RdlyProm Test00174_2 = RdlyProm();
      //Keyの値を設定する
      Test00174_2.comp_cd = 9912;
      Test00174_2.stre_cd = 9913;
      Test00174_2.mac_no = 9914;
      Test00174_2.sch_cd = 9915;
      Test00174_2.plu_cd = 'abc16';
      Test00174_2.cls_cd = 9917;
      Test00174_2.sale_date = 'abc18';
      Test00174_2.mode = 9919;
      Test00174_2.prom_typ = 9920;
      Test00174_2.sch_typ = 9921;
      Test00174_2.kind = 9922;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyProm? Test00174_Rtn = await db.selectDataByPrimaryKey(Test00174_2);
      //取得行がない場合、nullが返ってきます
      if (Test00174_Rtn == null) {
        print('\n********** 異常発生：00174_RdlyProm_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00174_Rtn?.comp_cd,9912);
        expect(Test00174_Rtn?.stre_cd,9913);
        expect(Test00174_Rtn?.mac_no,9914);
        expect(Test00174_Rtn?.sch_cd,9915);
        expect(Test00174_Rtn?.plu_cd,'abc16');
        expect(Test00174_Rtn?.cls_cd,9917);
        expect(Test00174_Rtn?.sale_date,'abc18');
        expect(Test00174_Rtn?.mode,9919);
        expect(Test00174_Rtn?.prom_typ,9920);
        expect(Test00174_Rtn?.sch_typ,9921);
        expect(Test00174_Rtn?.kind,9922);
        expect(Test00174_Rtn?.data1,9923);
        expect(Test00174_Rtn?.data2,9924);
        expect(Test00174_Rtn?.data3,9925);
        expect(Test00174_Rtn?.data4,9926);
        expect(Test00174_Rtn?.data5,9927);
        expect(Test00174_Rtn?.data6,9928);
      }

      //selectAllDataをして件数取得。
      List<RdlyProm> Test00174_AllRtn2 = await db.selectAllData(Test00174_1);
      int count2 = Test00174_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00174_1);
      print('********** テスト終了：00174_RdlyProm_01 **********\n\n');
    });

    // ********************************************************
    // テスト00175 : RdlyCust
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00175_RdlyCust_01', () async {
      print('\n********** テスト実行：00175_RdlyCust_01 **********');
      RdlyCust Test00175_1 = RdlyCust();
      Test00175_1.comp_cd = 9912;
      Test00175_1.stre_cd = 9913;
      Test00175_1.cust_no = 'abc14';
      Test00175_1.custzone_cd = 9915;
      Test00175_1.svs_cls_cd = 9916;
      Test00175_1.sale_date = 'abc17';
      Test00175_1.sub = 9918;
      Test00175_1.data1 = 9919;
      Test00175_1.data2 = 9920;
      Test00175_1.data3 = 9921;
      Test00175_1.data4 = 9922;
      Test00175_1.data5 = 9923;
      Test00175_1.data6 = 9924;
      Test00175_1.data7 = 9925;
      Test00175_1.data8 = 9926;
      Test00175_1.data9 = 9927;
      Test00175_1.data10 = 9928;
      Test00175_1.data11 = 9929;
      Test00175_1.data12 = 9930;
      Test00175_1.data13 = 9931;
      Test00175_1.data14 = 9932;
      Test00175_1.data15 = 9933;
      Test00175_1.data16 = 9934;
      Test00175_1.data17 = 9935;
      Test00175_1.data18 = 9936;
      Test00175_1.data19 = 9937;
      Test00175_1.data20 = 9938;
      Test00175_1.data21 = 9939;
      Test00175_1.data22 = 9940;
      Test00175_1.data23 = 9941;
      Test00175_1.data24 = 9942;
      Test00175_1.data25 = 1.243;

      //selectAllDataをして件数取得。
      List<RdlyCust> Test00175_AllRtn = await db.selectAllData(Test00175_1);
      int count = Test00175_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00175_1);

      //データ取得に必要なオブジェクトを用意
      RdlyCust Test00175_2 = RdlyCust();
      //Keyの値を設定する
      Test00175_2.comp_cd = 9912;
      Test00175_2.stre_cd = 9913;
      Test00175_2.cust_no = 'abc14';
      Test00175_2.custzone_cd = 9915;
      Test00175_2.svs_cls_cd = 9916;
      Test00175_2.sale_date = 'abc17';
      Test00175_2.sub = 9918;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyCust? Test00175_Rtn = await db.selectDataByPrimaryKey(Test00175_2);
      //取得行がない場合、nullが返ってきます
      if (Test00175_Rtn == null) {
        print('\n********** 異常発生：00175_RdlyCust_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00175_Rtn?.comp_cd,9912);
        expect(Test00175_Rtn?.stre_cd,9913);
        expect(Test00175_Rtn?.cust_no,'abc14');
        expect(Test00175_Rtn?.custzone_cd,9915);
        expect(Test00175_Rtn?.svs_cls_cd,9916);
        expect(Test00175_Rtn?.sale_date,'abc17');
        expect(Test00175_Rtn?.sub,9918);
        expect(Test00175_Rtn?.data1,9919);
        expect(Test00175_Rtn?.data2,9920);
        expect(Test00175_Rtn?.data3,9921);
        expect(Test00175_Rtn?.data4,9922);
        expect(Test00175_Rtn?.data5,9923);
        expect(Test00175_Rtn?.data6,9924);
        expect(Test00175_Rtn?.data7,9925);
        expect(Test00175_Rtn?.data8,9926);
        expect(Test00175_Rtn?.data9,9927);
        expect(Test00175_Rtn?.data10,9928);
        expect(Test00175_Rtn?.data11,9929);
        expect(Test00175_Rtn?.data12,9930);
        expect(Test00175_Rtn?.data13,9931);
        expect(Test00175_Rtn?.data14,9932);
        expect(Test00175_Rtn?.data15,9933);
        expect(Test00175_Rtn?.data16,9934);
        expect(Test00175_Rtn?.data17,9935);
        expect(Test00175_Rtn?.data18,9936);
        expect(Test00175_Rtn?.data19,9937);
        expect(Test00175_Rtn?.data20,9938);
        expect(Test00175_Rtn?.data21,9939);
        expect(Test00175_Rtn?.data22,9940);
        expect(Test00175_Rtn?.data23,9941);
        expect(Test00175_Rtn?.data24,9942);
        expect(Test00175_Rtn?.data25,1.243);
      }

      //selectAllDataをして件数取得。
      List<RdlyCust> Test00175_AllRtn2 = await db.selectAllData(Test00175_1);
      int count2 = Test00175_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00175_1);
      print('********** テスト終了：00175_RdlyCust_01 **********\n\n');
    });

    // ********************************************************
    // テスト00176 : RdlySvs
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00176_RdlySvs_01', () async {
      print('\n********** テスト実行：00176_RdlySvs_01 **********');
      RdlySvs Test00176_1 = RdlySvs();
      Test00176_1.comp_cd = 9912;
      Test00176_1.stre_cd = 9913;
      Test00176_1.svs_cls_cd = 9914;
      Test00176_1.sale_date = 'abc15';
      Test00176_1.sub = 9916;
      Test00176_1.data1 = 9917;
      Test00176_1.data2 = 9918;
      Test00176_1.data3 = 9919;
      Test00176_1.data4 = 9920;
      Test00176_1.data5 = 9921;
      Test00176_1.data6 = 9922;
      Test00176_1.data7 = 9923;
      Test00176_1.data8 = 9924;
      Test00176_1.data9 = 9925;
      Test00176_1.data10 = 9926;
      Test00176_1.data11 = 9927;
      Test00176_1.data12 = 9928;
      Test00176_1.data13 = 9929;
      Test00176_1.data14 = 9930;
      Test00176_1.data15 = 9931;
      Test00176_1.data16 = 9932;
      Test00176_1.data17 = 9933;
      Test00176_1.data18 = 9934;
      Test00176_1.data19 = 9935;
      Test00176_1.data20 = 9936;
      Test00176_1.data21 = 9937;
      Test00176_1.data22 = 9938;
      Test00176_1.data23 = 9939;
      Test00176_1.data24 = 9940;
      Test00176_1.data25 = 1.241;

      //selectAllDataをして件数取得。
      List<RdlySvs> Test00176_AllRtn = await db.selectAllData(Test00176_1);
      int count = Test00176_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00176_1);

      //データ取得に必要なオブジェクトを用意
      RdlySvs Test00176_2 = RdlySvs();
      //Keyの値を設定する
      Test00176_2.comp_cd = 9912;
      Test00176_2.stre_cd = 9913;
      Test00176_2.svs_cls_cd = 9914;
      Test00176_2.sale_date = 'abc15';
      Test00176_2.sub = 9916;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlySvs? Test00176_Rtn = await db.selectDataByPrimaryKey(Test00176_2);
      //取得行がない場合、nullが返ってきます
      if (Test00176_Rtn == null) {
        print('\n********** 異常発生：00176_RdlySvs_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00176_Rtn?.comp_cd,9912);
        expect(Test00176_Rtn?.stre_cd,9913);
        expect(Test00176_Rtn?.svs_cls_cd,9914);
        expect(Test00176_Rtn?.sale_date,'abc15');
        expect(Test00176_Rtn?.sub,9916);
        expect(Test00176_Rtn?.data1,9917);
        expect(Test00176_Rtn?.data2,9918);
        expect(Test00176_Rtn?.data3,9919);
        expect(Test00176_Rtn?.data4,9920);
        expect(Test00176_Rtn?.data5,9921);
        expect(Test00176_Rtn?.data6,9922);
        expect(Test00176_Rtn?.data7,9923);
        expect(Test00176_Rtn?.data8,9924);
        expect(Test00176_Rtn?.data9,9925);
        expect(Test00176_Rtn?.data10,9926);
        expect(Test00176_Rtn?.data11,9927);
        expect(Test00176_Rtn?.data12,9928);
        expect(Test00176_Rtn?.data13,9929);
        expect(Test00176_Rtn?.data14,9930);
        expect(Test00176_Rtn?.data15,9931);
        expect(Test00176_Rtn?.data16,9932);
        expect(Test00176_Rtn?.data17,9933);
        expect(Test00176_Rtn?.data18,9934);
        expect(Test00176_Rtn?.data19,9935);
        expect(Test00176_Rtn?.data20,9936);
        expect(Test00176_Rtn?.data21,9937);
        expect(Test00176_Rtn?.data22,9938);
        expect(Test00176_Rtn?.data23,9939);
        expect(Test00176_Rtn?.data24,9940);
        expect(Test00176_Rtn?.data25,1.241);
      }

      //selectAllDataをして件数取得。
      List<RdlySvs> Test00176_AllRtn2 = await db.selectAllData(Test00176_1);
      int count2 = Test00176_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00176_1);
      print('********** テスト終了：00176_RdlySvs_01 **********\n\n');
    });

    // ********************************************************
    // テスト00177 : RdlyCdpayflow
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00177_RdlyCdpayflow_01', () async {
      print('\n********** テスト実行：00177_RdlyCdpayflow_01 **********');
      RdlyCdpayflow Test00177_1 = RdlyCdpayflow();
      Test00177_1.comp_cd = 9912;
      Test00177_1.stre_cd = 9913;
      Test00177_1.mac_no = 9914;
      Test00177_1.chkr_no = 9915;
      Test00177_1.cshr_no = 9916;
      Test00177_1.sale_date = 'abc17';
      Test00177_1.kind = 9918;
      Test00177_1.sub = 9919;
      Test00177_1.payopera_cd = 9920;
      Test00177_1.payopera_typ = 'abc21';
      Test00177_1.data1 = 9922;
      Test00177_1.data2 = 9923;
      Test00177_1.data3 = 9924;
      Test00177_1.data4 = 9925;
      Test00177_1.data5 = 9926;
      Test00177_1.data6 = 9927;

      //selectAllDataをして件数取得。
      List<RdlyCdpayflow> Test00177_AllRtn = await db.selectAllData(Test00177_1);
      int count = Test00177_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00177_1);

      //データ取得に必要なオブジェクトを用意
      RdlyCdpayflow Test00177_2 = RdlyCdpayflow();
      //Keyの値を設定する
      Test00177_2.comp_cd = 9912;
      Test00177_2.stre_cd = 9913;
      Test00177_2.mac_no = 9914;
      Test00177_2.chkr_no = 9915;
      Test00177_2.cshr_no = 9916;
      Test00177_2.sale_date = 'abc17';
      Test00177_2.kind = 9918;
      Test00177_2.sub = 9919;
      Test00177_2.payopera_cd = 9920;
      Test00177_2.payopera_typ = 'abc21';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyCdpayflow? Test00177_Rtn = await db.selectDataByPrimaryKey(Test00177_2);
      //取得行がない場合、nullが返ってきます
      if (Test00177_Rtn == null) {
        print('\n********** 異常発生：00177_RdlyCdpayflow_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00177_Rtn?.comp_cd,9912);
        expect(Test00177_Rtn?.stre_cd,9913);
        expect(Test00177_Rtn?.mac_no,9914);
        expect(Test00177_Rtn?.chkr_no,9915);
        expect(Test00177_Rtn?.cshr_no,9916);
        expect(Test00177_Rtn?.sale_date,'abc17');
        expect(Test00177_Rtn?.kind,9918);
        expect(Test00177_Rtn?.sub,9919);
        expect(Test00177_Rtn?.payopera_cd,9920);
        expect(Test00177_Rtn?.payopera_typ,'abc21');
        expect(Test00177_Rtn?.data1,9922);
        expect(Test00177_Rtn?.data2,9923);
        expect(Test00177_Rtn?.data3,9924);
        expect(Test00177_Rtn?.data4,9925);
        expect(Test00177_Rtn?.data5,9926);
        expect(Test00177_Rtn?.data6,9927);
      }

      //selectAllDataをして件数取得。
      List<RdlyCdpayflow> Test00177_AllRtn2 = await db.selectAllData(Test00177_1);
      int count2 = Test00177_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00177_1);
      print('********** テスト終了：00177_RdlyCdpayflow_01 **********\n\n');
    });

    // ********************************************************
    // テスト00178 : RdlyTaxDeal
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00178_RdlyTaxDeal_01', () async {
      print('\n********** テスト実行：00178_RdlyTaxDeal_01 **********');
      RdlyTaxDeal Test00178_1 = RdlyTaxDeal();
      Test00178_1.comp_cd = 9912;
      Test00178_1.stre_cd = 9913;
      Test00178_1.mac_no = 9914;
      Test00178_1.chkr_no = 9915;
      Test00178_1.cshr_no = 9916;
      Test00178_1.sale_date = 'abc17';
      Test00178_1.mode = 9918;
      Test00178_1.kind = 9919;
      Test00178_1.sub = 9920;
      Test00178_1.func_cd = 9921;
      Test00178_1.data1 = 9922;
      Test00178_1.data2 = 9923;
      Test00178_1.data3 = 9924;
      Test00178_1.data4 = 9925;
      Test00178_1.data5 = 9926;
      Test00178_1.data6 = 9927;
      Test00178_1.data7 = 9928;
      Test00178_1.data8 = 9929;
      Test00178_1.data9 = 9930;
      Test00178_1.data10 = 9931;
      Test00178_1.data11 = 9932;
      Test00178_1.data12 = 9933;
      Test00178_1.data13 = 9934;
      Test00178_1.data14 = 9935;
      Test00178_1.data15 = 9936;
      Test00178_1.data16 = 9937;
      Test00178_1.data17 = 9938;
      Test00178_1.data18 = 9939;
      Test00178_1.data19 = 9940;
      Test00178_1.data20 = 1.241;
      Test00178_1.data21 = 1.242;

      //selectAllDataをして件数取得。
      List<RdlyTaxDeal> Test00178_AllRtn = await db.selectAllData(Test00178_1);
      int count = Test00178_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00178_1);

      //データ取得に必要なオブジェクトを用意
      RdlyTaxDeal Test00178_2 = RdlyTaxDeal();
      //Keyの値を設定する
      Test00178_2.comp_cd = 9912;
      Test00178_2.stre_cd = 9913;
      Test00178_2.mac_no = 9914;
      Test00178_2.chkr_no = 9915;
      Test00178_2.cshr_no = 9916;
      Test00178_2.sale_date = 'abc17';
      Test00178_2.mode = 9918;
      Test00178_2.kind = 9919;
      Test00178_2.sub = 9920;
      Test00178_2.func_cd = 9921;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyTaxDeal? Test00178_Rtn = await db.selectDataByPrimaryKey(Test00178_2);
      //取得行がない場合、nullが返ってきます
      if (Test00178_Rtn == null) {
        print('\n********** 異常発生：00178_RdlyTaxDeal_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00178_Rtn?.comp_cd,9912);
        expect(Test00178_Rtn?.stre_cd,9913);
        expect(Test00178_Rtn?.mac_no,9914);
        expect(Test00178_Rtn?.chkr_no,9915);
        expect(Test00178_Rtn?.cshr_no,9916);
        expect(Test00178_Rtn?.sale_date,'abc17');
        expect(Test00178_Rtn?.mode,9918);
        expect(Test00178_Rtn?.kind,9919);
        expect(Test00178_Rtn?.sub,9920);
        expect(Test00178_Rtn?.func_cd,9921);
        expect(Test00178_Rtn?.data1,9922);
        expect(Test00178_Rtn?.data2,9923);
        expect(Test00178_Rtn?.data3,9924);
        expect(Test00178_Rtn?.data4,9925);
        expect(Test00178_Rtn?.data5,9926);
        expect(Test00178_Rtn?.data6,9927);
        expect(Test00178_Rtn?.data7,9928);
        expect(Test00178_Rtn?.data8,9929);
        expect(Test00178_Rtn?.data9,9930);
        expect(Test00178_Rtn?.data10,9931);
        expect(Test00178_Rtn?.data11,9932);
        expect(Test00178_Rtn?.data12,9933);
        expect(Test00178_Rtn?.data13,9934);
        expect(Test00178_Rtn?.data14,9935);
        expect(Test00178_Rtn?.data15,9936);
        expect(Test00178_Rtn?.data16,9937);
        expect(Test00178_Rtn?.data17,9938);
        expect(Test00178_Rtn?.data18,9939);
        expect(Test00178_Rtn?.data19,9940);
        expect(Test00178_Rtn?.data20,1.241);
        expect(Test00178_Rtn?.data21,1.242);
      }

      //selectAllDataをして件数取得。
      List<RdlyTaxDeal> Test00178_AllRtn2 = await db.selectAllData(Test00178_1);
      int count2 = Test00178_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00178_1);
      print('********** テスト終了：00178_RdlyTaxDeal_01 **********\n\n');
    });

    // ********************************************************
    // テスト00179 : RdlyTaxDealHour
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00179_RdlyTaxDealHour_01', () async {
      print('\n********** テスト実行：00179_RdlyTaxDealHour_01 **********');
      RdlyTaxDealHour Test00179_1 = RdlyTaxDealHour();
      Test00179_1.comp_cd = 9912;
      Test00179_1.stre_cd = 9913;
      Test00179_1.mac_no = 9914;
      Test00179_1.chkr_no = 9915;
      Test00179_1.cshr_no = 9916;
      Test00179_1.sale_date = 'abc17';
      Test00179_1.date_hour = 'abc18';
      Test00179_1.mode = 9919;
      Test00179_1.kind = 9920;
      Test00179_1.sub = 9921;
      Test00179_1.func_cd = 9922;
      Test00179_1.data1 = 9923;
      Test00179_1.data2 = 9924;
      Test00179_1.data3 = 9925;
      Test00179_1.data4 = 9926;
      Test00179_1.data5 = 9927;
      Test00179_1.data6 = 9928;
      Test00179_1.data7 = 9929;
      Test00179_1.data8 = 9930;
      Test00179_1.data9 = 9931;
      Test00179_1.data10 = 9932;
      Test00179_1.data11 = 9933;
      Test00179_1.data12 = 9934;
      Test00179_1.data13 = 9935;
      Test00179_1.data14 = 9936;
      Test00179_1.data15 = 9937;
      Test00179_1.data16 = 9938;
      Test00179_1.data17 = 9939;
      Test00179_1.data18 = 9940;
      Test00179_1.data19 = 9941;
      Test00179_1.data20 = 1.242;
      Test00179_1.data21 = 1.243;

      //selectAllDataをして件数取得。
      List<RdlyTaxDealHour> Test00179_AllRtn = await db.selectAllData(Test00179_1);
      int count = Test00179_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00179_1);

      //データ取得に必要なオブジェクトを用意
      RdlyTaxDealHour Test00179_2 = RdlyTaxDealHour();
      //Keyの値を設定する
      Test00179_2.comp_cd = 9912;
      Test00179_2.stre_cd = 9913;
      Test00179_2.mac_no = 9914;
      Test00179_2.chkr_no = 9915;
      Test00179_2.cshr_no = 9916;
      Test00179_2.sale_date = 'abc17';
      Test00179_2.date_hour = 'abc18';
      Test00179_2.mode = 9919;
      Test00179_2.kind = 9920;
      Test00179_2.sub = 9921;
      Test00179_2.func_cd = 9922;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      RdlyTaxDealHour? Test00179_Rtn = await db.selectDataByPrimaryKey(Test00179_2);
      //取得行がない場合、nullが返ってきます
      if (Test00179_Rtn == null) {
        print('\n********** 異常発生：00179_RdlyTaxDealHour_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00179_Rtn?.comp_cd,9912);
        expect(Test00179_Rtn?.stre_cd,9913);
        expect(Test00179_Rtn?.mac_no,9914);
        expect(Test00179_Rtn?.chkr_no,9915);
        expect(Test00179_Rtn?.cshr_no,9916);
        expect(Test00179_Rtn?.sale_date,'abc17');
        expect(Test00179_Rtn?.date_hour,'abc18');
        expect(Test00179_Rtn?.mode,9919);
        expect(Test00179_Rtn?.kind,9920);
        expect(Test00179_Rtn?.sub,9921);
        expect(Test00179_Rtn?.func_cd,9922);
        expect(Test00179_Rtn?.data1,9923);
        expect(Test00179_Rtn?.data2,9924);
        expect(Test00179_Rtn?.data3,9925);
        expect(Test00179_Rtn?.data4,9926);
        expect(Test00179_Rtn?.data5,9927);
        expect(Test00179_Rtn?.data6,9928);
        expect(Test00179_Rtn?.data7,9929);
        expect(Test00179_Rtn?.data8,9930);
        expect(Test00179_Rtn?.data9,9931);
        expect(Test00179_Rtn?.data10,9932);
        expect(Test00179_Rtn?.data11,9933);
        expect(Test00179_Rtn?.data12,9934);
        expect(Test00179_Rtn?.data13,9935);
        expect(Test00179_Rtn?.data14,9936);
        expect(Test00179_Rtn?.data15,9937);
        expect(Test00179_Rtn?.data16,9938);
        expect(Test00179_Rtn?.data17,9939);
        expect(Test00179_Rtn?.data18,9940);
        expect(Test00179_Rtn?.data19,9941);
        expect(Test00179_Rtn?.data20,1.242);
        expect(Test00179_Rtn?.data21,1.243);
      }

      //selectAllDataをして件数取得。
      List<RdlyTaxDealHour> Test00179_AllRtn2 = await db.selectAllData(Test00179_1);
      int count2 = Test00179_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00179_1);
      print('********** テスト終了：00179_RdlyTaxDealHour_01 **********\n\n');
    });

    // ********************************************************
    // テスト00180 : WkQue
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00180_WkQue_01', () async {
      print('\n********** テスト実行：00180_WkQue_01 **********');
      WkQue Test00180_1 = WkQue();
      Test00180_1.serial_no = 'abc12';
      Test00180_1.pid = 9913;
      Test00180_1.wk_step = 9914;
      Test00180_1.endtime = 'abc15';

      //selectAllDataをして件数取得。
      List<WkQue> Test00180_AllRtn = await db.selectAllData(Test00180_1);
      int count = Test00180_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00180_1);

      //データ取得に必要なオブジェクトを用意
      WkQue Test00180_2 = WkQue();
      //Keyの値を設定する
      Test00180_2.serial_no = 'abc12';

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      WkQue? Test00180_Rtn = await db.selectDataByPrimaryKey(Test00180_2);
      //取得行がない場合、nullが返ってきます
      if (Test00180_Rtn == null) {
        print('\n********** 異常発生：00180_WkQue_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00180_Rtn?.serial_no,'abc12');
        expect(Test00180_Rtn?.pid,9913);
        expect(Test00180_Rtn?.wk_step,9914);
        expect(Test00180_Rtn?.endtime,'abc15');
      }

      //selectAllDataをして件数取得。
      List<WkQue> Test00180_AllRtn2 = await db.selectAllData(Test00180_1);
      int count2 = Test00180_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00180_1);
      print('********** テスト終了：00180_WkQue_01 **********\n\n');
    });

    // ********************************************************
    // テスト00181 : LanguagesMst
    // 前提：openDBが正常に行われていること。
    // 試験手順：testを実行する。
    // 期待結果：①対象テーブルクラスのコードをすべて通して、insert前後で、その件数が増えること。
    // 　　　　　②対象テーブルへのinsertしたデータを取得することができること。
    // ********************************************************
    test('00181_LanguagesMst_01', () async {
      print('\n********** テスト実行：00181_LanguagesMst_01 **********');
      LanguagesMst Test00181_1 = LanguagesMst();
      Test00181_1.multilingual_key = 'abc12';
      Test00181_1.country_division = 9913;
      Test00181_1.label_name = 'abc14';
      Test00181_1.ins_datetime = 'abc15';
      Test00181_1.upd_datetime = 'abc16';
      Test00181_1.upd_user = 'abc17';

      //selectAllDataをして件数取得。
      List<LanguagesMst> Test00181_AllRtn = await db.selectAllData(Test00181_1);
      int count = Test00181_AllRtn.length;

      //設定したテストデータをinsert
      await db.insert(Test00181_1);

      //データ取得に必要なオブジェクトを用意
      LanguagesMst Test00181_2 = LanguagesMst();
      //Keyの値を設定する
      Test00181_2.multilingual_key = 'abc12';
      Test00181_2.country_division = 9913;

      //キーを指定して取得するテーブルクラスのインスタンスを入れる。
      LanguagesMst? Test00181_Rtn = await db.selectDataByPrimaryKey(Test00181_2);
      //取得行がない場合、nullが返ってきます
      if (Test00181_Rtn == null) {
        print('\n********** 異常発生：00181_LanguagesMst_01 **********');
      } else {
        //insertで入れたデータを期待値とし照合
        expect(Test00181_Rtn?.multilingual_key,'abc12');
        expect(Test00181_Rtn?.country_division,9913);
        expect(Test00181_Rtn?.label_name,'abc14');
        expect(Test00181_Rtn?.ins_datetime,'abc15');
        expect(Test00181_Rtn?.upd_datetime,'abc16');
        expect(Test00181_Rtn?.upd_user,'abc17');
      }

      //selectAllDataをして件数取得。
      List<LanguagesMst> Test00181_AllRtn2 = await db.selectAllData(Test00181_1);
      int count2 = Test00181_AllRtn2.length;
      expect(count2,count + 1);

      //データ削除
      await db.delete(Test00181_1);
      print('********** テスト終了：00181_LanguagesMst_01 **********\n\n');
    });
  });
}