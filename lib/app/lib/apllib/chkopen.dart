/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:sprintf/sprintf.dart';

import '../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../postgres_library/src/pos_basic_table_access.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/competition_ini.dart';
import '../cm_sys/cm_cksys.dart';


/// 開店チェック関連
/// 関連tprxソース:chkopen.c
class ChkOpen {
  static const List<String?> chkTbl = ["c_header_log", "c_pbchg_log", null];
  static const WHERE1 = "where tran_flg<>'1'";
  static const WHERE2 = "where tran_flg<>'1' or sub_tran_flg<>'1'";
  static const WHERE3 = "where tran_flg = '0'";
  static const CONT1 = "+";
  static const CONT2 = ",";

  late RxCommonBuf pCom;
  String sql = '';

  /// INIファイルからデータを取得する（タイプ指定あり）
  ///  関連tprxソース:chkopen.c - chk_open()
  /// 引数:[tid] メッセージID
  /// 引数:[endp] 確認ダイアログ出力有無（null=ダイアログなし）
  /// 戻り値:true = Normal End
  ///       false = Error
  Future<bool> chkOpen(TprTID tid, Object? endp) async {
    bool adj = true;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    CompetitionIniRet compIniRet = await CompetitionIni.competitionIniGet(
        tid, CompetitionIniLists.COMPETITION_INI_SALE_DATE,
        CompetitionIniType.COMPETITION_INI_GETMEM);

    String saleDate = '0000-00-00';
    if (compIniRet.value != null) {
      saleDate = compIniRet.value;
    }

    if (saleDate == '0000-00-00') {
      adj = false;
    } else {
      try {
        var db = DbManipulationPs();
        sql = "select open_flg, close_flg from c_openclose_mst where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and sale_date = @saleDate";
        Map<String, dynamic>? subValues = {
          "comp"     : pCom.dbRegCtrl.compCd,
          "stre"     : pCom.dbRegCtrl.streCd,
          "mac"      : pCom.dbRegCtrl.macNo,
          "saleDate" : saleDate
        };

        Result dataList = await db.dbCon.execute(Sql.named(sql), parameters: subValues);
        if (dataList.isEmpty) {
          adj = false;  /* 該当レジが無い */
        } else {
          Map<String, dynamic> data = dataList.first.toColumnMap();
          COpencloseMstColumns oc = COpencloseMstColumns();
          oc.open_flg = data['open_flg'];
          oc.close_flg = data['close_flg'];
          if (oc.open_flg == 0) {
            adj = false;	/* 未開設 */
          }
          else if ((oc.open_flg == 1) && (oc.close_flg == 1)) {
            adj = false;	/* 閉設済 */
          }
        }
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "chkOpen() : $e $s )");
        return false;
      }
    }

