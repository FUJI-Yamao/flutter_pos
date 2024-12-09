/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:sprintf/sprintf.dart';

import '../../inc/sys/tpr_aid.dart';

class RcSlip{
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 伝票番号をトータルログにセット
  /// 関連tprxソース: rc_slip.c - rc_Set_SlipNo
  static Future<void> rcSetSlipNo() async {
    int slipNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetSlipNo() rxMemRead error\n");
      return ;
    }
    RxCommonBuf pCom = xRet.object;

    if((await CmCksys.cmBusinessModeSystem() != 0)
        && ((RcSysChk.rcSROpeModeChk())       // 廃棄
            || (RcSysChk.rcIVOpeModeChk())    // 棚卸
            || (RcSysChk.rcPDOpeModeChk()))){ // 生産
      slipNo = 1;
      CompetitionIni.competitionIniGet(Tpraid.TPRAID_CHK,
          CompetitionIniLists.COMPETITION_INI_SLIP_NO,
          CompetitionIniType.COMPETITION_INI_GETMEM);

      String shpNo = (pCom.iniMacInfo.system.shpno % 100).toString().padLeft(2,'0');
      int macNoI = (await CompetitionIni.competitionIniGetMacNo(Tpraid.TPRAID_CHK)).value;

      String macNoS = (macNoI % 1000).toString().padLeft(3,'0');
      String slNo = (slipNo % 100000).toString().padLeft(5,'0');
      RegsMem().tTtllog.t100002Sts.businessSlipCd = '$shpNo$macNoS$slNo';

      TprLog().logAdd(
          0, LogLevelDefine.normal, "    slipNo[${RegsMem().tTtllog.t100002Sts.businessSlipCd}]\n");
    }
  }

  ///  伝票番号をインクリメント
  /// 関連tprxソース: rc_slip.c - rc_Inc_SlipNo
  static Future<bool> rcIncSlipNo() async {

    int tid =await RcSysChk.getTid();
    if((await CmCksys.cmBusinessModeSystem() != 0)
        && ((RcSysChk.rcSROpeModeChk())       // 廃棄
            || (RcSysChk.rcIVOpeModeChk())    // 棚卸
            || (RcSysChk.rcPDOpeModeChk()))){ // 生産
      int slipNo = 1;
      CompetitionIniRet ret = await CompetitionIni.competitionIniGet(Tpraid.TPRAID_CHK,
          CompetitionIniLists.COMPETITION_INI_SLIP_NO,
          CompetitionIniType.COMPETITION_INI_GETMEM);
      if(!ret.isSuccess){
        TprLog().logAdd(tid, LogLevelDefine.error, "rcSetSlipNo() getMem error");
      }
      slipNo = ret.value;
      int old = slipNo;
      if(slipNo >= 99999){
        slipNo = 1;
      }else{
        slipNo++;
      }
      ret = await CompetitionIni.competitionIniSet(Tpraid.TPRAID_CHK,
          CompetitionIniLists.COMPETITION_INI_SLIP_NO,
          CompetitionIniType.COMPETITION_INI_SETMEM, slipNo.toString() );
      if(!ret.isSuccess){
        TprLog().logAdd(tid, LogLevelDefine.error, "rcSetSlipNo() setMem error");
      }
      ret = await CompetitionIni.competitionIniSet(Tpraid.TPRAID_CHK,
          CompetitionIniLists.COMPETITION_INI_SLIP_NO,
          CompetitionIniType.COMPETITION_INI_SETSYS, slipNo.toString() );
      if(!ret.isSuccess){
        TprLog().logAdd(tid, LogLevelDefine.error, "rcSetSlipNo() setIni error");
        return false;
      }

      TprLog().logAdd(
          tid, LogLevelDefine.normal, "rcSetSlipNo() Inc[$old]->[$slipNo]");

    }
    return true;
  }

  //  TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_order.c - rcSlipDisplay()
  static void rcSlipDisplay() {
    return;
  }
}