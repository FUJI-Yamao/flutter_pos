/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcky_rfdopr.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

/// 関連tprxソース: rxregstr.c
class Rxregstr {
  static const int ConfOpeMode_RG = 1;
  static const int ConfOpeMode_VD = 3;
  static const int ConfOpeMode_TR = 4;
  static const int ConfOpeMode_SR = 5;

  /// 関連tprxソース: rxregstr.c - rxRegsStart
  static Future<bool> rxRegsStart(int opeMode) async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // short  to_mode;
    //
    // to_mode = rxRegsSetup();
    // if (to_mode)
    //   return(to_mode);                   /* Regs Setup Error */
    //
    // if(type == KY_CHECKER)
    //   OT->flags.clk_mode = KY_CHECKER;
    // else
    // {
    // OT->flags.clk_mode = KY_DUALCSHR;
    // }
    await rxRegsProcess(opeMode);
    return true;
  }
  /// 関連tprxソース: rxregstr.c - rxRegsProcess
  static Future<void> rxRegsProcess(int opeMode) async {
    // rxSet_InitStat();                 /* Set Initialize Status  */
    await rxSetInitData(opeMode); /* Set Initialize Data's */
  }

  /// 関連tprxソース: rxregstr.c - rxSet_InitData
  static Future<void> rxSetInitData(int opeMode) async {
    await Rxregstr.rxSetMacShpNo();
    await Rxregstr.rxSetClerkNoName();
    await Rxregstr.rxSetOpeMode(opeMode);
    // TODO:10121 QUICPay、iD 202404実装対象外
    //
    // rxSet_AcbData();
    // rxSet_StaffData();
    // if(cm_crdt_system())
    // {
    //   rcIni_Read_crdt_no();      /* Set Credit No */
    // }
    // rxSet_TabInfo();
    // #if IC_CONNECT
    // if(rcChk_ICC_System()) {
    // rxSet_ICC_Property();
    // TS_BUF->icc.order = ICC_IDLE_GET_SUE_START;
    // }
    // #endif
    // if(rc_Check_CustomerCard_AutoCall()) {
    // rxSet_My_Customercard_No();
    // }
    // rxSet_TraningDate();
    // rxSet_ItemMax();
    // rxSet_CpnTglData();
  }

  /// 関連tprxソース: rxregstr.c - rxSet_ClerkNoName
  static Future<void> rxSetClerkNoName() async {
    /* 04.Feb.04 */
    //#if SIMPLE_2STAFF
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.frcClkFlg == 2) {
      if ((RegsMem().tHeader.ope_mode_flg ==
              OpeModeFlagList.OPE_MODE_STAFF_CLS) ||
          (RegsMem().tHeader.ope_mode_flg ==
              OpeModeFlagList.OPE_MODE_STAFF_OPN)) {
        return; // 簡易従業員２人制でオープンクローズはスキップ
      }
    }
    //#endif

    // RM-3800のフローティング仕様
    if ((CmCksys.cmChkRm5900FloatingSystem() != 0) // フローティング仕様
        &&
        (!RckyRfdopr.rcRfdOprCheckManualRefundMode())) // 手動返品以外
    {
      return; // フローティング仕様の場合はスキップ（c_staffopen_smtを使用しない）
    }

    if (cBuf.dbStaffopen.cshr_status == 1) {
      RegsMem().tHeader.cshr_no =
          int.tryParse(cBuf.dbStaffopen.cshr_cd ?? "0") ?? 0;
      //@@@V15     MEM->crdtlog.cshr_no = C_BUF->db_staffopen.cshr_cd;
      RegsMem().tTtllog.t1000.cshrName = cBuf.dbStaffopen.cshr_name ?? "";
    }

    if (CmCksys.cmQCashierJCSystem() != 0) {
      RegsMem().tHeader.chkr_no = 0;
      RegsMem().tTtllog.t1000.chkrName = '';
      return; // QCJCの場合
    }

    if (await RcSysChk.rcChkDesktopCashier()) {
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
          (RegsMem().tmpbuf.chkrNo != 0)) {
        RegsMem().tHeader.chkr_no = RegsMem().tmpbuf.chkrNo;
        //@@@V15        MEM->crdtlog.chkr_no = MEM->tmpbuf.chkr_no;
        RegsMem().tTtllog.t1000.chkrName = RegsMem().tmpbuf.chkrName;
      } else {
        RegsMem().tHeader.chkr_no = cBuf.dbStaffopen.chkr_cd?? 0;
        //@@@V15        MEM->crdtlog.chkr_no = C_BUF->db_staffopen.chkr_cd;
        RegsMem().tTtllog.t1000.chkrName = cBuf.dbStaffopen.chkr_name ?? "";
      }
      return;
    }

    /* 05.03.14 */
    if ((!RcSysChk.rcChkDeskTopType()) &&
        (await RcSysChk.rcKySelf() != RcRegs.KY_SINGLE)) {
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
          (RegsMem().tmpbuf.chkrNo != 0)) {
        RegsMem().tHeader.chkr_no = RegsMem().tmpbuf.chkrNo;
        //@@@V15        MEM->crdtlog.chkr_no = MEM->tmpbuf.chkr_no;
        RegsMem().tTtllog.t1000.chkrName = RegsMem().tmpbuf.chkrName;
      } else {
        RegsMem().tHeader.chkr_no = cBuf.dbStaffopen.chkr_cd ?? 0;
        //@@@V15        MEM->crdtlog.chkr_no = C_BUF->db_staffopen.chkr_cd;
        RegsMem().tTtllog.t1000.chkrName = cBuf.dbStaffopen.chkr_name ?? "";
      }
    } else {
      /* 04.Mar.01 */
      //#if SIMPLE_2STAFF
      if ((cBuf.dbStaffopen.cshr_status == 1) &&
          (RegsMem().tmpbuf.chkrNo != 0)) {
        RegsMem().tHeader.chkr_no = RegsMem().tmpbuf.chkrNo;
        //@@@V15        MEM->crdtlog.chkr_no = MEM->tmpbuf.chkr_no;
        RegsMem().tTtllog.t1000.chkrName = RegsMem().tmpbuf.chkrName;
      } else {
        RegsMem().tHeader.chkr_no = 0;
        RegsMem().tTtllog.t1000.chkrName = '';
      }
    }
    //#endif
  }

  /// 関連tprxソース: rxregstr.c - rxSet_MacShpNo
  /// マシン番号と店舗番号のセット
  static Future<void> rxSetMacShpNo() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    CompetitionIniRet ret =
        await CompetitionIni.competitionIniGetRcptNo(await RcSysChk.getTid());

    RegsMem().tHeader.mac_no = ret.value;
    RegsMem().tHeader.comp_cd = cBuf.dbRegCtrl.compCd;
    RegsMem().tHeader.stre_cd = cBuf.dbRegCtrl.streCd;
    if (CompileFlag.DEPARTMENT_STORE) {
      RegsMem().tTtllog.t100800.dcauFsppur =
          int.tryParse(cBuf.iniMacInfo.eventinput.event_cd) ?? 0;
    }
  }

  /// 関連tprxソース: rxregstr.c - rxSet_OpeMode
  static Future<void> rxSetOpeMode(int mode) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    Mac_infoJsonFile macInfo = cBuf.iniMacInfo;
    await macInfo.load(); // 一番初めの起動時はロードしないとファイルが作成されないため、ロードしておく.
    macInfo.internal_flg.mode = mode;
    await macInfo.save();
    SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, cBuf, RxMemAttn.MAIN_TASK);

    int scrMode = 0;
    int subScrMode = 0;
    int opeMode = 0;
    if (CompileFlag.SELF_GATE && await RcSysChk.rcSGChkSelfGateSystem()) {
      switch (mode) {
        case ConfOpeMode_VD:
          scrMode = RcRegs.VD_ITM;
          subScrMode = RcRegs.VD_ITM;
          opeMode = RcRegs.VD;
          break;
        case ConfOpeMode_TR:
          if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
            scrMode = RcRegs.TR_NEWSG_MDSLCT;
            subScrMode = RcRegs.TR_NEWSG_MDSLCT;
            opeMode = RcRegs.TR;
          } else {
            scrMode = RcRegs.TR_SG_STR;
            subScrMode = RcRegs.TR_SG_STR;
            opeMode = RcRegs.TR;
          }
          break;
        case ConfOpeMode_SR:
          scrMode = RcRegs.SR_ITM;
          subScrMode = RcRegs.SR_ITM;
          opeMode = RcRegs.SR;
          break;
        case ConfOpeMode_RG:
        default:
          if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
            scrMode = RcRegs.RG_NEWSG_MDSLCT;
            subScrMode = RcRegs.RG_NEWSG_MDSLCT;
            opeMode = RcRegs.RG;
          } else {
            scrMode = RcRegs.RG_SG_STR;
            subScrMode = RcRegs.RG_SG_STR;
            opeMode = RcRegs.RG;
          }
          break;
      }
    } else {
      switch (mode) {
        case 3:
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            if (await RcSysChk.rcCheckQCJCSystem()) {
              scrMode = RcRegs.VD_ITM;
              subScrMode = RcRegs.VD_STL;
              opeMode = RcRegs.VD;
            } else if (await RcSysChk.rcQCChkQcashierSystem()) {
              scrMode = RcRegs.VD_ITM;
              subScrMode = RcRegs.VD_STL;
              opeMode = RcRegs.VD;
            } else {
              scrMode = RcRegs.VD_STL;
              subScrMode = RcRegs.VD_STL;
              opeMode = RcRegs.VD;
            }
          } else {
            scrMode = RcRegs.VD_ITM;
            subScrMode = RcRegs.VD_ITM;
            opeMode = RcRegs.VD;
          }
          break;
        case 4:
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            if (await RcSysChk.rcCheckQCJCSystem()) {
              scrMode = RcRegs.TR_ITM;
              subScrMode = RcRegs.TR_STL;
              opeMode = RcRegs.TR;
            } else if (await RcSysChk.rcQCChkQcashierSystem()) {
              scrMode = RcRegs.TR_ITM;
              subScrMode = RcRegs.TR_STL;
              opeMode = RcRegs.TR;
            } else {
              scrMode = RcRegs.TR_STL;
              subScrMode = RcRegs.TR_STL;
              opeMode = RcRegs.TR;
            }
          } else {
            scrMode = RcRegs.TR_ITM;
            subScrMode = RcRegs.TR_ITM;
            opeMode = RcRegs.TR;
          }
          break;
        case 5:
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            scrMode = RcRegs.SR_STL;
            subScrMode = RcRegs.SR_STL;
            opeMode = RcRegs.SR;
          } else {
            scrMode = RcRegs.SR_ITM;
            subScrMode = RcRegs.SR_ITM;
            opeMode = RcRegs.SR;
          }
          break;
        case 6:
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            scrMode = RcRegs.OD_STL;
            subScrMode = RcRegs.OD_STL;
            opeMode = RcRegs.OD;
          } else {
            scrMode = RcRegs.OD_ITM;
            subScrMode = RcRegs.OD_ITM;
            opeMode = RcRegs.OD;
          }
          break;
        case 7:
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            scrMode = RcRegs.IV_STL;
            subScrMode = RcRegs.IV_STL;
            opeMode = RcRegs.IV;
          } else {
            scrMode = RcRegs.IV_ITM;
            subScrMode = RcRegs.IV_ITM;
            opeMode = RcRegs.IV;
          }
          break;
        case 8:
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            scrMode = RcRegs.PD_STL;
            subScrMode = RcRegs.PD_STL;
            opeMode = RcRegs.PD;
          } else {
            scrMode = RcRegs.PD_ITM;
            subScrMode = RcRegs.PD_ITM;
            opeMode = RcRegs.PD;
          }
          break;
        case 9:
          scrMode = RcRegs.IN_STL;
          subScrMode = RcRegs.IN_STL;
          opeMode = RcRegs.IN;
          break;
        case 10:
          scrMode = RcRegs.OU_STL;
          subScrMode = RcRegs.OU_STL;
          opeMode = RcRegs.OU;
          break;
        case 11:
          scrMode = RcRegs.CL_EVOID;
          subScrMode = RcRegs.CL_EVOID;
          opeMode = RcRegs.CL;
          break;
        case 1:
        default:
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            if (await RcSysChk.rcCheckQCJCSystem()) {
              scrMode = RcRegs.RG_ITM;
              subScrMode = RcRegs.RG_STL;
              opeMode = RcRegs.RG;
            } else if (await RcSysChk.rcQCChkQcashierSystem()) {
              scrMode = RcRegs.RG_ITM;
              subScrMode = RcRegs.RG_STL;
              opeMode = RcRegs.RG;
            } else {
              scrMode = RcRegs.RG_STL;
              subScrMode = RcRegs.RG_STL;
              opeMode = RcRegs.RG;
            }
          } else {
            scrMode = RcRegs.RG_ITM;
            subScrMode = RcRegs.RG_ITM;
            opeMode = RcRegs.RG;
          }
          break;
      }
    }
    rxSetTranOpeMode();
    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.scrMode = scrMode;
    cMem.stat.subScrMode = subScrMode;
    cMem.stat.opeMode = opeMode;
    cMem.stat.happySmileScrmode = 0;
    cMem.stat.happySmileBackscr = 0;
  }

  /// 実績に対する操作モードのセット
  /// 関連tprxソース: rxregstr.c - rxSet_TranOpeMode
  static void rxSetTranOpeMode() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    switch (cBuf.iniMacInfo.internal_flg.mode) {
      case 3: // 訂正
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_VOID;

        break;
      case 4: // 訓練
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_TRAINING;
        break;
      case 5: // 廃棄
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_SCRAP;
        break;
      case 6: // 発注
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_ORDER;
        break;
      case 7: // 棚卸
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_STOCKTAKING;
        break;
      case 8: // 生産
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_PRODUCTION;
        break;
      case 9: // 入金
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_REG;
        break;
      case 10: // 出金
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_REG;
        break;
      case 11: // 入出金違算
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_VOID;
        break;
      case 1: // 登録
      default:
        mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_REG;
        break;
    }
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  ///	履歴ログ処理で共有メモリ更新要求ファイルが作成された場合, 登録開始時, または, 売上終了時に共有メモリを更新する.
  /// 更新時は2人制で同時に処理が行われないように, セマフォで排他制御する.
  /// 注意:	共有メモリ更新すると問題があるフィールドは個別に戻す必要がある(簡易従業員など)
  /// 関連tprxソース: rxregstr.c - rxSet_ShmUpdate
  static void rxSetShmUpdate(TprMID tid) {}
}