    return adj;
  }

  /// Functions: 未送信実績チェック
  /// Returns:   OK or NG
  /// 関連tprxソース: chkopen.c - chk_sale_send
  static Future<int> chkSaleSend(TprTID tid, int chkFlg) async {
    String sql = '';
    int macNo = 0;
    int macType = 0; /* マシンタイプ */
    int rtn = 0;
    int stepUpFlg = 0;
    String saleDate = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    DbManipulationPs db = DbManipulationPs();
    Result res;

    macType = CmCksys.cmMmType(); /* マシンタイプ */

    /**********************/
    /* 未送信実績チェック */
    /**********************/
    if (chkFlg != 2) {
      if (macType != CmSys.MacS && macType != CmSys.MacERR) {
        /* Ｓレジ以外　ＴＳ接続以外 */
        if (await noSendCntGet(tid, AplLib.SALE_CHK_ALL) > 0) {
          rtn = DlgConfirmMsgKind.MSG_NOSENDRESULTS.dlgId;
        }
      }
    }

    /************************/
    /* 24時間仕様			*/
    /************************/
    if (await CmCksys.cm24hourSystem() != 0 &&
        (macType == CmSys.MacM1 || macType == CmSys.MacM2)) {
      if ((macType == CmSys.MacM1 && chkFlg == 4) ||
          (macType == CmSys.MacM2 &&
              (chkFlg == 2 || chkFlg == 4 || chkFlg == 5 || chkFlg == 7))) {
        CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
            tid,
            CompetitionIniLists.COMPETITION_INI_SALE_DATE,
            CompetitionIniType.COMPETITION_INI_GETMEM);
        saleDate = ret.value;

        if (saleDate.compareTo("0000-00-00") == 0) {
          return rtn;
        }

        sql = sprintf(
            "SELECT mac_no FROM c_reginfo_mst WHERE comp_cd = '%i' AND stre_cd = '%i' AND mac_typ='101';",
            [pCom.dbRegCtrl.compCd, pCom.dbRegCtrl.streCd]);

        try {
          res = await db.dbCon.execute(sql);
          if (res.length != 1) {
            //Cソース「db_PQntuples() != 1」時に相当
            return rtn;
          }

          Map<String, dynamic> data = res.elementAt(0).toColumnMap();
          macNo = int.tryParse(data["mac_no"]) ?? 0;
        } catch (e) {
          //Cソース「db_PQexec() == NULL」時に相当
          return rtn;
        }

        sql = sprintf(
            "select stepup_flg from c_openclose_mst where comp_cd='%i' and stre_cd = '%i' and mac_no='%i' and sale_date='%s';",
            [
              pCom.dbRegCtrl.compCd,
              pCom.dbRegCtrl.streCd,
              pCom.dbRegCtrl.macNo,
              saleDate
            ]);

        try {
          res = await db.dbCon.execute(sql);
          if (res.length != 1) {
            //Cソース「db_PQntuples() != 1」時に相当
            return rtn;
          }

          Map<String, dynamic> data = res.elementAt(0).toColumnMap();
          stepUpFlg = int.tryParse(data["stepup_flg"]) ?? 0;
        } catch (e) {
          //Cソース「db_PQexec() == NULL」時に相当
          return rtn;
        }

        if ((macType == CmSys.MacM1 && stepUpFlg == 2) ||
            (macType == CmSys.MacM2 && stepUpFlg != 0)) {
          rtn = DlgConfirmMsgKind.MSG_UPDATING.dlgId;
        }
      }
    }

    return rtn;
  }

  /// 未送信実績件数を返す
  /// typ 	DD_SALE_CHK:実績tran_flg未送信件数
  /// RDLY_SALE_CHK:wk_queの未送信件数
  /// 関連tprxソース: chkopen.c - Nosend_Cnt_Get
  static Future<int> noSendCntGet(TprTID tid, int typ) async {
    int ret = 0;
    String sql = '';
    String log = '';
    String tmpSql = '';
    int macTyp = 0;
    int wkGet = 0;
    Result res;
    DbManipulationPs db = DbManipulationPs();
    String callFunc = 'noSendCntGet';

    ret = -1;
    macTyp = CmCksys.cmMmType();

    if (typ == AplLib.SALE_CHK_DD || typ == AplLib.SALE_CHK_ALL) {
      switch (macTyp) {
        case CmSys.MacM1:
        /* M */
        case CmSys.MacM2:
        /* BS */
        case CmSys.MacS:
        /* S */
          tmpSql = rmstLogChkSqlGet(1);
          break;
        default:
        /* ST, TS */
          tmpSql = rmstLogChkSqlGet(0);
          break;
      }
      sql = "select $tmpSql";
    }

    if (typ == AplLib.SALE_CHK_RDLY || typ == AplLib.SALE_CHK_ALL) {
      if ((macTyp == CmSys.MacM1) || (macTyp == CmSys.MacM2)) {
        if (sql.isNotEmpty) {
          tmpSql = ",(select count(*) from wk_que)";
          wkGet = 1;
        } else {
          tmpSql = "select count(*) from wk_que";
        }
      }
    }

    sql = sql + tmpSql;

    if (sql.isEmpty) {
      return 0;
    }

    sql = '$sql;';

    try {
      res = await db.dbCon.execute(sql);

      Map<String, dynamic> data = res.elementAt(0).toColumnMap();
      ret = int.tryParse(res.elementAt(0).toString()) ?? 0;

      if (wkGet != 0) {
        // TODO:00013 三浦 sqlで取得する値確認
        // ret += atol(db_PQgetvalue(tid, res, 0, 1));
        ret += int.tryParse(res.elementAt(1).toString()) ?? 0;
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      return 0;
    }

    log = "$callFunc: Get NoSend[$typ][$ret]";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    return ret;
  }

  /// 未送信実績件数取得
  /// 関連tprxソース: chkopen.c - rmstLogChk_sql_Get
  static String rmstLogChkSqlGet(int typ) {
    String buf = '';
    String tmpBuf = '';
    String wBuf = '';
    String cont = '';
    int i = 0;

    cont = CONT1;
    switch (typ) {
//		case	3:	cont = CONT2;
      case 0:
        wBuf = WHERE1;
        break; //ST, TS
      case 1:
        wBuf = WHERE2;
        break; //M,BS,S
      case 2:
        wBuf = WHERE3;
        break;
      default :
        return buf;
    }

    while (chkTbl[i] != null) {
      if (i != 0) {
        buf = buf + cont;
      }

      tmpBuf = "(select count (*) from ${chkTbl[i]} $wBuf)";
      buf = buf + tmpBuf;
      i ++;
    }

    return buf;
  }
}