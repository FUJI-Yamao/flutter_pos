/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_regs.dart';

class RcOrder{
  /// 発注番号をトータルログにセット
  /// 関連tprxソース: rc_order.c - rc_Set_OrderNo()
  static Future<void> rcSetOrderNo() async {
    int orderNo;

    // if((await CmCksys.cmOrderModeSystem() != 0)
    //     && RcSysChk.rcODOpeModeChk()){ // 発注
    if((await CmCksys.cmOrderModeSystem() == 0)
        && RcSysChk.rcODOpeModeChk() == false){ // 発注
      orderNo = 0;
      CompetitionIni.competitionIniGet(Tpraid.TPRAID_CHK,
          CompetitionIniLists.COMPETITION_INI_ORDER_NO,
          CompetitionIniType.COMPETITION_INI_GETMEM);
      RegsMem().tTtllog.t100002Sts.businessOrderNo = orderNo % 100000;
      TprLog().logAdd
        (0, LogLevelDefine.normal,
          "    orderNo[${RegsMem().tTtllog.t100002Sts.businessOrderNo}]\n");
    }
  }

  /// 発注番号をインクリメント
  /// 関連tprxソース: rc_order.c - rc_Inc_OrderNo
  static Future<bool> rcIncOrderNo() async {
    int tid =await RcSysChk.getTid();
    if((await CmCksys.cmOrderModeSystem() != 0)
        && (RcSysChk.rcODOpeModeChk())      // 発注
           && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||  (await RcSysChk.rcCheckQCJCSystem()))
        ){
      int orderNo = 0;
      CompetitionIniRet ret = await CompetitionIni.competitionIniGet(Tpraid.TPRAID_CHK,
          CompetitionIniLists.COMPETITION_INI_ORDER_NO,
          CompetitionIniType.COMPETITION_INI_GETMEM);
      if(!ret.isSuccess){
        TprLog().logAdd(tid, LogLevelDefine.error, "rcIncOrderNo() getMem error");
      }
      orderNo = ret.value;
      int old = orderNo;
      if(orderNo >= 99999){
        orderNo = 1;
      }else{
        orderNo++;
      }
      ret = await CompetitionIni.competitionIniSet(Tpraid.TPRAID_CHK,
          CompetitionIniLists.COMPETITION_INI_ORDER_NO,
          CompetitionIniType.COMPETITION_INI_SETMEM, orderNo.toString() );
      if(!ret.isSuccess){
        TprLog().logAdd(tid, LogLevelDefine.error, "rcIncOrderNo() setMem error");
      }
      ret = await CompetitionIni.competitionIniSet(Tpraid.TPRAID_CHK,
          CompetitionIniLists.COMPETITION_INI_ORDER_NO,
          CompetitionIniType.COMPETITION_INI_SETSYS, orderNo.toString() );
      if(!ret.isSuccess){
        TprLog().logAdd(tid, LogLevelDefine.error, "rcIncOrderNo() setIni error");
        return false;
      }

      TprLog().logAdd(
          tid, LogLevelDefine.normal, "rcIncOrderNo() Inc[$old]->[$orderNo]");

    }
    return true;
  }

  //  TODO:00010 長田 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_order.c - rcOrderSend()
  static void rcOrderSend(dynamic Function() callback) {
    return;
  }

  //  TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_order.c - rcBMode_InitFlgClr_plu()
  static void rcBModeInitFlgClrPlu() {
    return;
  }
  //  TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_order.c - rcOrderDisplay()
  static void rcOrderDisplay() {
    return;
  }
}