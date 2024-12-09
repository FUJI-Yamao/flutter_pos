/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../db_library/src/db_manipulation.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/rcsch.dart';
import '../../lib/cm_jan/jan.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_regs.dart';
import 'rc_flrd.dart';
import 'rcsyschk.dart';

class RcKyCpnprn {
  static const CPNREPRN_ITEMDATA_MAX = 30;
  static const CPNREPRN_CPNCONTENT_SERVICE = 3;
  static const CPNREPRN_CPNCONTENT_MAKER = 1;
  static const CPNREPRN_CPNCONTENT_FRESH = 4;
  static const CPNREPRN_PRINT_ERR = 1;
  static const CPNREPRN_PRINT_NOTEND = -1;

  static int cpnPrnCnt = 0;
  static int regsReprintFlg = 0;
  static int rcCpnPrnInputFlg = 0;
  static List<String> cpnStartDateTime = List.filled(RxCntList.OTH_PROM_MAX, "");
  static List<String> cpnEndDateTime = List.filled(RxCntList.OTH_PROM_MAX, "");

  ///  関連tprxソース: rcky_pcnprn.c - rccpnprn_printResCheck
  static int rccpnprnPrintResCheck() {

    /* 印字中=-1 印字終了=0 印字終了印字エラー有=1 */
    return(RegsMem().tTtllog.t106500Sts[0].cpnPrnRes % 10);
  }

