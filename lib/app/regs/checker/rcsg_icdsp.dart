/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// TODO:10121 QUICPay、iD 202404実装対象外
import 'dart:ui';

import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/language/l_languagedbcall.dart';
import '../../ui/page/full_self/page/p_full_self_id_quicpay_page.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_multi.dart';
import 'rc_set.dart';
import 'rcfncchk.dart';
import 'rcid_com.dart';
import 'rcquicpay_com.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcsg_icdsp.c
class RcSGIcDsp {

  ///  関連tprxソース: rcsg_icdsp.c - rcSG_IC_Display
  static Future<void> rcSGICDisplay(int funcCd, int payPrc, int payMethod) async {
 // RxMem
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcSGICDisplay pCom faild.");
      return;
    }
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
          case RcRegs.DESKTOPTYPE:
          case RcRegs.KY_DUALCSHR:
              if(await RcSysChk.rcQCChkQcashierSystem()){
                cMem.stat.scrType = RcRegs.LCD_104Inch;
                if(funcCd == FuncKey.KY_EDYREF.keyId){

                }else if(funcCd == FuncKey.KY_SUICAREF.keyId){
                }else if(RcSysChk.rcChkQCMultiSuicaSystem() != 0 && (payMethod == FclService.FCL_SUIC.value)){
                }else if(await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_VEGA_USE.index
                && (payMethod == FclService.FCL_ID.value)){
                }else if(await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_VEGA_USE.index
                && (payMethod == FclService.FCL_QP.value)){
                }else{
                  // if(!rcQC_Check_EdyUse_Mode())
                  // {
                  //   if (rcQC_Check_PrePaid_BalanceShort_Mode())
                  //   {
                  //     rcQC_Dsp_Destroy();
                  //     if(QCPayDsp.window != NULL)
                  //     {
                  //       gtk_widget_destroy(QCPayDsp.window);
                  //       memset( &QCPayDsp, 0, sizeof(QCPayDsp) );
                  //     }
                  //     rcQC_SlctDsp_ScrMode();
                  //   }

                    // rcQC_EdyDsp_ScrMode();
                    // rcQC_PayDsp();
                    // rcQC_SlctDsp_Destroy();
                  // }

                }
              }else if(await RcSysChk.rcSGChkSelfGateSystem()){
  
                     RxCommonBuf pCom = xRet.object;
                    // AcMem cMem = SystemFunc.readAcMem();
                      String keyName = pCom.dbKfnc[cMem.stat.fncCode].fncName;
                      // フルセルフ.
                      Get.to(() =>
                        FullSelfIDQuicpPayPage(
                            title: '$keyName${'l_full_self_payment'.trns}',
                            onCancelPressed: () async {
                              if (await RcFncChk.rcCheckQPMode()) {
                                await RcQuicPayCom.rcMultiQPCancelProc();
                              } else if (await RcFncChk.rcCheckiDMode()) {
                                await RcidCom.rcMultiiDCancelProc();
                              }
                            })
                      );

              }

          
          break;
      default:
        break;
    }

   
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "rcSGICDisplay End");
  }

  ///  関連tprxソース: rcsg_icdsp.c - rcSG_IC_Conf
  static void rcSGICConf(int result) {
    // TODO:00008 宮家 中身の実装予定　
    return;
  }

  ///  関連tprxソース: rcsg_icdsp.c - rcSG_IC_ChgMsg
  static void rcSGICChgMsg(Color baseColor, String msg) {
    // TODO:00008 宮家 中身の実装予定　
    return;
  }

  ///  関連tprxソース: rcsg_icdsp.c - rcSG_IC_MainBtn_Show
  static void rcSGICMainBtnShow() {
    // TODO:00008 宮家 中身の実装予定　
    return;
  }

  ///  関連tprxソース: rcsg_icdsp.c - rcSG_IC_MainBtn_Hide
  static void rcSGICMainBtnHide() {
    // TODO:00008 宮家 中身の実装予定　
    return;
  }

  ///  関連tprxソース: rcsg_icdsp.c - rcSG_IC_DispEnd
  static Future<void> rcSGICDispEnd() async {
    // TODO:00008 宮家 中身の実装予定　
     RcSet.rcReMovScrMode();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
      cMem.stat.fncCode = atSing.spvtData.fncCode;
       if (atSing.spvtData.tranEnd != 1) {
        // 中止ボタンの時のみ、表示を戻したい為
        await Rc28StlInfo.rcFselfSubttlRedisp();
      }
    return;
  }

  ///  関連tprxソース: rcsg_icdsp.c - rcSG_IC_Select_Act
  static void rcSGICSelectAct() {
    // TODO:00008 宮家 中身の実装予定　
    return;
  }


}