/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cls_conf/mac_infoJsonFile.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';

import '../../../postgres_library/src/pos_basic_table_access.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'recog.dart';
import 'rx_prt_flag_set.dart';
/// 承認キーDB操作クラス.
/// 関連tprxソース: recog_db.h,recog_db.dart
class RecogDB {
  /// 承認キーのDBの数.
  static const 	RECOG_SQL_RECOGINFO_DB_NUM =64;
  /// 承認キーのページのデータを取得する.
  /// 関連tprxソース: recog_db.h-RECOG_SQL_RECOGINFO_EXIST
  static const 	RECOG_SQL_RECOGINFO_EXIST =
      "SELECT page FROM c_recoginfo_mst "
      "WHERE comp_cd = @comp AND stre_cd = @stre AND mac_no = @mac AND (page>=1 AND page<=@DBNum);";

	/// 承認状態設定
  /// 関連tprxソース: recog_db.h-RECOG_SQL_RECOG_SET
  static const RECOG_SQL_RECOG_SET = "update p_recog_mst set "
				"recog_set_flg = @recogsetflg "
				"where page = @page and posi = @posi and recog_set_flg <> @recogsetflg;";

  /// 承認状態設定(DB) 処理
  /// 関連tprxソース:recog_db.c　recog_set_DB()
  static Future<RecogValue> RecogSetDB(
      TprTID tid, RecogLists recogNum, RecogValue value) async {
    // 承認キー 参照用情報取得
    var (retValue, refInfo) = await Recog().getRefInfo(recogNum,  true);
    switch(retValue){
      case RefInfoRet.ERROR: // エラー
        TprLog().logAdd(tid, LogLevelDefine.error,  "RecogSetDB() error ${recogNum.name}",errId: -1);
        return RecogValue.RECOG_NO;
      case RefInfoRet.RECOG_NUM_ERROR:// 承認キーなし.
        TprLog().logAdd(tid, LogLevelDefine.error,  "RecogSetDB() unknown recog_num error${recogNum.name}",errId: -1);
        return RecogValue.RECOG_NO;
      case RefInfoRet.NOT_USE:// 承認キーなし.
        return RecogValue.RECOG_NO;
      default:
        break;
    }

    int page = refInfo.page;
    int func = refInfo.func;

    if((page < 1) || (page > RxMbrAtaChk.RECOG_PAGE_MAX) ||
        (func < 1) || (func > RxMbrAtaChk.RECOG_FUNC_MAX)){
      if(!((page == 1) && ((func == 19) || (func == 20)))) {
          TprLog().logAdd(tid, LogLevelDefine.normal,  "RecogSetDB() : page[$page] func[$func] error recog_num ${recogNum.name}");
          return RecogValue.RECOG_NO;
      }
    }

    bool ret = await recogSetDBDtl(tid,  page, func, value);
    if(!ret){
       return RecogValue.RECOG_NO;
    }
    return RecogValue.RECOG_YES;
  }

  /// 承認状態設定(DB) 詳細処理
  /// 関連tprxソース:recog_db.c　recog_set_DB_dtl()
  static Future<bool> recogSetDBDtl(TprTID tid, int page,int posi ,RecogValue recogSetFlg) async {
    TprLog().logAdd(tid, LogLevelDefine.normal,  "recogSetDBDtl() page = $page / position = $posi / recog_set_flg = $recogSetFlg ");

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, " rxMemRead RXMEM_COMMON get error\n" );
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    // 承認キーマスタ
    int flg = 0;
    if(recogSetFlg != RecogValue.RECOG_NO){
      flg = 1;
    }
    DbManipulationPs db = DbManipulationPs();

