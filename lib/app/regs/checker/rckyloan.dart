/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_inout.dart';
import 'package:flutter_pos/app/regs/checker/rc_recno.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl.dart';
import 'package:flutter_pos/app/regs/checker/rcinoutdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcky_cin.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:postgres/postgres.dart';
import 'package:sprintf/sprintf.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff_keyopt.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../inc/rc_mem.dart';
import '../../regs/checker/rc_flrd.dart';

/// 関連tprxソース: rckyloan.c
class RcKyLoan{
  static InOutInfo inOut = InOutInfo();
  static const LOAN_INI_PATH = "conf/chkr_save.ini";
  static KoptinoutBuff koptInOut = KoptinoutBuff();

  /// 関連tprxソース: rckyloan.c - LoanData
  static List<IniLoanData> loanData =
  [
    IniLoanData("inout_10000", InoutDisp.INOUT_Y10000, 0),
    IniLoanData("inout_5000", InoutDisp.INOUT_Y5000, 0),
    IniLoanData("inout_2000", InoutDisp.INOUT_Y2000, 0),
    IniLoanData("inout_1000", InoutDisp.INOUT_Y1000, 0),
    IniLoanData("inout_500", InoutDisp.INOUT_Y500, 0),
    IniLoanData("inout_100", InoutDisp.INOUT_Y100, 0),
    IniLoanData("inout_50", InoutDisp.INOUT_Y50, 0),
    IniLoanData("inout_10", InoutDisp.INOUT_Y10, 0),
    IniLoanData("inout_5", InoutDisp.INOUT_Y5, 0),
    IniLoanData("inout_1", InoutDisp.INOUT_Y1, 0),
    IniLoanData(null, -1, 0),
  ];

  /// 関連tprxソース: rckyloan.c - rcUpdate_ChgLoan_Auto
  static Future<void> rcUpdateChgLoanAuto() async {
    int errNo = 0;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcUpdateChgLoanAuto';

    if (await rcUpdateChgLoanAutoChk() == 0) {
      return;
    }

    inOut.fncCode = cMem.stat.fncCode;
    await RcFlrda.rcReadKoptinout(
        cMem.stat.fncCode, koptInOut); //関数内使用している可能性があるため、せっとしておく
    await rcGetLoanData(); //釣準備実績取得
    if (inOut.stockBtnOff != 0) {
      log = "$callFunc: Loan already exist[$errNo]";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      return;
    }

    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      inOut.chgCinLoanFlg = 2; //釣機在高
      errNo = await RcAcracb.rcAcrAcbAnswerReadDtl();
      if (errNo == 0) {
        errNo = await RcAcracb.rcChkAcrAcbChkStock(0);
        await Rcinoutdsp.rcAcrAcbMakeShtData();
      }
    }

    Rcinoutdsp.rcCalDifferentTtl();
    if (errNo == 0) {
      await Future.delayed(const Duration(seconds: 1));
      errNo = await rcUpdateFrestaAcxInfo();
    }

    if ((errNo == 0) && await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      rcUpdateDiffLoan();
      errNo = RcIfEvent.rcSendUpdate();

      if (errNo == 0) {
        await rcSaveLoanData(koptInOut); //必要？？？＠＠＠
      }

      await RcRecno.rcIncRctJnlNo(true);
      await Future.delayed(const Duration(seconds: 1));
    }

