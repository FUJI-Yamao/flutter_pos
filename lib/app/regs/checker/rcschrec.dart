/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_pastcompfile.dart';
import 'package:flutter_pos/app/lib/apllib/qr2txt.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
import 'package:get/get.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../inc/rc_mem.dart';
import 'rc_voidupdate.dart';
import 'rcsyschk.dart';
import 'regs.dart';

///  関連tprxソース: rcschrec.c
class RcSchRec {
  /// 訂正実績検索
  static const VOIDLOGSQL_VOIDKIND_CHK_VOID = "void_kind IN('0','1')";
  /// 領収書実績検索
  static const VOIDLOGSQL_VOIDKIND_CHK_RFM = "void_kind = '3'";
  /// DB接続フラグ
  static var voidTsCon = null;
  /// 接続先ステータス保持用変数
  static int pastCompChkServer = VoidupDbLoginStatus.VOIDUP_LOGIN_ERROR.stts;

  /// 取引を検索するSQLをセットする
  /// 引数:[fncCode] ファンクションコード
  /// 引数:[date] トータルログの日付
  /// 引数:[macNo] マシン番号
  /// 引数:[recNo] レシート番号
  /// 引数:[prtNo] プリント番号
  /// 引数:[saleDate] 営業日
  /// 引数:[ttlAmt] 金額
  /// 戻値:SQL文（TSサーバー用とローカル用の2種類を返す）
  ///  関連tprxソース: rcschrec.c - rcSch_DB_MkSql
  static (String, String) rcSchDBMkSql(
      FuncKey fncCode, String date, int macNo, int recNo, int prtNo,
      String saleDate, int ttlAmt) {
    String retTsSql = "";
    String retLocalSql = "";

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (retTsSql, retLocalSql);
    }
    RxCommonBuf cBuf = xRet.object;

    String prnTyp = "(prn_typ='0' or prn_typ ='115')";
    switch (fncCode) {
      case FuncKey.KY_EVOID:
        prnTyp = "prn_typ IN ('0', '5', '6', '7', '8', '115')";
        break;
      case FuncKey.KY_RCPT_VOID:
        if (RcSysChk.rcCheckRcptBarItem()) {
          prnTyp = "((prn_typ='0' or prn_typ ='115') and inout_flg='0')";
        }
        break;
      default:
        break;
    }

    String opeModeFlg = "and ope_mode_flg IN ('${OpeModeFlagList.OPE_MODE_REG}', '${OpeModeFlagList.OPE_MODE_TRAINING}', '${OpeModeFlagList.OPE_MODE_VOID}'";
    if ((fncCode == FuncKey.KY_EREF)
        || (fncCode == FuncKey.KY_RFDOPR)
        || (fncCode == FuncKey.KY_RCPT_VOID)) {
      opeModeFlg += ", '${OpeModeFlagList.OPE_MODE_SCRAP}'";
    }
    opeModeFlg += ", '${OpeModeFlagList.OPE_MODE_REG_QC_SPLIT}', '${OpeModeFlagList.OPE_MODE_REG_SP_TCKT}', '${OpeModeFlagList.OPE_MODE_TRAINING_QC_SPLIT}', '${OpeModeFlagList.OPE_MODE_TRAINING_SP_TCKT}')";

    String strRecNo = rcSchMakeRecNo(recNo, cBuf);

