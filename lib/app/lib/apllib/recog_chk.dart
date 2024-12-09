/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/sys/tpr_type.dart';
import '../../../../../../postgres_library/src/db_manipulation_ps.dart';

import '../../inc/sys/tpr_log.dart';

/// 承認キーチェック処理.
/// 関連tprxソース: recog_chk.c
class RecogChk{


  /// 指定のページの緊急承認キータイプを返す.
  /// 関連tprxソース: recog_chk.c - recog_get_DB_dtl()
  static Future<(bool, String)> recogGetDBDtl(TprTID tid ,int page) async {
    // 0を18個
    String recogData = 0.toString().padLeft(18, "0");
    try{
      TprLog().logAdd(tid, LogLevelDefine.normal,
          "recogGetDBDtl(): page = $page");

      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(tid, LogLevelDefine.error, " rxMemRead RXMEM_COMMON get error\n" );
        return (false,recogData);
      }
      RxCommonBuf pCom = xRet.object;
      // 承認キー対象レコード取得SQL実行
      var db = DbManipulationPs();


      String sql1 = "select emergency_type from c_recoginfo_mst where comp_cd = @p1 and stre_cd = @p2 and mac_no = @p3 and page = @p4";
      Map<String, dynamic>? subValues = {"p1" : pCom.iniMacInfoCrpNoNo,"p2" : pCom.iniMacInfoShopNo,"p3" : pCom.iniMacInfoMacNo,"p4" : page};
      Result result = await db.dbCon.execute(Sql.named(sql1),parameters:subValues);
      if(result.isEmpty){
        TprLog().logAdd(tid, LogLevelDefine.error,
            "recogGetDBDtl(): c _recoginfo_mst query RECOG_SQL_RECOGINFO_GET result no data",errId: -1);
        return (false,recogData);
      }
      Map<String,dynamic> data = result.first.toColumnMap();
      recogData = data["emergency_type"] ?? "";
      return (true,recogData);

    }catch(e,s){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "recogGetDBDtl(): c_recoginfo_mst query  error $e,$s",errId: -1);
      return (false,recogData);
    }

  }
}