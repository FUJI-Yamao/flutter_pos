/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcsyschk.dart';


class RcFlrd{
  // TODO:00007 梶原 作成中
  ///  関連tprxソース: rc_flrd.c - rcDbRead_Result
  static int rcDbReadResult(String sql){
    TprMID  aid;

    aid = rcGetProcessID() as TprMID;
    int flrdRes =0;
    // flrd_res = db_PQexec(aid, 1, chkr_con, sql);
    if(flrdRes == 0){
      // db_PQclear(aid, flrd_res);
      return DlgConfirmMsgKind.MSG_FILEREADERR.dlgId;
    }

    // if(! db_PQntuples(aid, flrd_res))
    if(true){
      // db_PQclear(aid, flrd_res);
      return DlgConfirmMsgKind.MSG_FILEREADERR.dlgId;
    }
    return 0;// return(OK);// TODO:00007 梶原  どこかで定義しなおす
  }
  // static short rcDbRead_Result(char *sql)
  // {
  //
  // TPRMID  aid;
  //
  // aid = rcGetProcessID();
  // flrd_res = db_PQexec(aid, 1, chkr_con, sql);
  //
  // if(flrd_res == 0)
  // {
  // db_PQclear(aid, flrd_res);
  // return(MSG_FILEREADERR);
  // }
  //
  // if(! db_PQntuples(aid, flrd_res))
  // {
  // db_PQclear(aid, flrd_res);
  // return(MSG_FILEREADERR);
  // }
  //
  // return(OK);
  // }

  ///  関連tprxソース: rc_flrd.c - rcGetProcessID
  static Future<TprMID> rcGetProcessID() async{
    TprMID  aid;

    if(RcSysChk.rcCheckPrchker()){
      return Tpraid.TPRAID_IIS;
    }

    if(RcSysChk.rcCheckMobilePos()){
      return Tpraid.TPRAID_MOBILE;
    }

    if(RcSysChk.rcCheckWiz()){
      return Tpraid.TPRAID_WIZS;
    }

    switch(await RcSysChk.rcKySelf()){
      case RcRegs.KY_DUALCSHR:
        aid = Tpraid.TPRAID_CASH;
        break;
      default:
        aid = Tpraid.TPRAID_CHK;
        break;
    }

    return aid;
  }

  // /***********************************************************************/
  // /*                   Credit Demand Table File Read                     */
  // /***********************************************************************/
  //
  ///  関連tprxソース: rc_flrd.c - rcRead_crdttbl_WC
  static Future<bool> rcReadCrdttblWC(int type) async{
    String sql;
    int companyCd;

    AtSingl atSing = SystemFunc.readAtSingl();

    if(type == RcCrdt.MANUAL_INPUT){
      return true;
    }
    if(atSing.inputbuf.dev != MCD.D_MCD2){
      return true;
    }

    companyCd = 99999;		/* WildCard */
    DbManipulationPs db = DbManipulationPs();
    Result result;
    Map<String, dynamic>? subValues;

    if(CmCksys.cmCustrealTpointSystem() != 0){
      sql = "select * from c_crdt_demand_tbl where card_kind < '@ld1' and company_cd <= '@ld2' and company_cd_to >= '@ld3' limit 1";
      subValues = {"ld1" : RxMem.TPOINT_TBL,"ld2" : companyCd,"ld3" : companyCd};
    }else{
      sql = "select * from c_crdt_demand_tbl where company_cd <= '@ld1' and company_cd_to >= '@ld2' limit 1";
      subValues = {"ld1" : companyCd,"ld2" : companyCd};
    }
    result = await db.dbCon.execute(Sql.named(sql),parameters: subValues);

    if(result.length != Typ.OK){  //【dart置き換え時コメント】SQL発行結果が取得できた場合
      return true;
    }else{
      return false;
    }
  }

  /// スケジュールテーブル読込の対象日時を返す（通常は登録開始時刻を返し, 訓練中は訓練日付を返す）
  /// 戻り値: 対象日時（通常モード:操作開始時間  訓練モード:訓練日付）
  ///  関連tprxソース: rc_flrd.c - rcGet_SchReadDate
  static String rcGetSchReadDate() {
    RegsMem mem = SystemFunc.readRegsMem();
    if (RcSysChk.rcTROpeModeChk() &&
        (mem.tTtllog.t100001Sts.traningDate.length != 0)) {
      return mem.tTtllog.t100001Sts.traningDate;
    } else {
      return mem.tHeader.starttime ?? "";
    }
  }