    if (!RcSysChk.rcCheckRcptBarItem()
        && (!((RcSysChk.rcSysChkDetailNoprnSystem() == 1)
            && (fncCode == FuncKey.KY_ERCTFM)))) {
      switch (fncCode) {
        case FuncKey.KY_CHGTRAN:
          retTsSql = "SELECT * FROM c_header_log$date where"
              " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
              " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
              " mac_no='$macNo' and"
              " $strRecNo and"
              " sale_date='$saleDate'"
              " $opeModeFlg;\n";
          retLocalSql = "SELECT * FROM c_header_log where"
              " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
              " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
              " mac_no='$macNo' and"
              " $strRecNo and"
              " sale_date='$saleDate'"
              " $opeModeFlg;\n";
          break;
        case FuncKey.KY_CRDTVOID:
          retTsSql = "SELECT * FROM c_header_log$date where"
              " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
              " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
              " mac_no='$macNo' and"
              " $strRecNo and"
              " sale_date='$saleDate' and"
              " $prnTyp and"
              " inout_flg='0'"
              " $opeModeFlg;\n";
          retLocalSql = "SELECT * FROM c_header_log where"
              " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
              " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
              " mac_no='$macNo' and"
              " $strRecNo and"
              " sale_date='$saleDate' and"
              " $prnTyp and"
              " inout_flg='0'"
              " $opeModeFlg;\n";
          break;
        case FuncKey.KY_RCPT_VOID:
        case FuncKey.KY_RFDOPR:
          String tmpTsSql = "SELECT * FROM c_header_log$date header"
              " INNER JOIN (select serial_no FROM c_data_log$date where func_cd='100001' and n_data25 = '$ttlAmt' order by serial_no desc) as data"
              " ON header.serial_no = data.serial_no"
              " INNER JOIN (select serial_no FROM c_status_log$date where func_cd='100001' and (regexp_split_to_array(status_data, '\t'))[1]!='0') as status"
              " ON header.serial_no = status.serial_no"
              " where"
              " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
              " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
              " mac_no='$macNo' and"
              " $strRecNo and"
              " sale_date='$saleDate' and"
              " $prnTyp and"
              " inout_flg='0'"
              " $opeModeFlg";
          String tmpLocalSql = "SELECT * FROM c_header_log header"
              " INNER JOIN (select serial_no FROM c_data_log where func_cd='100001' and n_data25 = '$ttlAmt' order by serial_no desc) as data"
              " ON header.serial_no = data.serial_no"
              " INNER JOIN (select serial_no FROM c_status_log where func_cd='100001' and (regexp_split_to_array(status_data, '\t'))[1]!='0') as status"
              " ON header.serial_no = status.serial_no"
              " where"
              " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
              " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
              " mac_no='$macNo' and"
              " $strRecNo and"
              " sale_date='$saleDate' and"
              " $prnTyp and"
              " inout_flg='0'"
              " $opeModeFlg";
          if (fncCode == FuncKey.KY_RCPT_VOID) {	// 通番訂正
            // 入出金系もここで検索
            retTsSql = "($tmpTsSql) union ("
                "SELECT * FROM c_header_log$date header"
                " INNER JOIN (select serial_no FROM c_header_log$date) as data"
                " ON header.serial_no = data.serial_no"
                " INNER JOIN (select serial_no FROM c_header_log$date) as status"
                " ON header.serial_no = status.serial_no"
                " where"
                " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
                " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
                " mac_no='$macNo' and"
                " $strRecNo and"
                " sale_date='$saleDate' and"
                " inout_flg IN ('2','3','4','5')"
                " $opeModeFlg);\n";
            retLocalSql = "($tmpLocalSql) union ("
                "SELECT * FROM c_header_log header"
                " INNER JOIN (select serial_no FROM c_header_log) as data"
                " ON header.serial_no = data.serial_no"
                " INNER JOIN (select serial_no FROM c_header_log) as status"
                " ON header.serial_no = status.serial_no"
                " where"
                " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
                " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
                " mac_no='$macNo' and"
                " $strRecNo and"
                " sale_date='$saleDate' and"
                " inout_flg IN ('2','3','4','5')"
                " $opeModeFlg);\n";
          } else {
            retTsSql = "$tmpTsSql;\n";
            retLocalSql = "$tmpLocalSql;\n";
          }
          break;
        default:
          retTsSql = "SELECT * FROM c_header_log$date header inner join"
              " (select serial_no FROM c_data_log$date where func_cd='100001' and n_data25 = '$ttlAmt' order by serial_no desc) as data"
              " ON header.serial_no = data.serial_no where"
              " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
              " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
              " mac_no='$macNo' and"
              " $strRecNo and"
              " sale_date='$saleDate' and"
              " $prnTyp and"
              " inout_flg='0'"
              " $opeModeFlg;\n";
          retLocalSql = "SELECT * FROM c_header_log header inner join"
              " (select serial_no FROM c_data_log where func_cd='100001' and n_data25 = '$ttlAmt' order by serial_no desc) as data"
              " ON header.serial_no = data.serial_no where"
              " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
              " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
              " mac_no='$macNo' and"
              " $strRecNo and"
              " sale_date='$saleDate' and"
              " $prnTyp and"
              " inout_flg='0'"
              " $opeModeFlg;\n";
          break;
      }
    } else {
      retTsSql = "SELECT * FROM c_header_log$date where"
          " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
          " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
          " mac_no='$macNo' and"
          " $strRecNo and"
          " sale_date='$saleDate' and"
          " $opeModeFlg";
      retLocalSql = "SELECT * FROM c_header_log where"
          " comp_cd='${cBuf.dbRegCtrl.compCd}' and"
          " stre_cd='${cBuf.dbRegCtrl.streCd}' and"
          " mac_no='$macNo' and"
          " $strRecNo and"
          " sale_date='$saleDate' and"
          " $opeModeFlg";
      if (fncCode == FuncKey.KY_RCPT_VOID) {  // 通番訂正
        retTsSql += " and ($prnTyp or (inout_flg IN ('2','3','4','5')))";
        retLocalSql += " and ($prnTyp or (inout_flg IN ('2','3','4','5')))";
      } else if (fncCode != FuncKey.KY_CHGTRAN) {
        retTsSql += " and $prnTyp and inout_flg='0'";
        retLocalSql += " and $prnTyp and inout_flg='0'";
      }
      retTsSql += " order by serial_no desc;\n";
      retLocalSql += " order by serial_no desc;\n";
    }

