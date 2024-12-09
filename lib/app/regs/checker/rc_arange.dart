/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../ui/enum/e_screen_kind.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

///  関連tprxソース: rcarange.c
class AcArange{

  ///  関連tprxソース: rcarange.c - rcArrange()
  static Future<void> rcArrange() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    await rcCheckWhoKey();
    int fncCode =atSing.inputbuf.Fcode;
    switch(atSing.inputbuf.dev)
    {
      case DevIn.D_KEY :
        await _rcSetFncCode(fncCode);
        break;  /* Set Timer Number  */
      case DevIn.D_TCH :
        await _rcSetFncCode(fncCode);
        break;  /* Set Timer Number  */
    // TODO:10121 QUICPay、iD 202404実装対象外
      // case DevIn.D_SML :
      //   rcSml_Arrange();
      //   break;  /* Set Timer Number  */
      // case DevIn.D_OBR :
      //   rcObr_Arrange();
      //   break;  /* Set Timer Number  */
      // case DevIn.D_MCD1:
      //   rcMcd1_Arrange();
      //   break;  /* Set Timer Number  */
      // case DevIn.D_MCD2:
      //   rcMcd2_Arrange();
      //   break;  /* Set Timer Number  */
      // case DevIn.D_ICCD1:
      //   rcMcd2_Arrange();
      //   break;  /* Set Timer Number  */
      default    :
        return;
    }
  }
  ///  関連tprxソース: rcarange.c - rcSet_FncCode()
  static Future<void> _rcSetFncCode(int fncCode) async {
    AcMem cMem = SystemFunc.readAcMem();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;

      if ( pCom.vtclRm5900Flg )
      {
        // TODO:10121 QUICPay、iD 202404実装対象外
        //rc59_SaveFuncKey ( );	// RM-3800用
      }
      if(CompileFlag.RF1_SYSTEM){
        if(fncCode == FuncKey.KY_DRWCHK.keyId && await CmCksys.cmRf1HsSystem() != 0){
          pCom.vtclRm5900AmountOnHandFlg = 0;
        }
      }
    }
    cMem.stat.fncCode = fncCode;
  }

  ///   関連tprxソース: rcarange.c - rcCheck_WhoKey()
  static Future<void> rcCheckWhoKey() async {
    Onetime ot = SystemFunc.readOnetime();
    ot.flags.clk_mode = 0;
    ot.flags.clk_dev = 0;


    if (!await RcSysChk.rcChk2Clk())
    {
      if (await DualCashierUtil.check2Person()) {
        ot.flags.clk_mode = RcRegs.KY_SINGLE;          /* Set Clerk Mode      */
        ot.flags.clk_dev  = RcRegs.KY_CHECKER;         /* Set Clerk Device    */
      }
      else {
        ot.flags.clk_mode = RcRegs.KY_CHECKER;         /* Set Clerk Mode      */
        ot.flags.clk_dev = RcRegs.KY_CHECKER;          /* Set Clerk Device    */
      }
    }
    else
    {
      AtSingl atSingl = SystemFunc.readAtSingl();
      if (atSingl.inputbuf.no == DevIn.KEY1)
      {
        ot.flags.clk_mode = RcRegs.KY_DUALCSHR;          /* Set Clerk Mode      */
        ot.flags.clk_dev  = RcRegs.KY_DUALCSHR;          /* Set Clerk Device    */
      }
      else
      {
        if ((! RcSysChk.rcCheckKyIntIn(false)) && (EnvironmentData().screenKind == ScreenKind.register2))
        {
          ot.flags.clk_mode = RcRegs.KY_CHECKER;          /* Set Clerk Mode      */
          ot.flags.clk_dev  = RcRegs.KY_CHECKER;          /* Set Clerk Device    */
        }
        else
        {
          ot.flags.clk_mode = RcRegs.KY_DUALCSHR;          /* Set Clerk Mode      */
          ot.flags.clk_dev  = RcRegs.KY_CHECKER;          /* Set Clerk Device    */
        }
      }
    }
  }
}