  // TODO:00012 平野 クレジット宣言：DBにデータがないため、動作確認保留
  ///  関連tprxソース: rc_flrd.c - rcRead_crdttbl_FL
  static Future<int> rcReadCrdttblFL(int type, int stat) async {
    String sql = '';

    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    if (await RcSysChk.rcChkCapSCafisSystem()) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // if (CMEM->working.crdt_reg.company_cd < 1L)
      // {
      //   sprintf(sql, "rcRead_crdttbl_FL() company_cd is 0 !!");
      //   TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, sql);
      //   return (MSG_CARDNOCDERR);
      // }
      //
      // if (AT_SING->inputbuf.dev == D_MCD1)
      // {
      //   if (rcChk_Tpoint_System())
      //   {
      //     sprintf(sql, "select * from c_crdt_demand_tbl where card_kind < '%ld' and mbr_no_from <= '%ld' and mbr_no_to >= '%ld' and card_jis = '1' order by abs(mbr_no_to-mbr_no_from) asc limit 1"
      //         , TPOINT_TBL, CMEM->working.crdt_reg.company_cd, CMEM->working.crdt_reg.company_cd);
      //   }
      //   else
      //   {
      //     sprintf(sql, "select * from c_crdt_demand_tbl where mbr_no_from <= '%ld' and mbr_no_to >= '%ld' and card_jis = '1' order by abs(mbr_no_to-mbr_no_from) asc limit 1"
      //         , CMEM->working.crdt_reg.company_cd, CMEM->working.crdt_reg.company_cd);
      //   }
      // }
      // else if (AT_SING->inputbuf.dev == D_MCD2)
      // {
      //   if (rcChk_Tpoint_System())
      //   {
      //     sprintf(sql, "select * from c_crdt_demand_tbl where card_kind < '%ld' and mbr_no_from <= '%ld' and mbr_no_to >= '%ld' and card_jis = '0' order by abs(mbr_no_to-mbr_no_from) asc limit 1"
      //         , TPOINT_TBL, CMEM->working.crdt_reg.company_cd, CMEM->working.crdt_reg.company_cd);
      //   }
      //   else
      //   {
      //     sprintf(sql, "select * from c_crdt_demand_tbl where mbr_no_from <= '%ld' and mbr_no_to >= '%ld' and card_jis = '0' order by abs(mbr_no_to-mbr_no_from) asc limit 1"
      //         , CMEM->working.crdt_reg.company_cd, CMEM->working.crdt_reg.company_cd);
      //   }
      // }
      // else
      // {
      //   if (rcChk_Tpoint_System())
      //   {
      //     sprintf(sql, "select * from c_crdt_demand_tbl where card_kind < '%ld' and mbr_no_from <= '%ld' and mbr_no_to >= '%ld' order by abs(mbr_no_to-mbr_no_from) asc limit 1"
      //         , TPOINT_TBL, CMEM->working.crdt_reg.company_cd, CMEM->working.crdt_reg.company_cd);
      //   }
      //   else
      //   {
      //     sprintf(sql, "select * from c_crdt_demand_tbl where mbr_no_from <= '%ld' and mbr_no_to >= '%ld' order by abs(mbr_no_to-mbr_no_from) asc limit 1"
      //         , CMEM->working.crdt_reg.company_cd, CMEM->working.crdt_reg.company_cd);
      //   }
      // }
    } else if (type == RcCrdt.MANUAL_INPUT) {
      if (RcSysChk.rcChkTpointSystem() != 0) {
        sql =
            "select * from c_crdt_demand_tbl where card_kind < '${RxMem.TPOINT_TBL}' and card_kind = '${cMem.working.crdtReg.cardKind}'";
      } else {
        sql =
            "select * from c_crdt_demand_tbl where card_kind = '${cMem.working.crdtReg.cardKind}'";
      }
    } else if (await CmCksys.cmNttaspSystem() != 0) {
      if (atSing.inputbuf.dev == DevIn.D_MCD1) {
        if (RcSysChk.rcChkTpointSystem() != 0) {
          sql =
              "select * from c_crdt_demand_tbl where card_kind < '${RxMem.TPOINT_TBL}' and company_cd <= '${cMem.working.crdtReg.companyCd}' and company_cd_to >= '${cMem.working.crdtReg.companyCd}' and card_jis = '1' limit 1";
        } else {
          sql =
              "select * from c_crdt_demand_tbl where company_cd <= '${cMem.working.crdtReg.companyCd}' and company_cd_to >= '${cMem.working.crdtReg.companyCd}' and card_jis = '1' limit 1";
        }
      } else if (atSing.inputbuf.dev == DevIn.D_MCD2) {
        if (RcSysChk.rcChkTpointSystem() != 0) {
          sql =
              "select * from c_crdt_demand_tbl where card_kind < '%ld' and company_cd <= '${cMem.working.crdtReg.companyCd}' and company_cd_to >= '${cMem.working.crdtReg.companyCd}' and card_jis = '0' and id = '${cMem.working.crdtReg.id}' and business = '${cMem.working.crdtReg.business}' limit 1";
        } else {
          sql =
              "select * from c_crdt_demand_tbl where company_cd <= '${cMem.working.crdtReg.companyCd}' and company_cd_to >= '${cMem.working.crdtReg.companyCd}' and card_jis = '0' and id = '${cMem.working.crdtReg.id}' and business = '${cMem.working.crdtReg.business}' limit 1";
        }
      } else {
        if (RcSysChk.rcChkTpointSystem() != 0) {
          sql =
              "select * from c_crdt_demand_tbl where card_kind < '${RxMem.TPOINT_TBL}' and company_cd <= '${cMem.working.crdtReg.companyCd}' and company_cd_to >= '${cMem.working.crdtReg.companyCd}' limit 1";
        } else {
          sql =
              "select * from c_crdt_demand_tbl where company_cd <= '${cMem.working.crdtReg.companyCd}' and company_cd_to >= '${cMem.working.crdtReg.companyCd}' limit 1";
        }
      }
    } else {
      if (RcSysChk.rcChkTpointSystem() != 0) {
//			sprintf(sql, "select * from c_crdt_demand_tbl where card_kind < '%ld' and company_cd = '%ld'", TPOINT_TBL ,CMEM->working.crdt_reg.company_cd);
        sql =
            "select * from c_crdt_demand_tbl where card_kind < '${RxMem.TPOINT_TBL}' and company_cd <= '${cMem.working.crdtReg.companyCd}' and company_cd_to >= '${cMem.working.crdtReg.companyCd}' limit 1";
      } else {
//			sprintf(sql, "select * from c_crdt_demand_tbl where company_cd = '%ld'", CMEM->working.crdt_reg.company_cd);
        sql =
            "select * from c_crdt_demand_tbl where company_cd <= '${cMem.working.crdtReg.companyCd}' and company_cd_to >= '${cMem.working.crdtReg.companyCd}' limit 1";
        /* 企業コードFromTo対応(該当レコードが複数ある場合は、常に古いレコードを採用する)  */
      }
    }

