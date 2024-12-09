/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../postgres_library/src/pos_basic_table_access.dart';
import '../../../postgres_library/src/royalty_promotion_table_access.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../regs/checker/rcsyschk.dart';
import 'rcsch.dart';
import 'rm_db_read.dart';

/// スケジュール(その他)読込のライブラリ関数

/// 関連tprxソース: rcschother.c - rcSchTrmRsvRead()
class RcSchOther {
  /// ターミナル予約マスタ読み込み, 及び, ターミナルテーブルへのUPDATE, 及び, 共有メモリのターミナルへの反映
  /// 関連tprxソース: rcschother.c - rcSchTrmRsvRead()
  static Future<bool> rcSchTrmRsvRead(TprMID tid) async {
    try {
      //共有メモリポインタの取得
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcSchTrmRsvRead() : rxMemRead error]", errId: -1);
        return false;
      }
      RxCommonBuf pCom = xRet.object;

      // 現在日付 YYYY-MM-DD HH:MM:SSの取得
      String date = DateUtil.getNowStr(DateUtil.formatForDB);
      // バックアップ
      // TODO:10035 クラスコピー バックアップ作成Fv
      // memcpy( &save_trm, &pCom->db_trm, sizeof(save_trm) );
      var db = DbManipulationPs();
      await db.dbCon.runTx((txn) async {
        String sql = ''' SELECT   comp_cd , stre_cd , trm_cd 
			 , max(case when bs_time >= max_time then trm_data else 0 end) as trm_data 
			FROM 
			( 
			  SELECT 
			    bs.comp_cd, bs.stre_cd, bs.trm_cd, bs.trm_data, bs.rsrv_datetime as bs_time, chk.rsrv_datetime as max_time 
			  FROM 
			    c_trm_rsrv_mst bs 
			  LEFT OUTER JOIN 
			    (SELECT comp_cd, stre_cd, trm_cd, max(rsrv_datetime) as rsrv_datetime FROM c_trm_rsrv_mst 
			     WHERE comp_cd = '${pCom.dbRegCtrl.compCd}' AND stre_cd ='${pCom
            .dbRegCtrl.streCd}' AND rsrv_datetime <= '$date' AND stop_flg = 0 AND kopt_cd = 0 group by comp_cd, stre_cd, trm_cd) as chk 
			  ON 
			    bs.comp_cd = chk.comp_cd AND bs.stre_cd = chk.stre_cd AND bs.trm_cd = chk.trm_cd 
			  WHERE 
			    bs.comp_cd = '${pCom.dbRegCtrl.compCd}' AND bs.stre_cd ='${pCom
            .dbRegCtrl.streCd}' AND bs.rsrv_datetime <= '$date' AND bs.stop_flg = 0 AND bs.kopt_cd = 0 
			  ORDER BY 
			    bs.trm_cd 
			) as hikaku 
			GROUP BY 
			  comp_cd, stre_cd, trm_cd
			   ''';

        Result dataList = await txn.execute(sql);
        if (dataList.isNotEmpty) {
          TprLog().logAdd(tid, LogLevelDefine.normal,
              " rcSchTrmRsvRead() : c_trm_mst rsrv chg start. nowTime[${date}]");
          RmDBRead.rmDbTrmDtRead(Tpraid.TPRAID_SYST, dataList, true, pCom);

          String updateSql =
              "UPDATE c_trm_mst as  trm  SET trm_data = rsrv.trm_data 	 FROM ($sql) rsrv  WHERE trm.trm_cd = rsrv.trm_cd AND trm.comp_cd = rsrv.comp_cd AND trm.stre_cd = rsrv.stre_cd";
          await txn.execute(updateSql);

          String deleteSql =
              "DELETE FROM c_trm_rsrv_mst WHERE rsrv_datetime <= '$date' AND comp_cd = '${pCom
              .dbRegCtrl.compCd}' AND stre_cd = '${pCom.dbRegCtrl
              .streCd}' AND kopt_cd = 0";
          await txn.execute(deleteSql);
        }
      });
    } catch (e, s) {
      // TODO:10035 クラスコピー バックアップから戻す.
      // memcpy( &pCom->db_trm, &save_trm, sizeof(save_trm) );
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "rcSchTrmRsvRead() : $e $s]",
          errId: -1);
      return false;
    }

    return true;
  }

  /// アカウントマスタ読み込み
  ///	引数:[tid] タスクID
  ///	引数:[acctbuf]	アカウントマスタのリスト
  /// 戻値: セットしたレコード数	 -1=NG
  /// 関連tprxソース:rcschother.c - rcSchAccountMst_Read
  static Future<int> rcSchAccountMstRead(TprMID tid,
      List<CAcctMstColumns> acctbuf, int max, String readDate) async {
    String callFunc = "RcSchOther.rcSchAccountMstRead()";
    
    if (max == 0) {
      TprLog().logAdd(tid, LogLevelDefine.error, "$callFunc: max record is zero");
      return 0;
    }

    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, "$callFunc: rxMemRead error", errId: -1);
      return -1;
    }
    RxCommonBuf pCom = xRet.object;

    // 現在日付 YYYY-MM-DD HH:MM:SSの取得
    String date = DateUtil.getNowStr(DateUtil.formatForDB);
    
    int tuples = 0;
    String sql = '''
        SELECT
          acct_cd, mthr_acct_cd, acct_name, rcpt_prn_flg, prn_seq_no, acct_typ, end_date, plus_end_date, acct_cal_typ
        FROM
          c_acct_mst
        WHERE
          start_date <= '$date' AND end_date >= '$date' AND comp_cd = '${pCom
            .dbRegCtrl.compCd}' AND stre_cd = '${pCom.dbRegCtrl.streCd}'
        ORDER BY
          prn_seq_no, acct_cd;''';
    DbManipulationPs db = DbManipulationPs();
    
    try {
      // バックアップ
      // TODO:10035 クラスコピー バックアップ作成Fv
      // memcpy( &save_trm, &pCom->db_trm, sizeof(save_trm) );
      await db.dbCon.runTx((txn) async {
        Result dataList = await txn.execute(sql);
        if (dataList.isNotEmpty) {
          tuples = dataList.length;
          if (max < tuples) {
            TprLog().logAdd(tid, LogLevelDefine.normal, "$callFunc : tuples max over max[$max] data_length[$dataList.length]");
            tuples = max;
          }
        }
        Map<String, dynamic> data;
        CAcctMstColumns buf;
        for (int num = 0; num < tuples; num++) {
          data = dataList[num].toColumnMap();
          buf = CAcctMstColumns();
          buf.acct_cd = int.tryParse(data["acct_cd"]) ?? 0;
          buf.mthr_acct_cd = int.tryParse(data["mthr_acct_cd"]) ?? 0;
          buf.rcpt_prn_flg = data["rcpt_prn_flg"] ?? 0;
          buf.prn_seq_no = data["prn_seq_no"] ?? 0;
          buf.acct_typ = data["acct_typ"] ?? 0;
          buf.acct_name = data["acct_name"].toString() ?? "";
          buf.end_date = data["end_date"].toString() ?? "";
          buf.plus_end_date = data["plus_end_date"].toString() ?? "";
          buf.acct_cal_typ = data["acct_cal_typ"] ?? 0;
          acctbuf.add(buf);
        }
      });
    } catch (e, s) {
      // TODO:10035 クラスコピー バックアップから戻す.
      // memcpy( &pCom->db_trm, &save_trm, sizeof(save_trm) );
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,"$callFunc: $e $s", errId: -1);
      return -1;
    }

    return tuples;
  }

  /// サービス分類のスケジュール読込
  /// 引数:[tid] タスクID
  /// 引数:[svsClsCd] サービス分類コード
  /// 引数:[readDate] 反映日（NULL=システム日付  NULL以外=該当日付で読込する）
  /// 戻値:[int] セットしたレコード数  -1=NG
  /// 引数:[PPromschMstColumns] スケジュール情報格納ポインタ
  /// 関連tprxソース:rcschother.c - rcSchCustSvsRead
  static Future<(int, PPromschMstColumns)> rcSchCustSvsRead(
      int tid, int svsClsCd, String readDate) async {
    int retInt = 0;
    PPromschMstColumns sch = PPromschMstColumns();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcSchOther.rcSchCustSvsRead(): rxMemPtr error");
      return (-1, sch);
    }
    RxCommonBuf pCom = xRet.object;

    String dtmNow = "now";
    if (readDate.isNotEmpty) {
      dtmNow = readDate;
    }

    DateTime? tmpDate = DateTime.tryParse(readDate);
    SchPriorityParam param = SchPriorityParam();
    param.limit = 1;
    param.keyType = SchSqlKeyType.SCHSQL_KEY_NORMAL;
    param.orderType = SchSqlOrderType.SCHSQL_ORDER_NORMAL;
    String whereSql = RcSch.rcSchPrioritySqlCreate(
        "prom_cd", null, tmpDate, param);

    // スケジュール優先
    String sql = "SELECT * FROM p_promsch_mst WHERE prom_typ='8' AND item_cd='$svsClsCd' AND acct_cd IN (SELECT acct_cd FROM c_acct_mst WHERE start_date<='$dtmNow' AND plus_end_date>='$dtmNow' AND comp_cd='${pCom
        .dbRegCtrl.compCd}' AND stre_cd='${pCom.dbRegCtrl
        .streCd}') AND $whereSql";
    DbManipulationPs db = DbManipulationPs();
    try {
      Result res = await db.dbCon.execute(sql);
      retInt = res.affectedRows;
      if (retInt > 0) {
        if (retInt > 1) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcSchOther.rcSchCustSvsRead(): tuples [$retInt] greater than limit [1]");
          retInt = 1;
        }
        Map<String, dynamic> data = res.first.toColumnMap();
        sch.comp_cd = int.tryParse(data["comp_cd"]) ?? 0;
        sch.stre_cd = int.tryParse(data["stre_cd"]) ?? 0;
        sch.plan_cd = data["plan_cd"];
        sch.prom_cd = int.tryParse(data["prom_cd"]) ?? 0;
        sch.prom_typ = int.tryParse(data["prom_typ"]) ?? 0;
        sch.sch_typ = int.tryParse(data["sch_typ"]) ?? 0;
        sch.prom_name = data["prom_name"];
        sch.reward_val = int.tryParse(data["reward_val"]) ?? 0;
        sch.item_cd = data["item_cd"];
        sch.lrgcls_cd = int.tryParse(data["lrgcls_cd"]) ?? 0;
        sch.mdlcls_cd = int.tryParse(data["mdlcls_cd"]) ?? 0;
        sch.smlcls_cd = int.tryParse(data["smlcls_cd"]) ?? 0;
        sch.tnycls_cd = int.tryParse(data["tnycls_cd"]) ?? 0;
        sch.dsc_val = int.tryParse(data["dsc_val"]) ?? 0;
        sch.cost = double.tryParse(data["cost"]) ?? 0;
        sch.cost_per = double.tryParse(data["cost_per"]) ?? 0;
        sch.cust_dsc_val = int.tryParse(data["cust_dsc_val"]) ?? 0;
        sch.form_qty1 = int.tryParse(data["form_qty1"]) ?? 0;
        sch.form_qty2 = int.tryParse(data["form_qty2"]) ?? 0;
        sch.form_qty3 = int.tryParse(data["form_qty3"]) ?? 0;
        sch.form_qty4 = int.tryParse(data["form_qty4"]) ?? 0;
        sch.form_qty5 = int.tryParse(data["form_qty5"]) ?? 0;
        sch.form_prc1 = int.tryParse(data["form_prc1"]) ?? 0;
        sch.form_prc2 = int.tryParse(data["form_prc2"]) ?? 0;
        sch.form_prc3 = int.tryParse(data["form_prc3"]) ?? 0;
        sch.form_prc4 = int.tryParse(data["form_prc4"]) ?? 0;
        sch.form_prc5 = int.tryParse(data["form_prc5"]) ?? 0;
        sch.cust_form_prc1 = int.tryParse(data["cust_form_prc1"]) ?? 0;
        sch.cust_form_prc2 = int.tryParse(data["cust_form_prc2"]) ?? 0;
        sch.cust_form_prc3 = int.tryParse(data["cust_form_prc3"]) ?? 0;
        sch.cust_form_prc4 = int.tryParse(data["cust_form_prc4"]) ?? 0;
        sch.cust_form_prc5 = int.tryParse(data["cust_form_prc5"]) ?? 0;
        sch.av_prc = int.tryParse(data["av_prc"]) ?? 0;
        sch.cust_av_prc = int.tryParse(data["cust_av_prc"]) ?? 0;
        sch.avprc_adpt_flg = int.tryParse(data["avprc_adpt_flg"]) ?? 0;
        sch.avprc_util_flg = int.tryParse(data["avprc_util_flg"]) ?? 0;
        sch.low_limit = int.tryParse(data["low_limit"]) ?? 0;
        sch.svs_typ = int.tryParse(data["svs_typ"]) ?? 0;
        sch.dsc_typ = int.tryParse(data["dsc_typ"]) ?? 0;
        sch.rec_limit = int.tryParse(data["rec_limit"]) ?? 0;
        sch.rec_buy_limit = int.tryParse(data["rec_buy_limit"]) ?? 0;
        sch.start_datetime = data["start_datetime"];
        sch.end_datetime = data["end_datetime"];
        sch.timesch_flg = int.tryParse(data["timesch_flg"]) ?? 0;
        sch.sun_flg = int.tryParse(data["sun_flg"]) ?? 0;
        sch.mon_flg = int.tryParse(data["mon_flg"]) ?? 0;
        sch.tue_flg = int.tryParse(data["tue_flg"]) ?? 0;
        sch.wed_flg = int.tryParse(data["wed_flg"]) ?? 0;
        sch.thu_flg = int.tryParse(data["thu_flg"]) ?? 0;
        sch.fri_flg = int.tryParse(data["fri_flg"]) ?? 0;
        sch.sat_flg = int.tryParse(data["sat_flg"]) ?? 0;
        sch.eachsch_typ = int.tryParse(data["eachsch_typ"]) ?? 0;
        sch.eachsch_flg = data["eachsch_flg"];
        sch.stop_flg = int.tryParse(data["stop_flg"]) ?? 0;
        sch.min_prc = int.tryParse(data["min_prc"]) ?? 0;
        sch.max_prc = int.tryParse(data["max_prc"]) ?? 0;
        sch.tax_flg = int.tryParse(data["tax_flg"]) ?? 0;
        sch.member_qty = int.tryParse(data["member_qty"]) ?? 0;
        sch.div_cd = int.tryParse(data["div_cd"]) ?? 0;
        sch.acct_cd = int.tryParse(data["acct_cd"]) ?? 0;
        sch.promo_ext_id = data["promo_ext_id"];
        sch.trends_typ = int.tryParse(data["trends_typ"]) ?? 0;
        sch.user_val_1 = int.tryParse(data["user_val_1"]) ?? 0;
        sch.user_val_2 = int.tryParse(data["user_val_2"]) ?? 0;
        sch.user_val_3 = int.tryParse(data["user_val_3"]) ?? 0;
        sch.user_val_4 = int.tryParse(data["user_val_4"]) ?? 0;
        sch.user_val_5 = int.tryParse(data["user_val_5"]) ?? 0;
        sch.user_val_6 = data["user_val_6"];
        sch.ins_datetime = data["ins_datetime"];
        sch.upd_datetime = data["upd_datetime"];
        sch.status = int.tryParse(data["status"]) ?? 0;
        sch.send_flg = int.tryParse(data["send_flg"]) ?? 0;
        sch.upd_user = int.tryParse(data["upd_user"]) ?? 0;
        sch.upd_system = int.tryParse(data["upd_system"]) ?? 0;
        sch.point_add_magn = double.tryParse(data["point_add_magn"]) ?? 0;
        sch.point_add_mem_typ = int.tryParse(data["point_add_mem_typ"]) ?? 0;
        sch.svs_cls_f_data1 = double.tryParse(data["svs_cls_f_data1"]) ?? 0;
        sch.svs_cls_s_data1 = int.tryParse(data["svs_cls_s_data1"]) ?? 0;
        sch.svs_cls_s_data2 = int.tryParse(data["svs_cls_s_data2"]) ?? 0;
        sch.svs_cls_s_data3 = int.tryParse(data["svs_cls_s_data3"]) ?? 0;
        sch.plupts_rate = double.tryParse(data["plupts_rate"]) ?? 0;
        sch.custsvs_unit = int.tryParse(data["custsvs_unit"]) ?? 0;
        sch.ref_acct = int.tryParse(data["ref_acct"]) ?? 0;
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcSchOther.rcSchCustSvsRead(): sql error");
      return (-1, sch);
    }

    return (retInt, sch);
  }
}