    return (retTsSql, retLocalSql);
  }

  /// 取引を検索するSQLをセットする
  /// 引数:[recNo] レシート番号
  /// 引数:[cBuf] 共有クラス"RxCommonBuf"
  /// 戻値:レシート番号を組み込んだSQLの一部
  ///  関連tprxソース: rcschrec.c - rcSch_Make_recno
  static String rcSchMakeRecNo(int recNo, RxCommonBuf cBuf) {
    String ret = "";
    if ((cBuf.dbTrm.journalnoPrn == 0) && (cBuf.dbTrm.recieptnoPrn == 1)) {
      ret = "print_no='$recNo'";
    } else {
      ret = "receipt_no='$recNo'";
    }

    if (RcSysChk.rcCheckRcptBarItem()) {
      AcMem cMem = SystemFunc.readAcMem();
      if ((cBuf.dbTrm.journalnoPrn == 0) && (cBuf.dbTrm.recieptnoPrn == 1)) {
        ret += " and receipt_no='${cMem.rcptBar.receiptNo}'";
      } else {
        ret += " and print_no='${cMem.rcptBar.printNo}'";
      }
    }

    return ret;
  }

  /// 指定シリアルNoがテーブルに登録されているかチェックする
  /// 引数:[serialNo] シリアルNo
  /// 引数:[tableDateName] テーブル名に付与される日付
  /// 戻値: 0=データあり  0以外=エラーNo
  ///  関連tprxソース: rcschrec.c - rcCheck_VoidRec
  static Future<int> rcCheckVoidRec(
      String serialNo, String? tableDateName) async {
    return await rcCheckVoidRecMain(serialNo, tableDateName, 0);
  }

  /// 指定シリアルNoがテーブルに登録されているかチェックする（メイン関数）
  /// 引数:[serialNo] シリアルNo
  /// 引数:[tableDateName] テーブル名に付与される日付
  /// 引数:[tyo] 免税フラグ
  /// 戻値: 0=データあり  0以外=エラーNo
  ///  関連tprxソース: rcschrec.c - rcCheck_VoidRec_Main
  static Future<int> rcCheckVoidRecMain(
      String serialNo, String? tableDateName, int typ) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCheckVoidRecMain(): serialNo[$serialNo] typ[$typ]");

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON).isInvalid()");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    String colChk = "";
    String lcolChk = "";
    if (typ == 1) {
      colChk = "void_taxfree_no = '$serialNo'";
      lcolChk = "various_data = '$serialNo'";
    } else {
      colChk = "void_serial_no = '$serialNo'";
      lcolChk = "void_serial_no = '$serialNo'";
    }

    String voidCkSql = "";
    String tsVoidCkSql = "";
    Map<String, dynamic>? tsSubValues;
    Map<String, dynamic>? subValues;
    //追加
    String comp;
    String stre;
    String chk;
    String kind;
    if (CmCksys.cmMmSystem() == CmSys.MacERR) {
      comp = "${cBuf.dbRegCtrl.compCd}".padLeft(9, "0");
      stre = "${cBuf.dbRegCtrl.streCd}".padLeft(9, "0");
      chk = colChk;
      kind = VOIDLOGSQL_VOIDKIND_CHK_VOID;
      tsVoidCkSql = "select * from c_void_log_01_${comp}_${stre} where ${chk} AND ${kind};";
      tsSubValues = {};
      // tsVoidCkSql =
      //     "select * from c_void_log_01_@comp_@stre where @chk AND @kind;";
      // tsSubValues = {
      //   "comp" : "${cBuf.dbRegCtrl.compCd}".padLeft(9, "0"),
      //   "stre" : "${cBuf.dbRegCtrl.streCd}".padLeft(9, "0"),
      //   "chk"  : colChk,
      //   "kind" : VOIDLOGSQL_VOIDKIND_CHK_VOID
      // };
    } else {
      chk = colChk;
      kind = VOIDLOGSQL_VOIDKIND_CHK_VOID;
      tsVoidCkSql = "select * from c_void_log_01 where ${chk} AND ${kind};";
      tsSubValues = {};
      // tsVoidCkSql = "select * from c_void_log_01 where @chk AND @kind;";
      // tsSubValues = {
      //   "chk"  : colChk,
      //   "kind" : VOIDLOGSQL_VOIDKIND_CHK_VOID
      // };
    }
    chk = lcolChk;
    kind = VOIDLOGSQL_VOIDKIND_CHK_VOID;
    voidCkSql = "select * from c_header_log where ${chk} AND ${kind};";
    subValues = {};
    // voidCkSql = "select * from c_header_log where @chk AND @kind;";
    // subValues = {
    //   "chk"  : lcolChk,
    //   "kind" : VOIDLOGSQL_VOIDKIND_CHK_VOID
    // };

    Result lres;
    try{
      lres = await rcVoidDbPQexec(
          tsVoidCkSql, tsSubValues, voidCkSql, subValues);
    }catch(e){
      return DlgConfirmMsgKind.MSG_READERR.dlgId;
    }
    /*
    if (lres.affectedRows != 0) {
      return DlgConfirmMsgKind.MSG_CORRDATA.dlgId;
    }
     */

    if ((CmCksys.cmMmSystem() == CmSys.MacERR)
        && (tableDateName != null)
        && (tableDateName.length > 0)) {
      String tsVoidCk99Sql =
          "select * from c_void_log$tableDateName where @chk AND @kind;\n";
      lres = await rcVoidDbPQexec(tsVoidCk99Sql, tsSubValues, voidCkSql, subValues);
      if (lres.isNotEmpty) {
        if (lres.affectedRows != 0) {
          return DlgConfirmMsgKind.MSG_CORRDATA.dlgId;
        }
      }
    }

    if (voidTsCon != null) {
      lres = await rcVoidLocalDbPQexec(voidCkSql, subValues);
      if (lres.isEmpty) {
        return 0;
      }
      /*
      if (lres.affectedRows != 0) {
        return DlgConfirmMsgKind.MSG_CORRDATA.dlgId;
      }
       */
    }

    return 0;
  }

  /// SQL文をサーバーに送信し、結果を返す
  /// 引数:[tsSql] TSサーバー向けSQL文
  /// 引数:[tsSubVal] TSサーバー向けSQL文_挿入パラメタ
  /// 引数:[localSql] ローカル向けSQL文
  /// 引数:[subVal] ローカル向けSQL文_挿入パラメタ
  /// 戻値: 送信結果（null=データなし  null以外=データあり）
  ///  関連tprxソース: rcschrec.c - rcVoid_db_PQexec
  static Future<Result> rcVoidDbPQexec(
      String tsSql, Map<String, dynamic>? tsSubVal,
      String localSql, Map<String, dynamic>? subVal) async {
    Result localRes;
    DbManipulationPs db = DbManipulationPs();
    String logMsg = "rcVoidDbPQexec(): PQexec ";

    if (voidTsCon == null) {
      // offline
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcVoidDbPQexec(): offline(Local PQexec [${RegsDef.chkrCon}])");
      localRes = await db.dbCon.execute(Sql.named(localSql),parameters:subVal);
    } else {
      // online
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcVoidDbPQexec(): online(Master PQexec[$voidTsCon])");
      localRes = await db.dbCon.execute(Sql.named(tsSql),parameters:tsSubVal);
    }
    if (localRes.isEmpty) {
      logMsg += "Error";
    } else {
      logMsg += "OK";
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$logMsg");

    return localRes;
  }

  /// SQL文をローカルサーバーに送信し、結果を返す
  /// 引数:[localSql] ローカル向けSQL文
  /// 引数:[subVal] ローカル向けSQL文_挿入パラメタ
  /// 戻値: null=データなし  null以外=データあり
  ///  関連tprxソース: rcschrec.c - rcVoid_Local_db_PQexec
  static Future<Result> rcVoidLocalDbPQexec(
      String localSql, Map<String, dynamic>? subVal) async {
    DbManipulationPs db = DbManipulationPs();
    Result localRes;
    String logMsg = "rcVoidLocalDbPQexec(): PQexec ";

    // offline
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcVoidLocalDbPQexec(): offline(Local PQexec [${RegsDef.chkrCon}])");
    localRes = await db.dbCon.execute(Sql.named(localSql),parameters:subVal);
    if (localRes.isEmpty) {
      logMsg += "Error";
    } else {
      logMsg += "OK";
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$logMsg");

    return localRes;
  }

  /// 過去実績参照テーブルの削除を行い、DBを閉じる
  ///  関連tprxソース: rcschrec.c - rcSch_DB_Close
  static Future<void> rcSchDbClose() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
      "rcSch_DB_Close void_ts_con[$voidTsCon]");
    await rcSchPastCompDropTable(await RcSysChk.getTid());
    if (voidTsCon != null) {
      voidTsCon = null;
    }
  }

  /// 過去実績参照テーブルの削除を行う
  /// 引数:[tid] タスクID
  ///  関連tprxソース: rcschrec.c - rcSch_PastComp_DropTable
  static Future<void> rcSchPastCompDropTable(TprMID tid) async {
    int ret = 0;

    if ((voidTsCon != null)
      && (pastCompChkServer == VoidupDbLoginStatus.VOIDUP_LOGIN_MASTER.stts)) {
      // Mレジに接続済みかチェック
      ret = await AplLibPastCompFile.pastCompFileDropTable(tid);	// 過去実績参照テーブルの削除処理を実行
      if (ret != OK) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "rcSchPastCompDropTable(): PastCompFile_DropTable Error!!");
      }
    }
  }

  /// 機能    ：印刷済みの領収書実績を検索する
  /// 引数    ：印刷予定の元取引のserial_no
  /// 戻値     :0(領収書印刷可能)、左記以外は印刷不可
  /// 関連tprxソース: rcschrec.c - rcCheck_Search_RfmReceipt
  static Future<int> rcCheckSearchRfmReceipt(String serialNo) async {
    String tsVoidckSql = "";
    String voidckSql = "";
    Result lres;
    String log = "";
    String colChk = "";
    Map<String, dynamic>? tsSubValues = {};
    Map<String, dynamic>? subValues = {};

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    colChk = "void_serial_no = $serialNo";

    if (CmCksys.cmMmType() == CmSys.MacERR) {
      tsVoidckSql =
          "select * from c_void_log_01_${cBuf.dbRegCtrl.compCd.toString().padLeft(9, "0")}_${cBuf.dbRegCtrl.streCd.toString().padLeft(9, "0")} where $colChk AND ${RcSchRec.VOIDLOGSQL_VOIDKIND_CHK_RFM};\n";
    } else {
      tsVoidckSql =
          "select * from c_void_log_01 where $colChk AND ${RcSchRec.VOIDLOGSQL_VOIDKIND_CHK_RFM};\n";
    }
    voidckSql =
        "select * from c_header_log where $colChk AND ${RcSchRec.VOIDLOGSQL_VOIDKIND_CHK_RFM};\n";

    lres = await rcVoidDbPQexec(tsVoidckSql, tsSubValues, voidckSql, subValues);
    if (lres.isNotEmpty) {
      log = "rcCheckSearchRfmReceipt: Global_cash_reg Error!!";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return (DlgConfirmMsgKind.MSG_RCTFM_ERR.dlgId);
    }

    if (voidTsCon != null) {
      lres = await rcVoidLocalDbPQexec(voidckSql, subValues);
      if (lres.isNotEmpty) {
        log = "%s: Local_cash_reg Error!!";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return (DlgConfirmMsgKind.MSG_RCTFM_ERR.dlgId);
      }
    }

    return (0);
  }

  /// 関連tprxソース: rcschrec.c - rcSch_Make_date
  static String rcSchMakeDate(int server, String saleDate) {
    String date = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    if ((server == VoidupDbLoginStatus.VOIDUP_LOGIN_MASTER.stts) ||
        (server == VoidupDbLoginStatus.VOIDUP_LOGIN_TS.stts) ||
        (server == VoidupDbLoginStatus.VOIDUP_LOGIN_SEGMENT.stts)) {
      if (server == VoidupDbLoginStatus.VOIDUP_LOGIN_TS.stts) {
        date =
            "_${saleDate.substring(6, 7)}${saleDate.substring(7, 8)}_${cBuf.dbRegCtrl.compCd}_${cBuf.dbRegCtrl.streCd}";
      } else {
        date = "_${saleDate.substring(6, 7)}${saleDate.substring(7, 8)}";
      }
    }
    return date;
  }

  /// 機能    ：過去実績圧縮ファイル取得からテーブルへの実績展開までの処理
  /// 引数    ：tid
  ///         ：server   接続先ステータス
  ///         ：saleDate 検索しようとしている過去実績の取引日付
  ///         ：macno    検索しようとしている過去実績のマシン番号
  ///         ：func_cd  取引検索実行しようとしているファンクションコード
  ///戻値     ：OK:テーブルへの過去実績展開完了 NG:処理失敗
  /// 関連tprxソース: rcschrec.c - rcSch_PastComp_TempTable_Crte
  static Future<int> rcSchPastCompTempTableCrte(TprMID tid, int server, String saleDate, int macno, int funcCd) async {
  // TODO:TSサーバーへのアクセスは10/4制限事項
  return (0);
  }
}