  /// DBからクーポンテーブルを読み取る
  /// 引数:再印刷フラグ
  /// 戻り値:印字内容数
  ///  関連tprxソース: rcky_pcnprn.c - rccpnprn_cpntblRead
  static Future<int> cpnTblRead(int reprintFlg) async {
    String readDate = RcFlrd.rcGetSchReadDate();
    String dtmNow = "";
    int wDay = 0;
    (dtmNow, wDay) = RcSch.rcSchGetDtmAdd(readDate);

    if (!((await CmCksys.cmZHQSystem() != 0) ||
        RcSysChk.rcChkZcpnprnCheckUser())) {
      return 0;
    }
    if (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) {
      return 0;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if ((mem.tTtllog.t100001Sts.cpnErrDlgFlg != 0) && (reprintFlg == 0)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcKyCpnprn.cpnTblRead(): Err dialog was displayed");
      return 0;
    }
    mem.prnrBuf.cpnPrnBuf = List<RxMemCpnPrn>.generate(RxCntList.OTH_PROM_MAX, (_) => RxMemCpnPrn());

    int ret = 0;
    CInstreMstColumns instreRec = CInstreMstColumns();
    (ret, instreRec) = Jan.cmGetDbInstre(JANInfConsts.JANtypeFreshZfsp.value);

    String weekField = "";
    int date = 0;
    String endOfMonthSql = "";
    String addBuf = "";
    if (await CmCksys.cmZHQSystem() == 0) {
      // 日付情報の取得
      switch (wDay) {
        case 0:
          weekField = "sun_flg";
          break;
        case 1:
          weekField = "mon_flg";
          break;
        case 2:
          weekField = "tue_flg";
          break;
        case 3:
          weekField = "wed_flg";
          break;
        case 4:
          weekField = "thu_flg";
          break;
        case 5:
          weekField = "fri_flg";
          break;
        case 6:
          weekField = "sat_flg";
          break;
        default:
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcKyCpnprn.cpnTblRead(): Could not obtain valid date");
          return -2;
      }
      date = RcSch.rcSchDateGet(dtmNow);
      if (RcSch.rcSchChkEndOfMonth(dtmNow)) {
        endOfMonthSql =
        " OR (date_flg1=${RcSch.RCSCH_ENDOFMONTH} OR date_flg2=${RcSch
            .RCSCH_ENDOFMONTH} OR date_flg3=${RcSch
            .RCSCH_ENDOFMONTH} OR date_flg4=${RcSch
            .RCSCH_ENDOFMONTH} OR date_flg5=${RcSch.RCSCH_ENDOFMONTH}) ";
      }
      addBuf = " AND template_id in ('${CpnRePrnTemp.SERVICE}','${CpnRePrnTemp
          .BITMAP}','${CpnRePrnTemp.MAKER}','${CpnRePrnTemp
          .SURVEY}','${CpnRePrnTemp.FRESH}','${CpnRePrnTemp
          .QUITSTOP}') AND $weekField = '1' AND ((date_flg1 = '0' AND date_flg2 = '0' AND date_flg3 = '0' AND date_flg4 = '0' AND date_flg5 = '0') OR (date_flg1 = '$date' OR date_flg2 = '$date' OR date_flg3 = '$date' OR date_flg4 = '$date' OR date_flg5 = '$date') $endOfMonthSql) AND (CASE WHEN timesch_flg = '1' THEN to_char(start_date, 'HH24:MI') <= to_char('$dtmNow'::timestamp, 'HH24:MI') AND to_char(end_date, 'HH24:MI') >= to_char('$dtmNow'::timestamp, 'HH24:MI') ELSE 1 = 1 END) ";
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcKyCpnprn.cpnTblRead(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    cpnPrnCnt = 0;
    mem.prnrBuf.cpnCnt = 0;
    int l = 0;
    int m = 0;
    int cnt = 1;
    String sql = "";
    String tmpCpnStartDateTime = "";
    String tmpCpnEndDateTime = "";
    String startDate = "";
    String endDate = "";
    String prnStreName = ""; /* 印字店舗名称 */
    String prnTime = ""; /* 印字期間 */
    String templateId = ""; /* テンプレートＩＤ */
    String pictPath = ""; /* 画像パス */
    String notes = ""; /* 注釈など */
    int line = 0;
    DbManipulationPs db = DbManipulationPs();
    Result dbRes;
    for (int i = 0; i < RxCntList.OTH_PROM_MAX; i++) {
      if ((mem.custCpnTbl[i].cpn_id != 0) &&
          ((mem.custCpnTbl[i].print_datetime != null) || (reprintFlg != 0)) &&
          (mem.custCpnTbl[i].stop_flg == 0)) {
        //クーポン管理マスタ読み取り
        sql =
        "SELECT cpn_start_datetime, cpn_end_datetime, stop_flg FROM c_cpn_ctrl_mst WHERE cpn_id = '${mem
            .custCpnTbl[i]
            .cpn_id}' AND cpn_start_datetime <= '$dtmNow' AND cpn_end_datetime >= '$dtmNow' AND stop_flg = 0 ";
        try {
          dbRes = await db.dbCon.execute(sql);
          if (dbRes.affectedRows != 1) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                "RcKyCpnprn.cpnTblRead(): c_cpn_ctrl_mst[$i] cpn_id[${mem
                    .custCpnTbl[i].cpn_id}] tuple[${dbRes.affectedRows}]");
            continue;
          }
          Map<String, dynamic> data = dbRes.first.toColumnMap();
          tmpCpnStartDateTime = data["cpn_start_datetime"];
          tmpCpnEndDateTime = data["cpn_end_datetime"];
        } catch (e) {
          //Cソース「db_PQexec() == NULL」時に相当
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcKyCpnprn.cpnTblRead(): read c_cpn_ctrl_mst db_PQexec() == NULL !!!");
          continue;
        }
        //クーポンヘッダー読み取り
        sql =
        "SELECT prn_stre_name, prn_time, start_date, end_date, template_id, pict_path, notes, line, stop_flg FROM c_cpnhdr_mst WHERE cpn_id = '${mem
            .custCpnTbl[i].cpn_id}' AND comp_cd = '${cBuf.dbRegCtrl
            .compCd}' AND stre_cd = '${cBuf.dbRegCtrl
            .streCd}' AND start_date <= '$dtmNow' AND end_date >= '$dtmNow' AND stop_flg = 0 $addBuf";
        try {
          dbRes = await db.dbCon.execute(sql);
          if (dbRes.affectedRows != 1) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                "RcKyCpnprn.cpnTblRead(): c_cpnhdr_mst[$i] cpn_id[${mem
                    .custCpnTbl[i].cpn_id}] tuple[${dbRes.affectedRows}]");
            continue;
          }
          Map<String, dynamic> data = dbRes.first.toColumnMap();
          startDate = data["start_date"];
          endDate = data["end_date"];
          prnStreName = data["prn_stre_name"];
          prnTime = data["prn_time"];
          templateId = data["template_id"];
          pictPath = data["pict_path"];
          notes = data["notes"];
          if ((templateId == CpnRePrnTemp.SERVICE) ||
              (templateId == CpnRePrnTemp.QUITSTOP) ||
              (templateId == CpnRePrnTemp.FRESH)) {
            line = int.parse(data["line"]);
          } else {
            line = CPNREPRN_ITEMDATA_MAX;
          }
          if ((templateId == CpnRePrnTemp.QUITSTOP) ||
              (templateId == CpnRePrnTemp.FRESH)) {
            if (ret == 0) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                  "RcKyCpnprn.cpnTblRead(): template_id = 10050 but there are no instre_flg");
              continue;
            } else if ((reprintFlg != 0) || RcSysChk.rcTROpeModeChk()) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                  "RcKyCpnprn.cpnTblRead(): template_id = 10050 no need to print");
              continue;
            }
          }
        } catch (e) {
          //Cソース「db_PQexec() == NULL」時に相当
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcKyCpnprn.cpnTblRead(): read c_cpnhdr_mst db_PQexec() == NULL !!!");
          continue;
        }

        mem.prnrBuf.cpnPrnBuf[l].cpnContentCnt = 0;
        m = 0;
        if ((templateId == CpnRePrnTemp.SERVICE) ||
            (templateId == CpnRePrnTemp.MAKER) ||
            (templateId == CpnRePrnTemp.QUITSTOP) ||
            (templateId == CpnRePrnTemp.FRESH)) {
          for (int j = 0; j < CPNREPRN_ITEMDATA_MAX && m < line; j++) {
            if (mem.custCpnTbl[i].print_flg[j] == 0) {
              continue;
            }
            //クーポン明細読み取り
            sql =
            "SELECT unnest(cpn_content) AS cpn_content FROM c_cpnbdy_mst WHERE plan_cd = '${mem
                .custCpnTbl[i].cpn_data}'";
            try {
              dbRes = await db.dbCon.execute(sql);
              if ((dbRes.affectedRows == 0) ||
                  ((templateId == CpnRePrnTemp.SERVICE) &&
                      (dbRes.affectedRows != CPNREPRN_CPNCONTENT_SERVICE)) ||
                  ((templateId == CpnRePrnTemp.MAKER) &&
                      (dbRes.affectedRows != CPNREPRN_CPNCONTENT_MAKER)) ||
                  ((templateId == CpnRePrnTemp.QUITSTOP) &&
                      (dbRes.affectedRows != CPNREPRN_CPNCONTENT_FRESH)) ||
                  ((templateId == CpnRePrnTemp.FRESH) &&
                      (dbRes.affectedRows != CPNREPRN_CPNCONTENT_FRESH))) {
                TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                    "RcKyCpnprn.cpnTblRead(): c_cpnbdy_mst[$i][$j] cpn_id[${mem
                        .custCpnTbl[i].cpn_id}] plan_cd[${mem.custCpnTbl[i]
                        .cpn_data}] template_id[$templateId] tuple[${dbRes
                        .affectedRows}]");
                continue;
              }
              if (templateId == CpnRePrnTemp.SERVICE) {
                cnt = CPNREPRN_CPNCONTENT_SERVICE;
              } else if ((templateId == CpnRePrnTemp.FRESH) ||
                  (templateId == CpnRePrnTemp.QUITSTOP)) {
                cnt = CPNREPRN_CPNCONTENT_FRESH;
              } else {
                cnt = CPNREPRN_CPNCONTENT_MAKER;
              }
              Map<String, dynamic> data = dbRes.first.toColumnMap();
              for (int k = 0; k < cnt; k++) {
                switch (k) {
                  case 0:
                    mem.prnrBuf.cpnPrnBuf[l].cpnData[m] =
                    mem.custCpnTbl[i].cpn_data!;
                    mem.prnrBuf.cpnPrnBuf[l].cpnContent[m].name =
                    data["cpn_content"];
                    mem.prnrBuf.cpnPrnBuf[l].cpnContentCnt++;
                    TprLog().logAdd(
                        await RcSysChk.getTid(), LogLevelDefine.normal,
                        "RcKyCpnprn.cpnTblRead(): DEBUG: c_cpnbdy_mst[$i][$j] cpn_id[${mem
                            .custCpnTbl[i].cpn_id}] plan_cd[${mem.custCpnTbl[i]
                            .cpn_data}] template_id[$templateId] tuple[${dbRes
                            .affectedRows}] cnt[$l][$m]<$line>");
                    break;
                  case 1:
                    mem.prnrBuf.cpnPrnBuf[l].cpnContent[m].limit =
                    data["cpn_content"];
                    break;
                  case 2:
                    mem.prnrBuf.cpnPrnBuf[l].cpnContent[m].amt =
                    data["cpn_content"];
                    break;
                  case 3:
                    mem.prnrBuf.cpnPrnBuf[l].cpnContent[m].jan =
                    data["cpn_content"];
                    break;
                  default:
                    break;
                }
              }
              m++;
              if (mem.prnrBuf.cpnPrnBuf[l].cpnContentCnt == 0) {
                continue;
              }
            } catch (e) {
              //Cソース「db_PQexec() == NULL」時に相当
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                  "RcKyCpnprn.cpnTblRead(): read c_cpnbdy_mst db_PQexec() == NULL !!!");
              continue;
            }
          }
        }
        mem.prnrBuf.cpnPrnBuf[l].custNo = mem.custCpnTbl[i].cust_no!;
        mem.prnrBuf.cpnPrnBuf[l].cpnId = mem.custCpnTbl[i].cpn_id.toString();
        mem.prnrBuf.cpnPrnBuf[l].prnStreName = prnStreName;
        mem.prnrBuf.cpnPrnBuf[l].prnTime = prnTime;
        mem.prnrBuf.cpnPrnBuf[l].templateId = templateId;
        mem.prnrBuf.cpnPrnBuf[l].pictPath = pictPath;
        mem.prnrBuf.cpnPrnBuf[l].notes = notes;
        mem.prnrBuf.cpnPrnBuf[l].instreFlg = instreRec.instre_flg!;
        cpnStartDateTime[l] = tmpCpnStartDateTime;
        cpnEndDateTime[l] = tmpCpnEndDateTime;
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "RcKyCpnprn.cpnTblRead(): Data get to prnbuf[$l] cpn_id[${mem
                .prnrBuf.cpnPrnBuf[l].cpnId}] content_cnt[${mem.prnrBuf
                .cpnPrnBuf[l].cpnContentCnt}] line[$line]");
        cpnPrnCnt++;
        l++;
      }
    }
    if (cpnPrnCnt != 0) {
      if ((await CmCksys.cmZHQSystem() != 0) && (cBuf.kitchen_prn1_run != 1)) {
        await rcCpnPrnPrintErrSet(CPNREPRN_PRINT_ERR);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "RcKyCpnprn.cpnTblRead(): There is no printer.");
        return -1;
      }
      if (!((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
          !(await RcSysChk.rcCheckQCJCSystem()))
          && (await rcCpnPrnSelfCheck())) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "RcKyCpnprn.cpnTblRead(): cpnprn_cnt [$cpnPrnCnt]");
        mem.prnrBuf.cpnCnt = cpnPrnCnt;
        // TODO:10070 タイマータスク
        //rccpnprn_TimerAdd(50, (GtkFunction)rccpnprn_ZHQcpn_Thread);
      }
    } else {
      if ((reprintFlg != 0) && (regsReprintFlg == 0)) {
        // TODO:10122 グラフィックス処理
        /*
        rcconprn_msgChg(lbl1_1, ZHQMSG_NOCPNINF);
        gtk_widget_hide(lbl2_1);
        rcconprn_msgChg(lbl3_1, ZHQMSG_NORMALEND);
        gtk_widget_set_sensitive(cpnreprn_end, TRUE);
        if (cpnreprn_window2 != NULL) {
          rcconprn_msgChg(lbl1_2, ZHQMSG_NOCPNINF);
          gtk_widget_hide(lbl2_2);
          rcconprn_msgChg(lbl3_2, ZHQMSG_NORMALEND);
          gtk_widget_set_sensitive(cpnreprn_end2, TRUE);
        }
         */
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "There is no coupon.");
    }

    return cpnPrnCnt;
  }

  /// セルフ機の使用チェック関数
  /// 戻り値: false=使用不可  true=使用可
  ///  関連tprxソース: rcky_pcnprn.c - rccpnprn_SelfCheck
  static Future<bool> rcCpnPrnSelfCheck() async {
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "RcKyCpnprn.rcCpnPrnSelfCheck(): rxMemRead error");
        return false;
      }
      RxCommonBuf cBuf = xRet.object;
      if (! (await RcSysChk.rcChkShopAndGoSystem()    // S&G精算機
        || (cBuf.hsFsQcMenteMode == 1)))    // HappyフルセルフでのQCメンテナンス画面
      {
        return false;
      }
    }
    return true;
  }

  /// 印字中or印字エラーメッセージを表示する
  /// 引数: 1=印字エラー  1以外=印字中
  /// 戻り値: false=使用不可  true=使用可
  ///  関連tprxソース: rcky_pcnprn.c - rccpnprn_printErrSet
  static Future<void> rcCpnPrnPrintErrSet(int num) async {
    //rcStl_pthread_mutex_lock();
    RegsMem mem = SystemFunc.readRegsMem();
    mem.tTtllog.t106500Sts[0].cpnPrnRes = num;
    if ((regsReprintFlg != 0) && (num > 0)) {
      mem.tTtllog.t106500Sts[0].cpnPrnRes += 10;
    }
    //rcStl_pthread_mutex_unlock();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcKyCpnprn.rcCpnPrnPrintErrSet(): [$num][$rcCpnPrnInputFlg]");
    if (rcCpnPrnInputFlg != 0) {
      // TODO:10122 グラフィックス処理
      /*
      if (num == -1) {
        rcconprn_msgChg(lbl3_1, ZHQMSG_PRINTING);
        gtk_widget_set_sensitive(cpnreprn_end, FALSE);
        if (cpnreprn_window2 != NULL) {
          rcconprn_msgChg(lbl3_2, ZHQMSG_PRINTING);
          gtk_widget_set_sensitive(cpnreprn_end2, FALSE);
        }
      } else {
        rcconprn_msgChg(lbl1_1, ZHQMSG_CANTPRINT);
        rcconprn_msgChg(lbl2_1, ZHQMSG_ONEMORE);
        rcconprn_msgChg(lbl3_1, ZHQMSG_PRINTERR);
        gtk_widget_set_sensitive(cpnreprn_end, TRUE);
        if (cpnreprn_window2 != NULL) {
          rcconprn_msgChg(lbl1_2, ZHQMSG_CANTPRINT);
          rcconprn_msgChg(lbl2_2, ZHQMSG_ONEMORE);
          rcconprn_msgChg(lbl3_2, ZHQMSG_PRINTERR);
          gtk_widget_set_sensitive(cpnreprn_end2, TRUE);
        }
      }
       */
    }
  }
}