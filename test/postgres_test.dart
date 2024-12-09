// /*
//  * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
//  * CONFIDENTIAL/社外秘
//  * 無断開示・無断複製禁止
//  */
//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
// import 'app/common/cls_conf/unitTestParts.dart';
// import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
// import 'package:flutter_pos/postgres_library/src/basic_table_access.dart';
// import 'package:flutter_pos/postgres_library/src/pos_basic_table_access.dart';
// import 'package:flutter_pos/app/inc/apl/rxtbl_buff.dart';
// import 'package:flutter_pos/postgres_library/src/staff_table_access.dart';
// import 'package:flutter_pos/postgres_library/src/sale_table_access.dart';
// import 'package:flutter_pos/app/common/date_util.dart';
//
//
// /*
// 本テストでは、登録画面バックエンドの一部機能の確認を行う
//  */
// Future<void> main() async{
//   await postgres_test();
// }
//
// class DbMap{
//   //***************************************************************************************************
//   //	DBから取得した値の加工.
//   //***************************************************************************************************
//
//   /// DBから取得した値をint型に直す
//   /// nullだった場合はinitValueを返す.
//   static int getIntValueFromDbMap(dynamic value, {int initValue = 0}) {
//     DBMapChangeRet<int> result = getIntValueFromDbMapRet(value);
//     return result.isSuccess ? result.value : initValue;
//   }
//
//   /// DBから取得した値をint型に直す
//   /// nullだった場合はinitValueを返す.
//   static String getStringValueFromDbMap(dynamic value,
//       {String initValue = ""}) {
//     DBMapChangeRet<String> result = getStringValueFromDbMapRet(value);
//     return result.isSuccess ? result.value : initValue;
//   }
//
//   /// DBから取得した値をint型に直す
//   /// nullだったりintに変換できなかった場合はDBMapChangeRet.isSuccessがfalseになる.
//   static DBMapChangeRet<int> getIntValueFromDbMapRet(dynamic value) {
//     if (value is int) {
//       return DBMapChangeRet(value, true);
//     }
//     if (value is double) {
//       return DBMapChangeRet(value.toInt(), true);
//     }
//     if (value == null) {
//       return DBMapChangeRet(0, false);
//     }
//     int? result = int.tryParse(value);
//     if (result == null) {
//       return DBMapChangeRet(0, false);
//     }
//     return DBMapChangeRet(result, true);
//   }
//
//   /// DBから取得した値(数値)をbool型に直す
//   /// 0より大きければtrue
//   static DBMapChangeRet<bool> getBoolValueFromDbMapIntValueRet(dynamic value) {
//     if (value is bool) {
//       return DBMapChangeRet(value, true);
//     }
//     if (value is int) {
//       return DBMapChangeRet(value > 0, true);
//     }
//     if (value == null) {
//       return DBMapChangeRet(false, false);
//     }
//     int? result = int.tryParse(value);
//     if (result == null) {
//       return DBMapChangeRet(false, false);
//     }
//     bool isTrue = result > 0;
//     return DBMapChangeRet(isTrue, true);
//   }
//
//   /// DBから取得した値(数値)をbool型に直す
//   /// 0より大きければtrue
//   static DBMapChangeRet<String> getStringValueFromDbMapRet(dynamic value) {
//     if (value == null) {
//       return DBMapChangeRet("", false);
//     }
//     return DBMapChangeRet(value, true);
//   }
// }
// /// DBマップから[T]型へ変換した結果クラス.
// class DBMapChangeRet<T> {
//   /// 変換後の値
//   T value;
//
//   /// 変換成功したかどうか.
//   bool isSuccess;
//   DBMapChangeRet(this.value, this.isSuccess);
// }
//
// enum REGGRP_LISTS {
//   REGGRP_CLS(1), // 分類グループ
//   REGGRP_TRM(2), // ターミナルグループ
//   REGGRP_PRESET(3), // プリセットグループ
//   REGGRP_KOPT(4), // キーオプショングループ
//   REGGRP_BATCH(5), // 予約レポートグループ
//   REGGRP_IMG(6), // イメージグループ
//   REGGRP_MSG(7), // メッセージグループ
//   REGGRP_CASHRECYCLE(8), // キャッシュリサイクル(マネージメント)グループ
//   REGGRP_CARDCOMP(9), // カード企業コード
//   REGGRP_CARDSTRE(10), // カード店舗コード
//   REGGRP_STROPNCLS(11), // 自動開閉店グループ
//   REGGRP_FORCESTRCLS(12); // 自動強制閉設グループ
//
//   final int typeCd;
//   const REGGRP_LISTS(this.typeCd);
// }
//
// Future<void> postgres_test() async
// {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   var db = DbManipulationPs();
//
//   // if (Platform.isAndroid) PathProviderAndroid.registerWith();
//   // await SysMain.startApplicationIni();
//   // await EnvironmentData().loadAppInitJson();
//
//
//   group('basic_table',()
//   {
//     setUpAll(() async {
//       PathProviderPlatform.instance = MockPathProviderPlatform();
//       await db.openDB();
//     });
//     setUp(() async {});
//
//     // 各テストの事後処理
//     tearDown(() async {});
//
//     tearDownAll(() async {
//     });
//
//
//     // // ********************************************************
//     // // テスト00001 : mappedResultsQuery
//     // // 前提：なし
//     // // 試験手順：testを実行する。
//     // // 期待結果：①
//     // // 　　　　　②
//     // // ********************************************************
//     // test('00001_mappedResultsQuery_01', () async {
//     //   print('\n********** テスト実行：00001_mappedResultsQuery_01 **********');
//     //   try{
//     //     List<Map<String, Map<String, dynamic>>> result;
//     //     // String sql1 = "select * from c_stre_mst where stre_cd = '%ld' and comp_cd = '%ld'";
//     //     //　mappedResultsQueryで使う場合はSQL文で@変数1の形にする。
//     //     String sql1 = "select * from c_stre_mst where stre_cd = @ld and comp_cd = @ld2";
//     //     Map<String, dynamic>? subValues = {"ld" : 2,"ld2" : 1};
//     //     result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//     //
//     //     if(result == null){
//     //       print('\n********** null：00001_mappedResultsQuery_01 **********');
//     //     }else{
//     //       print('\n********** レコードあり：00001_mappedResultsQuery_01 **********');
//     //       String temp = result[0]["c_stre_mst"].toString();
//     //       String temp2 = "";
//     //       String temp3 = "";
//     //       temp2 = (result[0]["c_stre_mst"]!["name"] != null) ? (result[0]["c_stre_mst"]!["name"].toString()) : '中身なし';
//     //       temp3 = (result[0]["c_stre_mst"]!["ins_datetime"] != null) ? (result[0]["c_stre_mst"]!["ins_datetime"].toString()) : '中身なし';
//     //       print('c_stre_mstの中身は$temp');
//     //       print('c_stre_mstのnameは$temp2');
//     //       print('c_stre_mstのins_datetimeは$temp3');
//     //     }
//     //
//     //   }catch(e){
//     //     print('\n********** 異常発生：00001_mappedResultsQuery_01 **********');
//     //   }
//     //   print('********** テスト終了：00001_mappedResultsQuery_01 **********\n\n');
//     // });
//     //
//     // // ********************************************************
//     // // テスト00002 : _rmDbStreRead
//     // // 前提：なし
//     // // 試験手順：testを実行する。
//     // // 期待結果：①
//     // // 　　　　　②
//     // // ********************************************************
//     // test('00002__rmDbStreRead', () async {
//     //   print('\n********** テスト実行：00002__rmDbStreRead **********');
//     //   try{
//     //     var dbAccess = DbManipulationPs();
//     //     List<Map<String, Map<String, dynamic>>> result;
//     //     CStreMst mst = CStreMst();
//     //     // mst.stre_cd = _pCom.dbRegCtrl.streCd;
//     //     // mst.comp_cd = _pCom.dbRegCtrl.compCd;
//     //     // CStreMstColumns? data = await dbAccess.selectDataByPrimaryKey(mst);
//     //     CStreMstColumns? data;
//     //     String sql1 = "select * from c_stre_mst where stre_cd = @ld and comp_cd = @ld2";
//     //     Map<String, dynamic>? subValues = {"ld" : 2,"ld2" : 1};
//     //     result = await dbAccess.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//     //     // data = mst.toTable(result) as CStreMstColumns;
//     //     if (result == null) {
//     //       print('\n********** レコード取得失敗：00002__rmDbStreRead **********');
//     //       // _setErrDlgId(DlgConfirmMsgKind.MSG_STRE_NOTREAD);
//     //       // return false;
//     //     }else{
//     //       print('\n********** レコードあり：00001_mappedResultsQuery_01 **********');
//     //       // String temp = result[0]["c_stre_mst"].toString();
//     //       // String temp2 = "";
//     //       // String temp3 = "";
//     //       // temp2 = (result[0]["c_stre_mst"]!["name"] != null) ? (result[0]["c_stre_mst"]!["name"].toString()) : '中身なし';
//     //       // temp3 = (result[0]["c_stre_mst"]!["ins_datetime"] != null) ? (result[0]["c_stre_mst"]!["ins_datetime"].toString()) : '中身なし';
//     //       // print('c_stre_mstの中身は$temp');
//     //       // print('c_stre_mstのnameは$temp2');
//     //       // print('c_stre_mstのins_datetimeは$temp3');
//     //     }
//     //     // _pCom.dbStr = data;
//     //   }catch(e){
//     //     print('\n********** 異常発生：00002__rmDbStreRead **********');
//     //   }
//     //   print('********** テスト終了：00002__rmDbStreRead **********\n\n');
//     // });
//     //
//     // // ********************************************************
//     // // テスト00003 : getExtCollectPreset
//     // // 前提：なし
//     // // 試験手順：testを実行する。
//     // // 期待結果：①
//     // // 　　　　　②
//     // // ********************************************************
//     // test('00003_getExtCollectPreset', () async {
//     //   print('\n********** テスト実行：00003_getExtCollectPreset **********');
//     //   try{
//     //     List<Map<String, Map<String, dynamic>>> result;
//     //     var db = DbManipulationPs();
//     //     String sql1 = "select * from c_preset_mst where comp_cd = @p1 AND stre_cd = @p2 AND preset_cd = @p3 ORDER BY preset_no";
//     //     Map<String, dynamic>? subValues = {"p1" : 1,"p2" : 2,"p3" : 101};
//     //     result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//     //
//     //     if (result == null) {
//     //       print('\n********** レコード取得失敗：00003_getExtCollectPreset **********');
//     //       // _setErrDlgId(DlgConfirmMsgKind.MSG_STRE_NOTREAD);
//     //       // return false;
//     //     }else{
//     //       print('\n********** レコードあり：00003_getExtCollectPreset **********');
//     //       List<CPresetMstColumns> mst = List.generate(result.length, (i) {
//     //         CPresetMstColumns rn = CPresetMstColumns();
//     //         rn.comp_cd = int.tryParse(result[i]["c_preset_mst"]?['comp_cd']);
//     //         rn.stre_cd = int.tryParse(result[i]["c_preset_mst"]?['stre_cd']);
//     //         rn.preset_grp_cd = int.tryParse(result[i]["c_preset_mst"]?['preset_grp_cd']);
//     //         rn.preset_cd = int.tryParse(result[i]["c_preset_mst"]?['preset_cd']);
//     //         rn.preset_no = result[i]["c_preset_mst"]?['preset_no'];
//     //         rn.presetcolor = result[i]["c_preset_mst"]?['presetcolor'] ?? 0;
//     //         rn.ky_cd = result[i]["c_preset_mst"]?['ky_cd'] ?? 0;
//     //         rn.ky_plu_cd = result[i]["c_preset_mst"]?['ky_plu_cd'];
//     //         rn.ky_smlcls_cd = int.tryParse(result[i]["c_preset_mst"]?['ky_smlcls_cd']) ?? 0;
//     //         rn.ky_size_flg = result[i]["c_preset_mst"]?['ky_size_flg'] ?? 0;
//     //         rn.ky_status = result[i]["c_preset_mst"]?['ky_status'] ?? 0;
//     //         rn.ky_name = result[i]["c_preset_mst"]?['ky_name'];
//     //         rn.img_num = int.tryParse(result[i]["c_preset_mst"]?['img_num']) ?? 0;
//     //         rn.ins_datetime = (result[i]["c_preset_mst"]?['ins_datetime']).toString();
//     //         rn.upd_datetime = (result[i]["c_preset_mst"]?['upd_datetime']).toString();
//     //         rn.status = result[i]["c_preset_mst"]?['status'] ?? 0;
//     //         rn.send_flg = result[i]["c_preset_mst"]?['send_flg'] ?? 0;
//     //         rn.upd_user = int.tryParse(result[i]["c_preset_mst"]?['upd_user']) ?? 0;
//     //         rn.upd_system = result[i]["c_preset_mst"]?['upd_system'] ?? 0;
//     //         return rn;
//     //       });
//     //     }
//     //     // _pCom.dbStr = data;
//     //   }catch(e){
//     //     print('\n********** 異常発生：00003_getExtCollectPreset **********');
//     //   }
//     //   print('********** テスト終了：00003_getExtCollectPreset **********\n\n');
//     // });
//     //
//     // // ********************************************************
//     // // テスト00004 : getExtCollectPreset
//     // // 前提：なし
//     // // 試験手順：testを実行する。
//     // // 期待結果：①
//     // // 　　　　　②
//     // // ********************************************************
//     // test('00003_getExtCollectPreset', () async {
//     //   print('\n********** テスト実行：00003_getExtCollectPreset **********');
//     //   try{
//     //     var db = DbManipulationPs();
//     //     List<Map<String, Map<String, dynamic>>> result;
//     //     String sql1 = "select * from c_stre_mst where stre_cd = @p1 and comp_cd = @p2";
//     //     Map<String, dynamic>? subValues = {"p1" : 2,"p2" : 1};
//     //     result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//     //
//     //     if (result == null) {
//     //       print('\n********** レコード取得失敗：00003_getExtCollectPreset **********');
//     //       // _setErrDlgId(DlgConfirmMsgKind.MSG_STRE_NOTREAD);
//     //       // return false;
//     //     }else{
//     //       print('\n********** レコードあり：00003_getExtCollectPreset **********');
//     //       CStreMstColumns rn = CStreMstColumns();
//     //       rn.stre_cd = result[0]["c_stre_mst"]?['stre_cd'];
//     //       rn.comp_cd = result[0]["c_stre_mst"]?['comp_cd'];
//     //       rn.zone_cd = result[0]["c_stre_mst"]?['zone_cd'];
//     //       rn.bsct_cd = result[0]["c_stre_mst"]?['bsct_cd'];
//     //       rn.name = result[0]["c_stre_mst"]?['name'];
//     //       rn.short_name = result[0]["c_stre_mst"]?['short_name'];
//     //       rn.kana_name = result[0]["c_stre_mst"]?['kana_name'];
//     //       rn.post_no = result[0]["c_stre_mst"]?['post_no'];
//     //       rn.adress1 = result[0]["c_stre_mst"]?['adress1'];
//     //       rn.adress2 = result[0]["c_stre_mst"]?['adress2'];
//     //       rn.adress3 = result[0]["c_stre_mst"]?['adress3'];
//     //       rn.telno1 = result[0]["c_stre_mst"]?['telno1'];
//     //       rn.telno2 = result[0]["c_stre_mst"]?['telno2'];
//     //       rn.srch_telno1 = result[0]["c_stre_mst"]?['srch_telno1'];
//     //       rn.srch_telno2 = result[0]["c_stre_mst"]?['srch_telno2'];
//     //       rn.ip_addr = result[0]["c_stre_mst"]?['ip_addr'];
//     //       rn.trends_typ = result[0]["c_stre_mst"]?['trends_typ'];
//     //       rn.stre_typ = result[0]["c_stre_mst"]?['stre_typ'];
//     //       rn.flg_shp = result[0]["c_stre_mst"]?['flg_shp'];
//     //       rn.business_typ1 = result[0]["c_stre_mst"]?['business_typ1'];
//     //       rn.business_typ2 = result[0]["c_stre_mst"]?['business_typ2'];
//     //       rn.chain_other_flg = result[0]["c_stre_mst"]?['chain_other_flg'];
//     //       rn.locate_typ = result[0]["c_stre_mst"]?['locate_typ'];
//     //       rn.openclose_flg = result[0]["c_stre_mst"]?['openclose_flg'];
//     //       rn.opentime = result[0]["c_stre_mst"]?['opentime'];
//     //       rn.closetime = result[0]["c_stre_mst"]?['closetime'];
//     //       rn.floorspace = result[0]["c_stre_mst"]?['floorspace'];
//     //       rn.today = result[0]["c_stre_mst"]?['today'];
//     //       rn.bfrday = result[0]["c_stre_mst"]?['bfrday'];
//     //       rn.twodaybfr = result[0]["c_stre_mst"]?['twodaybfr'];
//     //       rn.nextday = result[0]["c_stre_mst"]?['nextday'];
//     //       rn.sysflg_base = result[0]["c_stre_mst"]?['sysflg_base'];
//     //       rn.sysflg_sale = result[0]["c_stre_mst"]?['sysflg_sale'];
//     //       rn.sysflg_purchs = result[0]["c_stre_mst"]?['sysflg_purchs'];
//     //       rn.sysflg_order = result[0]["c_stre_mst"]?['sysflg_order'];
//     //       rn.sysflg_invtry = result[0]["c_stre_mst"]?['sysflg_invtry'];
//     //       rn.sysflg_cust = result[0]["c_stre_mst"]?['sysflg_cust'];
//     //       rn.sysflg_poppy = result[0]["c_stre_mst"]?['sysflg_poppy'];
//     //       rn.sysflg_elslbl = result[0]["c_stre_mst"]?['sysflg_elslbl'];
//     //       rn.sysflg_fresh = result[0]["c_stre_mst"]?['sysflg_fresh'];
//     //       rn.sysflg_wdslbl = result[0]["c_stre_mst"]?['sysflg_wdslbl'];
//     //       rn.sysflg_24hour = result[0]["c_stre_mst"]?['sysflg_24hour'];
//     //       rn.showorder = result[0]["c_stre_mst"]?['showorder'];
//     //       rn.opendate = result[0]["c_stre_mst"]?['opendate'];
//     //       rn.stre_ver_flg = result[0]["c_stre_mst"]?['stre_ver_flg'];
//     //       rn.sunday_off_flg = result[0]["c_stre_mst"]?['sunday_off_flg'];
//     //       rn.monday_off_flg = result[0]["c_stre_mst"]?['monday_off_flg'];
//     //       rn.tuesday_off_flg = result[0]["c_stre_mst"]?['tuesday_off_flg'];
//     //       rn.wednesday_off_flg = result[0]["c_stre_mst"]?['wednesday_off_flg'];
//     //       rn.thursday_off_flg = result[0]["c_stre_mst"]?['thursday_off_flg'];
//     //       rn.friday_off_flg = result[0]["c_stre_mst"]?['friday_off_flg'];
//     //       rn.saturday_off_flg = result[0]["c_stre_mst"]?['saturday_off_flg'];
//     //       rn.itemstock_flg = result[0]["c_stre_mst"]?['itemstock_flg'];
//     //       rn.wait_time = result[0]["c_stre_mst"]?['wait_time'];
//     //       rn.ins_datetime = result[0]["c_stre_mst"]?['ins_datetime'];
//     //       rn.upd_datetime = result[0]["c_stre_mst"]?['upd_datetime'];
//     //       rn.status = result[0]["c_stre_mst"]?['status'];
//     //       rn.send_flg = result[0]["c_stre_mst"]?['send_flg'];
//     //       rn.upd_user = result[0]["c_stre_mst"]?['upd_user'];
//     //       rn.upd_system = result[0]["c_stre_mst"]?['upd_system'];
//     //       rn.entry_no = result[0]["c_stre_mst"]?['entry_no'];
//     //     }
//     //     // _pCom.dbStr = data;
//     //   }catch(e){
//     //     print('\n********** 異常発生：00003_getExtCollectPreset **********');
//     //   }
//     //   print('********** テスト終了：00003_getExtCollectPreset **********\n\n');
//     // });
//
//     // ********************************************************
//     // テスト00101 : drv_scan_init getInstreFlg
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00101_drv_scan_init getInstreFlg', () async {
//       print('\n********** テスト実行：00101_drv_scan_init getInstreFlg **********');
//       int  instre_flg_Typ9 = 0;
//       int  format_no_Typ9 = 0;
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//
//         /* 値下バーコード１段目の設定確認 */
//         String sql1 = "select instre_flg,format_no from c_instre_mst where format_typ=1;";
//         result = await db.dbCon.mappedResultsQuery(sql1);
//         if (result.length != 0) {
//           instre_flg_Typ9 = int.tryParse(result[0]["c_instre_mst"]?["instre_flg"]) ?? 0;
//           format_no_Typ9 = int.tryParse(result[0]["c_instre_mst"]?["format_no"]) ?? 0;
//         } else {
//           instre_flg_Typ9 = 0;
//           format_no_Typ9 = 0;
//         }
//         print('instre_flg_Typ9の中身は$instre_flg_Typ9');
//         print('format_no_Typ9の中身は$format_no_Typ9');
//
//       }catch(e){
//         print('\n********** 異常発生：00101_drv_scan_init getInstreFlg **********');
//       }
//       print('********** テスト終了：00101_drv_scan_init getInstreFlg **********\n\n');
//     });
//     // ********************************************************
//     // テスト00102 : recog_chk recogGetDBDtl
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00102_recog_chk recogGetDBDtl', () async {
//       print('\n********** テスト実行：00102_recog_chk recogGetDBDtl **********');
//       // String recogData = 0.toString().padLeft(18, "0");
//       String recogData = '0';
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select emergency_type from c_recoginfo_mst where comp_cd = @p1 and stre_cd = @p2 and mac_no = @p3 and page = @p4";
//         Map<String, dynamic>? subValues = {"p1" : 1,"p2" : 2,"p3" : 3,"p4" : 20};
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//         recogData = result[0]["c_recoginfo_mst"]?["emergency_type"] ?? "";
//
//         print('recogDataの中身は$recogData');
//
//       }catch(e){
//         print('\n********** 異常発生：00102_recog_chk recogGetDBDtl **********');
//       }
//       print('********** テスト終了：00102_recog_chk recogGetDBDtl **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00103 : regs getExtCollectPreset
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00103_regs getExtCollectPreset', () async {
//       print('\n********** テスト実行：00103_regs getExtCollectPreset **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select * from c_preset_mst where comp_cd = @p1 AND stre_cd = @p2 AND preset_cd = @p3 ORDER BY preset_no";
//         Map<String, dynamic>? subValues = {"p1" : 1,"p2" : 2,"p3" : 101};
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//         List<CPresetMstColumns> cp =  List.generate(result.length, (i) {
//           CPresetMstColumns rn = CPresetMstColumns();
//           rn.comp_cd = int.tryParse(result[i]["c_preset_mst"]?['comp_cd']);
//           rn.stre_cd = int.tryParse(result[i]["c_preset_mst"]?['stre_cd']);
//           rn.preset_grp_cd = int.tryParse(result[i]["c_preset_mst"]?['preset_grp_cd']);
//           rn.preset_cd = int.tryParse(result[i]["c_preset_mst"]?['preset_cd']);
//           rn.preset_no = result[i]["c_preset_mst"]?['preset_no'];
//           rn.presetcolor = result[i]["c_preset_mst"]?['presetcolor'] ?? 0;
//           rn.ky_cd = result[i]["c_preset_mst"]?['ky_cd'] ?? 0;
//           rn.ky_plu_cd = result[i]["c_preset_mst"]?['ky_plu_cd'];
//           rn.ky_smlcls_cd = int.tryParse(result[i]["c_preset_mst"]?['ky_smlcls_cd']) ?? 0;
//           rn.ky_size_flg = result[i]["c_preset_mst"]?['ky_size_flg'] ?? 0;
//           rn.ky_status = result[i]["c_preset_mst"]?['ky_status'] ?? 0;
//           rn.ky_name = result[i]["c_preset_mst"]?['ky_name'];
//           rn.img_num = int.tryParse(result[i]["c_preset_mst"]?['img_num']) ?? 0;
//           rn.ins_datetime = (result[i]["c_preset_mst"]?['ins_datetime']).toString();
//           rn.upd_datetime = (result[i]["c_preset_mst"]?['upd_datetime']).toString();
//           rn.status = result[i]["c_preset_mst"]?['status'] ?? 0;
//           rn.send_flg = result[i]["c_preset_mst"]?['send_flg'] ?? 0;
//           rn.upd_user = int.tryParse(result[i]["c_preset_mst"]?['upd_user']) ?? 0;
//           rn.upd_system = result[i]["c_preset_mst"]?['upd_system'] ?? 0;
//           return rn;
//         });
//         for(int i = 0; i< cp.length; i++){
//           CPresetMstColumns temp = CPresetMstColumns();
//           temp = cp[i];
//           int? preset_no1 = temp.preset_no;
//           print('cpの$i番目のpreset_noは$preset_no1');
//         }
//
//       }catch(e){
//         print('\n********** 異常発生：00103_regs getExtCollectPreset **********');
//       }
//       print('********** テスト終了：00103_regs getExtCollectPreset **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00104 : rm_db_read _rmDbImgRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00104_rm_db_read _rmDbImgRead', () async {
//       print('\n********** テスト実行：00104_rm_db_read _rmDbImgRead **********');
//       try{
//         String sql =
//             "select img_cd ,img_data from c_img_mst where comp_cd = 1 AND stre_cd = 2 AND img_grp_cd = '1' order by img_cd";
//         List<Map<String, Map<String, dynamic>>> result;
//         result = await db.dbCon.mappedResultsQuery(sql);
//
//         print('SQL実行完了');
//
//         if (result == null || result.isEmpty) {
//           print('データなし');
//         }
//
//         List<int> img_cd_list = [];
//         List<String> img_data_list = [];
//         for (int i = 0; i < result.length; i++) {
//           img_cd_list.insert(i, DbMap.getIntValueFromDbMap(result[i]["c_img_mst"]?["img_cd"]));
//           if (img_cd_list[i] <= 0) {
//             break;
//           }
//           img_data_list.insert(i,DbMap.getStringValueFromDbMap(result[i]["c_img_mst"]?["img_data"]));
//         }
//
//         for(int i = 0; i< img_cd_list.length;i++){
//           print('img_cdの$i番目の中身は${img_cd_list[i]}');
//           print('img_dataの$i番目の中身は${img_data_list[i]}');
//         }
//       }catch(e){
//         print('\n********** 異常発生：00104_rm_db_read _rmDbImgRead **********');
//       }
//       print('********** テスト終了：00104_rm_db_read _rmDbImgRead **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00105 : rm_db_read _getDdBMacInfoData
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00105_rm_db_read _getDdBMacInfoData', () async {
//       print('\n********** テスト実行：00105_rm_db_read _getDdBMacInfoData **********');
//       try{
//         String sql = '''SELECT
// 	inf.comp_cd AS comp_cd, inf.stre_cd AS stre_cd, inf.mac_no AS mac_no,
// 	MAX(inf.mac_typ) AS mac_typ, MAX(inf.mac_addr) AS mac_addr, MAX(inf.ip_addr) AS ip_addr,
// 	MAX(inf.brdcast_addr) AS brdcast_addr, MAX(inf.ip_addr2) AS ip_addr2, MAX(inf.brdcast_addr2) AS brdcast_addr2,
// 	MAX(inf.org_mac_no) AS org_mac_no, MAX(inf.crdt_trm_cd) AS crdt_trm_cd, MAX(inf.set_owner_flg) AS set_owner_flg,
// 	MAX(inf.mac_role1) AS mac_role1, MAX(inf.mac_role2) AS mac_role2, MAX(inf.mac_role3) AS mac_role3,
// 	MAX(inf.pbchg_flg) AS pbchg_flg, MAX(inf.start_datetime) AS start_datetime, MAX(inf.end_datetime) AS end_datetime,
// 	MAX(inf.auto_opn_cshr_cd) AS auto_opn_cshr_cd, MAX(inf.auto_opn_chkr_cd) AS auto_opn_chkr_cd, MAX(inf.auto_cls_cshr_cd) AS auto_cls_cshr_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_CLS.typeCd}' THEN grp.grp_cd ELSE '0' END) AS cls_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_TRM.typeCd}' THEN grp.grp_cd ELSE '1' END) AS trm_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_PRESET.typeCd}' THEN grp.grp_cd ELSE '1' END) AS preset_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_KOPT.typeCd}' THEN grp.grp_cd ELSE '1' END) AS kopt_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_BATCH.typeCd}' THEN grp.grp_cd ELSE '1' END) AS batch_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_IMG.typeCd}' THEN grp.grp_cd ELSE '1' END) AS img_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_MSG.typeCd}' THEN grp.grp_cd ELSE '1' END) AS msg_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_CASHRECYCLE.typeCd}' THEN grp.grp_cd ELSE '0' END) AS cashrecycle_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_CARDCOMP.typeCd}' THEN grp.grp_cd ELSE '1' END) AS card_comp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_CARDSTRE.typeCd}' THEN grp.grp_cd ELSE '1' END) AS card_stre_cd
// 	, MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_STROPNCLS.typeCd}' THEN grp.grp_cd ELSE '1' END) AS stropncls_grp_cd,
// 	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_FORCESTRCLS.typeCd}' THEN grp.grp_cd ELSE '0' END) AS forcestrcls_grp_cd
// 	FROM c_reginfo_mst inf
// 	LEFT OUTER JOIN c_reginfo_grp_mst grp
// 	ON inf.comp_cd = grp.comp_cd AND inf.stre_cd = grp.stre_cd AND inf.mac_no = grp.mac_no
// 	WHERE inf.comp_cd = '1' AND inf.stre_cd = '2' AND inf.mac_no = '3'
// 	GROUP BY inf.comp_cd, inf.stre_cd, inf.mac_no
// 	''';
//
//         List<Map<String, Map<String, dynamic>>> result;
//         result = await db.dbCon.mappedResultsQuery(sql);
//
//         print('${result}');
//       }catch(e){
//         print('\n********** 異常発生：00105_rm_db_read _getDdBMacInfoData **********');
//       }
//       print('********** テスト終了：00105_rm_db_read _getDdBMacInfoData **********\n\n');
//     });
//     // ********************************************************
//     // テスト00106 : rm_db_read _rmDbStreRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00106_rm_db_read _rmDbStreRead', () async {
//       print('\n********** テスト実行：00106_rm_db_read _rmDbStreRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select * from c_stre_mst where stre_cd = @p1 and comp_cd = @p2";
//         Map<String, dynamic>? subValues = {"p1" : 2,"p2" : 1};
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         CStreMstColumns rn = CStreMstColumns();
//         rn.stre_cd = int.parse(result[0]["c_stre_mst"]?['stre_cd']);
//         rn.comp_cd = int.parse(result[0]["c_stre_mst"]?['comp_cd']);
//         rn.zone_cd = int.parse(result[0]["c_stre_mst"]?['zone_cd']);
//         rn.bsct_cd = int.parse(result[0]["c_stre_mst"]?['bsct_cd']);
//         rn.name = result[0]["c_stre_mst"]?['name'];
//         rn.short_name = result[0]["c_stre_mst"]?['short_name'];
//         rn.kana_name = result[0]["c_stre_mst"]?['kana_name'];
//         rn.post_no = result[0]["c_stre_mst"]?['post_no'];
//         rn.adress1 = result[0]["c_stre_mst"]?['adress1'];
//         rn.adress2 = result[0]["c_stre_mst"]?['adress2'];
//         rn.adress3 = result[0]["c_stre_mst"]?['adress3'];
//         rn.telno1 = result[0]["c_stre_mst"]?['telno1'];
//         rn.telno2 = result[0]["c_stre_mst"]?['telno2'];
//         rn.srch_telno1 = result[0]["c_stre_mst"]?['srch_telno1'];
//         rn.srch_telno2 = result[0]["c_stre_mst"]?['srch_telno2'];
//         rn.ip_addr = result[0]["c_stre_mst"]?['ip_addr'];
//         rn.trends_typ = result[0]["c_stre_mst"]?['trends_typ'];
//         rn.stre_typ = result[0]["c_stre_mst"]?['stre_typ'];
//         rn.flg_shp = result[0]["c_stre_mst"]?['flg_shp'];
//         rn.business_typ1 = result[0]["c_stre_mst"]?['business_typ1'];
//         rn.business_typ2 = result[0]["c_stre_mst"]?['business_typ2'];
//         rn.chain_other_flg = result[0]["c_stre_mst"]?['chain_other_flg'];
//         rn.locate_typ = result[0]["c_stre_mst"]?['locate_typ'];
//         rn.openclose_flg = result[0]["c_stre_mst"]?['openclose_flg'];
//         rn.opentime = (result[0]["c_stre_mst"]?['opentime']).toString();
//         rn.closetime = (result[0]["c_stre_mst"]?['closetime']).toString();
//         rn.floorspace = double.parse(result[0]["c_stre_mst"]?['floorspace']);
//         rn.today = (result[0]["c_stre_mst"]?['today']).toString();
//         rn.bfrday = (result[0]["c_stre_mst"]?['bfrday']).toString();
//         rn.twodaybfr = (result[0]["c_stre_mst"]?['twodaybfr']).toString();
//         rn.nextday = (result[0]["c_stre_mst"]?['nextday']).toString();
//         rn.sysflg_base = result[0]["c_stre_mst"]?['sysflg_base'];
//         rn.sysflg_sale = result[0]["c_stre_mst"]?['sysflg_sale'];
//         rn.sysflg_purchs = result[0]["c_stre_mst"]?['sysflg_purchs'];
//         rn.sysflg_order = result[0]["c_stre_mst"]?['sysflg_order'];
//         rn.sysflg_invtry = result[0]["c_stre_mst"]?['sysflg_invtry'];
//         rn.sysflg_cust = result[0]["c_stre_mst"]?['sysflg_cust'];
//         rn.sysflg_poppy = result[0]["c_stre_mst"]?['sysflg_poppy'];
//         rn.sysflg_elslbl = result[0]["c_stre_mst"]?['sysflg_elslbl'];
//         rn.sysflg_fresh = result[0]["c_stre_mst"]?['sysflg_fresh'];
//         rn.sysflg_wdslbl = result[0]["c_stre_mst"]?['sysflg_wdslbl'];
//         rn.sysflg_24hour = result[0]["c_stre_mst"]?['sysflg_24hour'];
//         rn.showorder = result[0]["c_stre_mst"]?['showorder'];
//         rn.opendate = (result[0]["c_stre_mst"]?['opendate']).toString();
//         rn.stre_ver_flg = result[0]["c_stre_mst"]?['stre_ver_flg'];
//         rn.sunday_off_flg = result[0]["c_stre_mst"]?['sunday_off_flg'];
//         rn.monday_off_flg = result[0]["c_stre_mst"]?['monday_off_flg'];
//         rn.tuesday_off_flg = result[0]["c_stre_mst"]?['tuesday_off_flg'];
//         rn.wednesday_off_flg = result[0]["c_stre_mst"]?['wednesday_off_flg'];
//         rn.thursday_off_flg = result[0]["c_stre_mst"]?['thursday_off_flg'];
//         rn.friday_off_flg = result[0]["c_stre_mst"]?['friday_off_flg'];
//         rn.saturday_off_flg = result[0]["c_stre_mst"]?['saturday_off_flg'];
//         rn.itemstock_flg = result[0]["c_stre_mst"]?['itemstock_flg'];
//         rn.wait_time = result[0]["c_stre_mst"]?['wait_time'];
//         rn.ins_datetime = (result[0]["c_stre_mst"]?['ins_datetime']).toString();
//         rn.upd_datetime = (result[0]["c_stre_mst"]?['upd_datetime']).toString();
//         rn.status = result[0]["c_stre_mst"]?['status'];
//         rn.send_flg = result[0]["c_stre_mst"]?['send_flg'];
//         rn.upd_user = int.parse(result[0]["c_stre_mst"]?['upd_user']);
//         rn.upd_system = result[0]["c_stre_mst"]?['upd_system'];
//         rn.entry_no = result[0]["c_stre_mst"]?['entry_no'];
//         print('rnの中身は${rn.ins_datetime}');
//
//         if (result == null) {
//           print('データなし');
//         }
//         // String temp = "";
//         // print('tempの中身は$temp');
//       }catch(e){
//         print('\n********** 異常発生：00106_rm_db_read _rmDbStreRead **********');
//       }
//       print('********** テスト終了：00106_rm_db_read _rmDbStreRead **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00107 : rm_db_read _rmDbCompRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00107_rm_db_read _rmDbCompRead', () async {
//       print('\n********** テスト実行：00107_rm_db_read _rmDbCompRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select * from c_comp_mst where comp_cd = @p1";
//         Map<String, dynamic>? subValues = {"p1" : 1};
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         CCompMstColumns rn = CCompMstColumns();
//         rn.comp_cd = int.parse(result[0]["c_comp_mst"]?['comp_cd']);
//         rn.comp_typ = result[0]["c_comp_mst"]?['comp_typ'];
//         rn.rtr_id = int.parse(result[0]["c_comp_mst"]?['rtr_id']);
//         rn.name = result[0]["c_comp_mst"]?['name'];
//         rn.short_name = result[0]["c_comp_mst"]?['short_name'];
//         rn.kana_name = result[0]["c_comp_mst"]?['kana_name'];
//         rn.post_no = result[0]["c_comp_mst"]?['post_no'];
//         rn.adress1 = result[0]["c_comp_mst"]?['adress1'];
//         rn.adress2 = result[0]["c_comp_mst"]?['adress2'];
//         rn.adress3 = result[0]["c_comp_mst"]?['adress3'];
//         rn.telno1 = result[0]["c_comp_mst"]?['telno1'];
//         rn.telno2 = result[0]["c_comp_mst"]?['telno2'];
//         rn.srch_telno1 = result[0]["c_comp_mst"]?['srch_telno1'];
//         rn.srch_telno2 = result[0]["c_comp_mst"]?['srch_telno2'];
//         rn.ins_datetime = (result[0]["c_comp_mst"]?['ins_datetime']).toString();
//         rn.upd_datetime = (result[0]["c_comp_mst"]?['upd_datetime']).toString();
//         rn.status = result[0]["c_comp_mst"]?['status'];
//         rn.send_flg = result[0]["c_comp_mst"]?['send_flg'];
//         rn.upd_user = int.parse(result[0]["c_comp_mst"]?['upd_user']);
//         rn.upd_system = result[0]["c_comp_mst"]?['upd_system'];
//         print('rnの中身は${rn.ins_datetime}');
//       }catch(e){
//         print('\n********** 異常発生：00107_rm_db_read _rmDbCompRead **********');
//       }
//       print('********** テスト終了：00107_rm_db_read _rmDbCompRead **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00108 : rm_db_read _rmDbCtrlRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00108_rm_db_read _rmDbCtrlRead', () async {
//       print('\n********** テスト実行：00108_rm_db_read _rmDbCtrlRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select ctrl_cd,ctrl_data from c_ctrl_mst where comp_cd = @p1";
//         Map<String, dynamic>? subValues = {"p1" : 1};
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         for (int i = 0; i < result.length;i++) {
//           int ctrlCd = int.parse(result[i]["c_ctrl_mst"]!["ctrl_cd"]);
//           print('$i番目のctrlCdの中身は$ctrlCd');
//           double ctrlData = double.parse(result[i]["c_ctrl_mst"]!["ctrl_data"]);
//           print('$i番目のctrlDataの中身は$ctrlData');
//           CtrlCodeList def = CtrlCodeList.getDefine(ctrlCd);
//           print('$i番目のdefの中身は$def');
//         }
//       }catch(e){
//         print('\n********** 異常発生：00108_rm_db_read _rmDbCtrlRead **********');
//       }
//       print('********** テスト終了：00108_rm_db_read _rmDbCtrlRead **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00109 : rm_db_read _rmDbTrmRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00109_rm_db_read _rmDbTrmRead', () async {
//       print('\n********** テスト実行：00109_rm_db_read _rmDbTrmRead **********');
//       try{
//         String sql = "";
//         int num1 = 2; //0,1,2で確認した
//         switch(num1){
//           case 0:
//             sql = "select * from c_trm_mst where comp_cd = 1 and  stre_cd = 2 and  trm_grp_cd = 1";
//             break;
//           case 1:
//             sql = "SELECT trm_grp_cd, trm_cd, trm_data from c_trm_mst where comp_cd = 1 and  stre_cd = 2 and  trm_grp_cd = 1";
//             break;
//           case 2:
//             sql = "SELECT trm_grp_cd, trm_cd, trm_data from c_trm_mst where comp_cd = 1 and  stre_cd = 2 and  trm_grp_cd = 1";
//             break;
//         }
//         List<Map<String, Map<String, dynamic>>> result;
//         result = await db.dbCon.mappedResultsQuery(sql);
//
//         for (int i = 0; i< result.length; i++){
//           int trmGrpCd = int.tryParse(result[i]["c_trm_mst"]?["trm_grp_cd"]) ?? 0;
//           print('$i番目のtrmGrpCdの中身は$trmGrpCd');
//           int trmCd = int.tryParse(result[i]["c_trm_mst"]?["trm_cd"]) ?? 0;
//           print('$i番目のtrmCdの中身は$trmCd');
//           dynamic trmData = double.tryParse(result[i]["c_trm_mst"]?["trm_data"]) ?? 0.0;
//           print('$i番目のtrmDataの中身は$trmData');
//         }
//       }catch(e){
//         print('\n********** 異常発生：00109_rm_db_read _rmDbTrmRead **********');
//       }
//       print('********** テスト終了：00109_rm_db_read _rmDbTrmRead **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00110 : rm_db_read _rmDbReportCntRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00110_rm_db_read _rmDbReportCntRead', () async {
//       print('\n********** テスト実行：00110_rm_db_read _rmDbReportCntRead **********');
//       try{
//         String sql =
//             "select bfr_datetime from c_report_cnt where report_cnt_cd = '1002' and comp_cd  = 1 and stre_cd = 2 and mac_no = 3";
//
//         List<Map<String, Map<String, dynamic>>> result;
//         result = await db.dbCon.mappedResultsQuery(sql);
//
//         if (result.isEmpty) {
//           print('データなし');
//           return;
//         }
//
//         String temp = (result[0]["c_report_cnt"]?["bfr_datetime"]).toString();
//         print('tempの中身は$temp');
//       }catch(e){
//         print('\n********** 異常発生：00110_rm_db_read _rmDbReportCntRead **********');
//       }
//       print('********** テスト終了：00110_rm_db_read _rmDbReportCntRead **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00111 : rm_db_read _rmDbOpenCloseRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00111_rm_db_read _rmDbOpenCloseRead', () async {
//       print('\n********** テスト実行：00111_rm_db_read _rmDbOpenCloseRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select * from c_openclose_mst where comp_cd = @p1 AND stre_cd = @p2 AND mac_no = @p3 AND sale_date = @p4";
//         Map<String, dynamic>? subValues = {"p1" : 1,"p2" : 2,"p3" : 3,"p4" :'20231012'};
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         print('SQL実行完了');
//         if(result.length == 0){
//           print('データなし');
//           return;
//         }
//         COpencloseMstColumns rn = COpencloseMstColumns();
//         rn.comp_cd = int.parse(result[0]["c_openclose_mst"]?['comp_cd']);
//         rn.stre_cd = int.parse(result[0]["c_openclose_mst"]?['stre_cd']);
//         rn.mac_no = int.parse(result[0]["c_openclose_mst"]?['mac_no']);
//         rn.sale_date = (result[0]["c_openclose_mst"]?['sale_date']).toString();
//         rn.open_flg = result[0]["c_openclose_mst"]?['open_flg'];
//         rn.close_flg = result[0]["c_openclose_mst"]?['close_flg'];
//         rn.not_update_flg = result[0]["c_openclose_mst"]?['not_update_flg'];
//         rn.log_not_sndflg = result[0]["c_openclose_mst"]?['log_not_sndflg'];
//         rn.custlog_not_sndflg = result[0]["c_openclose_mst"]?['custlog_not_sndflg'];
//         rn.custlog_not_delflg = result[0]["c_openclose_mst"]?['custlog_not_delflg'];
//         rn.stepup_flg = result[0]["c_openclose_mst"]?['stepup_flg'];
//         rn.ins_datetime = (result[0]["c_openclose_mst"]?['ins_datetime']).toString();
//         rn.upd_datetime = (result[0]["c_openclose_mst"]?['upd_datetime']).toString();
//         rn.status = result[0]["c_openclose_mst"]?['status'];
//         rn.send_flg = result[0]["c_openclose_mst"]?['send_flg'];
//         rn.upd_user = int.parse(result[0]["c_openclose_mst"]?['upd_user']);
//         rn.upd_system = result[0]["c_openclose_mst"]?['upd_system'];
//         rn.pos_ver = result[0]["c_openclose_mst"]?['pos_ver'];
//         rn.pos_sub_ver = result[0]["c_openclose_mst"]?['pos_sub_ver'];
//         rn.recal_flg = result[0]["c_openclose_mst"]?['recal_flg'];
//         print('rnの中身は${rn.ins_datetime}');
//       }catch(e){
//         print('\n********** 異常発生：00111_rm_db_read _rmDbOpenCloseRead **********');
//       }finally{
//         print('********** テスト終了：00111_rm_db_read _rmDbOpenCloseRead **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00112 : rm_db_read _rmDbTrmPlanRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00112_rm_db_read _rmDbTrmPlanRead', () async {
//       print('\n********** テスト実行：00112_rm_db_read _rmDbTrmPlanRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql =
//             "select * from c_trm_plan_mst where comp_cd = 1 AND stre_cd = 2";
//         result = await db.dbCon.mappedResultsQuery(sql);
//
//         int acctCd = 0;
//         int acctFlg = 0;
//         String promoExtId = "";
//         for(int i = 0; i < result.length;i++){
//           acctCd = int.parse(result[i]["c_trm_plan_mst"]?["acct_cd"]);
//           print('$i番目のacctCdの中身は$acctCd');
//           acctFlg = result[i]["c_trm_plan_mst"]?["acct_flg"];
//           print('$i番目のacctFlgの中身は$acctFlg');
//           promoExtId = result[i]["c_trm_plan_mst"]?["promo_ext_id"];
//           print('$i番目のpromoExtIdの中身は$promoExtId');
//         }
//
//         String temp = "";
//         print('tempの中身は$temp');
//       }catch(e){
//         print('\n********** 異常発生：00112_rm_db_read _rmDbTrmPlanRead **********');
//       }
//       print('********** テスト終了：00112_rm_db_read _rmDbTrmPlanRead **********\n\n');
//     });
//
//     // ********************************************************
//     // テスト00113 : rm_db_read _rmDbStaffopenRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00113_rm_db_read _rmDbStaffopenRead', () async {
//       print('\n********** テスト実行：00113_rm_db_read _rmDbStaffopenRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select * from c_staffopen_mst where mac_no = @p1";
//         Map<String, dynamic>? subValues = {"p1" : 3};
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//         print('SQL実行完了');
//         if(result.length == 0){
//           print('データなし');
//           return;
//         }
//         CStaffopenMstColumns rn = CStaffopenMstColumns();
//         rn.comp_cd = int.parse(result[0]["c_staffopen_mst"]?['comp_cd']);
//         rn.stre_cd = int.parse(result[0]["c_staffopen_mst"]?['stre_cd']);
//         rn.mac_no = int.parse(result[0]["c_staffopen_mst"]?['mac_no']);
//         rn.chkr_cd = result[0]["c_staffopen_mst"]?['chkr_cd'];
//         rn.chkr_name = result[0]["c_staffopen_mst"]?['chkr_name'];
//         rn.chkr_status = result[0]["c_staffopen_mst"]?['chkr_status'];
//         rn.chkr_open_time = (result[0]["c_staffopen_mst"]?['chkr_open_time']).toString();
//         rn.chkr_start_no = int.parse(result[0]["c_staffopen_mst"]?['chkr_start_no']);
//         rn.chkr_end_no = int.parse(result[0]["c_staffopen_mst"]?['chkr_end_no']);
//         rn.cshr_cd = result[0]["c_staffopen_mst"]?['cshr_cd'];
//         rn.cshr_name = result[0]["c_staffopen_mst"]?['cshr_name'];
//         rn.cshr_status = result[0]["c_staffopen_mst"]?['cshr_status'];
//         rn.cshr_open_time = (result[0]["c_staffopen_mst"]?['cshr_open_time']).toString();
//         rn.cshr_start_no = int.parse(result[0]["c_staffopen_mst"]?['cshr_start_no']);
//         rn.cshr_end_no = int.parse(result[0]["c_staffopen_mst"]?['cshr_end_no']);
//         rn.ins_datetime = (result[0]["c_staffopen_mst"]?['ins_datetime']).toString();
//         rn.upd_datetime = (result[0]["c_staffopen_mst"]?['upd_datetime']).toString();
//         rn.status = result[0]["c_staffopen_mst"]?['status'];
//         rn.send_flg = result[0]["c_staffopen_mst"]?['send_flg'];
//         rn.upd_user = int.parse(result[0]["c_staffopen_mst"]?['upd_user']);
//         rn.upd_system = result[0]["c_staffopen_mst"]?['upd_system'];
//
//       }catch(e){
//         print('\n********** 異常発生：00113_rm_db_read _rmDbStaffopenRead **********');
//       }finally{
//         print('********** テスト終了：00113_rm_db_read _rmDbStaffopenRead **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00114 : rm_db_read _rmDbInstreRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00114_rm_db_read _rmDbInstreRead', () async {
//       print('\n********** テスト実行：00114_rm_db_read _rmDbInstreRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select * from c_instre_mst where comp_cd = 1  order by format_typ";
//         result = await db.dbCon.mappedResultsQuery(sql1);
//
//         List<CInstreMstColumns> dataList =  List.generate(result.length, (i) {
//           CInstreMstColumns rn = CInstreMstColumns();
//           rn.comp_cd = int.parse(result[i]["c_instre_mst"]?['comp_cd']);
//           rn.instre_flg = result[i]["c_instre_mst"]?['instre_flg'];
//           rn.format_no = int.parse(result[i]["c_instre_mst"]?['format_no']);
//           rn.format_typ = int.parse(result[i]["c_instre_mst"]?['format_typ']);
//           rn.cls_code = int.parse(result[i]["c_instre_mst"]?['cls_code']);
//           rn.ins_datetime = (result[i]["c_instre_mst"]?['ins_datetime']).toString();
//           rn.upd_datetime = (result[i]["c_instre_mst"]?['upd_datetime']).toString();
//           rn.status = result[i]["c_instre_mst"]?['status'];
//           rn.send_flg = result[i]["c_instre_mst"]?['send_flg'];
//           rn.upd_user = int.parse(result[i]["c_instre_mst"]?['upd_user']);
//           rn.upd_system = result[i]["c_instre_mst"]?['upd_system'];
//           print('$i番目のins_datetimeの中身は${rn.ins_datetime}');
//           return rn;
//         });
//
//       }catch(e){
//         print('\n********** 異常発生：00114_rm_db_read _rmDbInstreRead **********');
//       }finally{
//         print('********** テスト終了：00114_rm_db_read _rmDbInstreRead **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00115 : rm_db_read _rmDbTaxRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00115_rm_db_read _rmDbTaxRead', () async {
//       print('\n********** テスト実行：00115_rm_db_read _rmDbTaxRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select * from c_tax_mst where tax_cd > 0 and comp_cd = 1 order by tax_cd";
//         result = await db.dbCon.mappedResultsQuery(sql1);
//
//         List<CTaxMstColumns> dataList = List.generate(result.length, (i) {
//           CTaxMstColumns rn = CTaxMstColumns();
//           rn.comp_cd = int.parse(result[i]["c_tax_mst"]?['comp_cd']);
//           rn.tax_cd = result[i]["c_tax_mst"]?['tax_cd'];
//           rn.tax_name = result[i]["c_tax_mst"]?['tax_name'];
//           rn.tax_typ = result[i]["c_tax_mst"]?['tax_typ'];
//           rn.odd_flg = result[i]["c_tax_mst"]?['odd_flg'];
//           rn.tax_per = double.parse(result[i]["c_tax_mst"]?['tax_per']);
//           rn.mov_cd = result[i]["c_tax_mst"]?['mov_cd'];
//           rn.ins_datetime = (result[i]["c_tax_mst"]?['ins_datetime']).toString();
//           rn.upd_datetime = (result[i]["c_tax_mst"]?['upd_datetime']).toString();
//           rn.status = result[i]["c_tax_mst"]?['status'];
//           rn.send_flg = result[i]["c_tax_mst"]?['send_flg'];
//           rn.upd_user = int.parse(result[i]["c_tax_mst"]?['upd_user']);
//           rn.upd_system = result[i]["c_tax_mst"]?['upd_system'];
//           print('$i番目のins_datetimeの中身は${rn.ins_datetime}');
//           return rn;
//         });
//       }catch(e){
//         print('\n********** 異常発生：00115_rm_db_read _rmDbTaxRead **********');
//       }finally{
//         print('********** テスト終了：00115_rm_db_read _rmDbTaxRead **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00116 : rm_db_read _rmDbRecmsgRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00116_rm_db_read _rmDbRecmsgRead', () async {
//       print('\n********** テスト実行：00116_rm_db_read _rmDbRecmsgRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql = '''
//          SELECT
// 		 lay.comp_cd AS comp_cd, lay.stre_cd AS stre_cd, lay.msggrp_cd AS msggrp_cd, lay.msg_typ AS msg_typ, lay.msg_cd AS msg_cd, lay.target_typ AS target_typ,
// 		 msg.msg_kind AS msg_kind, msg.msg_data_1 AS msg_data_1, msg.msg_data_2 AS msg_data_2,
// 		 msg.msg_data_3 AS msg_data_3, msg.msg_data_4 AS msg_data_4, msg.msg_data_5 AS msg_data_5,
// 		 msg.ins_datetime AS ins_datetime, msg.upd_datetime AS upd_datetime, msg.status AS status,
// 		 msg.send_flg AS send_flg, msg.upd_user AS upd_user, msg.upd_system AS upd_system
//
// 		 , msg.msg_size_1 AS msg_size_1, msg.msg_size_2 AS msg_size_2, msg.msg_size_3 AS msg_size_3, msg.msg_size_4 AS msg_size_4, msg.msg_size_5 AS msg_size_5
// 		 , msg.msg_color_1 AS msg_color_1, msg.msg_color_2 AS msg_color_2, msg.msg_color_3 AS msg_color_3, msg.msg_color_4 AS msg_color_4, msg.msg_color_5 AS msg_color_5
// 		 , msg.back_color AS back_color, msg.back_pict_typ AS back_pict_typ
// 		 , msg.second AS second, msg.flg_01 AS flg_01, msg.flg_02 AS flg_02, msg.flg_03 AS flg_03, msg.flg_04 AS flg_04, msg.flg_05 AS flg_05
//
// 		 FROM c_msglayout_mst lay LEFT OUTER JOIN c_msg_mst msg
// 		 ON lay.comp_cd = msg.comp_cd AND lay.stre_cd = msg.stre_cd AND lay.msg_cd = msg.msg_cd
// 		 WHERE lay.comp_cd = '1' AND lay.stre_cd = '2' AND lay.msggrp_cd = '1' ORDER BY lay.msg_typ
//          ''';
//
//         result = await db.dbCon.mappedResultsQuery(sql);
//         print('${result.length}');
//
//         for(int i =0; i < 1;i++){
//           Map<String, Map<String, dynamic>> data = result[i];
//           int msgCd = DbMap.getIntValueFromDbMap(data["lay"]?["msg_cd"]);
//           print('msgCd:$msgCd');
//           // if (msgCd <= 0) {
//           //   return;
//           // }
//           int grpCd = DbMap.getIntValueFromDbMap(data["lay"]?["msggrp_cd"]);
//           // print('grpCd:$grpCd');
//           // if (grpCd <= 0) {
//           //   return;
//           // }
//           int posi = DbMap.getIntValueFromDbMap(data["lay"]?["msg_typ"], initValue: -1);
//           print('posi:$posi');
//           // if (posi <= -1) {
//           //   return;
//           // }
//           // if (posi < DbMsgMstId.DB_MSGMST_MAX) {
//             int msg_cd = DbMap.getIntValueFromDbMap(data["lay"]?["msg_cd"]);
//             int msg_kind = DbMap.getIntValueFromDbMap(data["msg"]?["msg_kind"]);
//             String msg_data_1 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_1"]);
//             String msg_data_2 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_2"]);
//             String msg_data_3 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_3"]);
//             String msg_data_4 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_4"]);
//             String msg_data_5 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_5"]);
//             int msggrp_cd = DbMap.getIntValueFromDbMap(data["lay"]?["msggrp_cd"]);
//             int msg_typ = DbMap.getIntValueFromDbMap(data["lay"]?["msg_typ"]);
//             int target_typ =
//                 DbMap.getIntValueFromDbMap(data["lay"]?["target_typ"]);
//           // } else if (DbMsgMstFipId.isFipPosi(posi)) {
//           //   posi = DbMsgMstFipId.getIdFromPosi(posi);
//             msg_cd = DbMap.getIntValueFromDbMap(data["lay"]?["msg_cd"]);
//             msg_kind = DbMap.getIntValueFromDbMap(data["msg"]?["msg_kind"]);
//             msg_data_1 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_1"]);
//             msg_data_2 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_2"]);
//             msg_data_3 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_3"]);
//             msggrp_cd = DbMap.getIntValueFromDbMap(data["lay"]?["msggrp_cd"]);
//             msg_typ = DbMap.getIntValueFromDbMap(data["lay"]?["msg_typ"]);
//             target_typ =
//                 DbMap.getIntValueFromDbMap(data["lay"]?["target_typ"]);
//           // } else if (DbMsgMstColorDspId.isColorFipPosi(posi)) {
//           //   posi = DbMsgMstColorDspId.getIdFromPosi(posi);
//             msg_cd = DbMap.getIntValueFromDbMap(data["lay"]?["msg_cd"]);
//             DbMap.getIntValueFromDbMap(data["msg"]?["msg_kind"]);
//             msg_data_1 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_1"]);
//             msg_data_2 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_2"]);
//             msg_data_3 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_3"]);
//             msg_data_4 =
//                 DbMap.getStringValueFromDbMap(data["msg"]?["msg_data_4"]);
//
//             msggrp_cd = DbMap.getIntValueFromDbMap(data["lay"]?["msggrp_cd"]);
//             msg_typ = DbMap.getIntValueFromDbMap(data["lay"]?["msg_typ"]);
//             target_typ =
//                 DbMap.getIntValueFromDbMap(data["lay"]?["target_typ"]);
//
//             int msg_size_1 =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["msg_size_1"]);
//             int msg_size_2 =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["msg_size_2"]);
//             int msg_size_3 =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["msg_size_3"]);
//             int msg_size_4 =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["msg_size_4"]);
//
//             int msg_color_1 =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["msg_color_1"]);
//             int msg_color_2 =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["msg_color_2"]);
//             int msg_color_3 =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["msg_color_3"]);
//             int msg_color_4 =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["msg_color_4"]);
//
//             int back_color =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["back_color"]);
//             int back_pict_typ =
//                 DbMap.getIntValueFromDbMap(data["msg"]?["back_pict_typ"]);
//             int second = DbMap.getIntValueFromDbMap(data["msg"]?["second"]);
//             int flg_01 = DbMap.getIntValueFromDbMap(data["msg"]?["flg_01"]);
//             int flg_02 = DbMap.getIntValueFromDbMap(data["msg"]?["flg_02"]);
//             int flg_03 = DbMap.getIntValueFromDbMap(data["msg"]?["flg_03"]);
//             int flg_04 = DbMap.getIntValueFromDbMap(data["msg"]?["flg_04"]);
//             int flg_05 = DbMap.getIntValueFromDbMap(data["msg"]?["flg_05"]);
//             print('変換完了');
//             print('flg_05:$flg_05');
//           // }
//         }
//
//
//       }catch(e){
//         print('\n********** 異常発生：00116_rm_db_read _rmDbRecmsgRead **********');
//       }finally{
//         print('********** テスト終了：00116_rm_db_read _rmDbRecmsgRead **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00117 : rm_db_read _rmDbRecmsgSchRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00117_rm_db_read _rmDbRecmsgSchRead', () async {
//       print('\n********** テスト実行：00117_rm_db_read _rmDbRecmsgSchRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         // String whereSql =
//         // RcSch.rcSchPrioritySqlCreate("msgsch_cd", null, null, null);
//         String sql = '''
//       SELECT
// 		  lay.comp_cd AS comp_cd, lay.stre_cd AS stre_cd, lay.msgsch_cd as msgsch_cd, lay.msggrp_cd AS msggrp_cd, lay.msg_typ AS msg_typ, lay.msg_cd AS msg_cd, lay.target_typ AS target_typ,
// 		  msg.msg_kind AS msg_kind, msg.msg_data_1 AS msg_data_1, msg.msg_data_2 AS msg_data_2,
// 		  msg.msg_data_3 AS msg_data_3, msg.msg_data_4 AS msg_data_4, msg.msg_data_5 AS msg_data_5,
// 		  msg.ins_datetime AS ins_datetime, msg.upd_datetime AS upd_datetime, msg.status AS status,
// 		  msg.send_flg AS send_flg, msg.upd_user AS upd_user, msg.upd_system AS upd_system
//
// 		 , msg.msg_size_1 AS msg_size_1, msg.msg_size_2 AS msg_size_2, msg.msg_size_3 AS msg_size_3, msg.msg_size_4 AS msg_size_4, msg.msg_size_5 AS msg_size_5
// 		 , msg.msg_color_1 AS msg_color_1, msg.msg_color_2 AS msg_color_2, msg.msg_color_3 AS msg_color_3, msg.msg_color_4 AS msg_color_4, msg.msg_color_5 AS msg_color_5
// 		 , msg.back_color AS back_color, msg.back_pict_typ AS back_pict_typ
// 		 , msg.second AS second, msg.flg_01 AS flg_01, msg.flg_02 AS flg_02, msg.flg_03 AS flg_03, msg.flg_04 AS flg_04, msg.flg_05 AS flg_05
//
// 		FROM
// 		  c_msgsch_layout_mst lay
// 		LEFT OUTER JOIN
// 		  c_msg_mst msg
// 		ON
// 		  lay.comp_cd = msg.comp_cd AND lay.stre_cd = msg.stre_cd AND lay.msg_cd = msg.msg_cd
// 		WHERE
// 		  lay.comp_cd = '1' AND lay.stre_cd = '2' AND lay.stop_flg = 0 AND lay.msggrp_cd = '3'
// 		  AND lay.msgsch_cd IN (SELECT msgsch_cd FROM c_msgsch_mst)
// 		ORDER BY lay.msg_typ
//       ''';
//
//         result = await db.dbCon.mappedResultsQuery(sql);
//         print('${result.length}');
//       }catch(e){
//         print('\n********** 異常発生：00117_rm_db_read _rmDbRecmsgSchRead **********');
//       }finally{
//         print('********** テスト終了：00117_rm_db_read _rmDbRecmsgSchRead **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00118 : rm_db_read _rmDbKeyFncRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00118_rm_db_read _rmDbKeyFncRead', () async {
//       print('\n********** テスト実行：00118_rm_db_read _rmDbKeyFncRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         // String whereSql =
//         // RcSch.rcSchPrioritySqlCreate("msgsch_cd", null, null, null);
//         String sql = "";
//         int decide = 0;
//         switch(decide){
//           case 0:
//             sql =
//             "SELECT kopt_grp_cd,fnc_cd,fnc_name,fnc_disp_flg FROM c_keyfnc_mst WHERE comp_cd = '1' AND stre_cd = '2' AND kopt_grp_cd = '1'";
//             break;
//           case 1:
//             sql =
//             "SELECT kopt_grp_cd,fnc_cd,fnc_name,fnc_disp_flg FROM c_keyfnc_mst WHERE comp_cd = '1' AND stre_cd = '2' AND kopt_grp_cd = '1'";
//             break;
//         }
//         result = await db.dbCon.mappedResultsQuery(sql);
//         int subGrpCount = 0;
//         // DBの値が正しくとれているかどうか.
//         bool isSuccess = true;
//         print('${result.length}');
//         for (int i = 0; i < 1;i++) {
//           DBMapChangeRet<int> koptGrpCdRet =
//           DbMap.getIntValueFromDbMapRet(result[i]["c_keyfnc_mst"]?["kopt_grp_cd"]);
//           isSuccess &= koptGrpCdRet.isSuccess;
//           print('koptGrpCdRetは${koptGrpCdRet.value}');
//
//           DBMapChangeRet<int> fCdRet = DbMap.getIntValueFromDbMapRet(result[i]["c_keyfnc_mst"]?["fnc_cd"]);
//           isSuccess &= fCdRet.isSuccess;
//           print('fCdRetは${fCdRet.value}');
//
//           DBMapChangeRet<bool> fDspFlgRet =
//           DbMap.getBoolValueFromDbMapIntValueRet(result[i]["c_keyfnc_mst"]?["fnc_disp_flg"]);
//           isSuccess &= fDspFlgRet.isSuccess;
//           print('fDspFlgRetは${fDspFlgRet.value}');
//
//           DBMapChangeRet<String> fNameRet =
//           DbMap.getStringValueFromDbMapRet(result[i]["c_keyfnc_mst"]?["fnc_name"]);
//           isSuccess &= fNameRet.isSuccess;
//           print('fNameRetは${fNameRet.value}');
//
//         }
//       }catch(e){
//         print('\n********** 異常発生：00118_rm_db_read _rmDbKeyFncRead **********');
//       }finally{
//         print('********** テスト終了：00118_rm_db_read _rmDbKeyFncRead **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00119 : rm_db_read rmDbCashrecycleRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00119_rm_db_read rmDbCashrecycleRead', () async {
//       print('\n********** テスト実行：00119_rm_db_read rmDbCashrecycleRead **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select * from c_cashrecycle_info_mst where comp_cd = 1  and stre_cd = '2' and mac_no = '3'";
//         result = await db.dbCon.mappedResultsQuery(sql1);
//
//         print('${result.length}');
//         if (result.length == 1) {
//           CCashrecycleInfoMstColumns rn = CCashrecycleInfoMstColumns();
//           rn.comp_cd = int.parse(result[0]["c_cashrecycle_info_mst"]?['comp_cd']);
//           rn.stre_cd = int.parse(result[0]["c_cashrecycle_info_mst"]?['stre_cd']);
//           rn.mac_no = int.parse(result[0]["c_cashrecycle_info_mst"]?['mac_no']);
//           rn.cashrecycle_grp = int.parse(result[0]["c_cashrecycle_info_mst"]?['cashrecycle_grp']);
//           rn.cal_grp_cd = int.parse(result[0]["c_cashrecycle_info_mst"]?['cal_grp_cd']);
//           rn.server = result[0]["c_cashrecycle_info_mst"]?['server'];
//           rn.server_macno = int.parse(result[0]["c_cashrecycle_info_mst"]?['server_macno']);
//           rn.server_info = result[0]["c_cashrecycle_info_mst"]?['server_info'];
//           rn.sub_server = result[0]["c_cashrecycle_info_mst"]?['sub_server'];
//           rn.sub_server_macno = int.parse(result[0]["c_cashrecycle_info_mst"]?['sub_server_macno']);
//           rn.sub_server_info = result[0]["c_cashrecycle_info_mst"]?['sub_server_info'];
//           rn.first_disp_macno1 = int.parse(result[0]["c_cashrecycle_info_mst"]?['first_disp_macno1']);
//           rn.first_disp_macno2 = int.parse(result[0]["c_cashrecycle_info_mst"]?['first_disp_macno2']);
//           rn.first_disp_macno3 = int.parse(result[0]["c_cashrecycle_info_mst"]?['first_disp_macno3']);
//           rn.ins_datetime = (result[0]["c_cashrecycle_info_mst"]?['ins_datetime']).toString();
//           rn.upd_datetime = (result[0]["c_cashrecycle_info_mst"]?['upd_datetime']).toString();
//           rn.status = result[0]["c_cashrecycle_info_mst"]?['status'];
//           rn.send_flg = result[0]["c_cashrecycle_info_mst"]?['send_flg'];
//           rn.upd_user = int.parse(result[0]["c_cashrecycle_info_mst"]?['upd_user']);
//           rn.upd_system = result[0]["c_cashrecycle_info_mst"]?['upd_system'];
//           print('ins_datetimeの中身は${rn.ins_datetime}');
//         } else {
//           print('データなし');
//         }
//       }catch(e){
//         print('\n********** 異常発生：00119_rm_db_read rmDbCashrecycleRead **********');
//       }finally{
//         print('********** テスト終了：00119_rm_db_read rmDbCashrecycleRead **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00120 : rm_db_read rmDbCashrecycleRead後半
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00120_rm_db_read rmDbCashrecycleRead後半', () async {
//       print('\n********** テスト実行：00120_rm_db_read rmDbCashrecycleRead後半 **********');
//       try{
//         String cashrecycleMstSql =
//             "SELECT code, data, data_typ FROM c_cashrecycle_mst WHERE comp_cd = 1  and stre_cd = '2' and cashrecycle_grp ='1' order by code";
//         List<Map<String, Map<String, dynamic>>> cashrecycleMstDataList;
//         cashrecycleMstDataList = await db.dbCon.mappedResultsQuery(cashrecycleMstSql);
//         print('${cashrecycleMstDataList.length}');
//         for (int i = 0; i < cashrecycleMstDataList.length;i++) {
//           DBMapChangeRet<int> codeRet = DbMap.getIntValueFromDbMapRet(
//               cashrecycleMstDataList[i]["c_cashrecycle_mst"]?["code"]);
//           print('code:${codeRet.value}');
//           DBMapChangeRet<int> dataRet = DbMap.getIntValueFromDbMapRet(
//               cashrecycleMstDataList[i]["c_cashrecycle_mst"]?["data"]);
//           print('data:${dataRet.value}');
//         }
//
//       }catch(e){
//         print('\n********** 異常発生：00120_rm_db_read rmDbCashrecycleRead後半 **********');
//       }finally{
//         print('********** テスト終了：00120_rm_db_read rmDbCashrecycleRead後半 **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00121 : rm_db_read rmDbPresetMkey1Read
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00121_rm_db_read rmDbPresetMkey1Read', () async {
//       print('\n********** テスト実行：00121_rm_db_read rmDbPresetMkey1Read **********');
//       try{
//         bool isSuccess = true;
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql =
//             "select  ky_cd, ky_plu_cd, ky_smlcls_cd, ky_name   from c_preset_mst where comp_cd = '1' and stre_cd = '2' and preset_grp_cd = '1' and preset_cd = '501'  order by preset_no";
//         result = await db.dbCon.mappedResultsQuery(sql);
//         print('${result.length}');
//
//         for (int i = 0; i < result.length; i++) {
//           Map<String, Map<String, dynamic>> data = result[i];
//           String? tmpPluCd;
//           // メカキーの PLU CODEが NULLか0ならNULLをセット
//           DBMapChangeRet<int> tmpCdRet =
//           DbMap.getIntValueFromDbMapRet(data["c_preset_mst"]?["ky_plu_cd"]);
//           if (tmpCdRet.isSuccess && tmpCdRet.value != 0) {
//             tmpPluCd = DbMap.getStringValueFromDbMap(data["c_preset_mst"]?["ky_plu_cd"]);
//           }
//
//           int kyCd = DbMap.getIntValueFromDbMap(data["c_preset_mst"]?["ky_cd"]);
//           print('kycd:$kyCd');
//           String? kyPluCd = tmpPluCd;
//           print('kyPluCd:$kyPluCd');
//           int kySmlclsCd = DbMap.getIntValueFromDbMap(data["c_preset_mst"]?["ky_smlcls_cd"]);
//           print('kySmlclsCd:$kySmlclsCd');
//
//           // if (CmCksys.cmPresetMkeyShow()) {
//           //   _rmFBPreMkeySet(_pCom.mkeyD, data);
//           // }
//           kyCd = DbMap.getIntValueFromDbMap(data["c_preset_mst"]?["ky_cd"]);
//           print('kyCd:$kyCd');
//           int kySmlClsCd = DbMap.getIntValueFromDbMap(data["c_preset_mst"]?["ky_smlcls_cd"]);
//           print('kySmlClsCd:$kySmlClsCd');
//           int kyPlu = DbMap.getIntValueFromDbMap(data["c_preset_mst"]?["ky_plu_cd"]);
//           print('kyPlu:$kyPlu');
//           String imgBuf = DbMap.getStringValueFromDbMap(data["c_preset_mst"]?["ky_name"]);
//           print('imgBuf:$imgBuf');
//
//         }
//
//       }catch(e){
//         print('\n********** 異常発生：00121_rm_db_read rmDbPresetMkey1Read **********');
//       }finally{
//         print('********** テスト終了：00121_rm_db_read rmDbPresetMkey1Read **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00122 : rm_db_read rmDbPresetMkey2Read
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00122_rm_db_read rmDbPresetMkey2Read', () async {
//       print('\n********** テスト実行：00122_rm_db_read rmDbPresetMkey2Read **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql =
//             "select  ky_cd, ky_plu_cd, ky_smlcls_cd from c_preset_mst where comp_cd = '1' and stre_cd = '2' and preset_grp_cd = '1' and preset_cd = '401'  order by preset_no";
//         result = await db.dbCon.mappedResultsQuery(sql);
//         print('${result.length}');
//         for (int i = 0; i < result.length; i++) {
//           Map<String, Map<String, dynamic>> data = result[i];
//           String? tmpPluCd;
//           // メカキーの PLU CODEが NULLか0ならNULLをセット
//           DBMapChangeRet<int> tmpCdRet =
//           DbMap.getIntValueFromDbMapRet(data["c_preset_mst"]?["ky_plu_cd"]);
//           print('tmpCdRet:${tmpCdRet.value}');
//           if (tmpCdRet.isSuccess && tmpCdRet.value != 0) {
//             tmpPluCd = DbMap.getStringValueFromDbMap(data["c_preset_mst"]?["ky_plu_cd"]);
//             print('tmpPluCd:$tmpPluCd');
//           }
//           int kyCd = DbMap.getIntValueFromDbMap(data["c_preset_mst"]?["ky_cd"]);
//           print('kyCd:$kyCd');
//           String? kyPluCd = tmpPluCd;
//           print('kyPluCd:$kyPluCd');
//           int kySmlclsCd = DbMap.getIntValueFromDbMap(data["c_preset_mst"]?["ky_smlcls_cd"]);
//           print('kySmlclsCd:$kySmlclsCd');
//         }
//       }catch(e){
//         print('\n********** 異常発生：00122_rm_db_read rmDbPresetMkey2Read **********');
//       }finally{
//         print('********** テスト終了：00122_rm_db_read rmDbPresetMkey2Read **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00123 : rc_key_cash updateEjLog
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00123_rc_key_cash updateEjLog', () async {
//       print('\n********** テスト実行：00123_rc_key_cash updateEjLog **********');
//       try{
//         String sql1 = "INSERT INTO c_ej_log VALUES(@serial_no,@comp_cd,@stre_cd,@mac_no,@print_no,@seq_no,@receipt_no,@end_rec_flg,@only_ejlog_flg,@cshr_no,@chkr_no,@now_sale_datetime,@sale_date,@ope_mode_flg,@print_data,@sub_only_ejlog_flg,@trankey_search,@etckey_search)";
//         //2回行うとserial_noが重なるのでエラーとなることを確認！
//         Map<String, dynamic>? subValues = {"serial_no" : '2023101200000000100000000200000000000050005',"comp_cd" : 1,"stre_cd" : 2,"mac_no" : 0,"print_no" : 5,"seq_no" : 1,"receipt_no" : 5,"end_rec_flg" : 0,"only_ejlog_flg" : 0,"cshr_no" : 0,"chkr_no" : 0,"now_sale_datetime" : '2023-10-12',"sale_date" : '2023-10-12',"ope_mode_flg" : 0,"print_data" : 'print_data',"sub_only_ejlog_flg" : 0,"trankey_search" : '0',"etckey_search" : '0'};
//         db.dbCon.execute(sql1,substitutionValues:subValues);
//       }catch(e){
//         print('\n********** 異常発生：00123_rc_key_cash updateEjLog **********');
//       }finally{
//         print('********** テスト終了：00123_rc_key_cash updateEjLog **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00124 : rc_key_plu rcReadPluFL
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00124_rc_key_plu rcReadPluFL', () async {
//       print('\n********** テスト実行：00124_rc_key_plu rcReadPluFL **********');
//       try{
//         String deleteCheck = "";
//         deleteCheck = "AND status != '2'"; //削除済みを除く.
//         String sql1 = "select * from c_plu_mst where comp_cd = @p1 AND  stre_cd = @p2 AND plu_cd = @p3 $deleteCheck";
//         Map<String, dynamic>? subValues = {"p1" : '1',"p2" : '2',"p3" : '1234567890101'};
//         List<Map<String, Map<String, dynamic>>> result = [];
//         try {
//           result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//         } catch (e, s) {
//           print('exception!');
//         }
//         if (result.isEmpty) {
//           print('empty');
//         }
//         // プライマリーキーを条件に取っているので取得できるのは１件のみ.
//         CPluMstColumns rn = CPluMstColumns();
//         rn.comp_cd = int.parse(result[0]["c_plu_mst"]?['comp_cd']);
//         rn.stre_cd = int.parse(result[0]["c_plu_mst"]?['stre_cd']);
//         rn.plu_cd = result[0]["c_plu_mst"]?['plu_cd'];
//         rn.lrgcls_cd = int.parse(result[0]["c_plu_mst"]?['lrgcls_cd']);
//         rn.mdlcls_cd = int.parse(result[0]["c_plu_mst"]?['mdlcls_cd']);
//         rn.smlcls_cd = int.parse(result[0]["c_plu_mst"]?['smlcls_cd']);
//         rn.tnycls_cd = int.parse(result[0]["c_plu_mst"]?['tnycls_cd']);
//         rn.eos_cd = result[0]["c_plu_mst"]?['eos_cd'];
//         rn.bar_typ = result[0]["c_plu_mst"]?['bar_typ'];
//         rn.item_typ = result[0]["c_plu_mst"]?['item_typ'];
//         rn.item_name = result[0]["c_plu_mst"]?['item_name'];
//         rn.pos_name = result[0]["c_plu_mst"]?['pos_name'];
//         rn.list_typcapa = result[0]["c_plu_mst"]?['list_typcapa'];
//         rn.list_prc = int.parse(result[0]["c_plu_mst"]?['list_prc']);
//         rn.instruct_prc = int.parse(result[0]["c_plu_mst"]?['instruct_prc']);
//         rn.pos_prc = int.parse(result[0]["c_plu_mst"]?['pos_prc']);
//         rn.cust_prc = int.parse(result[0]["c_plu_mst"]?['cust_prc']);
//         rn.cost_prc = double.parse(result[0]["c_plu_mst"]?['cost_prc']);
//         rn.chk_amt = int.parse(result[0]["c_plu_mst"]?['chk_amt']);
//         rn.tax_cd_1 = result[0]["c_plu_mst"]?['tax_cd_1'];
//         rn.tax_cd_2 = result[0]["c_plu_mst"]?['tax_cd_2'];
//         rn.tax_cd_3 = result[0]["c_plu_mst"]?['tax_cd_3'];
//         rn.tax_cd_4 = result[0]["c_plu_mst"]?['tax_cd_4'];
//         rn.cost_tax_cd = result[0]["c_plu_mst"]?['cost_tax_cd'];
//         rn.cost_per = double.parse(result[0]["c_plu_mst"]?['cost_per']);
//         rn.rbtpremium_per = double.parse(result[0]["c_plu_mst"]?['rbtpremium_per']);
//         rn.nonact_flg = result[0]["c_plu_mst"]?['nonact_flg'];
//         rn.prc_chg_flg = result[0]["c_plu_mst"]?['prc_chg_flg'];
//         rn.rbttarget_flg = result[0]["c_plu_mst"]?['rbttarget_flg'];
//         rn.stl_dsc_flg = result[0]["c_plu_mst"]?['stl_dsc_flg'];
//         rn.weight_cnt = result[0]["c_plu_mst"]?['weight_cnt'];
//         rn.plu_tare = result[0]["c_plu_mst"]?['plu_tare'];
//         rn.self_cnt_flg = result[0]["c_plu_mst"]?['self_cnt_flg'];
//         rn.guara_month = result[0]["c_plu_mst"]?['guara_month'];
//         rn.multprc_flg = result[0]["c_plu_mst"]?['multprc_flg'];
//         rn.multprc_per = double.parse(result[0]["c_plu_mst"]?['multprc_per']);
//         rn.weight_flg = result[0]["c_plu_mst"]?['weight_flg'];
//         rn.mbrdsc_flg = result[0]["c_plu_mst"]?['mbrdsc_flg'];
//         rn.mbrdsc_prc = int.parse(result[0]["c_plu_mst"]?['mbrdsc_prc']);
//         rn.mny_tckt_flg = result[0]["c_plu_mst"]?['mny_tckt_flg'];
//         rn.stlplus_flg = result[0]["c_plu_mst"]?['stlplus_flg'];
//         rn.prom_tckt_no = int.parse(result[0]["c_plu_mst"]?['prom_tckt_no']);
//         rn.weight = int.parse(result[0]["c_plu_mst"]?['weight']);
//         rn.pctr_tckt_flg = result[0]["c_plu_mst"]?['pctr_tckt_flg'];
//         rn.btl_prc = int.parse(result[0]["c_plu_mst"]?['btl_prc']);
//         rn.clsdsc_flg = result[0]["c_plu_mst"]?['clsdsc_flg'];
//         rn.cpn_flg = result[0]["c_plu_mst"]?['cpn_flg'];
//         rn.cpn_prc = int.parse(result[0]["c_plu_mst"]?['cpn_prc']);
//         rn.plu_cd_flg = result[0]["c_plu_mst"]?['plu_cd_flg'];
//         rn.self_alert_flg = result[0]["c_plu_mst"]?['self_alert_flg'];
//         rn.chg_ckt_flg = result[0]["c_plu_mst"]?['chg_ckt_flg'];
//         rn.self_weight_flg = result[0]["c_plu_mst"]?['self_weight_flg'];
//         rn.msg_name = result[0]["c_plu_mst"]?['msg_name'];
//         rn.msg_flg = result[0]["c_plu_mst"]?['msg_flg'];
//         rn.msg_name_cd = int.parse(result[0]["c_plu_mst"]?['msg_name_cd']);
//         rn.pop_msg = result[0]["c_plu_mst"]?['pop_msg'];
//         rn.pop_msg_flg = result[0]["c_plu_mst"]?['pop_msg_flg'];
//         rn.pop_msg_cd = int.parse(result[0]["c_plu_mst"]?['pop_msg_cd']);
//         rn.liqrcls_cd = int.parse(result[0]["c_plu_mst"]?['liqrcls_cd']);
//         rn.liqr_typcapa = int.parse(result[0]["c_plu_mst"]?['liqr_typcapa']);
//         rn.alcohol_per = double.parse(result[0]["c_plu_mst"]?['alcohol_per']);
//         rn.liqrtax_cd = int.parse(result[0]["c_plu_mst"]?['liqrtax_cd']);
//         rn.use1_start_date = (result[0]["c_plu_mst"]?['use1_start_date']).toString();
//         rn.use2_start_date = (result[0]["c_plu_mst"]?['use2_start_date']).toString();
//         rn.prc_exe_flg = result[0]["c_plu_mst"]?['prc_exe_flg'];
//         rn.tmp_exe_flg = result[0]["c_plu_mst"]?['tmp_exe_flg'];
//         rn.cust_dtl_flg = result[0]["c_plu_mst"]?['cust_dtl_flg'];
//         rn.tax_exemption_flg = result[0]["c_plu_mst"]?['tax_exemption_flg'];
//         rn.point_add = int.parse(result[0]["c_plu_mst"]?['point_add']);
//         rn.coupon_flg = result[0]["c_plu_mst"]?['coupon_flg'];
//         rn.kitchen_prn_flg = result[0]["c_plu_mst"]?['kitchen_prn_flg'];
//         rn.pricing_flg = result[0]["c_plu_mst"]?['pricing_flg'];
//         rn.bc_tckt_cnt = result[0]["c_plu_mst"]?['bc_tckt_cnt'];
//         rn.last_sale_datetime = (result[0]["c_plu_mst"]?['last_sale_datetime']).toString();
//         rn.maker_cd = int.parse(result[0]["c_plu_mst"]?['maker_cd']);
//         rn.user_val_1 = int.parse(result[0]["c_plu_mst"]?['user_val_1']);
//         rn.user_val_2 = int.parse(result[0]["c_plu_mst"]?['user_val_2']);
//         rn.user_val_3 = int.parse(result[0]["c_plu_mst"]?['user_val_3']);
//         rn.user_val_4 = int.parse(result[0]["c_plu_mst"]?['user_val_4']);
//         rn.user_val_5 = int.parse(result[0]["c_plu_mst"]?['user_val_5']);
//         rn.user_val_6 = result[0]["c_plu_mst"]?['user_val_6'];
//         rn.prc_upd_system = result[0]["c_plu_mst"]?['prc_upd_system'];
//         rn.ins_datetime = (result[0]["c_plu_mst"]?['ins_datetime']).toString();
//         rn.upd_datetime = (result[0]["c_plu_mst"]?['upd_datetime']).toString();
//         rn.status = result[0]["c_plu_mst"]?['status'];
//         rn.send_flg = result[0]["c_plu_mst"]?['send_flg'];
//         rn.upd_user = int.parse(result[0]["c_plu_mst"]?['upd_user']);
//         rn.upd_system = result[0]["c_plu_mst"]?['upd_system'];
//         rn.cust_prc2 = int.parse(result[0]["c_plu_mst"]?['cust_prc2']);
//         rn.mbrdsc_prc2 = int.parse(result[0]["c_plu_mst"]?['mbrdsc_prc2']);
//         rn.producer_cd = int.parse(result[0]["c_plu_mst"]?['producer_cd']);
//         rn.certificate_typ = result[0]["c_plu_mst"]?['certificate_typ'];
//         rn.kind_cd = result[0]["c_plu_mst"]?['kind_cd'];
//         rn.div_cd = result[0]["c_plu_mst"]?['div_cd'];
//         rn.sub1_lrg_cd = int.parse(result[0]["c_plu_mst"]?['sub1_lrg_cd']);
//         rn.sub1_mdl_cd = int.parse(result[0]["c_plu_mst"]?['sub1_mdl_cd']);
//         rn.sub1_sml_cd = int.parse(result[0]["c_plu_mst"]?['sub1_sml_cd']);
//         rn.sub2_lrg_cd = int.parse(result[0]["c_plu_mst"]?['sub2_lrg_cd']);
//         rn.sub2_mdl_cd = int.parse(result[0]["c_plu_mst"]?['sub2_mdl_cd']);
//         rn.sub2_sml_cd = int.parse(result[0]["c_plu_mst"]?['sub2_sml_cd']);
//         rn.disc_cd = int.parse(result[0]["c_plu_mst"]?['disc_cd']);
//         rn.typ_no = result[0]["c_plu_mst"]?['typ_no'];
//         rn.dlug_flg = result[0]["c_plu_mst"]?['dlug_flg'];
//         rn.otc_flg = result[0]["c_plu_mst"]?['otc_flg'];
//         rn.item_flg1 = result[0]["c_plu_mst"]?['item_flg1'];
//         rn.item_flg2 = result[0]["c_plu_mst"]?['item_flg2'];
//         rn.item_flg3 = result[0]["c_plu_mst"]?['item_flg3'];
//         rn.item_flg4 = result[0]["c_plu_mst"]?['item_flg4'];
//         rn.item_flg5 = result[0]["c_plu_mst"]?['item_flg5'];
//         rn.item_flg6 = result[0]["c_plu_mst"]?['item_flg6'];
//         rn.item_flg7 = result[0]["c_plu_mst"]?['item_flg7'];
//         rn.item_flg8 = result[0]["c_plu_mst"]?['item_flg8'];
//         rn.item_flg9 = result[0]["c_plu_mst"]?['item_flg9'];
//         rn.item_flg10 = result[0]["c_plu_mst"]?['item_flg10'];
//         rn.dpnt_rbttarget_flg = result[0]["c_plu_mst"]?['dpnt_rbttarget_flg'];
//         rn.dpnt_usetarget_flg = result[0]["c_plu_mst"]?['dpnt_usetarget_flg'];
//         print(rn.ins_datetime);
//       }catch(e){
//         print('\n********** 異常発生：00124_rc_key_plu rcReadPluFL **********');
//       }finally{
//         print('********** テスト終了：00124_rc_key_plu rcReadPluFL **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00125 : regs getRegistPresetData
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00125_regs getRegistPresetData', () async {
//       print('\n********** テスト実行：00125_regs getRegistPresetData **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> mstList;
//         String sql1 = "select * from c_preset_mst where comp_cd = @p1 AND stre_cd = @p2 AND preset_grp_cd = @p3 AND preset_cd = @p4 ORDER BY preset_no";
//         Map<String, dynamic>? subValues = {"p1" : 1,"p2" : 2,"p3" : 1,"p4" : 201};
//         mstList = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         if (mstList.isEmpty) {
//           print('empty');
//         }
//
//         // if (mstList.length < _presetNumByCd) {
//         //   TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
//         //       "preset_read_db : tuples error [${mstList.length}]");
//         // }
//
//         // プリセットにセットされている有効な画像noを取得する｡
//         List<int> imgNoList = <int>[];
//         int imgNumCnt = 0;
//         for (int i = 0;i < mstList.length; i++){
//           imgNumCnt = int.parse(mstList[i]["c_preset_mst"]?["img_num"]);
//           if(imgNumCnt > 0){
//             imgNoList.add(imgNumCnt);
//           }
//         }
//         // 画像IDと画像名のMAP.
//         Map<int, String> imgMap = <int, String>{};
//         if (imgNoList.isNotEmpty) {
//           // 画像マスタの取得.
//           List<Map<String, Map<String, dynamic>>> imgList;
//           String sql1 = "select * from c_preset_img_mst where comp_cd = @p1 AND  img_num IN (${imgNoList.join(',')})";
//           Map<String, dynamic>? subValues = {"p1" : 1};
//           imgList = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//           print('imgList:$imgList');
//           if(imgList.isNotEmpty){
//             for (int i = 0;i < imgList.length;i++){
//               imgNumCnt = int.parse(imgList[i]["c_preset_img_mst"]?["img_num"]);
//               imgMap[imgNumCnt] = imgList[i]["c_preset_img_mst"]?["name"] ?? "";
//             }
//           }
//         }
//         print('mstList:${mstList.length}');
//         // プリセットマスタと対応する画像マスタをセットにしてリストにする.
//         for (int i =0;i < mstList.length; i++){
//           String imgName = "";
//           imgNumCnt = int.parse(mstList[i]["c_preset_mst"]?["img_num"]);
//           if (imgNumCnt > 0) {
//             imgName = imgMap[imgNumCnt] ?? "";
//           }
//           print('imgName:$imgName');
//           CPresetMstColumns rn = CPresetMstColumns();
//           rn.comp_cd = int.parse(mstList[i]["c_preset_mst"]?['comp_cd']);
//           rn.stre_cd = int.parse(mstList[i]["c_preset_mst"]?['stre_cd']);
//           rn.preset_grp_cd = int.parse(mstList[i]["c_preset_mst"]?['preset_grp_cd']);
//           rn.preset_cd = int.parse(mstList[i]["c_preset_mst"]?['preset_cd']);
//           rn.preset_no = mstList[i]["c_preset_mst"]?['preset_no'];
//           rn.presetcolor = mstList[i]["c_preset_mst"]?['presetcolor'];
//           rn.ky_cd = mstList[i]["c_preset_mst"]?['ky_cd'];
//           rn.ky_plu_cd = mstList[i]["c_preset_mst"]?['ky_plu_cd'];
//           rn.ky_smlcls_cd = int.parse(mstList[i]["c_preset_mst"]?['ky_smlcls_cd']);
//           rn.ky_size_flg = mstList[i]["c_preset_mst"]?['ky_size_flg'];
//           rn.ky_status = mstList[i]["c_preset_mst"]?['ky_status'];
//           rn.ky_name = mstList[i]["c_preset_mst"]?['ky_name'];
//           rn.img_num = int.parse(mstList[i]["c_preset_mst"]?['img_num']);
//           rn.ins_datetime = (mstList[i]["c_preset_mst"]?['ins_datetime']).toString();
//           rn.upd_datetime = (mstList[i]["c_preset_mst"]?['upd_datetime']).toString();
//           rn.status = mstList[i]["c_preset_mst"]?['status'];
//           rn.send_flg = mstList[i]["c_preset_mst"]?['send_flg'];
//           rn.upd_user = int.parse(mstList[i]["c_preset_mst"]?['upd_user']);
//           rn.upd_system = mstList[i]["c_preset_mst"]?['upd_system'];
//           print(rn.ins_datetime);
//           // list.add(RegistPresetButtonSet(rn, imgName));
//         }
//         // return list;
//       }catch(e){
//         print('\n********** 異常発生：00125_regs getRegistPresetData **********');
//       }finally{
//         print('********** テスト終了：00125_regs getRegistPresetData **********\n\n');
//       }
//     });
//
//     // ********************************************************
//     // テスト00126 : rcsch_other rcSchTrmRsvRead
//     // 前提：なし
//     // 試験手順：testを実行する。
//     // 期待結果：①
//     // 　　　　　②
//     // ********************************************************
//     test('00126_rcsch_other rcSchTrmRsvRead', () async {
//       print('\n********** テスト実行：00126_rcsch_other rcSchTrmRsvRead **********');
//       try{
//         // 現在日付 YYYY-MM-DD HH:MM:SSの取得
//         String date = DateUtil.getNowStr(DateUtil.formatForDB);
//
//         await db.dbCon.transaction((txn) async {
//           String sql = ''' SELECT   comp_cd , stre_cd , trm_cd
// 			 , max(case when bs_time >= max_time then trm_data else 0 end) as trm_data
// 			FROM
// 			(
// 			  SELECT
// 			    bs.comp_cd, bs.stre_cd, bs.trm_cd, bs.trm_data, bs.rsrv_datetime as bs_time, chk.rsrv_datetime as max_time
// 			  FROM
// 			    c_trm_rsrv_mst bs
// 			  LEFT OUTER JOIN
// 			    (SELECT comp_cd, stre_cd, trm_cd, max(rsrv_datetime) as rsrv_datetime FROM c_trm_rsrv_mst
// 			     WHERE comp_cd = '1' AND stre_cd ='2' AND rsrv_datetime <= '$date' AND stop_flg = 0 AND kopt_cd = 0 group by comp_cd, stre_cd, trm_cd) as chk
// 			  ON
// 			    bs.comp_cd = chk.comp_cd AND bs.stre_cd = chk.stre_cd AND bs.trm_cd = chk.trm_cd
// 			  WHERE
// 			    bs.comp_cd = '1' AND bs.stre_cd ='2' AND bs.rsrv_datetime <= '$date' AND bs.stop_flg = 0 AND bs.kopt_cd = 0
// 			  ORDER BY
// 			    bs.trm_cd
// 			) as hikaku
// 			GROUP BY
// 			  comp_cd, stre_cd, trm_cd
// 			   ''';
//
//           print('sql:$sql');
//           List<Map<String, Map<String, dynamic>>> dataList = await txn.mappedResultsQuery(sql);
//           print('dataList:${dataList.length}');
//           if (dataList.isNotEmpty) {
//
//             //SELECTの結果取得レコードが0だったため、この中に入らない。
//             //別途UPDATE文およびDELETE文をpgAdminにて確認し問題ないことを確認した。
//
//             // TprLog().logAdd(tid, LogLevelDefine.normal,
//             //     " rcSchTrmRsvRead() : c_trm_mst rsrv chg start. nowTime[${date}]");
//             // RmDBRead.rmDbTrmDtRead(Tpraid.TPRAID_SYST, dataList, true, pCom);
//
//             String updateSql =
//                 "UPDATE c_trm_mst as  trm  SET trm_data = rsrv.trm_data 	 FROM ($sql) rsrv  WHERE trm.trm_cd = rsrv.trm_cd AND trm.comp_cd = rsrv.comp_cd AND trm.stre_cd = rsrv.stre_cd";
//             print('updateSql:$updateSql');
//             await txn.query(updateSql);
//
//             String deleteSql =
//                 "DELETE FROM c_trm_rsrv_mst WHERE rsrv_datetime <= '$date' AND comp_cd = '1' AND stre_cd = '2' AND kopt_cd = 0";
//             print('deleteSql:$deleteSql');
//             txn.query(deleteSql);
//           }
//         });
//       }catch(e){
//         print('\n********** 異常発生：00126_rcsch_other rcSchTrmRsvRead **********');
//       }finally{
//         print('********** テスト終了：00126_rcsch_other rcSchTrmRsvRead **********\n\n');
//       }
//     });
//
//   });
// }