    // 承認キー更新対象レコード取得SQL実行し、recordが存在することを確認.
    PRecogMst mst = PRecogMst();
    mst.page = page;
    mst.posi = posi;
    try{

      String sql1 = "select * from p_recog_mst where page = @page and posi = @posi";
      Map<String, dynamic>? subValues1 = {"page" : page, "posi" : posi};
      Result result1 =await db.dbCon.execute(Sql.named(sql1),parameters: subValues1);

      if(result1 == null){
        // recordが存在しないのでNG.
        TprLog().logAdd(tid, LogLevelDefine.error,  "recogSetDBDtl() p_recog_mst no target data",errId: -1);
        return false;
      }
      // p_recog_mstのrecog_set_flgに承認キー種別(なし/承認/緊急/強制)を設定するようにする
      String update_sql1 = "update p_recog_mst set recog_set_flg = @flg "
          "where page = @page and posi = @posi and recog_set_flg <> @flg";
      Map<String, dynamic>? updateSubValues1 = {
        "page" : page,
        "posi" : posi,
        "flg"  : recogSetFlg.index
      };
      await db.dbCon.execute(Sql.named(update_sql1), parameters: updateSubValues1);

      String sql2 = "select emergency_type from c_recoginfo_mst "
          "where comp_cd = @comp and mac_no = @mac and stre_cd = @stre and page = @page";
      Map<String, dynamic>? subValues2 = {
        "comp" : pCom.iniMacInfoCrpNoNo,
        "mac"  : pCom.iniMacInfoMacNo,
        "stre" : pCom.iniMacInfoShopNo,
        "page" : page
      };
      Result result2 = await db.dbCon.execute(Sql.named(sql2), parameters: subValues2);
      if(result2 == null){
        // recordが存在しないのでNG.
        TprLog().logAdd(tid, LogLevelDefine.error,  "recogSetDBDtl() c_recoginfo_mst  no target data",errId: -1);
        return false;
      }
      Map<String,dynamic> data = result2.first.toColumnMap();
      String typeOld = data["emergency_type"] ?? "".padLeft(18, "0");
      List<String> typeOldList =typeOld.split("");
      String typeNew ="";
      // 承認キータイプの編集
      for (int i = 0; i < 18; i++) {
        if ((i + 1) == posi) {
          String buf = recogSetFlg.index.toString();
          typeNew += buf[0];
        } else {
          typeNew += typeOldList[i];
        }
      }

      //承認キー更新SQL実行
      // p_recog_mstのrecog_set_flgに承認キー種別(なし/承認/緊急/強制)を設定するようにする
      String update_sql2 = "update c_recoginfo_mst set emergency_type = @typeNew "
          "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and page = @page";
      Map<String, dynamic>? updateSubValues2 = {
        "typeNew" : typeNew,
        "comp" : pCom.iniMacInfoCrpNoNo,
        "stre" : pCom.iniMacInfoShopNo,
        "mac" : pCom.iniMacInfoMacNo,
        "page" : page
      };
      await db.dbCon.execute(Sql.named(update_sql2), parameters: updateSubValues2);
      return true;

    }catch(e,s){
      TprLog().logAdd(tid, LogLevelDefine.error,  "recogSetDBDtl() db error $e,$s",errId: -1);
      return false;
    }
  }

  /// 承認キー情報マスタのチェック
  /// 関連tprxソース:recog_db.c　recoginfo_db_chk()
  static Future<bool> recoginfoDbCheck(TprTID tid) async {
    TprLog().logAdd(tid, LogLevelDefine.normal,  "recoginfoDbCheck()");
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "recoginfoDbCheck(): SystemFunc.rxMemRead[RXMEM_COMMON]");
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macJson = pCom.iniMacInfo;
    if( macJson.system.macno  == 0 || macJson.system.shpno == 0 || macJson.system.crpno  == 0  ){
      // 設定ファイルに値が設定されていないならNG.
      TprLog().logAdd(tid, LogLevelDefine.normal,
          "recoginfoDbCheck() jsonSetting error macNo:${macJson.system.macno },streCd:${macJson.system.shpno } compCd:${macJson.system.crpno}");
      return false;
    }
    DbManipulationPs db = DbManipulationPs();
    String exitSql = RECOG_SQL_RECOGINFO_EXIST;
    try{

      Map<String, dynamic>? subValues = {
        "comp" : macJson.system.crpno,
        "stre" : macJson.system.shpno,
        "mac"  : macJson.system.macno,
        "DBNum": RECOG_SQL_RECOGINFO_DB_NUM
      };
      Result dataList=  await db.dbCon.execute(Sql.named(exitSql), parameters: subValues);
      //  対象レコード取得確認(:該当レコード無し=NGとする)
      if(dataList.length < RECOG_SQL_RECOGINFO_DB_NUM){
        // 承認キーデータを読み込む.
        List<String> vList = ["COMP=${macJson.system.crpno}","STRE=${macJson.system.shpno}","MACNO=${macJson.system.macno}"];
        String err =  await db.execSqlFromAsset("assets/sql/insert/mm_recoginfomst.out", vList);
        if(err.isNotEmpty){
          throw(err);
        }
        TprLog().logAdd(tid, LogLevelDefine.normal,
            "recoginfoDbCheck(): c_recoginfo_mst insert");
      }
    }catch(e,s){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "recoginfoDbCheck(): db_PQexec() c_recoginfo_mst read error $e,$s");
      return false;
    }
    return true;
  }
  /// 承認状態初期化(DB)
  /// 関連tprxソース:recog_db.c　recog_init_DB()
  static Future<void> recogInitDB(TprTID tid) async {
    try{
      DbManipulationPs db = DbManipulationPs();

      // 承認キーのデータを初期化する.
      // 全てのデータのrecog_set_flgを0へ.
      String update_sql = "update p_recog_mst set recog_set_flg = 0 ";
      await db.dbCon.execute(update_sql);

      // 承認キー情報マスタを全削除する.
      String delete_sql = "delete from c_recoginfo_mst";
      await db.dbCon.execute(delete_sql); // where文なし実行で全削除.

    }catch(e,s){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "recogInitDB(): db_PQexec() error $e,$s");
    }
  }

  /// 機能概要     : 承認キーマスタの更新(DB) 処理
  /// パラメータ   : tid: タスクID
  ///             : recogNum: 承認キー区分番号
  ///             : value: 設定値値
  /// 戻り値       : 1以上: 正常終了
  ///             : 0: 異常終了
  /// 関連tprxソース:recog_db.c - recog_set_DB_AppMst()
  static Future<RecogValue> recogSetDBAppMst(TprMID tid,  RecogLists recogNum, RecogValue value) async {
    String erlog = "";
    int	page = -1;
    int	func = -1;
    int	ret = Typ.NG;
    RecogRefInfo recogRefInfo = RecogRefInfo();
    RefInfoRet refInfoRet;

    // 承認キー 参照用情報取得
    (refInfoRet, recogRefInfo) = await Recog().getRefInfo(recogNum, true);
    switch (refInfoRet)
    {
      case RefInfoRet.ERROR:	// エラー
        erlog = "recogSetDBAppMst(): error[$recogNum]";
        TprLog().logAdd(tid, LogLevelDefine.error, erlog, errId: -1);
        return RecogValue.RECOG_NO;

      case RefInfoRet.RECOG_NUM_ERROR:	// 承認キーなし
        erlog = "recogSetDBAppMst(): unknown recog_num error[$recogNum]";
        TprLog().logAdd(tid, LogLevelDefine.error, erlog, errId: -1);
        return RecogValue.RECOG_NO;

      case RefInfoRet.NOT_USE:	// 未使用
        return RecogValue.RECOG_NO;
      default:	// 正常
        break;
    }

    // 構造体からデータ取り出し
    page = recogRefInfo.page;
    func = recogRefInfo.func;

    if((page < 1) || (page > RxMbrAtaChk.RECOG_PAGE_MAX) ||
      (func < 1) || (func > RxMbrAtaChk.RECOG_FUNC_MAX)) {
      if(!((page == 1) && ((func == 19) || (func == 20)))) {
        erlog = "recogSetDBAppMst(): page[$page] func[$func] error recog_num[$recogNum]";
        TprLog().logAdd(tid, LogLevelDefine.normal, erlog, errId: -1);
        return RecogValue.RECOG_NO;
      }
    }

    ret = await recogSetDBAppMstDtl(tid, page, func, value.index);
    if(ret == Typ.NG){
      return RecogValue.RECOG_NO;
    }

    return RecogValue.RECOG_YES;
  }

  /// 機能概要     : 承認キーマスタの更新(DB) 詳細処理
  /// パラメータ   : tid: TID
  ///             : page: 承認キーページ
  ///             : posi: 承認キー位置
  ///             : recogSetFlg: 設定値(0:未承認／1:承認)
  /// 戻り値       : 1以上: 正常終了
  ///             : 0: 異常終了
  /// 関連tprxソース:recog_db.c - recog_set_DB_AppMst_dtl()
  static Future<int> recogSetDBAppMstDtl(TprTID tid, int page, int posi, int recogSetFlg) async {
    String logBuf = "";
    int nResult = Typ.NG;
    DbManipulationPs db = DbManipulationPs();

    if (recogSetFlg != 0) {
      logBuf = "recogSetDBAppMstDtl(): page = $page / position = $posi / recog_set_flg = $recogSetFlg";
      TprLog().logAdd(tid, LogLevelDefine.normal, logBuf);
    }

    /* 承認キー更新SQL実行 */
    // p_recog_mstのrecog_set_flgに承認キー種別(なし/承認/緊急/強制)を設定するようにする
    Map<String, dynamic>? subValues = {
      "recogsetflg": recogSetFlg,
      "page": page,
      "posi": posi
    };

    await db.dbCon.runTx((txn) async {
      try {
        await txn.execute(Sql.named(RECOG_SQL_RECOG_SET), parameters: subValues);
        nResult = Typ.OK;
      } catch (e, s) {
        logBuf = "recogSetDBAppMstDtl(): db error $e,$s";
        TprLog().logAdd(tid, LogLevelDefine.error, logBuf, errId: -1);
        txn.rollback();
        nResult = Typ.NG;
      }
    });

    return nResult;
  }

}
