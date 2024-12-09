/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';
import 'dart:io';

import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/upd_util.dart';
import '../../lib/if_acx/acx_com.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_auto.dart';
import 'rc_clxos_drwcheck.dart';
import 'rc_ewdsp.dart';
import 'rc_itm_dsp.dart';
import 'rc_ifprint.dart';
import 'rc_inout.dart';
import 'rc_ext.dart';
import 'rcinoutdsp.dart';
import 'rcfncchk.dart';

///  関連tprxソース: rcky_drawchk.c
class RcKyDrawChk {
/*----------------------------------------------------------------------*
 * Constant Values
 *----------------------------------------------------------------------*/
  static List<int> drawChk0 = [
    FncCode.KY_REG.keyId,
    FncCode.KY_ENT.keyId,
    FuncKey.KY_PLU.keyId,
    0
  ];
  static const List<int> drawChk1 = [0];
  static const List<int> drawChk2 = [0];
  static const List<int> drawChk3 = [0];
  static const List<int> drawChk4 = [0];
  static InOutInfo inOut = InOutInfo();

  ///  関連tprxソース: rcky_drawchk.c - rcKyDrawChk
  static Future<void> rcKyDrawChk() async {
      AcMem cMem = SystemFunc.readAcMem();
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
         Rcinoutdsp.rcSGKeyImageTextMake(cMem.stat.fncCode);
      }
      cMem.ent.errNo = await _rcCheckKyDrawChk(0);
      if(cMem.ent.errNo == Typ.OK) {
         _rcPrgKyDrawChk();
         RegsMem mem = SystemFunc.readRegsMem();
         mem.prnrBuf.opeStaffCd = 0;
         mem.prnrBuf.opeStaffName = "";
         if(AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
           inOut.exeFlg = 1;
//           rcAutoExec(NULL, NULL, NULL);
         }
      } else {
         await RcExt.rcErr('rcKyDrawChk',cMem.ent.errNo);
         /* 自動開閉設動作中 */
         if(AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
            if(!await RcFncChk.rcCheckInOutMode()) {
               RcAuto.rcAutoStrOpnClsFuncErrStop(cMem.ent.errNo);  /* エラー発生の為、自動化中止 */
            }
         }
      }
  }

  ///  関連tprxソース: rcky_drawchk.c - rcCheck_Ky_DrawChk
  ///chkCtrlFlg : 0以外で特定のチェック処理を除外する
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  static Future<int> _rcCheckKyDrawChk(int chkCtrlFlg) async {
    int   result = 0;
    int  ret = 0;
    List<int> p = [];
    int i = 0;

    if( (RcSysChk.rcVDOpeModeChk()) || (RcSysChk.rcSROpeModeChk()) ) {
      return(DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId);
    }
    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) && (!await RcSysChk.rcCheckQCJCSystem())) {
      return (DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId);
    }

    AcMem cMem = SystemFunc.readAcMem();
    if((! RcRegs.kyStC0(cMem.keyStat[cMem.stat.fncCode])) &&
      (RcRegs.kyStC0(cMem.keyStat[FncCode.KY_ENT.keyId]))               ) {
      return(DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    }
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    p = drawChk0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb, i); i++; }
    p = drawChk1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb, i); i++; }
    p = drawChk2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb, i); i++; }
    p = drawChk3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb, i); i++; }
    p = drawChk4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb, i); i++; }

    ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return (RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret));
    }

    if(chkCtrlFlg == 0)
    {
      for( i = 0; i < 30; i++ ) {
        result = await UpdUtil.updReadRest(Tpraid.TPRAID_UPD);
        if( result > 0 ) {
          await Future.delayed( const Duration(milliseconds: 100)); //100000us
        } else {
          break;
        }
      }
      if(result != 0) {
        return(DlgConfirmMsgKind.MSG_REMAIN_LTRAN.dlgId); 
      }
   }
   return(Typ.OK);
  }

  ///  関連tprxソース: rcky_drawchk.c - rcPrg_Ky_DrawChk
  static Future<void> _rcPrgKyDrawChk() async {
     _rcStartDrawChk();

    // クラウドPOS(差異チェック)
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "_rcPrgKyDrawChk rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    CalcResultDrwchkWithRawJson resultWithRawJson = await RcClxosDrawerCheck.rcDrawerCheck(pCom);

  }

  ///  関連tprxソース: rcky_drawchk.c - rcStart_DrawChk
  static Future<void> _rcStartDrawChk() async {
     AcMem cMem = SystemFunc.readAcMem();
     RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
     if (xRet.isInvalid()) {
       return;
     }
     RxTaskStatBuf tsBuf = xRet.object;

     if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
       await RcIfPrint.rcDrwopen(); /* Drawer Open !! */
       cMem.stat.clkStatus |= RcIf.OPEN_DRW;
       RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
       taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
     }

     await RcExt.cashStatSet("_rcStartDrawChk");

     tsBuf.cash.inout_flg = 1;
     _rcEditKeyData();
     RcRegs.kyStS0(cMem.keyStat, inOut.fncCode); /* Set Bit 0 of KY_PICK? */
     RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); /* Set Bit 0 of KY_REG */
  }

  ///  関連tprxソース: rcky_drawchk.c - rcEdit_KeyData
  static Future<void> _rcEditKeyData() async {
     AcMem cMem = SystemFunc.readAcMem();
     inOut = InOutInfo();
     inOut.fncCode = cMem.stat.fncCode;
  }

  ///  関連tprxソース: rcky_drawchk.c - rcEnd_DifferentDrawChk
  static int _rcEndDifferentDrawChk() {
   return(Typ.OK);
  }

  ///  関連tprxソース: rcky_drawchk.c - rcUpdate_DrawChk
  static void _rcUpdateDrawChk() {
  }

  ///  関連tprxソース: rcky_drawchk.c - rcResult_DrawChk
  static int _rcResultDrawChk() {//差異チェック実行結果(過不足情報)をファイルに保存
    return(Typ.OK);
  }

  ///  関連tprxソース: rcky_drawchk.c - rcChk_rcKyDrwChk_MechaKeysCheck
  ///キー使用不可確認関数
  static Future<int> _rcChk_rcKyDrwChkMechaKeysCheck() async {
    int errNo = await _rcCheckKyDrawChk(1);
    return errNo;
  }

  ///  関連tprxソース: rcky_drawchk.c - rcChk_DrawChk_OverFlow_Stock_Include
  static Future<int> rcChkDrawChkOverFlowStockInclude() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkDrawChkOverFlowStockInclude: SystemFunc.rxMemRead() isInvalid");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    //オーバーフロー在高を釣機合計に含めるか判定
    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) != 0) {
      if (pCom.iniMacInfo.acx_flg.ecs_overflowpick_use == 1) {  // スペック設定「硬貨オーバーフロー回収を使用」が「する」
        return 1;
      }
    }
    return 0;
  }
}