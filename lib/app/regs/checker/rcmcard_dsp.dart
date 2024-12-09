/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../db_library/src/db_manipulation.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import 'rcsyschk.dart';

class RcMcardDsp {
  /// ゴダイ会員番号判別用データ
  static List<String?> godaiMbrcdTbl = [
    "211",	/* 従業員証1 */
    "212",	/* 従業員証2 */
    "222",	/* でんでんカード */
    "223",	/* でんでんプリカ */
    "224",	/* 売掛カード */
    null
  ];

  /// ターミナルに「会員カード判定マスタでのチェックあり」の場合、会員番号をチェックし結果を返す
  /// 引数: 会員番号
  /// 戻り値: true=有効な番号  false=無効な番号
  /// 関連tprxソース: rcmcard_dsp.c - rcMember_Chk_MbrCardMst
  static Future<bool> rcMemberChkMbrCardMst(String mbrCd) async {
    bool ret = true;
    CMbrcardMstColumns mbrCardMst = CMbrcardMstColumns();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    /* ターミナル「会員カード判定マスタを利用して、入力番号が有効かチェック」*/
    if (cBuf.dbTrm.checkMbrcardmstUse == 1) {  // チェック必要
      // 会員カード判定マスタから会員番号に一致するレコードを検索
      ret = await rcMemberGetMbrCardMst(mbrCd, mbrCardMst);
    }
    else if (cBuf.dbTrm.checkMbrcardmstUse == 0) {  // チェックしない
      ret = await rcMemberChkMbrCode(mbrCd);
    }

    return ret;
  }

  /// 有効な会員番号か判定する
  /// 引数: 会員番号
  /// 戻り値: true=有効会員  false=無効会員
  /// 関連tprxソース: rcmcard_dsp.c - rcMember_Chk_MbrCode
  static Future<bool> rcMemberChkMbrCode(String mbrCd) async {
    bool ret = true;

    if (await CmCksys.cmDs2GodaiSystem() != 0) {
      ret = false;
      for (int i = 0; (godaiMbrcdTbl[i] != null); i++) {
        // 先頭３桁チェック
        if (mbrCd.substring(0, 3) == godaiMbrcdTbl[i]) {
          ret = true;
          break;
        }
      }
    }
    return ret;
  }

  /// 会員カード判定マスタから会員番号に一致するレコードを取得する
  /// 引数:[mbrCd] 会員番号
  /// 引数:[pRecord] 会員カードマスタ
  /// 戻り値: true=対象データあり  false=対象データなし
  /// 関連tprxソース: rcmcard_dsp.c - rcMember_Get_MbrCardMst
  static Future<bool> rcMemberGetMbrCardMst(String mbrCd, CMbrcardMstColumns? pRecord) async {
    String callFunc = "RcMcardDsp.rcMemberGetMbrCardMst()";
    if ((mbrCd == "") || (pRecord == null)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: param ERROR");
      return false;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    DbManipulationPs db = DbManipulationPs();
    String sql = "SELECT * FROM c_mbrcard_mst WHERE comp_cd='${cBuf.dbRegCtrl.compCd}' AND code_from<='$mbrCd' AND code_to>='$mbrCd' ORDER BY seq_no LIMIT 1;";

    // レジ内のDBへ接続
    try {
      Result? dbRes = await db.dbCon.execute(sql);
      if (dbRes.affectedRows >= 1) {
        // データ取得
        Map<String, dynamic> data = dbRes.first.toColumnMap();
        pRecord.seq_no 	= int.parse(data["seq_no"] ?? "0");  // レコードID
        pRecord.comp_cd	= int.parse(data["comp_cd"] ?? "0");	// 企業コード
        pRecord.code_from = data["code_from"];  // 番号体系 (From)
        pRecord.code_to = data["code_to"];  // 番号体系 (To)
        pRecord.c_data1 = data["c_data1"];  // 文字データ1
        pRecord.c_data1 = data["c_data2"];  // 文字データ2
        pRecord.c_data1 = data["c_data3"];  // 文字データ3
        pRecord.s_data1 = int.parse(data["s_data1"] ?? "0");  // フラグデータ1
        pRecord.s_data2 = int.parse(data["s_data2"] ?? "0");  // フラグデータ2
        pRecord.n_data1 = int.parse(data["n_data1"] ?? "0");  // 数字データ1
        pRecord.n_data2 = int.parse(data["n_data2"] ?? "0");  // 数字データ2
        pRecord.ins_datetime = data["ins_datetime"];
        pRecord.upd_datetime = data["upd_datetime"];
        pRecord.status = int.parse(data["status"] ?? "0");
        pRecord.send_flg = int.parse(data["send_flg"] ?? "0");
        pRecord.upd_user = int.parse(data["upd_user"] ?? "0");
        pRecord.upd_system = int.parse(data["upd_system"] ?? "0");
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: db_PQexec ERROR. SQL=$sql");
      return false;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: mbrcd=$mbrCd");
    return true;
  }
}