    try {
      DbManipulationPs db = DbManipulationPs();
      Result result1 = await db.dbCon.execute(Sql.named(sql));
      if (result1.isEmpty) {
        if (await CmCksys.cmCapsPqvicSystem() != 0) {
          return (DlgConfirmMsgKind.MSG_CRDTTBLNONFILE.dlgId);
        }
        cMem.working.refData.crdtTbl = CCrdtDemandTbl();
        for (int i = 0; i < 121; i++) {
          // カード会社名の長さ指定：char	card_company_name[121]
          cMem.working.refData.crdtTbl.card_company_name += ' ';
        }

        if (CompileFlag.MC_SYSTEM) {
          return (DlgConfirmMsgKind.MSG_CRDTTBLNONFILE.dlgId);
        } else {
          if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
            return (DlgConfirmMsgKind.MSG_TEXT50.dlgId);
          }
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // #if DEPARTMENT_STORE
          // else if (rcChk_Crdt_User () == NAKAGO_CRDT) {
          //   if(stat != CARDCREW_ON)
          //     CMEM->stat.Depart_Flg |= 0x20; /* クレジット請求テーブルノンファイル */
          //   if(type == MANUAL_INPUT)
          //    return(MSG_CRDTTBLNONFILE);
          //   else
          //    return(MSG_RECARD_IN);
          // }
          // #endif
          else {
            if (await CmCksys.cmNttaspSystem() != 0) {
              if (await rcReadCrdttblWC(type)) {
                return (DlgConfirmMsgKind.MSG_CRDTTBLNONFILE.dlgId);
              }
            } else {
              return (DlgConfirmMsgKind.MSG_CRDTTBLNONFILE.dlgId);
            }
          }
        }
      }

