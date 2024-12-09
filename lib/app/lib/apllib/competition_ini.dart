/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:sprintf/sprintf.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/counter.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/counterJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

export '../../inc/apl/counter.dart';

///  CompetisionIniの返り値クラス.
class CompetitionIniRet {
  bool isSuccess = true;
  dynamic value;

  CompetitionIniRet(this.isSuccess, [this.value = null]);
}

///  関連tprxソース: competition_ini.c
class CompetitionIni {
  ///  関連tprxソース:competition_ini.c- MACNO_LOG
  static const MACNO_LOG = false;

  static Future<CompetitionIniRet> competitionIniGetMacNo(TprTID tid) async {
    return await competitionIniGet(tid, CompetitionIniLists.COMPETITION_INI_MAC_NO,
        CompetitionIniType.COMPETITION_INI_GETMEM);
  }

  ///  関連tprxソース: competition_ini.c - competition_ini_get_long()
  ///  DBからレシートNoを取得する.
  static Future<CompetitionIniRet> competitionIniGetRcptNo(TprTID tid) async {
    // DBから値を取得する方針に変更したため、コメントアウト
    // return await competitionIni(tid, CompetitionIniLists.COMPETITION_INI_RCPT_NO,
    //     CompetitionIniType.COMPETITION_INI_GETMEM);
    bool getResult;
    Map<String, dynamic> setResult;
    String log = "";
    int count = 0;
    PRecogCounterLog recogCounterLog = PRecogCounterLog();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "competitionIniGetRcptNo() rxMemRead error\n");
      return CompetitionIniRet(false);
    }
    RxCommonBuf cBuf = xRet.object;

    while(true){
      // p_regcounter_logのデータ取得
      getResult = await getRegcounterLog(tid, recogCounterLog);
      if(!getResult){
        log = "competitionIniGetRcptNo() : getRegcounterLog error";
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        return CompetitionIniRet(false);
      }

      // p_regcounter_logの更新
      setResult = await setRegcounterLog(tid,recogCounterLog);
      if(setResult["resultSql"] == Typ.NG){
        log = "competitionIniGetRcptNo() : setRegcounterLog error";
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        return CompetitionIniRet(false);
      }
      // 更新なし、または更新失敗の場合は再度更新を試みる
      if(setResult["resultFunc"] == Typ.NG){
        count++;
        if(count > 20){
          log = "competitionIniGetRcptNo() : count over !!!! ";
          TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
          return CompetitionIniRet(false);
        }

        log = sprintf("competitionIniGetRcptNo() : continue [%d] [%d] [%d]",
            [cBuf.dbRegCtrl.compCd, cBuf.dbRegCtrl.streCd, cBuf.dbRegCtrl.macNo]);
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);

        Future.delayed(const Duration(milliseconds: 100000));
        continue;
      }
      break;
    }
    return CompetitionIniRet(true, recogCounterLog.cnt_json_data["receipt_no"]);
  }
  ///  DBからレシートNoを取得する.
  static Future<CompetitionIniRet> competitionIniSetRcptNo(TprTID tid,int rcptNo) async {
    bool getResult;
    Map<String, dynamic> setResult;
    String log = "";
    int count = 0;
    PRecogCounterLog recogCounterLog = PRecogCounterLog();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "competitionIniSetRcptNo() rxMemRead error\n");
      return CompetitionIniRet(false);
    }
    RxCommonBuf cBuf = xRet.object;

    while(true){
      getResult = await getRegcounterLog(tid, recogCounterLog);
      if(!getResult){
        log = "competitionIniSetRcptNo() : getRegcounterLog error";
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        return CompetitionIniRet(false);
      }
      // 更新用のrcptNoをセット
      recogCounterLog.cnt_json_data["receipt_no"] = rcptNo;

      // p_regcounter_logの更新
      setResult = await setRegcounterLog(tid,recogCounterLog);
      if(setResult["resultSql"] == Typ.NG){
        log = "competitionIniSetRcptNo() : setRegcounterLog error";
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        return CompetitionIniRet(false);
      }
      // 更新なし、または更新失敗の場合は再度更新を試みる
      if(setResult["resultFunc"] == Typ.NG){
        count++;
        if(count > 20){
          log = "competitionIniSetRcptNo() : count over !!!! ";
          TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
          return CompetitionIniRet(false);
        }

        log = sprintf("competitionIniSetRcptNo() : continue [%d] [%d] [%d]",
            [cBuf.dbRegCtrl.compCd, cBuf.dbRegCtrl.streCd, cBuf.dbRegCtrl.macNo]);
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        Future.delayed(const Duration(milliseconds: 100000));
        continue;
      }
      break;
    }
    return CompetitionIniRet(true);
  }

  /// DBからプリントNoを取得する
  static Future<CompetitionIniRet> competitionIniGetPrintNo(TprTID tid) async {
    // return await competitionIni(
    //     tid,
    //     CompetitionIniLists.COMPETITION_INI_PRINT_NO,
    //     CompetitionIniType.COMPETITION_INI_GETMEM);
    bool getResult;
    Map<String, dynamic> setResult;
    String log = "";
    int count = 0;
    PRecogCounterLog recogCounterLog = PRecogCounterLog();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "competitionIniGetPrintNo() rxMemRead error\n");
      return CompetitionIniRet(false);
    }
    RxCommonBuf cBuf = xRet.object;

    while(true){
      // p_regcounter_logのデータ取得
      getResult = await getRegcounterLog(tid, recogCounterLog);
      if(!getResult){
        log = "competitionIniGetPrintNo() : getRegcounterLog error";
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        return CompetitionIniRet(false);
      }

      // p_regcounter_logの更新
      setResult = await setRegcounterLog(tid,recogCounterLog);
      if(setResult["resultSql"] == Typ.NG){
        log = "competitionIniGetPrintNo() : setRegcounterLog error";
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        return CompetitionIniRet(false);
      }
      // 更新なし、または更新失敗の場合は再度更新を試みる
      if(setResult["resultFunc"] == Typ.NG){
        count++;
        if(count > 20){
          log = "competitionIniGetPrintNo() : count over !!!! ";
          TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
          return CompetitionIniRet(false);
        }

        log = sprintf("competitionIniGetPrintNo() : continue [%d] [%d] [%d]",
            [cBuf.dbRegCtrl.compCd, cBuf.dbRegCtrl.streCd, cBuf.dbRegCtrl.macNo]);
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);

        Future.delayed(const Duration(milliseconds: 100000));
        continue;
      }
      break;
    }
    return CompetitionIniRet(true, recogCounterLog.cnt_json_data["print_no"]);
  }
  /// DBにプリントNoをセットする
  static Future<CompetitionIniRet> competitionIniSetPrintNo(TprTID tid, int printNo) async {
    bool getResult;
    Map<String, dynamic> setResult;
    String log = "";
    int count = 0;
    PRecogCounterLog recogCounterLog = PRecogCounterLog();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "competitionIniSetPrintNo() rxMemRead error\n");
      return CompetitionIniRet(false);
    }
    RxCommonBuf cBuf = xRet.object;

    while(true){
      getResult = await getRegcounterLog(tid, recogCounterLog);
      if(!getResult){
        log = "competitionIniSetPrintNo() : getRegcounterLog error";
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        return CompetitionIniRet(false);
      }
      // 更新用のrcptNoをセット
      recogCounterLog.cnt_json_data["print_no"] = printNo;

      // p_regcounter_logの更新
      setResult = await setRegcounterLog(tid,recogCounterLog);
      if(setResult["resultSql"] == Typ.NG){
        log = "competitionIniSetPrintNo() : setRegcounterLog error";
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
        return CompetitionIniRet(false);
      }
      // 更新なし、または更新失敗の場合は再度更新を試みる
      if(setResult["resultFunc"] == Typ.NG){
        count++;
        if(count > 20){
          log = "competitionIniSetPrintNo() : count over !!!! ";
          TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);
          return CompetitionIniRet(false);
        }

        log = sprintf("competitionIniSetPrintNo() : continue [%d] [%d] [%d]",
            [cBuf.dbRegCtrl.compCd, cBuf.dbRegCtrl.streCd, cBuf.dbRegCtrl.macNo]);
        TprLog().logAdd(tid, LogLevelDefine.error, log, errId: -1);

        Future.delayed(const Duration(milliseconds: 100000));
        continue;
      }
      break;
    }
    return CompetitionIniRet(true);
  }
  /// 値をSetするCompetitionIniTypeの時に使用する.
  /// 関連tprxソース: competition_ini.c - competition_ini()
  static Future<CompetitionIniRet> competitionIniSet(
    TprTID tid, CompetitionIniLists competitionNo, CompetitionIniType type,
    String? settingValue) async {
    if(!type.isSetValue()){
      debugPrint("competitionIniSet() setting type ${type.name} error");
      return CompetitionIniRet(false);
    }
    return await _competitionIni(tid, competitionNo, type, settingValue: settingValue);
  } 

  /// 値をGetするCompetitionIniTypeの時に使用する.
  /// 関連tprxソース: competition_ini.c - competition_ini()
  static Future<CompetitionIniRet> competitionIniGet(
      TprTID tid, CompetitionIniLists competitionNo, CompetitionIniType type) async{
    if(type.isSetValue()){
      debugPrint("competitionIniGet() setting type ${type.name} error");
      return CompetitionIniRet(false);
    }
    return await _competitionIni(tid, competitionNo, type);
  }

  ///  関連tprxソース: competition_ini.c - competition_ini()
  static Future<CompetitionIniRet> _competitionIni(
      TprTID tid, CompetitionIniLists competitionNo, CompetitionIniType type,
      {String? settingValue}) async {
    late RxCommonBuf cMem;
    if (competitionNo.index < 0 ||
        CompetitionIniLists.COMPETITION_INI_MAX.index <= competitionNo.index) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "competitionIni() param error[${competitionNo.name}][${type.name}][${settingValue.toString()}]",
          errId: -1);
      return CompetitionIniRet(false, settingValue);
    }
    if(type.isSetValue() && settingValue == null){
      // 値をセットするタイプなのにセットする値がnullの場合はエラー
        TprLog().logAdd(tid, LogLevelDefine.error,
            "competitionIni() setting none value Error[${competitionNo.name}][${type.name}][${settingValue.toString()}]");
       return CompetitionIniRet(false, settingValue);
    }

    // メモリがターゲットならtrue.
    bool isUseMemory = false;
    // パラメータチェック：指定が共有メモリ.
    if (type.isUseMemory()) {
      if (!competitionNo.canUseMemory()) {
        // メモリからの取得やセットは出来ない物のターゲットがメモリになっているのでエラー.
        TprLog().logAdd(tid, LogLevelDefine.error,
            "competitionIni() MEM typ not support Error[${competitionNo.name}][${type.name}][${settingValue.toString()}]");
        return CompetitionIniRet(false, settingValue);
      }
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(
            tid,
            LogLevelDefine.error,
            "competitionIni() rxMemRead Error"
            "[${competitionNo.name}][${type.name}][${settingValue.toString()}]");
        return CompetitionIniRet(false, settingValue);
      }
      cMem = xRet.object;
      isUseMemory = true;
    }
    if (type.isUseJson() && !competitionNo.canUseJson()) {
      // パラメータチェック：指定が設定ファイルなのにcompetitionNoが設定ファイルのものではない.
      TprLog().logAdd(tid, LogLevelDefine.error,
          "competitionIni() SYS typ not support Error[${competitionNo.name}][${type.name}][${settingValue.toString()}]");
      return CompetitionIniRet(false, settingValue);
    }

    // データ参照先をＪＣ判定が必要か？
    bool qcjc_state = false;
    bool qcjc_c_get = false;
    bool qcjc_regs = false; /* 0以外の場合、QCJC動作の登録モード、訓練モード  */
    bool qcjc_regs_c = false; /* 登録、訓練 0:QCashierJのデータ 1:WebSpeezaCデータ */
    bool qcjc_cnct_c = false; /* 0:QCashierJのデータ 1:WebSpeezaCデータ */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);

    if (xRet.isValid()) {
      cMem = xRet.object;

      if (cMem.iniSys.type.qcashier_system != 0.toString() &&
          cMem.iniSys.type.receipt_qr_system != 0.toString()) {
        qcjc_state = cMem.qcjcStat;
      }
        if (CompileFlag.SMART_SELF &&
            cMem.iniSys.type.desktop_cashier_system != 0.toString()) {
          qcjc_state = false;
        }

        if (qcjc_state) {
          // TODO:10023 QCJC仕様
        }

    } else {
      switch (type) {
        case CompetitionIniType.COMPETITION_INI_GETSYS_JC_C:
        case CompetitionIniType.COMPETITION_INI_SETSYS_JC_C:
          qcjc_c_get = true;
          break;
        default:
      }
    }
    late ConfigJsonFile jsonFile;
    String section = "";
    String keyword = "";
    switch (competitionNo) {
      case CompetitionIniLists.COMPETITION_INI_RCT_DNS:
      case CompetitionIniLists.COMPETITION_INI_RCT_LF_PLUS:
      case CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT:
      case CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE:
      case CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE2:
      case CompetitionIniLists.COMPETITION_INI_ERR_RPR_TIMER:
      case CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE:
        jsonFile = cMem.iniMacInfo;
        section = "printer";
        keyword = "";
        break;
      case CompetitionIniLists.COMPETITION_INI_MAC_NO:
      case CompetitionIniLists.COMPETITION_INI_CRPNO_NO:
      case CompetitionIniLists.COMPETITION_INI_SHPNO_NO:
        jsonFile = cMem.iniMacInfo;
        section = "system";
        keyword = "";

        break;
      default:
        jsonFile = cMem.iniCounter;
        section = "tran";
        keyword = "";
        break;
    }
    CompetitionIniModel model;
    dynamic pData;
    // 参照データ設定
    switch (competitionNo) {
      case CompetitionIniLists.COMPETITION_INI_MAC_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniMacInfoMacNo;
          if (qcjc_cnct_c) {
            // // TODO:10023 QCJC仕様
            //
            // if (cMem.qcjc_c == CmdFunc.getpid())
            // {
            //   if (cMem.qcjc_frcclk_chg == 0)
            //   {
            //    pData = (void *)&cmem->ini_macinfo_JC_C.macno;
            //   }
            // }
            // else
            // {
            //   pData = (void *)&cmem->ini_macinfo_JC_C.macno;
            // }
          }
        }
        keyword = "macno";
        break;
      case CompetitionIniLists.COMPETITION_INI_CRPNO_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        break;
      case CompetitionIniLists.COMPETITION_INI_SHPNO_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        keyword = "shpno";
        break;
      case CompetitionIniLists.COMPETITION_INI_RCT_DNS:
      case CompetitionIniLists.COMPETITION_INI_RCT_LF_PLUS:
      case CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT:
      case CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE:
      case CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE2:
      case CompetitionIniLists.COMPETITION_INI_ERR_RPR_TIMER:
      case CompetitionIniLists.COMPETITION_INI_RCT_NEAREND_CHK:
      case CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_SHORT;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          switch (competitionNo) {
            case CompetitionIniLists.COMPETITION_INI_RCT_DNS:
              pData = cMem.iniMacInfo.printer.rct_dns;
              if (qcjc_cnct_c) {
                //  // TODO:10023 QCJC仕様
                // pData = (void *)&cmem->ini_macinfo_JC_C.rct_dns;
              }
              break;
            case CompetitionIniLists.COMPETITION_INI_RCT_LF_PLUS:
              pData = cMem.iniMacInfo.printer.rct_lf_plus;
              if (qcjc_cnct_c) {
                // TODO:10023 QCJC仕様
                // pData = (void *)&cmem->ini_macinfo_JC_C.rct_lf_plus;
              }
              break;
            case CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT:
              pData = cMem.iniMacInfo.printer.rct_tb_cut;
              if (qcjc_cnct_c) {
                // TODO:10023 QCJC仕様
                //  pData = (void *)&cmem->ini_macinfo_JC_C.rct_tb_cut;
              }
              break;
            case CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE:
              pData = cMem.iniMacInfo.printer.rct_cut_type;
              if (qcjc_cnct_c) {
                // TODO:10023 QCJC仕様
                // (void *)&cmem->ini_macinfo_JC_C.rct_cut_type;
              }
              break;
            case CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE2:
              pData = cMem.iniMacInfo.printer.rct_cut_type2;
              if (qcjc_cnct_c) {
                // TODO:10023 QCJC仕様
                // (void *)&cmem->ini_macinfo_JC_C.rct_cut_type2;
              }
              break;
            case CompetitionIniLists.COMPETITION_INI_RCT_NEAREND_CHK:
              pData = cMem.iniMacInfo.printer.nearend_check;
              if (qcjc_cnct_c) {
                // TODO:10023 QCJC仕様
                // pData = (void *)&cmem->ini_macinfo_JC_C.nearend_check;
              }
              break;
            case CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE:
              pData = cMem.iniMacInfo.printer.zhq_cpn_rct_share;
              if (qcjc_cnct_c) {
                // TODO:10023 QCJC仕様
                //  pData = (void *)&cmem->ini_macinfo_JC_C.zhq_cpn_rct_share;
              }
              break;
            case CompetitionIniLists.COMPETITION_INI_ERR_RPR_TIMER:
            default:
              pData = cMem.iniMacInfo.printer.err_rpr_timer;
              if (qcjc_cnct_c) {
                // TODO:10023 QCJC仕様
                // pData = (void *)&cmem->ini_macinfo_JC_C.err_rpr_timer;
              }
              break;
          }
        }
        switch (competitionNo) {
          case CompetitionIniLists.COMPETITION_INI_RCT_DNS:
            keyword = "rct_dns";
            break;
          case CompetitionIniLists.COMPETITION_INI_RCT_LF_PLUS:
            keyword = "rct_lf_plus";
            break;
          case CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT:
            keyword = "rct_tb_cut";
            break;
          case CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE:
            keyword = "rct_cut_type";
            break;
          case CompetitionIniLists.COMPETITION_INI_RCT_CUT_TYPE2:
            keyword = "rct_cut_type2";
            break;
          case CompetitionIniLists.COMPETITION_INI_RCT_NEAREND_CHK:
            keyword = "nearend_check";
            break;
          case CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE:
            keyword = "zhq_cpn_rct_share";
            break;
          case CompetitionIniLists.COMPETITION_INI_ERR_RPR_TIMER:
          default:
            keyword = "err_rpr_timer";
            break;
        }
        break;
      // COMPETITION_INI_RCPT_NO 及び COMPETITION_INI_PRINT_NOのケースは
      // DBを使用する方針になったためコメントアウト

      // case CompetitionIniLists.COMPETITION_INI_RCPT_NO:
      //   model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //   if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
      //     qcjc_cnct_c = true;
      //   }
      //   if (isUseMemory) {
      //     pData = cMem.iniCounter.tran.rcpt_no;
      //     if (qcjc_cnct_c) {
      //       // TODO:10023 QCJC仕様
      //       // if (cmem->qcjc_c == getpid())
      //       // {
      //       // if (cmem->qcjc_frcclk_chg == 0)
      //       // {
      //       // pData = (void *)&cmem->ini_counter_JC_C.rcpt_no;
      //       // }
      //       // }
      //       // else
      //       // {
      //       // pData = (void *)&cmem->ini_counter_JC_C.rcpt_no;
      //       // }
      //     }
      //   }
      //   keyword = "rcpt_no";
      //   break;
      // case CompetitionIniLists.COMPETITION_INI_PRINT_NO:
      //   model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //   if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
      //     qcjc_cnct_c = true;
      //   }
      //   if (isUseMemory) {
      //     pData = cMem.iniCounter.tran.print_no;
      //
      //     if (qcjc_cnct_c) {
      //       // TODO:10023 QCJC仕様
      //       //  pData = (void *)&cmem->ini_counter_JC_C.print_no;
      //     }
      //   }
      //   keyword = "print_no";
      //   break;
      case CompetitionIniLists.COMPETITION_INI_SALE_DATE:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.sale_date;
        }
        keyword = "sale_date";
        break;
      case CompetitionIniLists.COMPETITION_INI_LAST_SALE_DATE:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        keyword = "last_sale_date";
        break;
      case CompetitionIniLists.COMPETITION_INI_RECEIPT_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        keyword = "receipt_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_DEBIT_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        keyword = "debit_no";
        break;