    if (errNo != 0) {
      AplLibAuto.aplLibAutoEjWrite(await RcSysChk.getTid(),
          AutoLibEj.AUTOLIB_EJ_ERROR.value, errNo, null);
    }
    await RcSet.rcClearDataReg();
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); /* Total Reicept Clear */
    cMem.postReg = PostReg();
  }

  /// 釣準備、/pj/tprx/conf/chkr_save.iniへ入力データを書き込む
  /// 関連tprxソース: rckyloan.c - rcSaveLoanData
  static Future<void> rcSaveLoanData(KoptinoutBuff koptInOut) async {
    String iniFile = '';
    String log = '';
    String setBuf = '';
    int i = 0;
    int ret = 0;
    String callFunc = 'rcSaveLoanData';

    if (koptInOut.keepFlg == 0 || inOut.chgCinLoanFlg != 0) {
      return;
    }

    iniFile = sprintf("%s/%s", [EnvironmentData().sysHomeDir, LOAN_INI_PATH]);

    for (i = 0; loanData[i].name != null; i++) {
      setBuf = inOut.InOutBtn[loanData[i].code].Count.toString();
      // TODO:10164 自動閉設 実装保留
      // ret = TprLibSetIni(iniFile, LOAN_SECTION, loanData[i].name, setBuf);
      if (ret != 0) {
        log = "$callFunc : err($ret)";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      }
    }
  }

  /// 開設処理で自動釣準備を作成するか判断
  /// ０：しない　１：する
  /// 関連tprxソース: rckyloan.c - rcUpdate_ChgLoan_Auto_Chk
  static Future<int> rcUpdateChgLoanAutoChk() async {
    if (RcSysChk.rcsyschkSm66FrestaSystem() &&
//	   (rcCheck_AcrAcb_ON(1) != 0)		&&
        AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) ==
            AutoRun.AUTORUN_STROPN.val && /* 自動開店 */
        AplLibAuto.aplLibAutoGetAutoMode(await RcSysChk.getTid()) ==
            AutoMode.AUTOMODE_KY_LOAN_DATA.val) { //開店自動釣準備
      await RcFlrda.rcReadKoptinout(FuncKey.KY_LOAN.keyId, koptInOut);
      if (koptInOut.frcSelectFlg != 0) { //金種別
        return 1;
      }
    }
    return 0;
  }

  /// 釣準備画面表示用釣準備実績と釣機在高ボタン使用可能判定用の実績取得
  /// 関連tprxソース: rckyloan.c - rcGetLoanData
  static Future<void> rcGetLoanData() async {
    int tuples = 0;
    TprMID aid;
    String sql = '';
    String compareSql = '';
    String log = '';
    int startNo = 0;
    int loanCnt = 0;
    int loanAmt = 0;
    int cashDrwAmt = 0;
    int visitCnt = 0;
    String callFunc = 'rcGetLoanData';
    Result res;
    DbManipulationPs db = DbManipulationPs();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    aid = await RcFlrd.rcGetProcessID();

    sql = sprintf(
        "select receipt_no from c_header_log where mac_no='%i' and ope_mode_flg ='%i' order by endtime desc;\n",
        [
          await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid()),
          OpeModeFlagList.OPE_MODE_CLOSE_LINE
        ]);

    try {
      res = await db.dbCon.execute(sql);
      if (res.isEmpty) {
        //Cソース「db_PQntuples() != 1」時に相当
        startNo = 0;
      } else {
        Map<String, dynamic> data = res.elementAt(0).toColumnMap();
        startNo = int.tryParse(data["receipt_no"]) ?? 0;
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      return;
    }

    //締め精算時と現在のレシート番号を比較し、一周回っている場合を考慮
    if (await Counter.competitionGetRcptNo(await RcSysChk.getTid()) < startNo) {
      compareSql = sprintf("and (receipt_no >= '%i' or receipt_no <= '%i') ", [
        startNo,
        await Counter.competitionGetRcptNo(await RcSysChk.getTid())
      ]);
    } else {
      compareSql = sprintf("and receipt_no >= '%i' ", [startNo]);
    }

    //サービスよりの要望にて訓練での釣準備実績は取得しないよう変更
    sql = "select "
        "sum(case when data.func_cd='105000' and header.ope_mode_flg <> '${OpeModeFlagList.OPE_MODE_TRAINING}' then data.n_data2 else '0' end)::integer as loan_cnt, "
        "sum(case when data.func_cd='105000' and header.ope_mode_flg <> '${OpeModeFlagList.OPE_MODE_TRAINING}' then data.n_data3 else '0' end)::integer as loan_amt, "
        "sum(case when data.func_cd='100200' and data.n_data1='${FuncKey.KY_CASH.keyId}' then data.n_data5 else '0' end)::integer as cash_drw_amt, "
        "sum(case when data.func_cd='100001' then data.n_data23 else '0' end)::integer as visit_cnt "
        "from c_data_log as data left outer join c_header_log as header on (data.serial_no = header.serial_no) "
        "where "
        "data.serial_no in (select serial_no from c_header_log where comp_cd='${cBuf.dbRegCtrl.compCd}' and stre_cd='${cBuf.dbRegCtrl.streCd}' and mac_no='${await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())}' $compareSql);\n";

    try {
      res = await db.dbCon.execute(sql);

      Map<String, dynamic> data = res.elementAt(0).toColumnMap();
      startNo = int.tryParse(data["visit_cnt"]) ?? 0;
      /* 釣準備回数 */
      loanCnt = int.tryParse(data["loan_cnt"]) ?? 0;
      /* 釣準備金額 */
      loanAmt = int.tryParse(data["loan_amt"]) ?? 0;
      /* 現金理論在高 */
      cashDrwAmt = int.tryParse(data["cash_drw_amt"]) ?? 0;
      /* 来店回数（取引回数） */
      visitCnt = int.tryParse(data["visit_cnt"]) ?? 0;
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      log = "$callFunc : get data Error!\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      return;
    }

    tuples = res.length;
    if (tuples == 0) {
      log = "$callFunc : First KY_LOAN\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return;
    }

    log = "$callFunc : loan_cnt[$loanCnt] loan_amt[$loanAmt]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    log = "$callFunc : cash_drw_amt[$cashDrwAmt] visit_cnt[$visitCnt]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    inOut.stockBtnOff = 0;
    inOut.sumLoanCnt = loanCnt;
    inOut.sumLoanAmt = loanAmt;
    if (loanCnt != 0 || loanAmt != 0 || cashDrwAmt != 0 || visitCnt != 0) {
      inOut.stockBtnOff = 1; //いずれかの実績が存在するため、釣機在高ボタン使用不可にする
    }
  }

  /// 関連tprxソース: rckyloan.c - rcUpdate_fresta_acxinfo
  static Future<int> rcUpdateFrestaAcxInfo() async {
    String log = '';
    int errNo = 0;
    String callFunc = 'rcUpdateFrestaAcxInfo';

    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); /* Ttl Buffer All Clear */
    RegsMem().tHeader.prn_typ = PrnterControlTypeIdx.TYPE_ACXINFO.index;
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
//釣銭情報実績(t105500)
    RegsMem().tTtllog.t105500.sht10000 =
        inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count;
    RegsMem().tTtllog.t105500.sht5000 =
        inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count;
    RegsMem().tTtllog.t105500.sht2000 =
        inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count;
    RegsMem().tTtllog.t105500.sht1000 =
        inOut.InOutBtn[InoutDisp.INOUT_Y1000].Count;
    RegsMem().tTtllog.t105500.sht500 =
        inOut.InOutBtn[InoutDisp.INOUT_Y500].Count;
    RegsMem().tTtllog.t105500.sht100 =
        inOut.InOutBtn[InoutDisp.INOUT_Y100].Count;
    RegsMem().tTtllog.t105500.sht50 = inOut.InOutBtn[InoutDisp.INOUT_Y50].Count;
    RegsMem().tTtllog.t105500.sht10 = inOut.InOutBtn[InoutDisp.INOUT_Y10].Count;
    RegsMem().tTtllog.t105500.sht5 = inOut.InOutBtn[InoutDisp.INOUT_Y5].Count;
    RegsMem().tTtllog.t105500.sht1 = inOut.InOutBtn[InoutDisp.INOUT_Y1].Count;
    RegsMem().tTtllog.t105500.drawAmt = inOut.Pdata.TotalPrice;
    RegsMem().tTtllog.t105500.autoFlg = 1;
    errNo = RcIfEvent.rcSendUpdate();
    if (errNo != 0) {
      log = "$callFunc: Update error[$errNo]";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
    }
    await RcRecno.rcIncRctJnlNo(true);
    return errNo;
  }

  /// 関連tprxソース: rckyloan.c - rcUpdate_DiffLoan
  static Future<void> rcUpdateDiffLoan() async {
    int type = 0;
    await RckyCin.rcUpdateDiffEdit(type);
    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      await RcAcracb.rcAcrAcbStockUpdate(1);
    }
  }
}

/// 関連tprxソース: rckyloan.c - IniLoanData
class IniLoanData {
  String? name = '';
  int code = 0;
  int diffData = 0;

  IniLoanData(this.name, this.code, this.diffData);
}
