/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:io';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../cm_ej/cm_ejlib.dart';
import '../cm_sys/cm_cksys.dart';
import 'competition_ini.dart';
import 'upd_util.dart';

/// 関連tprxソース: bkupd_lib.c
class BkupdLib {

  /// 関連tprxソース: bkupd_lib.c - rmstEjWriteProc
  static Future<int> rmstEjWriteProc() async {
    late File fp;
    int ret = 0;
    int wPrintNo = 0;
    String localPath = "${EnvironmentData().sysHomeDir}/tmp";
    String clsFname = "$localPath/${AplLib.EJ_CLOSE_TXT}";
    String opnFname = "$localPath/${AplLib.EJ_OPEN_TXT}";
    String dataFname = "$localPath/${AplLib.EJDATA_TXT}";
    String lastSaleDate = "";

    if (SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON).isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "StoreOpenMain : rxMemPtr NG!!");
      return 0;
    }

    lastSaleDate = (await CompetitionIni.competitionIniGet( Tpraid.TPRAID_STR, CompetitionIniLists.COMPETITION_INI_LAST_SALE_DATE, CompetitionIniType.COMPETITION_INI_GETSYS)).value;
    if (lastSaleDate.length == "0000-00-00".length) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmstEjWriteProc: last_sale_date = 0000-00-00");
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "rmstEjWriteProc: Not Write Ej Log for open close");
      final File opnFile = File(opnFname);
      final File clsFile = File(clsFname);
      if(opnFile.existsSync()){
        try {
          opnFile.deleteSync();
        } catch (e, s) {
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
              "rmstEjWriteProc : opn file delete Error,$e,$s");
        }
      }
      if(clsFile.existsSync()){
        try {
          clsFile.deleteSync();
        } catch (e, s) {
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
              "rmstEjWriteProc : cls file delete Error,$e,$s");
        }
      }
      return 0;
    }

    fp = File(clsFname);
    if (fp.existsSync()) {
      try {
        fp.copySync(dataFname);
      } catch (e, s) {
        ret = 1;
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstEjWriteProc : cls file copy Error,$e,$s");
      }
      if (ret == 0) {
        wPrintNo = await Counter.competitionGetPrintNo(Tpraid.TPRAID_STR);
        ret = await EjLib().cmEjOther();
        if(ret == 0){
          final File clsFile = File(clsFname);
          if(clsFile.existsSync()){
            try {
              clsFile.deleteSync();
            } catch (e, s) {
              TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                  "rmstEjWriteProc : cls file delete Error,$e,$s");
            }
          }
        }
        final File dataFile = File(dataFname);
        if(dataFile.existsSync()){
          try {
            dataFile.deleteSync();
          } catch (e, s) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "rmstEjWriteProc : data file delete Error,$e,$s");
          }
        }
        if (wPrintNo >= 9999) {
          wPrintNo = 1;
        } else {
          wPrintNo++;
        }
        // wPrintNo = (await CompetitionIni.competitionIni( Tpraid.TPRAID_STR, CompetitionIniLists.COMPETITION_INI_PRINT_NO, CompetitionIniType.COMPETITION_INI_SETMEM)).value;
        // wPrintNo = (await CompetitionIni.competitionIni( Tpraid.TPRAID_STR, CompetitionIniLists.COMPETITION_INI_PRINT_NO, CompetitionIniType.COMPETITION_INI_SETSYS)).value;
        await CompetitionIni.competitionIniSetPrintNo(Tpraid.TPRAID_STR,wPrintNo);
      }
    } else {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "rmstEjWriteProc: close file open error");
    }
    await Future.delayed(const Duration(seconds: 1));	//２つ以上連続実績作成時EJがかかれなくなってしまうので
    fp = File(opnFname);
    if (fp.existsSync()) {
      try {
        fp.copySync(dataFname);
      } catch (e, s) {
        ret = 1;
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "rmstEjWriteProc : cls file copy Error,$e,$s");
      }
      if (ret == 0) {
        wPrintNo = await Counter.competitionGetPrintNo(Tpraid.TPRAID_STR);
        ret = await EjLib().cmEjOther();
        if (ret == 0) {
          final File opnFile = File(opnFname);
          if(opnFile.existsSync()){
            try {
              opnFile.deleteSync();
            } catch (e, s) {
              TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                  "rmstEjWriteProc : opn file delete Error,$e,$s");
            }
          }
        }
        final File dataFile = File(opnFname);
        if(dataFile.existsSync()){
          try {
            dataFile.deleteSync();
          } catch (e, s) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "rmstEjWriteProc : data file delete Error,$e,$s");
          }
        }
        if (wPrintNo >= 9999) {
          wPrintNo = 1;
        } else {
          wPrintNo++;
        }
        // wPrintNo = (await CompetitionIni.competitionIni( Tpraid.TPRAID_STR, CompetitionIniLists.COMPETITION_INI_PRINT_NO, CompetitionIniType.COMPETITION_INI_SETMEM)).value;
        // wPrintNo = (await CompetitionIni.competitionIni( Tpraid.TPRAID_STR, CompetitionIniLists.COMPETITION_INI_PRINT_NO, CompetitionIniType.COMPETITION_INI_SETSYS)).value;
         await CompetitionIni.competitionIniSetPrintNo(Tpraid.TPRAID_STR,wPrintNo);
      }
    }else {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, "rmstEjWriteProc: open file open error");
    }

    if(await CmCksys.cmDrugStoreSystem() != 0) {
      UpdUtil.updRestCntChk(Tpraid.TPRAID_STR);
    }

    return ret;
  }
}