//		case CompetitionIniLists.COMPETITION_INI_LASTLOGIN:
//			model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG_LONG;
//			if(mem) pData = (void *)&cmem->ini_counter.lastlogin;
//			keyword = "lastlogin";
//			break;
      case CompetitionIniLists.COMPETITION_INI_CREDIT_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.credit_no;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //  pData = (void *)&cmem->ini_counter_JC_C.print_no;
          }
        }
        keyword = "credit_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_LAST_EJ_BKUP:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        keyword = "last_ej_bkup";
        break;
      case CompetitionIniLists.COMPETITION_INI_LAST_DATA_BKUP:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        keyword = "last_data_bkup";
        break;
      case CompetitionIniLists.COMPETITION_INI_GUARANTEE_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        keyword = "guarantee_no";
        break;
// TODO:10032 コンパイルスイッチ(MC_SYSTEM
      //    //  #if MC_SYSTEM
      //    case CompetitionIniLists.COMPETITION_INI_POS_NO:
      //    model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //    if(isUseMemory){ pData = cMem.iniCounter..pos_no;
      //    keyword = "pos_no";
      //    break;
      //    case CompetitionIniLists.COMPETITION_INI_ONETIME_NO:
      //    model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //    if(isUseMemory){ pData = cMem.iniCounter..onetime_no;
      //    keyword = "onetime_no";
      //    break;
      //    case CompetitionIniLists.COMPETITION_INI_CARDCASH_NO:
      //    model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //    if(isUseMemory){ pData = cMem.iniCounter..cardcash_no;
      //    keyword = "cardcash_no";
      //    break;
      //    case CompetitionIniLists.COMPETITION_INI_NOCARDCASH_NO:
      //    model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //    if(isUseMemory){ pData = cMem.iniCounter..nocardcash_no;
      //    keyword = "nocardcash_no";
      //    break;
      //    case CompetitionIniLists.COMPETITION_INI_CARDFEE_NO:
      //    model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //    if(isUseMemory){ pData = cMem.iniCounter..cardfee_no;
      //    keyword = "cardfee_no";
      //    break;
      //    case CompetitionIniLists.COMPETITION_INI_OTHCRDT_NO:
      //    model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //    if(isUseMemory){ pData = cMem.iniCounter..othcrdt_no;
      //    keyword = "othcrdt_no";
      //    break;
      //    case CompetitionIniLists.COMPETITION_INI_OWNCRDT_NO:
      //    model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //    if(isUseMemory){ pData = cMem.iniCounter..owncrdt_no;
      //    keyword = "owncrdt_no";
      //    break;
      //    case CompetitionIniLists.COMPETITION_INI_CRDTCAN_NO:
      //    model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      //    if(isUseMemory){ pData = cMem.iniCounter..crdtcan_no;
      //    keyword = "crdtcan_no";
      //    break;
      // #endif
      case CompetitionIniLists.COMPETITION_INI_POPPY_CNT:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        keyword = "poppy_cnt";
        break;
      case CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.nttasp_credit_no;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //   pData = (void *)&cmem->ini_counter_JC_C.nttasp_credit_no;
          }
        }
        keyword = "nttasp_credit_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_NTTASP_CORR_STAT:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.nttasp_corr_stat;
        }
        keyword = "nttasp_corr_stat";
        break;
      case CompetitionIniLists.COMPETITION_INI_NTTASP_CORR_RENO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.nttasp_corr_reno;
        }
        keyword = "nttasp_corr_reno";
        break;
      case CompetitionIniLists.COMPETITION_INI_NTTASP_CORR_DATE:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.nttasp_corr_date;
        }
        keyword = "nttasp_corr_date";
        break;
      case CompetitionIniLists.COMPETITION_INI_EAT_IN_NOW:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.eat_in_now;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //  pData = (void *)&cmem->ini_counter_JC_C.eat_in_now;
          }
        }
        keyword = "eat_in_now";
        break;
      // TODO:10033 コンパイルスイッチ(TW)
      // #if TW
      // case CompetitionIniLists.COMPETITION_INI_TW_NO:
      // model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
      // if(isUseMemory){ pData = cMem.iniCounter..tw_no;
      // keyword = "tw_no";
      // break;
      // #endif
      case CompetitionIniLists.COMPETITION_INI_EDY_POS_ID:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.edy_pos_id;
        }
        keyword = "edy_pos_id";
        break;
      case CompetitionIniLists.COMPETITION_INI_SIP_POS_KY:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.sip_pos_ky;
        }
        keyword = "sip_pos_ky";
        break;
      case CompetitionIniLists.COMPETITION_INI_ENCRYPT_PIDNEW:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_MCHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.encrypt_PidNew;
        }
        keyword = "encrypt_PidNew";
        break;
      case CompetitionIniLists.COMPETITION_INI_ENCRYPT_ERK1DI:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_MCHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.encrypt_ErK1di;
        }
        keyword = "encrypt_ErK1di";
        break;
      case CompetitionIniLists.COMPETITION_INI_ENCRYPT_SEND_DATE:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_MCHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.encrypt_send_date;
        }
        keyword = "encrypt_send_date";
        break;
      case CompetitionIniLists.COMPETITION_INI_ENCRYPT_CREDIT_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_MCHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.encrypt_credit_no;
        }
        keyword = "encrypt_credit_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_ENCRYPT_SUICA_IDTR:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_MUCHAR;
        if (isUseMemory) {
          // TODO:10007 設定ファイルにないデータ iniCounter encrypt_Suica_IDtr
          //    pData = cMem.iniCounter.tran.encrypt_Suica_IDtr;
        }
        keyword = "encrypt_Suica_IDtr";
        break;
      case CompetitionIniLists.COMPETITION_INI_ENCRYPT_SUICA_KYTR:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_MUCHAR;
        if (isUseMemory) {
          // TODO:10007 設定ファイルにないデータ iniCounter encrypt_Suica_IDtr
          //    pData = cMem.iniCounter.tran.encrypt_Suica_Kytr;
        }
        keyword = "encrypt_Suica_Kytr";
        break;
      case CompetitionIniLists.COMPETITION_INI_DELIV_RCT_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.deliv_rct_no;
        }
        keyword = "deliv_rct_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_ORDER_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.order_no;
        }
        keyword = "order_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_SLIP_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.slip_no;
        }
        keyword = "slip_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_COM_SEQ_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_USHORT;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.com_seq_no;
        }
        keyword = "com_seq_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_QS_AT_CLSTIME:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.qs_at_clstime;
        }
        keyword = "qs_at_clstime";
        break;
      case CompetitionIniLists.COMPETITION_INI_QS_AT_WAITTIMER:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_SHORT;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.qs_at_waittimer;
        }
        keyword = "qs_at_waittimer";
        break;
      case CompetitionIniLists.COMPETITION_INI_QS_AT_OPNDATETIME:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.qs_at_opndatetime;
        }
        keyword = "qs_at_opndatetime";
        break;
      case CompetitionIniLists.COMPETITION_INI_FCL_DLL_FIX_TIME:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.fcl_dll_fix_time;
        }
        keyword = "fcl_dll_fix_time";
        break;
      case CompetitionIniLists.COMPETITION_INI_END_SALETIME:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.end_saletime;
        }
        keyword = "end_saletime";
        break;
      case CompetitionIniLists.COMPETITION_INI_QS_AT_CLS:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_SHORT;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.qs_at_cls;
        }
        keyword = "qs_at_cls";
        break;
      case CompetitionIniLists.COMPETITION_INI_MBRDSCTCKT_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.mbrdsctckt_no;
        }
        keyword = "mbrdsctckt_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_HT2980_SEQ_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.ht2980_seq_no;
        }
        keyword = "ht2980_seq_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_DUTY_EJ_COUNT:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_INT;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.duty_ej_count;
        }
        keyword = "duty_ej_count";
        break;
      case CompetitionIniLists.COMPETITION_INI_LAST_CLR_TOTAL:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        keyword = "last_clr_total";
        break;
      case CompetitionIniLists.COMPETITION_INI_CAPS_PQVIC_AES_KEY:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if (isUseMemory) {
          // TODO:10007 設定ファイルにないデータ
//          pData = cMem.iniCounter.tran.caps_pqvic_aes_key;
        }
        keyword = "caps_pqvic_aes_key";
        break;
      case CompetitionIniLists.COMPETITION_INI_SPECIAL_USER_COUNT:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.special_user_count;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //   pData = (void *)&cmem->ini_counter_JC_C.special_user_count;
          }
        }

        keyword = "special_user_count";
        break;
      case CompetitionIniLists.COMPETITION_INI_MBR_PRIZE_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          // TODO:10007 設定ファイルにないデータ
          //  pData = cMem.iniCounter.tran.mbr_prize_no;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //   pData = (void *)&cmem->ini_counter_JC_C.mbr_prize_no;
          }
        }

        keyword = "mbr_prize_counter";
        break;
      case CompetitionIniLists.COMPETITION_INI_SQRC_TCT_CNT:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.sqrc_tct_cnt;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //   pData = (void *)&cmem->ini_counter_JC_C.sqrc_tct_cnt;
          }
        }
        keyword = "sqrc_tct_cnt";
        break;
      case CompetitionIniLists.COMPETITION_INI_P11_PRIZE_COUNTER:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.P11_prize_counter;
        }
        keyword = "P11_prize_counter";
        break;
      case CompetitionIniLists.COMPETITION_INI_P7_PRIZE_COUNTER:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.P7_prize_counter;
        }
        keyword = "P7_prize_counter";
        break;
      case CompetitionIniLists.COMPETITION_INI_P11_PRIZE_GROUP_COUNTER:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.p11_prize_group_counter;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //   pData = (void *)&cmem->ini_counter_JC_C.p11_prize_group_counter;
          }
        }
        keyword = "p11_prize_group_counter";
        break;
      // TODO:10022 コンパイルスイッチ(SS_CR2)
      // #if SS_CR2
      // case CompetitionIniLists.COMPETITION_INI_CR2_CHGCIN:
      // model = CompetitionIniModel.COMPETITION_INI_MODEL_INT;
      // if(isUseMemory){ pData = cMem.iniCounter..cr2_chgcin_no;
      // keyword = "cr2_chgcin_no";
      // break;
      // case CompetitionIniLists.COMPETITION_INI_CR2_CHGOUT:
      // model = CompetitionIniModel.COMPETITION_INI_MODEL_INT;
      // if(isUseMemory){ pData = cMem.iniCounter..cr2_chgout_no;
      // keyword = "cr2_chgout_no";
      // break;
      // #endif
      case CompetitionIniLists.COMPETITION_INI_NOW_OPEN_DATETIME:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        keyword = "now_open_datetime";
        break;
      case CompetitionIniLists.COMPETITION_INI_CERTIFICATE_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_CHAR;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        keyword = "certificate_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_CCT_SEQ_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_LONG;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.cct_seq_no;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //   pData = (void *)&cmem->ini_counter_JC_C.cct_seq_no;
          }
        }
        keyword = "cct_seq_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_DPOINT_PROC_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_INT;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          pData = cMem.iniCounter.tran.dpoint_proc_no;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //   pData = (void *)&cmem->ini_counter_JC_C.dpoint_proc_no;
          }
        }
        keyword = "dpoint_proc_no";
        break;
      case CompetitionIniLists.COMPETITION_INI_FRESTA_SLIP_NO:
        model = CompetitionIniModel.COMPETITION_INI_MODEL_INT;
        if ((qcjc_state) && (qcjc_regs) && (qcjc_regs_c)) {
          qcjc_cnct_c = true;
        }
        if (isUseMemory) {
          // TODO:10007 設定ファイルにないデータ
          //  pData = cMem.iniCounter.tran.fresta_slip_no;
          if (qcjc_cnct_c) {
            // TODO:10023 QCJC仕様
            //   pData = (void *)&cmem->ini_counter_JC_C.fresta_slip_no;
          }
        }
        keyword = "fresta_slip_no";
        break;
      default:
        TprLog().logAdd(tid, LogLevelDefine.error,
            "competitionIni() competition_ini_num Error[${competitionNo.name}][${type}][${settingValue}]",
            errId: -1);

        return CompetitionIniRet(false);
    }
    if (MACNO_LOG) {
      if (competitionNo == CompetitionIniLists.COMPETITION_INI_MAC_NO) {
        TprLog().logAdd(tid, LogLevelDefine.normal,
            "competitionIni() num[${competitionNo.name}]typ[$type] : qcjc_stat[$qcjc_state] qcjc_regs[$qcjc_regs] qcjc_regs_c[$qcjc_regs_c] qcjc_cnct_c[$qcjc_cnct_c] qcjc_c_get[$qcjc_c_get] 1-1-1-1-(1or0)");
      }
    }
    // 参照先がWebSpeezaCの場合、ＩＮＩファイル名を変更する.
    if (((qcjc_state) && (qcjc_cnct_c)) || (qcjc_c_get)) {
      // TODO:10023 QCJC仕様
    }

    //カウンターデータの結果を返す
    switch (type) {
      case CompetitionIniType.COMPETITION_INI_GETMEM:
      case CompetitionIniType.COMPETITION_INI_GETMEM_JC_C:
      case CompetitionIniType.COMPETITION_INI_GETMEM_JC_J:
        if (pData == null) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "competitionIni() GETMEM pData NULL Error[${competitionNo.name}][$type][$settingValue]",
              errId: -1);
          return CompetitionIniRet(false);
        }
        dynamic value;
        switch (model) {
          case CompetitionIniModel.COMPETITION_INI_MODEL_CHAR:
            value = pData;
            break;
          case CompetitionIniModel.COMPETITION_INI_MODEL_UCHAR:
            value = pData;
            break;
          case CompetitionIniModel.COMPETITION_INI_MODEL_MCHAR:
            value = pData;
            break;
          case CompetitionIniModel.COMPETITION_INI_MODEL_MUCHAR:
            value = pData;
            break;
          case CompetitionIniModel.COMPETITION_INI_MODEL_SHORT:
            value = pData;
            break;
          case CompetitionIniModel.COMPETITION_INI_MODEL_USHORT:
            value = pData;
            break;
          case CompetitionIniModel.COMPETITION_INI_MODEL_INT:
            value = pData;
            break;
          case CompetitionIniModel.COMPETITION_INI_MODEL_LONG:
            value = pData;
            break;
          case CompetitionIniModel.COMPETITION_INI_MODEL_LONG_LONG:
            value = pData;
            break;
          default:
            TprLog().logAdd(tid, LogLevelDefine.error,
                "competitionIni() GETMEM model[${model.name}] ERROR[${competitionNo.name}][$type][$settingValue]",
                errId: -1);
            return CompetitionIniRet(false);
        }
        return CompetitionIniRet(true, value);
      case CompetitionIniType.COMPETITION_INI_SETMEM:
      case CompetitionIniType.COMPETITION_INI_SETMEM_JC_C:
      case CompetitionIniType.COMPETITION_INI_SETMEM_JC_J:
        if (pData == null) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "competitionIni() SETMEM pData NULL Error[${competitionNo.name}][$type][$settingValue]",
              errId: -1);
          return CompetitionIniRet(false);
        }
        switch (model) {
          case CompetitionIniModel.COMPETITION_INI_MODEL_CHAR:
          case CompetitionIniModel.COMPETITION_INI_MODEL_UCHAR:
          case CompetitionIniModel.COMPETITION_INI_MODEL_MCHAR:
          case CompetitionIniModel.COMPETITION_INI_MODEL_MUCHAR:
          case CompetitionIniModel.COMPETITION_INI_MODEL_SHORT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_USHORT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_INT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_LONG:
          case CompetitionIniModel.COMPETITION_INI_MODEL_LONG_LONG:
            // TODO:共有メモリのデータを更新する.
            return CompetitionIniRet(true);
          default:
            TprLog().logAdd(tid, LogLevelDefine.error,
                "competitionIni() SETMEM  model[${model.name}] ERROR[${competitionNo.name}][$type][$settingValue]",
                errId: -1);
            return CompetitionIniRet(false);
        }
      case CompetitionIniType.COMPETITION_INI_GETSYS:
      case CompetitionIniType.COMPETITION_INI_GETSYS_JC_C:
      case CompetitionIniType.COMPETITION_INI_GETSYS_JC_J:
        JsonRet ret = await jsonFile.getValueWithName(section, keyword);
        if (!ret.result) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "competitionIni() typ[$type] TprLibGetIni error] ERROR[${competitionNo.name}][$section][$keyword][${ret.cause.name}]",
              errId: -1);

          return CompetitionIniRet(false);
        }
        dynamic value = ret.value;
        switch (model) {
          case CompetitionIniModel.COMPETITION_INI_MODEL_CHAR:
          case CompetitionIniModel.COMPETITION_INI_MODEL_UCHAR:
          case CompetitionIniModel.COMPETITION_INI_MODEL_MCHAR:
          /* 2013/02/12 */
          case CompetitionIniModel.COMPETITION_INI_MODEL_MUCHAR:
          /* 2013/02/12 */
          case CompetitionIniModel.COMPETITION_INI_MODEL_SHORT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_USHORT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_INT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_LONG:
          case CompetitionIniModel.COMPETITION_INI_MODEL_LONG_LONG:
            return CompetitionIniRet(true, value);
          default:
            TprLog().logAdd(tid, LogLevelDefine.error,
                "competitionIni() GETSYS model[${model.name}] ERROR[${competitionNo.name}][$type][$settingValue][${value.toString()}]",
                errId: -1);
            return CompetitionIniRet(false);
        }

      case CompetitionIniType.COMPETITION_INI_SETSYS:
      case CompetitionIniType.COMPETITION_INI_SETSYS_JC_C:
      case CompetitionIniType.COMPETITION_INI_SETSYS_JC_J:
        switch (model) {
          case CompetitionIniModel.COMPETITION_INI_MODEL_CHAR:
          case CompetitionIniModel.COMPETITION_INI_MODEL_UCHAR:
              JsonRet ret = await jsonFile.setValueWithName(
                section, keyword, settingValue);
            if (!ret.result) {
              TprLog().logAdd(tid, LogLevelDefine.error,
                  "competitionIni() typ[$type] ERROR[${competitionNo.name}][$section][$keyword][$settingValue][${ret.cause.name}]",
                  errId: -1);
            }
            return CompetitionIniRet(true, settingValue);
          case CompetitionIniModel.COMPETITION_INI_MODEL_SHORT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_USHORT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_INT:
          case CompetitionIniModel.COMPETITION_INI_MODEL_LONG:
          case CompetitionIniModel.COMPETITION_INI_MODEL_LONG_LONG:
            int? settingNum  = int.tryParse(settingValue!);
            if (settingNum == null) {
                TprLog().logAdd(tid, LogLevelDefine.error,
                    "competitionIni() typ[$type] ERROR parse int [${competitionNo.name}][$section][$keyword][$settingValue]",
                    errId: -1);
            }
            JsonRet ret = await jsonFile.setValueWithName(section, keyword, settingNum);
            if (!ret.result) {
              TprLog().logAdd(tid, LogLevelDefine.error,
                  "competitionIni() typ[$type] ERROR[${competitionNo.name}][$section][$keyword][$settingValue][${ret.cause.name}]",
                  errId: -1);
            }
            return CompetitionIniRet(true, settingValue);
          default:
            TprLog().logAdd(tid, LogLevelDefine.error,
                "competitionIni() SETSYS model[${model.name}] ERROR[${competitionNo.name}][$type][$settingValue][${settingValue.toString()}]",
                errId: -1);
            return CompetitionIniRet(false);
        }

      default:
        TprLog().logAdd(tid, LogLevelDefine.error,
            "competitionIni() typ[$type] not support[${competitionNo.name}]",
            errId: -1);
        return CompetitionIniRet(false);
    }
  }

  ///  関連tprxソース: competition_ini.c - competition_ini_get_short()
  static Future<int> competitionIniGetShort(int tid, CompetitionIniLists competition_ini_num, CompetitionIniType typ) async {
    CompetitionIniRet ret = await competitionIniGet(tid, competition_ini_num, typ);
    return (ret.value ?? 0);
  }

  /// p_regcounter_logのデータ取得
  /// 戻値　0: OK  0以外: エラー
  /// 関連tprxソース: cmn_proc.c - Get_Regcounter_Log
  static Future<bool> getRegcounterLog(TprMID tid, PRecogCounterLog recogCounterLog) async {
    String sql = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "getRegcounterLog() rxMemRead error\n");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    try{
      var db = DbManipulationPs();

      sql = sprintf("SELECT "
          " mac_no, sale_date, last_sale_date, upd_datetime, "
          " cnt_json_data ->> 'receipt_no' as receipt_no,  cnt_json_data ->> 'print_no' as print_no, cnt_json_data ->> 'rcpt_print_no' as rcpt_print_no "
          " FROM p_regcounter_log WHERE comp_cd = %d AND stre_cd = '%d' AND mac_no = '%d' ;",
          [cBuf.dbRegCtrl.compCd,cBuf.dbRegCtrl.streCd,cBuf.dbRegCtrl.macNo]
      );
      Result result = await db.dbCon.execute(sql);
      if(result.isEmpty){
        TprLog().logAdd(tid, LogLevelDefine.error,
            "getRegcounterLog(): Error [$sql]",errId: -1);
        return false;
      }

      for(int i = 0; i < result.length; i++){
        Map<String, dynamic> data = result[i].toColumnMap();

        recogCounterLog.mac_no = int.parse(data['mac_no']);
        recogCounterLog.sale_date = (data['sale_date']).toString();
        recogCounterLog.upd_datetime = (data['last_sale_date']).toString();
        recogCounterLog.upd_datetime = (data['upd_datetime']).toString();
        recogCounterLog.cnt_json_data = {
          "receipt_no" : int.parse(data['receipt_no']),
          "print_no": int.parse(data['print_no']),
          "rcpt_print_no" : int.parse(data['rcpt_print_no'])
        };
      }
    }catch(e, s){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "getRegcounterLog() : $e $s )");
      return false;
    }
    return true;
  }


  ///	p_regcounter_log に情報をセット
  ///	戻値　"resultFunc": 0: OK  0以外: エラー
  ///　　　 "resultSql" : 0: UPDATE成功　0以外: UPDATE失敗 or 未実施
  /// 関連tprxソース: cmn_proc.c - Set_Regcounter_Log
  static Future<Map<String, dynamic>> setRegcounterLog(TprMID tid, PRecogCounterLog recogCounterLog) async {
    String updSql = "";
    String addSql = "";
    String chkSql = "";
    String log = "";
    int cmdFlg;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "setRegcounterLog() rxMemRead error\n");
      return {"resultFunc": Typ.NG,"resultSql":Typ.NG};
    }
    RxCommonBuf cBuf = xRet.object;

    try {
      var db = DbManipulationPs();

      if (recogCounterLog.upd_datetime == null) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "setRegcounterLog(): Error arugment ", errId: -1);
        return {"resultFunc": Typ.NG,"resultSql":Typ.NG};
      }

      if (recogCounterLog.upd_datetime!.length <= 0) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "setRegcounterLog(): upd_datetime no set SKIP ", errId: -1);
        return {"resultFunc": Typ.OK,"resultSql":Typ.NG};
      }

      int receiptNo   = recogCounterLog.cnt_json_data["receipt_no"];
      int printNo     = recogCounterLog.cnt_json_data["print_no"];
      int rcptPrintNo = recogCounterLog.cnt_json_data["rcpt_print_no"];


      // 登録時のカウンター更新
      addSql = sprintf(
          "cnt_json_data = cnt_json_data || '{\"receipt_no\":%d, \"print_no\":%d, \"rcpt_print_no\":%d}' ",
          [receiptNo,printNo,rcptPrintNo]);

      // 番号を更新(読んだときの時刻を対象としてUPDATE)
      updSql = sprintf("UPDATE p_regcounter_log "
          "SET upd_datetime = '${DateTime.now()}', %s "
          "WHERE comp_cd = '%d' AND stre_cd = '%d' AND mac_no = '%d' "
          "AND upd_datetime = '%s'; ",
          [addSql,
            cBuf.dbRegCtrl.compCd,
            cBuf.dbRegCtrl.streCd,
            cBuf.dbRegCtrl.macNo,
            recogCounterLog.upd_datetime]);

      await db.dbCon.execute(updSql);

      // UPDATEが成功しているかチェック
      chkSql = sprintf("SELECT * from p_regcounter_log "
          "WHERE comp_cd = '%d' AND stre_cd = '%d' AND mac_no = '%d' "
          "AND upd_datetime = '%s'; ",
          [ cBuf.dbRegCtrl.compCd,
            cBuf.dbRegCtrl.streCd,
            cBuf.dbRegCtrl.macNo,
            recogCounterLog.upd_datetime]);

      Result updResult = await db.dbCon.execute(chkSql);
      //SELECT結果が空なら更新済み
      if(updResult.isEmpty){
        cmdFlg = Typ.OK;
      }else{
        cmdFlg = Typ.NG;
      }

    }catch(e,s){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "setRegcounterLog() : $e $s )");
      return {"resultFunc": Typ.NG,"resultSql":Typ.NG};
    }

    log = sprintf("setRegcounterLog() : cmdFlg[%d] mac[%d]rec[%d]prn[%d]rcpr[%d]sale[%s]",
        [ cmdFlg,
          recogCounterLog.mac_no,
          recogCounterLog.cnt_json_data["receipt_no"],
          recogCounterLog.cnt_json_data["print_no"],
          recogCounterLog.cnt_json_data["rcpt_print_no"],
          recogCounterLog.sale_date
        ]);

    TprLog().logAdd(tid, LogLevelDefine.normal,log);

    return {"resultFunc": Typ.OK,"resultSql":cmdFlg};
  }
}