      Map<String, dynamic> data = result1.first.toColumnMap();
      if (!CompileFlag.MC_SYSTEM) {
        if (type == RcCrdt.IC_INPUT) {
          cMem.working.refData.crdtTbl.card_kind = int.parse(data["card_kind"]);
          cMem.working.refData.crdtTbl.card_company_name =
              data["card_company_name"].toString();
          cMem.working.refData.crdtTbl.good_thru_position =
              int.parse(data["good_thru_position"]);
          return (Typ.OK);
        }
      }

      if ((!CompileFlag.MC_SYSTEM) && (stat == RcCrdt.CARDCREW_ON)) {
        cMem.working.refData.crdtTbl.card_kind = int.parse(data["card_kind"]);
        cMem.working.refData.crdtTbl.offline_limit =
            int.parse(data["offline_limit"]);
        cMem.working.refData.crdtTbl.mbr_no_digit =
            int.parse(data["mbr_no_digit"]);
        cMem.working.refData.crdtTbl.ckdigit_chk =
            int.parse(data["ckdigit_chk"]);
        cMem.working.refData.crdtTbl.ckdigit_wait =
            data["ckdigit_wait"].toString();
        if (await RcSysChk.rcChkCrdtDscSystem()) {
          cMem.working.refData.crdtTbl.stlcrdtdsc_per =
              int.parse(data["stlcrdtdsc_per"]);
        }
        if (CompileFlag.DEPARTMENT_STORE) {
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // CMEM->working.ref_data.crdttbl.fil2               = atol(rcDbGet_Field("fil2"));
          // CMEM->working.ref_data.crdttbl.fil5               = atol(rcDbGet_Field("fil5"));
          // strncpy(CMEM->working.ref_data.crdttbl.card_company_name, rcDbGet_Field("card_company_name"),
          // sizeof(CMEM->working.ref_data.crdttbl.card_company_name));
          // CMEM->working.ref_data.crdttbl.divide3_limit      = atol(rcDbGet_Field("divide3_limit"));
        }
      } else {
        cMem.working.refData.crdtTbl.card_kind = int.parse(data["card_kind"]);
        cMem.working.refData.crdtTbl.company_cd = int.parse(data["company_cd"]);
        cMem.working.refData.crdtTbl.id = data["id"].toString();
        //strncpy(&CMEM->working.ref_data.crdttbl.business,rcDbGet_Field("business"),
        // sizeof(CMEM->working.ref_data.crdttbl.business));
        cMem.working.refData.crdtTbl.business = int.parse(data["business"]);
        //CMEM->working.ref_data.crdttbl.mbr_no_from        = atol(rcDbGet_Field("mbr_no_from"));
        //CMEM->working.ref_data.crdttbl.mbr_no_to          =int.parse(data["mbr_no_to"));
        cMem.working.refData.crdtTbl.mbr_no_from =
            int.parse(data["mbr_no_from"]);
        cMem.working.refData.crdtTbl.mbr_no_to = int.parse(data["mbr_no_to"]);
        cMem.working.refData.crdtTbl.mbr_no_position =
            int.parse(data["mbr_no_position"]);
        cMem.working.refData.crdtTbl.mbr_no_digit =
            int.parse(data["mbr_no_digit"]);
        cMem.working.refData.crdtTbl.ckdigit_chk =
            int.parse(data["ckdigit_chk"]);
        cMem.working.refData.crdtTbl.ckdigit_wait =
            data["ckdigit_wait"].toString();
        cMem.working.refData.crdtTbl.card_company_name =
            data["card_company_name"].toString();
        cMem.working.refData.crdtTbl.good_thru_position =
            int.parse(data["good_thru_position"]);
        cMem.working.refData.crdtTbl.pay_autoinput_chk =
            int.parse(data["pay_autoinput_chk"]);
        cMem.working.refData.crdtTbl.pay_shut_day =
            int.parse(data["pay_shut_day"]);
        cMem.working.refData.crdtTbl.pay_day = int.parse(data["pay_day"]);
        cMem.working.refData.crdtTbl.lump = int.parse(data["lump"]);
        cMem.working.refData.crdtTbl.twice = int.parse(data["twice"]);
        cMem.working.refData.crdtTbl.divide = int.parse(data["divide"]);
        cMem.working.refData.crdtTbl.bonus_lump = int.parse(data["bonus_lump"]);
        cMem.working.refData.crdtTbl.bonus_twice =
            int.parse(data["bonus_twice"]);
        cMem.working.refData.crdtTbl.bonus_use = int.parse(data["bonus_use"]);
        cMem.working.refData.crdtTbl.ribo = int.parse(data["ribo"]);
        cMem.working.refData.crdtTbl.skip = int.parse(data["skip"]);
        cMem.working.refData.crdtTbl.divide3 = int.parse(data["divide3"]);
        cMem.working.refData.crdtTbl.divide4 = int.parse(data["divide4"]);
        cMem.working.refData.crdtTbl.divide5 = int.parse(data["divide5"]);
        cMem.working.refData.crdtTbl.divide6 = int.parse(data["divide6"]);
        cMem.working.refData.crdtTbl.divide7 = int.parse(data["divide7"]);
        cMem.working.refData.crdtTbl.divide8 = int.parse(data["divide8"]);
        cMem.working.refData.crdtTbl.divide9 = int.parse(data["divide9"]);
        cMem.working.refData.crdtTbl.divide10 = int.parse(data["divide10"]);
        cMem.working.refData.crdtTbl.divide11 = int.parse(data["divide11"]);
        cMem.working.refData.crdtTbl.divide12 = int.parse(data["divide12"]);
        cMem.working.refData.crdtTbl.divide15 = int.parse(data["divide15"]);
        cMem.working.refData.crdtTbl.divide18 = int.parse(data["divide18"]);
        cMem.working.refData.crdtTbl.divide20 = int.parse(data["divide20"]);
        cMem.working.refData.crdtTbl.divide24 = int.parse(data["divide24"]);
        cMem.working.refData.crdtTbl.divide25 = int.parse(data["divide25"]);
        cMem.working.refData.crdtTbl.divide30 = int.parse(data["divide30"]);
        cMem.working.refData.crdtTbl.divide35 = int.parse(data["divide35"]);
        cMem.working.refData.crdtTbl.divide36 = int.parse(data["divide36"]);
        cMem.working.refData.crdtTbl.divide3_limit =
            int.parse(data["divide3_limit"]);
        cMem.working.refData.crdtTbl.divide4_limit =
            int.parse(data["divide4_limit"]);
        cMem.working.refData.crdtTbl.divide5_limit =
            int.parse(data["divide5_limit"]);
        cMem.working.refData.crdtTbl.divide6_limit =
            int.parse(data["divide6_limit"]);
        cMem.working.refData.crdtTbl.divide7_limit =
            int.parse(data["divide7_limit"]);
        cMem.working.refData.crdtTbl.divide8_limit =
            int.parse(data["divide8_limit"]);
        cMem.working.refData.crdtTbl.divide9_limit =
            int.parse(data["divide9_limit"]);
        cMem.working.refData.crdtTbl.divide10_limit =
            int.parse(data["divide10_limit"]);
        cMem.working.refData.crdtTbl.divide11_limit =
            int.parse(data["divide11_limit"]);
        cMem.working.refData.crdtTbl.divide12_limit =
            int.parse(data["divide12_limit"]);
        cMem.working.refData.crdtTbl.divide15_limit =
            int.parse(data["divide15_limit"]);
        cMem.working.refData.crdtTbl.divide18_limit =
            int.parse(data["divide18_limit"]);
        cMem.working.refData.crdtTbl.divide20_limit =
            int.parse(data["divide20_limit"]);
        cMem.working.refData.crdtTbl.divide24_limit =
            int.parse(data["divide24_limit"]);
        cMem.working.refData.crdtTbl.divide25_limit =
            int.parse(data["divide25_limit"]);
        cMem.working.refData.crdtTbl.divide30_limit =
            int.parse(data["divide30_limit"]);
        cMem.working.refData.crdtTbl.divide35_limit =
            int.parse(data["divide35_limit"]);
        cMem.working.refData.crdtTbl.divide36_limit =
            int.parse(data["divide36_limit"]);
        cMem.working.refData.crdtTbl.bonus_use2 = int.parse(data["bonus_use2"]);
        cMem.working.refData.crdtTbl.bonus_use3 = int.parse(data["bonus_use3"]);
        cMem.working.refData.crdtTbl.bonus_use4 = int.parse(data["bonus_use4"]);
        cMem.working.refData.crdtTbl.bonus_use5 = int.parse(data["bonus_use5"]);
        cMem.working.refData.crdtTbl.bonus_use6 = int.parse(data["bonus_use6"]);
        cMem.working.refData.crdtTbl.bonus_use7 = int.parse(data["bonus_use7"]);
        cMem.working.refData.crdtTbl.bonus_use8 = int.parse(data["bonus_use8"]);
        cMem.working.refData.crdtTbl.bonus_use9 = int.parse(data["bonus_use9"]);
        cMem.working.refData.crdtTbl.bonus_use10 =
            int.parse(data["bonus_use11"]);
        cMem.working.refData.crdtTbl.bonus_use11 =
            int.parse(data["bonus_use10"]);
        cMem.working.refData.crdtTbl.bonus_use12 =
            int.parse(data["bonus_use12"]);
        cMem.working.refData.crdtTbl.bonus_use15 =
            int.parse(data["bonus_use15"]);
        cMem.working.refData.crdtTbl.bonus_use18 =
            int.parse(data["bonus_use18"]);
        cMem.working.refData.crdtTbl.bonus_use20 =
            int.parse(data["bonus_use20"]);
        cMem.working.refData.crdtTbl.bonus_use24 =
            int.parse(data["bonus_use24"]);
        cMem.working.refData.crdtTbl.bonus_use25 =
            int.parse(data["bonus_use25"]);
        cMem.working.refData.crdtTbl.bonus_use30 =
            int.parse(data["bonus_use30"]);
        cMem.working.refData.crdtTbl.bonus_use35 =
            int.parse(data["bonus_use35"]);
        cMem.working.refData.crdtTbl.bonus_use36 =
            int.parse(data["bonus_use36"]);
        cMem.working.refData.crdtTbl.bonus_use2_limit =
            int.parse(data["bonus_use2_limit"]);
        cMem.working.refData.crdtTbl.bonus_use3_limit =
            int.parse(data["bonus_use3_limit"]);
        cMem.working.refData.crdtTbl.bonus_use4_limit =
            int.parse(data["bonus_use4_limit"]);
        cMem.working.refData.crdtTbl.bonus_use5_limit =
            int.parse(data["bonus_use5_limit"]);
        cMem.working.refData.crdtTbl.bonus_use6_limit =
            int.parse(data["bonus_use6_limit"]);
        cMem.working.refData.crdtTbl.bonus_use7_limit =
            int.parse(data["bonus_use7_limit"]);
        cMem.working.refData.crdtTbl.bonus_use8_limit =
            int.parse(data["bonus_use8_limit"]);
        cMem.working.refData.crdtTbl.bonus_use9_limit =
            int.parse(data["bonus_use9_limit"]);
        cMem.working.refData.crdtTbl.bonus_use10_limit =
            int.parse(data["bonus_use10_limit"]);
        cMem.working.refData.crdtTbl.bonus_use11_limit =
            int.parse(data["bonus_use11_limit"]);
        cMem.working.refData.crdtTbl.bonus_use12_limit =
            int.parse(data["bonus_use12_limit"]);
        cMem.working.refData.crdtTbl.bonus_use15_limit =
            int.parse(data["bonus_use15_limit"]);
        cMem.working.refData.crdtTbl.bonus_use18_limit =
            int.parse(data["bonus_use18_limit"]);
        cMem.working.refData.crdtTbl.bonus_use20_limit =
            int.parse(data["bonus_use20_limit"]);
        cMem.working.refData.crdtTbl.bonus_use24_limit =
            int.parse(data["bonus_use24_limit"]);
        cMem.working.refData.crdtTbl.bonus_use25_limit =
            int.parse(data["bonus_use25_limit"]);
        cMem.working.refData.crdtTbl.bonus_use30_limit =
            int.parse(data["bonus_use30_limit"]);
        cMem.working.refData.crdtTbl.bonus_use35_limit =
            int.parse(data["bonus_use35_limit"]);
        cMem.working.refData.crdtTbl.bonus_use36_limit =
            int.parse(data["bonus_use36_limit"]);
        cMem.working.refData.crdtTbl.pay_input_chk =
            int.parse(data["pay_input_chk"]);
        cMem.working.refData.crdtTbl.winter_bonus_from =
            int.parse(data["winter_bonus_from"]);
        cMem.working.refData.crdtTbl.winter_bonus_to =
            int.parse(data["winter_bonus_to"]);
        cMem.working.refData.crdtTbl.winter_bonus_pay1 =
            int.parse(data["winter_bonus_pay1"]);
        cMem.working.refData.crdtTbl.winter_bonus_pay2 =
            int.parse(data["winter_bonus_pay2"]);
        cMem.working.refData.crdtTbl.winter_bonus_pay3 =
            int.parse(data["winter_bonus_pay3"]);
        cMem.working.refData.crdtTbl.summer_bonus_from =
            int.parse(data["summer_bonus_from"]);
        cMem.working.refData.crdtTbl.summer_bonus_to =
            int.parse(data["summer_bonus_to"]);
        cMem.working.refData.crdtTbl.summer_bonus_pay1 =
            int.parse(data["summer_bonus_pay1"]);
        cMem.working.refData.crdtTbl.summer_bonus_pay2 =
            int.parse(data["summer_bonus_pay2"]);
        cMem.working.refData.crdtTbl.summer_bonus_pay3 =
            int.parse(data["summer_bonus_pay3"]);
        cMem.working.refData.crdtTbl.bonus_lump_limit =
            int.parse(data["bonus_lump_limit"]);
        cMem.working.refData.crdtTbl.bonus_twice_limit =
            int.parse(data["bonus_twice_limit"]);
        cMem.working.refData.crdtTbl.offline_limit =
            int.parse(data["offline_limit"]);
        cMem.working.refData.crdtTbl.card_jis = int.parse(data["card_jis"]);
        if (await RcSysChk.rcChkCrdtDscSystem()) {
          cMem.working.refData.crdtTbl.stlcrdtdsc_per =
              int.parse(data["stlcrdtdsc_per"]);
        }
        cMem.working.refData.crdtTbl.mkr_cd = int.parse(data["mkr_cd"]);
//     CMEM->working.ref_data.crdttbl.destination        = atol(rcDbGet_Field("destination")); /* 15Ver */
        cMem.working.refData.crdtTbl.signless_flg =
            int.parse(data["signless_flg"]);
        cMem.working.refData.crdtTbl.bonus_add_input_chk =
            int.parse(data["bonus_add_input_chk"]);
        cMem.working.refData.crdtTbl.bonus_cnt_input_chk =
            int.parse(data["bonus_cnt_input_chk"]);
        cMem.working.refData.crdtTbl.bonus_cnt = int.parse(data["bonus_cnt"]);
        cMem.working.refData.crdtTbl.paymonth_input_chk =
            int.parse(data["paymonth_input_chk"]);
        if (CompileFlag.DEPARTMENT_STORE) {
          // cMem.working.refData.crdtTbl.fil2               = atol(rcDbGet_Field("fil2"));
          // cMem.working.refData.crdtTbl.fil5               = atol(rcDbGet_Field("fil5"));
        }
        if (await CmCksys.cmTuoSystem() != 0) {
          cMem.working.refData.crdtTbl.coopcode1 = int.parse(data["coopcode1"]);
          cMem.working.refData.crdtTbl.coopcode2 = int.parse(data["coopcode2"]);
          cMem.working.refData.crdtTbl.coopcode3 = int.parse(data["coopcode3"]);
          cMem.working.refData.crdtTbl.sign_amt = int.parse(data["sign_amt"]);
          cMem.working.refData.crdtTbl.effect_code =
              int.parse(data["effect_code"]);
        }
      }

      if (await RcSysChk.rcChkCapSCafisSystem()) {
        // TODO:10166 クレジット決済 20241004実装対象外
        // if (!((isAlpha(cMem.working.refData.crdtTbl.id)) &&
        //     (cMem.working.refData.crdtTbl.business >= 0) &&
        //     (cMem.working.refData.crdtTbl.business <= 9) &&
        //     (cMem.working.refData.crdtTbl.company_cd > 0))) {
        //   // rcDbRead_Clear();
        //   return (DlgConfirmMsgKind.MSG_CHK_CRDT.dlgId);
        // }
      }
      // rcDbRead_Clear();
    } catch (e, s) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcReadCrdttblFL() db error $e,$s",
          errId: -1);
      return DlgConfirmMsgKind.MSG_FILEREADERR.dlgId;
    }
    return (Typ.OK);
  }
}