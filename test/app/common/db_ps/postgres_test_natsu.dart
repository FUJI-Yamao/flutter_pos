// /*
//  * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
//  * CONFIDENTIAL/社外秘
//  * 無断開示・無断複製禁止
//  */
//
// import 'dart:io';
// import 'package:flutter/gestures.dart';
// import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:path/path.dart';
// import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
// //import 'app/common/cls_conf/unitTestParts.dart';
// import '../cls_conf/unitTestParts.dart';
// import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
// import 'package:flutter_pos/postgres_library/src/pos_basic_table_access.dart';
// //import 'package:flutter_pos/lib/app/sys/mente/sio/sio_def.dart';
//
// /*
// 本テストでは、登録画面バックエンドの一部機能の確認を行う
//  */
// Future<void> main() async{
//   await postgres_test();
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
//     test('00201_chkopen', () async {
//       print('\n********** テスト実行：00201_chkopen **********');
//       // test用データを挿入
//       // 未開設パターン：insert into c_openclose_mst (comp_cd, stre_cd, mac_no, sale_date, open_flg, close_flg) values (1,2,3,'2018-01-01 00:00:00',0,0);
//       // 閉設済パターン：insert into c_openclose_mst (comp_cd, stre_cd, mac_no, sale_date, open_flg, close_flg) values (1,2,3,'2023-01-01 00:00:00',1,1);
//       try{
//         bool adj;
//         String saleDate = '2023-01-01 00:00:00';
//         var db = DbManipulationPs();
//         String sql = "select open_flg, close_flg from c_openclose_mst where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and sale_date = @saleDate";
//         Map<String, dynamic>? subValues = {
//           "comp"     : 1,
//           "stre"     : 2,
//           "mac"      : 3,
//           "saleDate" : saleDate
//         };
//         List<Map<String, Map<String, dynamic>>> dataList;
//         dataList = await db.dbCon.mappedResultsQuery(sql, substitutionValues: subValues);
//         if (dataList.isEmpty) {
//           adj = false;  /* 該当レジが無い */
//         } else {
//           COpencloseMstColumns oc = COpencloseMstColumns();
//           oc.open_flg = dataList[0]["c_openclose_mst"]?['open_flg'];
//           oc.close_flg = dataList[0]["c_openclose_mst"]?['close_flg'];
//           if (oc.open_flg == 0) {
//             adj = false;	/* 未開設 */
//             print("未開設だよ");
//           }
//           else if ((oc.open_flg == 1) && (oc.close_flg == 1)) {
//             adj = false;	/* 閉設済 */
//             print("閉設済みだよ");
//           }
//         }
//       }catch(e){
//         print('\n********** 異常発生：00201_chkopen **********');
//       }
//       print('********** テスト終了：00201_chkopen **********\n\n');
//     });
//
//     test('00202_mm_reptlib', () async {
//       //test用データ
//       //insert into c_report_cnt (comp_cd, stre_cd, mac_no, report_cnt_cd, settle_cnt, bfr_datetime) values (1,2,3,98,1234,'2018-01-01 00:00:00');
//       print('\n********** テスト実行：00202_mm_reptlib **********');
//       int REPT_CNT_DLY = 98;		/* 日計 */
//       int REPT_CNT_MLY = 99;		/* 累計 */
//       int REPT_CNT_MLY_BS = 100;		/* 累計(BS) */
//       int REPT_CNT_CUST_ENQ_CLR = 1000;		/* 顧客問い合わせテーブルクリア */
//       int REPT_CNT_DEC_RBT = 1001;		/* 確定ポイント割戻 */
//       int REPT_CNT_DEC_FSP_LVL = 1002;		/* ＦＳＰレベル決定 */
//       int REPT_CNT_CUST_PLAY = 1003;		/* 顧客関連再生 */
//       int REPT_CNT_CUST_ENQ_CLR_BS = 1004;		/* 顧客問い合わせテーブルクリア(BS) */
//       int REPT_CNT_TEXT_READ = 1005;		/* テキストデータ読込 */
//       int REPT_CNT_CUST_POINT_CLR = 1006;
//       String SQL_REPT_SELECT = "select settle_cnt,bfr_datetime from c_report_cnt where report_cnt_cd = @repCntCd and comp_cd = @comp and stre_cd = @stre and mac_no = @mac";
//       //String sql = SQL_REPT_SELECT;
//       int settleCnt = 0;
//       String bfrDatetime ='0000-00-00 00:00';
//       Map<String, dynamic>? subValues = {
//         "repCntCd" : REPT_CNT_DLY,
//         "comp"     : 1,
//         "stre"     : 2,
//         "mac"      : 3
//       };
//       try{
//         var db = DbManipulationPs();
//         List<Map<String, Map<String, dynamic>>> dataList;
//         dataList = await db.dbCon.mappedResultsQuery(SQL_REPT_SELECT, substitutionValues: subValues);
//         if (dataList.isEmpty) {
//           print('headprintEj2(): DB error (SQL_REPT_SELECT selected rec count = 0)');
//         } else {
//           settleCnt = int.parse(dataList[0]['c_report_cnt']?['settle_cnt']);
//           if(dataList[0]['c_report_cnt'] != null) {
//             bfrDatetime =
//                 dataList[0]['c_report_cnt']!['bfr_datetime'].toString();
//           }
//           print("settleCntは$settleCntだよ");
//           print("bfrDatetimeは$bfrDatetimeだよ");
//         }
//       }catch(e){
//         print('\n********** 異常発生：00202_mm_reptlib **********');
//       }
//       print('********** テスト終了：00202_mm_reptlib **********\n\n');
//     });
//
//     test('00203_recog_db01', () async {
//       //test用データ
//
//       int page = 2;
//       int posi = 2;
//       print('\n********** テスト実行：00203_recog_db01 **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result1;
//         String sql1 = "select * from p_recog_mst where page = @page and posi = @posi";
//         Map<String, dynamic>? subValues1 = {"page" : page, "posi" : posi};
//         result1 =await db.dbCon.mappedResultsQuery(sql1,substitutionValues: subValues1);
//
//         if(result1 == null){
//           // recordが存在しないのでNG.
//           print("recordないよ");
//         }
//
//         // p_recog_mstのrecog_set_flgに承認キー種別(なし/承認/緊急/強制)を設定するようにする
//         int recogSetFlg = 1;
//         String update_sql1 = "update p_recog_mst set recog_set_flg = @flg "
//             "where page = @page and posi = @page and recog_set_flg <> @flg";
//         Map<String, dynamic>? updateSubValues1 = {
//           "page" : page,
//           "posi" : posi,
//           "flg"  : recogSetFlg
//         };
//         await db.dbCon.query(update_sql1, substitutionValues: updateSubValues1);
//
//         List<Map<String, Map<String, dynamic>>> result2;
//         String sql2 = "select emergency_type from c_recoginfo_mst "
//             "where comp_cd = @comp and mac_no = @mac and stre_cd = @stre and page = @page";
//         Map<String, dynamic>? subValues2 = {
//           "comp" : 1,
//           "mac"  : 3,
//           "stre" : 2,
//           "page" : page
//         };
//         result2 = await db.dbCon.mappedResultsQuery(sql2, substitutionValues: subValues2);
//         if(result2 == null){
//           // recordが存在しないのでNG.
//           print("recordが存在しないのでNGだって");
//         }
//         print("results2の中身は$result2だよ");
//
//         String typeNew = "111111111111";
//         //承認キー更新SQL実行
//         // p_recog_mstのrecog_set_flgに承認キー種別(なし/承認/緊急/強制)を設定するようにする
//         String update_sql2 = "update c_recoginfo_mst set emergency_type = @typeNew "
//             "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and page = @page";
//         Map<String, dynamic>? updateSubValues2 = {
//           "typeNew" : typeNew,
//           "comp" : 1,
//           "stre" : 2,
//           "mac" : 3,
//           "page" : page
//         };
//         await db.dbCon.query(update_sql2, substitutionValues: updateSubValues2);
//
//       }catch(e){
//         print('\n********** 異常発生：00203_recog_db01 **********');
//       }
//       print('********** テスト終了：00203_recog_db01 **********\n\n');
//     });
//
//     test('00203_recog_db02', () async {
//       //test用データ
//
//       DbManipulationPs db = DbManipulationPs();
//       int RECOG_SQL_RECOGINFO_DB_NUM =64;
//       String RECOG_SQL_RECOGINFO_EXIST =
//           "SELECT page FROM c_recoginfo_mst "
//           "WHERE comp_cd = @comp AND stre_cd = @stre AND mac_no = @mac AND (page>=1 AND page<=@DBNum);";
//       String exitSql = RECOG_SQL_RECOGINFO_EXIST;
//       print('\n********** テスト実行：00203_recog_db02 **********');
//       try{
//         List<Map<String, Map<String, dynamic>?>> dataList;
//         Map<String, dynamic>? subValues = {
//           "comp" : 1,
//           "stre" : 2,
//           "mac" : 3,
//           "DBNum": RECOG_SQL_RECOGINFO_DB_NUM
//         };
//         dataList=  await db.dbCon.mappedResultsQuery(exitSql, substitutionValues: subValues);
//         //  対象レコード取得確認(:該当レコード無し=NGとする)
//         if(dataList.length < RECOG_SQL_RECOGINFO_DB_NUM){
//           // 承認キーデータを読み込む.
//           // TODO:10028 承認キーDB RECOG_CMD_SET_RECOGINFO . sqlファイルを読み込み.
//           // snprintf ( cmd, sizeof(cmd)-1, RECOG_CMD_SET_RECOGINFO, HomePath, comp_cd, stre_cd, mac_no );
//           // system ( cmd );
//           print( "recoginfoDbCheck(): c_recoginfo_mst insert");
//         }
//         print("dataListの中身は$dataList");
//       }catch(e){
//         print('\n********** 異常発生：00203_recog_db02 **********');
//       }
//       print('********** テスト終了：00203_recog_db02 **********\n\n');
//     });
//
//     test('00204_rx_prt_flg_set01', () async {
//       print('\n********** テスト実行：00204_rx_prt_flg_set01 **********');
//       try{
//         int loginStaffCd = 0;
//         String data1 = "testtest";
//         String data2 = "testcode";
//         String  RECOGKEY_SQL_RECOGINFO_SET = "update c_recoginfo_mst set password = @password, fcode = @fcode, upd_datetime = 'now' , status = '0', send_flg = '0', upd_user = @upd_user, upd_system = '0' where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and page = @page";
//         String sql = RECOGKEY_SQL_RECOGINFO_SET;
//         Map<String, dynamic>? subValues = {
//           "password" : data1,
//           "fcode"    : data2,
//           "upd_user" : loginStaffCd,
//           "comp"     : 1,
//           "stre"     : 2,
//           "mac"      : 3,
//           "page"     : 1
//         };
//
//         await db.dbCon.query(sql, substitutionValues:subValues);
//         print("updateしますよ");
//
//       }catch(e){
//         print('\n********** 異常発生：00204_rx_prt_flg_set01 **********');
//       }
//       print('********** テスト終了：00204_rx_prt_flg_set01 **********\n\n');
//     });
//
//     test('00204_rx_prt_flg_set02', () async {
//       //test用
//       //insert into c_recoginfo_mst (comp_cd, stre_cd, mac_no, page, password, fcode) values (1,2,3,111,'123456789123','54321');
//       print('\n********** テスト実行：00204_rx_prt_flg_set02 **********');
//       try{
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 =
//             "select password, fcode from c_recoginfo_mst "
//             "where comp_cd = @comp and mac_no = @mac and stre_cd = @stre and page = @page";
//         Map<String, dynamic>? subValues = {
//           "comp" : 1,
//           "mac"  : 3,
//           "stre" : 2,
//           "page" : 111
//         };
//
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         if(result == null){
//           // データが取得できなかったらエラーとして返す.
//           print("データ取得できてないよ");
//         }
//
//         //test用
//         print("resultは$result");
//         String password = result[0]["c_recoginfo_mst"]?["password"];
//         print("passwordは$password");
//
//         if(result[0]["c_recoginfo_mst"]?["password"] == null){
//           print("Get password error");
//         }else if(result[0]["c_recoginfo_mst"]?["password"]!.isEmpty){
//           print("passwordが設定されてないよ");
//         }
//         if(result[0]["c_recoginfo_mst"]?["fcode"] == null){
//           print("Get fcode error");
//         }else if(result[0]["c_recoginfo_mst"]?["fcode"]!.isEmpty){
//           print("fcode設定されてないよ");
//
//         }
//
//         int bi = int.parse(result[0]["c_recoginfo_mst"]?["fcode"]!);
//         List<int> des = [];
//         for(int i=0; i<12; i+=2){
//           //2文字取得
//           String tmp = result[0]["c_recoginfo_mst"]?["password"]![i]
//               + result[0]["c_recoginfo_mst"]?["password"]![i+1];
//           // 文字列を16進数数値へ変換.
//           int hex = int.parse(tmp, radix:16);
//           des.add(hex);
//           print('16進数にへんかんしたよ:　$des');
//         }
//
//       }catch(e){
//         print('\n********** 異常発生：00204_rx_prt_flg_set02 **********');
//       }
//       print('********** テスト終了：00204_rx_prt_flg_set02 **********\n\n');
//     });
//
//     test('00205_sio_db', () async {
//       print('\n********** テスト実行：00006_Query_06 sio_db.dart **********');
//       try{
//         List<Map<String, Map<String, dynamic>?>> result;
//         String RECOG_SQL_REGCNCTSIO_EXIST	=
//             "SELECT com_port_no "
//             "FROM c_regcnct_sio_mst "
//             "WHERE comp_cd = @comp AND stre_cd = @stre AND mac_no = @mac "
//             "AND (com_port_no >= '1' AND com_port_no <= '4')";
//         Map<String, dynamic>? subValues = {
//           "comp" : 1,
//           "stre" : 2,
//           "mac"  : 3
//         };
//         String sql1 = RECOG_SQL_REGCNCTSIO_EXIST;
//
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         if (result.isEmpty) {
//           print("検索結果はからだよ");
//         }
//         if (result.length < 4) {
//           print("検索結果は4未満だよ：$result");
//         }else{
//           print("検索結果ありだよ：$result");
//         }
//
//       }catch(e){
//         print('\n********** 異常発生：00205_sio_db **********');
//       }
//       print('********** テスト終了：00205_sio_db **********\n\n');
//     });
//
//     test('00206_staff_auth', () async {
//       print('\n********** テスト実行：00206_staff_auth **********');
//       try{
//         List<Map<String, Map<String, dynamic>?>> result;
//         Map<String, dynamic>? subValues = {
//           "staff" : 999999,
//           "comp" : 1
//         };
//         String sql1 = "SELECT auth_lvl FROM c_staff_mst WHERE staff_cd = @staff AND comp_cd = @comp";
//
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//         int rtLevel = -1;
//         if (result.isEmpty) {
//           print("検索結果はからだよ");
//         }
//         if (result.isNotEmpty) {
//           rtLevel = result[0]["c_staff_mst"]?["auth_lvl"] == null
//               ? -1
//               : result[0]["c_staff_mst"]?["auth_lvl"] as int;
//           print("検索結果：　$rtLevel");
//         }
//
//       }catch(e){
//         print('\n********** 異常発生：00206_staff_auth **********');
//       }
//       print('********** テスト終了：00206_staff_auth **********\n\n');
//     });
//
//     test('00207_recogkey_sub', () async {
//       print('\n********** テスト実行：00207_recogkey_sub **********');
//       try{
//         int pageNum = 3;
//         int posi = 18;
//         List<Map<String, Map<String, dynamic>>> result;
//         String sql1 = "select recog_name from p_recog_mst where page = @p1 and posi = @p2";
//         Map<String, dynamic>? subValues = {"p1" : pageNum,"p2" : posi};
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         if(result[0] == null){
//           // データが取得できなかったらエラーとして返す.
//           print("データ取得できてないよ");
//         }
//
//         if(result[0]["p_recog_mst"]?["recog_name"] == null){
//           // 名前が設定されていなかったときは、エラーログをだし、取得できなかった文言を表示する.
//           print("名前が設定されてないよ");
//
//         }else if(result[0]["p_recog_mst"]?["recog_name"]!.isEmpty){
//           print("名前が.isEmptyだよ");
//         }else{
//           // 値が設定されているのでその値をセット.
//           List<String> recogkeyFuncList = <String>[];
//           recogkeyFuncList.add(result[0]["p_recog_mst"]?["recog_name"]!);
//           print('名前を設定したよ :$recogkeyFuncList');
//         }
//
//       }catch(e){
//         print('\n********** 異常発生：00207_recogkey_sub **********');
//       }
//
//       print('********** テスト終了：00207_recogkey_sub **********\n\n');
//
//     });
//
//     test('00208_sio01_01', () async {
//       print('\n********** テスト実行：00208_sio01_01 **********');
//       //236行
//       try{
//         List<Map<String, Map<String, dynamic>?>> result;
//         String SIO_SQL_GET_SIO_DEFAULT_DATA =
//             "select sioMst.cnct_kind, sioMst.cnct_grp, sioMst.drv_sec_name, COALESCE(imgMst.img_data, ' ') as img_data, "
//             "sioMst.sio_rate, sioMst.sio_stop, sioMst.sio_record, sioMst.sio_parity "
//             "from c_sio_mst sioMst left outer join c_img_mst imgMst on (imgMst.img_cd = sioMst.sio_image_cd) "
//             "left outer join c_reginfo_grp_mst regGrp on (regGrp.grp_cd = imgMst.img_grp_cd and regGrp.grp_typ = '6') "
//             "where sioMst.cnct_grp = @cnct_grp and sioMst.drv_sec_name = @drv_sec_name";
//         Map<String, dynamic>? subValues = {
//           "cnct_grp" : 2,
//           "drv_sec_name"  : 'acb'
//         };
//         String sql1 = SIO_SQL_GET_SIO_DEFAULT_DATA;
//
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         print('差集合の中身result： $result');
//
//         int sio_rate = result[0]['c_sio_mst']?['sio_rate'];
//         int sio_stop = result[0]['c_sio_mst']?['sio_stop'];
//         int sio_record = result[0]['c_sio_mst']?['sio_record'];
//         int sio_parity = result[0]['c_sio_mst']?['sio_parity'];
//         String img_data = result[0]['']?['img_data'];
//
//         print('sio_rate: $sio_rate, sio_stop: $sio_stop, sio_record: $sio_record, sio_parity: $sio_parity');
//         print('img_data: $img_data');
//
//       }catch(e){
//         print('\n********** 異常発生：00208_sio01_01 **********');
//       }
//       print('********** テスト終了：00208_sio01_01 **********\n\n');
//     });
//
//     test('00208_sio01_02', () async {
//       print('\n********** テスト実行：00208_sio01_02 **********');
//       //352行
//       String SIO_SQL_GET_SECTIONTITLE =
//           "select sioMst.drv_sec_name, imgMst.img_data "
//           "from c_sio_mst sioMst left outer join c_img_mst imgMst on (imgMst.img_cd = sioMst.sio_image_cd) "
//           "where imgMst.comp_cd = @comp AND imgMst.stre_cd = @stre";
//       int PAGE_MAX = 1;
//       int TOOL_MAX = 54;
//       var sioSectTitleTbl = List<SioSectTbl>.generate(
//           PAGE_MAX * TOOL_MAX, (index) => SioSectTbl());
//       try{
//         var db = DbManipulationPs();
//         // SQL文を作成し、実行
//         String sql = SIO_SQL_GET_SECTIONTITLE;
//         Map<String, dynamic>? subValues = {
//           "comp" : 1,
//           "stre" : 2
//         };
//
//         List<Map<String, Map<String, dynamic>?>> dataList;
//         dataList = await db.dbCon.mappedResultsQuery(sql,substitutionValues: subValues);
//         if (dataList.isEmpty) {
//           print('_createSectTitleTable(): DB error (Get sio section title tables)');
//           return false;
//         }
//         // 上限設定
//         int ntuples = 0;
//         if (dataList.length > PAGE_MAX * TOOL_MAX) {
//           ntuples = PAGE_MAX * TOOL_MAX;
//         } else {
//           ntuples = dataList.length;
//         }
//         // 取得データを sioSectTitleTbl に格納
//         for (int i = 0; i < ntuples; i++) {
//           sioSectTitleTbl[i].sectionName = dataList[i]['c_sio_mst']?['drv_sec_name'];
//           sioSectTitleTbl[i].titleName = dataList[i]['c_img_mst']?['img_data'];
//         }
//         print("dataListの中身：$dataList");
//         //ひとまず配列にデータが入っていることを1ケース確認。
//         print("sioDevTblOld[0].deviceの中身：${sioSectTitleTbl[0].sectionName}");
//         print("sioDevTblOld[0].baudの中身：${sioSectTitleTbl[0].titleName}");
//
//       }catch(e){
//         print('\n********** 異常発生：00208_sio01_02 **********');
//       }
//       print('********** テスト終了：00208_sio01_02 **********\n\n');
//     });
//
//     test('00208_sio01_03', () async {
//       print('\n********** テスト実行：00208_sio01_03 **********');
//       //606行
//       //test用
//       // update c_regcnct_sio_mst set cnct_kind = 1,cnct_grp =2, sio_rate=1, sio_stop=1, sio_record=1,sio_parity=1 where com_port_no = 1;
//
//       try{
//         List<Map<String, Map<String, dynamic>?>> result;
//         String SIO_SQL_GET_REGCNCT_SIO_DATA	=
//             "select regcnctMst.com_port_no, regcnctMst.cnct_kind, regcnctMst.cnct_grp, "
//             "sioMst.drv_sec_name, COALESCE(imgMst.img_data, ' ') as img_data, "
//             "regcnctMst.sio_rate, regcnctMst.sio_stop, regcnctMst.sio_record, "
//             "regcnctMst.sio_parity, regcnctMst.qcjc_flg "
//             "from c_regcnct_sio_mst regcnctMst "
//             "inner join c_sio_mst sioMst on "
//             "(sioMst.cnct_kind = regcnctMst.cnct_kind and sioMst.cnct_grp = regcnctMst.cnct_grp) "
//             "left outer join c_img_mst imgMst on (imgMst.img_cd = sioMst.sio_image_cd) "
//             "left outer join c_reginfo_grp_mst regGrp on "
//             "(regGrp.grp_cd = imgMst.img_grp_cd and regGrp.grp_typ = '6') "
//             "where regcnctMst.comp_cd = @comp and regcnctMst.stre_cd = @stre "
//             "and regcnctMst.mac_no = @mac and "
//             "regcnctMst.comp_cd = regGrp.comp_cd and "
//             "regcnctMst.stre_cd = regGrp.stre_cd and regcnctMst.mac_no = regGrp.mac_no "
//             "order by com_port_no asc";
//         Map<String, dynamic>? subValues = {
//           "comp" : 1,
//           "stre" : 2,
//           "mac"  : 3
//         };
//         String sql1 = SIO_SQL_GET_REGCNCT_SIO_DATA;
//
//         result = await db.dbCon.mappedResultsQuery(sql1,substitutionValues:subValues);
//
//         //test用
//         print('差集合の中身result： $result');
//
//         if (result.isEmpty) {
//           print('_setDevTableInit(): DB error (Get sio token tables)');
//           return false;
//         }
//
//         int pGetValue = 0;
//         int nRec = 0;
//         int SIONUM_MAX = 4;
//         String NOT_USE = "使用せず";
//         var sioDevTblOld = List<SioTokTbl>.generate(SIONUM_MAX, (index) => SioTokTbl(NOT_USE));
//         //List<String> sioDevTblOld = <String>[];
//
//         for (int i = 0; i < SIONUM_MAX; i++) {
//           pGetValue = result[i]['c_regcnct_sio_mst']?['com_port_no'];
//           print("pGetValueの中身：$pGetValue");
//           if (i == pGetValue - 1) {
//             sioDevTblOld[i].device = result[i]['']?['img_data'];
//             sioDevTblOld[i].baud = result[i]['c_regcnct_sio_mst']?['sio_rate'] as int;
//             sioDevTblOld[i].stopB = result[i]['c_regcnct_sio_mst']?['sio_stop'] as int;
//             sioDevTblOld[i].dataB = result[i]['c_regcnct_sio_mst']?['sio_record'] as int;
//             sioDevTblOld[i].parity = result[i]['c_regcnct_sio_mst']?['sio_parity'] as int;
//             nRec++;
//           }
//           if (nRec >= result.length) {
//             break;
//           }
//         }
//         print("sioDevTblOld[0].deviceの中身：${sioDevTblOld[0].device}");
//         print("sioDevTblOld[0].baudの中身：${sioDevTblOld[0].baud}");
//         print("sioDevTblOld[0].stopBの中身：${sioDevTblOld[0].stopB}");
//         print("sioDevTblOld[0].dataBの中身：${sioDevTblOld[0].dataB}");
//         print("sioDevTblOld[0].parityの中身：${sioDevTblOld[0].parity}");
//       }catch(e){
//         print('\n********** 異常発生：00208_sio01_03 **********');
//       }
//       print('********** テスト終了：00208_sio01_03 **********\n\n');
//     });
//
//     test('00208_sio01_04-1', () async {
//
//       int comPortNo = 0;
//       int delPortNo = 0;
//       List<List<int>> sioQcjcTyp = [
//         [ 0, 0, 0, 0 ],
//         [ 0, 0, 0, 0 ],
//       ];
//       int LOGIN_STAFF_CD = 999999;
//       print('\n********** テスト実行：00208_sio01_04-1 **********');
//       //763行
//       //test用
//       // insert into c_regcnct_sio_mst (comp_cd, stre_cd, mac_no,com_port_no) values (1,2,3,5);
//       // insert into c_regcnct_sio_mst (comp_cd, stre_cd, mac_no,com_port_no) values (1,2,3,6);
//       try{
//         await db.dbCon.transaction((txn) async {
//           // ポート番号 = 5 のレコードがいたら不要なので消す
//           delPortNo = 5;
//           print("削除対象のポートdelPortNo:$delPortNo");
//           // TODO:10094 webAPI DB関連
//           String delete_sql = "delete from c_regcnct_sio_mst "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           Map<String, dynamic>? subValues1 = {
//             "comp": 1,
//             "stre": 2,
//             "mac": 3,
//             "cp_no": delPortNo
//           };
//           await txn.query(delete_sql, substitutionValues: subValues1);
//
//           // データが削除されたか確認
//           List<Map<String, Map<String, dynamic>>> deleteResult;
//           String delete_check_sql = "select * from c_regcnct_sio_mst "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           deleteResult = await txn.mappedResultsQuery(
//               delete_check_sql, substitutionValues: subValues1);
//
//           print("deleteResultの中身：$deleteResult");
//           if (deleteResult.isNotEmpty) {
//             print("対象ポートの削除ができてないよ");
//             db.rollback(txn);
//           }else{
//             print("対象ポートの削除ができたよ");
//           }
//
//           // TODO:10094 webAPI DB関連
//           comPortNo = 6;
//           Map<String, dynamic>? subValues2 = {
//             "qcjc_flg": sioQcjcTyp[0][0],
//             "upd_user": LOGIN_STAFF_CD,
//             "comp": 1,
//             "stre": 2,
//             "mac": 3,
//             "cp_no": comPortNo
//           };
//           String update_sql = "update c_regcnct_sio_mst "
//               "set cnct_kind = 0, cnct_grp = 0, sio_rate = -1, sio_stop = -1,"
//               "sio_record = -1, sio_parity = -1, qcjc_flg = @qcjc_flg,"
//               "upd_datetime = 'now', upd_user = @upd_user, upd_system = 2 "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           await txn.query(update_sql, substitutionValues: subValues2);
//
//           // データ確認
//           List<Map<String, Map<String, dynamic>>> updateResult;
//           String sql1 = "select * from c_regcnct_sio_mst "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           updateResult =
//           await txn.mappedResultsQuery(sql1, substitutionValues: subValues2);
//
//           DateTime nowTime = DateTime.now();
//           print("現在時刻は$nowTime");
//           print("upd_datetime:${updateResult[0]["c_regcnct_sio_mst"]?["upd_datetime"]}");
//           String upd_datetime = (updateResult[0]["c_regcnct_sio_mst"]?["upd_datetime"]).toString();
//           String now_time = nowTime.toString();
//           print(upd_datetime.substring(0,10));
//           print(now_time.substring(0,10));
//           String up = upd_datetime.substring(0,10);
//           //String up = upd_datetime.substring(0,11);
//           String now = now_time.substring(0,10);
//
//
//           if (up != now) {
//             print("_sio01SetJson(): DB error (UPDATE c_regcnct_sio_mst)");
//             db.rollback(txn);
//           }else{
//             print("updateされてるよ");
//           }
//           // TODO:10094 webAPI DB関連
//           if (updateResult.isEmpty) {
//             String insert_sql =
//                 "insert into c_regcnct_sio_mst values ("
//                 "@comp, @stre, @mac,"
//                 "@cp_no, 0,0,-1,-1,-1,-1,"
//                 "@qcjc_flg,'now','now',0,0,"
//                 "@upd_user,2)";
//
//             Map<String, dynamic>? subValues3 = {
//               "comp": 1,
//               "stre": 2,
//               "mac": 3,
//               "cp_no": comPortNo,
//               "qcjc_flg": sioQcjcTyp[0][0],
//               "upd_user": LOGIN_STAFF_CD
//             };
//             await txn.query(insert_sql, substitutionValues: subValues3);
//
//             // データ確認
//             List<Map<String, Map<String, dynamic>>> insertResult;
//             String insert_check_sql = "select * from c_regcnct_sio_mst "
//                 "where comp_cd = @comp and stre_cd = @stre and "
//                 "mac_no = @mac and com_port_no = @cp_no and ins_datetime = 'now' and upd_datetime = 'now'";
//             insertResult = await txn.mappedResultsQuery(
//                 insert_check_sql, substitutionValues: subValues3);
//             if (insertResult.isEmpty) {
//               print('_sio01SetJson(): DB error (INSERT INTO c_regcnct_sio_mst)');
//               db.rollback(txn);
//             }
//           }
//         });
//
//       }catch(e){
//         print('\n********** 異常発生：00208_sio01_04-1 **********');
//       }
//       print('********** テスト終了：00208_sio01_04-1 **********\n\n');
//     });
//
//     test('00208_sio01_04-1-1', () async {
//       //00208_sio01_04-1のif (updateResult.isEmpty)が真のケース
//       int comPortNo = 0;
//       int delPortNo = 0;
//       List<List<int>> sioQcjcTyp = [
//         [ 0, 0, 0, 0 ],
//         [ 0, 0, 0, 0 ],
//       ];
//       int LOGIN_STAFF_CD = 999999;
//       print('\n********** テスト実行：00208_sio01_04-1-1 **********');
//       //763行
//       //test用
//       // insert into c_regcnct_sio_mst (comp_cd, stre_cd, mac_no,com_port_no) values (1,2,3,5);
//       // insert into c_regcnct_sio_mst (comp_cd, stre_cd, mac_no,com_port_no) values (1,2,3,6);
//       try{
//         comPortNo = 7;
//         await db.dbCon.transaction((txn) async {
//           String insert_sql =
//               "insert into c_regcnct_sio_mst values ("
//               "@comp, @stre, @mac,"
//               "@cp_no, 0,0,-1,-1,-1,-1,"
//               "@qcjc_flg,'now','now',0,0,"
//               "@upd_user,2)";
//
//           Map<String, dynamic>? subValues3 = {
//             "comp": 1,
//             "stre": 2,
//             "mac": 3,
//             "cp_no": comPortNo,
//             "qcjc_flg": sioQcjcTyp[0][0],
//             "upd_user": LOGIN_STAFF_CD
//           };
//           await txn.query(insert_sql, substitutionValues: subValues3);
//
//           // データ確認
//           List<Map<String, Map<String, dynamic>>> insertResult;
//           String insert_check_sql = "select * from c_regcnct_sio_mst "
//               "where comp_cd = @comp and stre_cd = @stre and "
//               "mac_no = @mac and com_port_no = @cp_no and ins_datetime = 'now' and upd_datetime = 'now'";
//           insertResult = await txn.mappedResultsQuery(
//               insert_check_sql, substitutionValues: subValues3);
//           if (insertResult.isEmpty) {
//             print('_sio01SetJson(): DB error (INSERT INTO c_regcnct_sio_mst)');
//             db.rollback(txn);
//           }
//           print("insertResultの中身：$insertResult");
//         });
//
//       }catch(e){
//         print('\n********** 異常発生：00208_sio01_04-1-1 **********');
//       }
//       print('********** テスト終了：00208_sio01_04-1-1 **********\n\n');
//     });
//
//     test('00208_sio01_04-2', () async {
//
//       int comPortNo = 0;
//       int delPortNo = 0;
//       List<List<int>> sioQcjcTyp = [
//         [ 0, 0, 0, 0 ],
//         [ 0, 0, 0, 0 ],
//       ];
//       int LOGIN_STAFF_CD = 999999;
//       print('\n********** テスト実行：00208_sio01_04-2 **********');
//       //922行以降
//       //test用
//       // insert into c_regcnct_sio_mst (comp_cd, stre_cd, mac_no,com_port_no) values (1,2,3,5);
//       // insert into c_regcnct_sio_mst (comp_cd, stre_cd, mac_no,com_port_no) values (1,2,3,6);
//       try{
//         await db.dbCon.transaction((txn) async {
//           // ポート番号 = 5 のレコードがいたら不要なので消す
//           delPortNo = 5;
//           print("削除対象のポートdelPortNo:$delPortNo");
//           // TODO:10094 webAPI DB関連
//           String delete_sql = "delete from c_regcnct_sio_mst "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           Map<String, dynamic>? subValues = {
//             "comp": 1,
//             "stre": 2,
//             "mac": 3,
//             "cp_no": delPortNo
//           };
//           await txn.query(delete_sql, substitutionValues: subValues);
//
//           // データが削除されたか確認
//           List<Map<String, Map<String, dynamic>>> deleteResult;
//           String delete_check_sql = "select * from c_regcnct_sio_mst "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           deleteResult = await txn.mappedResultsQuery(delete_check_sql, substitutionValues: subValues);
//
//           print("deleteResultの中身：$deleteResult");
//           if (deleteResult.isNotEmpty) {
//             print("対象ポートの削除ができてないよ");
//             db.rollback(txn);
//           }else{
//             print("対象ポートの削除ができたよ");
//           }
//
//           // sio record update
//           // TODO:10094 webAPI DB関連
//           List<Map<String, Map<String, dynamic>>> dbSioResult1;
//           Map<String, dynamic>? subValues1 = {
//             "cnct_grp" : 2,
//             "drv_sec_name"  : 'acb'
//           };
//
//           String select_dbSio_sql = "select * from c_sio_mst "
//               "where cnct_grp = @cnct_grp and drv_sec_name = @drv_sec_name";
//           dbSioResult1 = await txn.mappedResultsQuery(select_dbSio_sql, substitutionValues: subValues1);
//
//           int baud = 111;
//           int stopB =111;
//           int dataB = 111;
//           int parity = 111;
//           comPortNo =6;
//           Map<String, dynamic>? updateSubValues = {
//             "cnct_kind"  : dbSioResult1[0]["c_sio_mst"]?["cnct_kind"],
//             "cnct_grp"   : 2,
//             "sio_rate"   : baud,
//             "sio_stop"   : stopB,
//             "sio_record" : dataB,
//             "sio_parity" : parity,
//             "qcjc_flg"   : 1,
//             "upd_user"   : LOGIN_STAFF_CD,
//             "comp"       : 1,
//             "stre"       : 2,
//             "mac"        : 3,
//             "cp_no"      : comPortNo
//           };
//           String update_sql = "update c_regcnct_sio_mst "
//               "set cnct_kind = @cnct_kind, "
//               "cnct_grp = @cnct_grp, "
//               "sio_rate = @sio_rate, sio_stop = @sio_stop, sio_record = @sio_record, "
//               "sio_parity = @sio_parity, qcjc_flg = @qcjc_flg,"
//               "upd_datetime = 'now', upd_user = @upd_user, "
//               "upd_system = 2 "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           await txn.query(update_sql, substitutionValues: updateSubValues);
//
//           // データ確認
//           String select_dbReg_sql = "select * from c_regcnct_sio_mst "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           Map<String, dynamic>? selectSubValues = {
//             "comp"       : 1,
//             "stre"       : 2,
//             "mac"        : 3,
//             "cp_no"      : comPortNo
//           };
//           List<Map<String, Map<String, dynamic>>> dbRegResult1;
//           dbRegResult1 = await txn.mappedResultsQuery(select_dbReg_sql, substitutionValues: selectSubValues);
//
//           // TODO:00012 平野 時間比較を修正する必要あり
//
//           DateTime nowTime = DateTime.now();
//           String upd_datetime = (dbRegResult1[0]["c_regcnct_sio_mst"]?["upd_datetime"]).toString();
//           String now_time = nowTime.toString();
//           String up = upd_datetime.substring(0,10);
//           String now = now_time.substring(0,10);
//
//           print("$up:$now");
//
//           //元のif文ではミリ秒で一致しないため、日付のみで比較するよう仮修正
//           //if (dbRegResult1[0]["c_regcnct_sio"]?["upd_datetime"] != 'now') {
//           if(up != now){
//             print("updateされてないよ");
//             db.rollback(txn);
//           }else{
//             print("updateされたよ");
//             print("dbRegResult1の中身：$dbRegResult1");
//           }
//         });
//
//       }catch(e){
//         print('\n********** 異常発生：00208_sio01_04-2 **********');
//       }
//       print('********** テスト終了：00208_sio01_04-2 **********\n\n');
//     });
//
//     test('00208_sio01_04-2-1', () async {
//
//       int comPortNo = 0;
//       int delPortNo = 0;
//       List<List<int>> sioQcjcTyp = [
//         [ 0, 0, 0, 0 ],
//         [ 0, 0, 0, 0 ],
//       ];
//       int LOGIN_STAFF_CD = 999999;
//       print('\n********** テスト実行：00208_sio01_04-2-1 **********');
//       //1147行以降
//       //test用
//       // insert into c_regcnct_sio_mst (comp_cd, stre_cd, mac_no,com_port_no) values (1,2,3,5);
//       // insert into c_regcnct_sio_mst (comp_cd, stre_cd, mac_no,com_port_no) values (1,2,3,6);
//       try{
//         await db.dbCon.transaction((txn) async {
//            // sio record update
//           // TODO:10094 webAPI DB関連
//           String select_dbSio_sql = "select * from c_sio_mst "
//               "where cnct_grp = @cnct_grp and drv_sec_name = @drv_sec_name";
//
//           int baud = 111;
//           int stopB =111;
//           int dataB = 111;
//           int parity = 111;
//           comPortNo =8;
//
//           Map<String, dynamic>? subValues1 = {
//             "cnct_grp" : 2,
//             "drv_sec_name"  : 'acb'
//           };
//
//           String select_dbReg_sql = "select * from c_regcnct_sio_mst "
//               "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and com_port_no = @cp_no";
//           Map<String, dynamic>? selectSubValues = {
//             "comp"       : 1,
//             "stre"       : 2,
//             "mac"        : 3,
//             "cp_no"      : comPortNo
//           };
//
//           //1147行以降
//           // TODO:10094 webAPI DB関連
//           List<Map<String, Map<String, dynamic>>> dbRegResult2;
//           List<Map<String, Map<String, dynamic>>> dbSioResult2;
//           dbRegResult2 = await txn.mappedResultsQuery(select_dbReg_sql, substitutionValues: selectSubValues);
//           dbSioResult2 = await txn.mappedResultsQuery(select_dbSio_sql, substitutionValues: subValues1);
//
//           print("dbRegResult2の中身：$dbRegResult2");
//           print("dbSioResult2の中身：$dbSioResult2");
//
//           if (dbRegResult2.isEmpty && dbSioResult2.isNotEmpty) {
//             String insert_sql =
//                 "insert into c_regcnct_sio_mst values ("
//                 "@comp, @stre, @mac,"
//                 "@cp_no, @cnct_kind, "
//                 "@cnct_grp,@sio_rate,@sio_stop,@sio_record,@sio_parity,"
//                 "@qcjc_flg,'now','now',0,0,"
//                 "@upd_user,2)";
//             Map<String, dynamic>? insertSubValues = {
//               "comp"       : 1,
//               "stre"       : 2,
//               "mac"        : 3,
//               "cp_no"      : comPortNo,
//               "cnct_kind"  : dbSioResult2[0]["c_sio_mst"]?["cnct_kind"],
//               "cnct_grp"   : 2,
//               "sio_rate"   : baud,
//               "sio_stop"   : stopB,
//               "sio_record" : dataB,
//               "sio_parity" : parity,
//               "qcjc_flg"   : 1,
//               "upd_user"   : LOGIN_STAFF_CD,
//
//             };
//             await txn.query(insert_sql, substitutionValues: insertSubValues);
//
//             // データ確認
//             List<Map<String, Map<String, dynamic>>> dbRegResult3;
//             dbRegResult3 = await txn.mappedResultsQuery(select_dbReg_sql, substitutionValues: selectSubValues);
//
//             if (dbRegResult3.isEmpty) {
//               print("insertできてないよ");
//               db.rollback(txn);
//             }else{
//               print("insertできたよ");
//               print("insertの内容：$dbRegResult3");
//             }
//           }
//         });
//
//       }catch(e){
//         print('\n********** 異常発生：00208_sio01_04-2-1 **********');
//       }
//       print('********** テスト終了：00208_sio01_04-2-1 **********\n\n');
//     });
//
//     test('00209_l_languagedbcall', () async {
//       print('\n********** テスト実行：00209_l_languagedbcall **********');
//       //test用
//       // insert into languages_mst (multilingual_key, country_division, label_name) values ('test1',1,'labelName1');
//       // insert into languages_mst (multilingual_key, country_division, label_name) values ('test2',2,'labelName2');
//       // insert into languages_mst (multilingual_key, country_division, label_name) values ('test3',3,'labelName3');
//       try{
//         var dbAccess = DbManipulationPs();
//
//         // データ読み込み
//         List<LanguagesData> lstRtn = [];
//         List<Map<String, Map<String, dynamic>?>> result;
//         String sql1 = "select * from languages_mst";
//         result = await dbAccess.dbCon.mappedResultsQuery(sql1);
//
//         if (result.isEmpty) {
//           print('多言語マスタは空');
//         } else {
//           // 必要な部分だけを抽出
//           for(int i = 0; i < result.length; i++ ){
//             lstRtn.add(LanguagesData(
//                 multilingual_key: result[i]["languages_mst"]?["multilingual_key"],
//                 country_division: result[i]["languages_mst"]?["country_division"],
//                 label_name: result[i]["languages_mst"]?["label_name"]));
//
//             print("lstRtnの中身：${lstRtn[i]}");
//           }
//         }
//
//
//       }catch(e){
//         print('\n********** 異常発生：00209_l_languagedbcall **********');
//       }
//
//       print('********** テスト終了：00209_l_languagedbcall **********\n\n');
//
//     });
//
//     test('00209_l_languagedbcall_2', () async {
//       print('\n********** テスト実行：00209_l_languagedbcall_2 **********');
//       //test用
//       // insert into languages_mst (multilingual_key, country_division, label_name) values ('test1',1,'labelName1');
//       // insert into languages_mst (multilingual_key, country_division, label_name) values ('test2',2,'labelName2');
//       // insert into languages_mst (multilingual_key, country_division, label_name) values ('test3',3,'labelName3');
//       try{
//         var dbAccess = DbManipulationPs();
//
//         // データ読み込み
//         List<LanguagesData> lstRtn = [];
//         List<Map<String, Map<String, dynamic>?>> result;
//         String sql1 = "select * from languages_mst";
//         result = await dbAccess.dbCon.mappedResultsQuery(sql1);
//
//         if (result.isEmpty) {
//           print('多言語マスタは空');
//         } else {
//           // 必要な部分だけを抽出
//           for(int i = 0; i < result.length; i++ ){
//             String mkey = result[i]["languages_mst"]?["multilingual_key"];
//             int country = result[i]["languages_mst"]?["country_division"];
//             String name = result[i]["languages_mst"]?["label_name"];
//             lstRtn.add(LanguagesData(
//                 multilingual_key: mkey,
//                 country_division: country,
//                 label_name: name));
//
//             print("lstRtnの中身：${lstRtn[i].multilingual_key}");
//             print("lstRtnの中身：${lstRtn[i].country_division}");
//             print("lstRtnの中身：${lstRtn[i].label_name}");
//           }
//         }
//
//
//       }catch(e){
//         print('\n********** 異常発生：00209_l_languagedbcall_2 **********');
//       }
//
//       print('********** テスト終了：00209_l_languagedbcall_2 **********\n\n');
//
//     });
//     /*testここに挿入*/
//     /*　00203_recog_db_03 はデータ削除があるのでうしろにおいておく*/
//     test('00203_recog_db_03', () async {
//       //test用データ
//       print('\n********** テスト実行：00203_recog_db_03 **********');
//       try{
//         DbManipulationPs db = DbManipulationPs();
//
//         //更新test確認用
//         String testsql1_1 = "select recog_set_flg from p_recog_mst where recog_set_flg = 1";
//         List<Map<String, Map<String, dynamic>?>> dataList1_1;
//         dataList1_1 = await db.dbCon.mappedResultsQuery(testsql1_1);
//         print("更新前のp_recog_mst：$dataList1_1");
//
//         // 承認キーのデータを初期化する.
//         // 全てのデータのrecog_set_flgを0へ.
//         String update_sql = "update p_recog_mst set recog_set_flg = 0 ";
//         await db.dbCon.query(update_sql);
//
//         //更新test確認用
//         List<Map<String, Map<String, dynamic>?>> dataList1_2;
//         dataList1_2 = await db.dbCon.mappedResultsQuery(testsql1_1);
//         print("更新後のp_recog_mst：$dataList1_2");
//
//
//         //削除test確認用
//         String testsql2_1 = "select emergency_type from c_recoginfo_mst";
//         List<Map<String, Map<String, dynamic>?>> dataList2_1;
//         dataList2_1 = await db.dbCon.mappedResultsQuery(testsql2_1);
//         print("削除前のc_recoginfo_mst：$dataList2_1");
//
//         // 承認キー情報マスタを全削除する.
//         String delete_sql = "delete from c_recoginfo_mst";
//         await db.dbCon.query(delete_sql); // where文なし実行で全削除.
//
//         List<Map<String, Map<String, dynamic>?>> dataList2_2;
//         dataList2_2 = await db.dbCon.mappedResultsQuery(testsql2_1);
//         print("削除後のc_recoginfo_mst：$dataList2_2");
//
//       }catch(e){
//         print('\n********** 異常発生：00203_recog_db_03 **********');
//       }
//       print('********** テスト終了：00203_recog_db_03 **********\n\n');
//     });
//   });
// }
//
// class SioTokTbl {
//   /// 接続デバイス名（セクション日本語タイトルに相当）
//   String device;
//   /// ボーレート（sioBaudTblの要素数: c_regcnct_sio_mst - sio_rate）
//   int baud;
//   /// ストップビット（sioStopbTblの要素数: c_regcnct_sio_mst - sio_stop）
//   int stopB;
//   /// ストップビット（sioDatabTblの要素数: c_regcnct_sio_mst - sio_record）
//   int dataB;
//   /// パリティ（sioPariTblの要素数: c_regcnct_sio_mst - sio_parity）
//   int parity;
//
//   SioTokTbl(this.device, {this.baud = -1, this.stopB = -1, this.dataB = -1, this.parity = -1});
// }
//
// class SioSectTbl {
//   /// ドライバセクション名（c_sio_mst - drv_sec_name）
//   String sectionName = '';
//   /// セクション日本語タイトル（c_img_mst - img_data）
//   String titleName = '';
// }
//
// class CmCksys {
// static bool cmWebplus2System() {
// return TprxPlatform.getFile("/etc/aaeon_atom_smhd.json").existsSync();
// }
// }
//
// class TprxPlatform {
//   static bool isDesktop =
//     (Platform.isLinux || Platform.isMacOS || Platform.isWindows);
//   static File getFile(String path){
//     return  File(getPlatformPath(path));
//   }
//
//   /// プラットフォームに合わせたパスに直す.
//   static getPlatformPath(String path) {
//     if(Platform.isAndroid){ //Androidは自アプリ内のフォルダへアクセスさせる.
//       if(path.isNotEmpty && path[0] == "/"){
//         // 絶対パスが指定されている場合、相対パスに直す.
//         path = path.substring(1);
//       }
//       return join(AppPath().path, path);
//     }
//     return path;
//   }
// }
//
// class LanguagesData {
//   final multilingual_key;
//   final country_division;
//   final label_name;
//
//   const LanguagesData(
//       {required this.multilingual_key,
//         required this.country_division,
//         required this.label_name});
//
//   factory LanguagesData.fromMap(Map<String, dynamic> map) => LanguagesData(
//     multilingual_key: map['multilingual_key'],
//     country_division: map['country_division'],
//     label_name: map['label_name'],
//   );
//
//   Map<String, dynamic> toMap() => {
//     'multilingual_key': multilingual_key,
//     'country_division': country_division,
//     'label_name': label_name,
//   };
// }
