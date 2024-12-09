/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/regs/checker/rc28stlinfo.dart';
import 'package:flutter_pos/app/regs/checker/rc_edy.dart';
import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../regs/checker/rcsyschk.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/electronic_money/basepage/p_payment_cardtouch.dart';
import '../../ui/page/electronic_money/controller/c_payment_cardtouch.dart';
import '../inc/L_rcspvt.dart';
import '../inc/rc_mem.dart';
import 'rc_set.dart';
import 'rcfncchk.dart';
import 'rcid_com.dart';
import 'rcky_rfdopr.dart';
import 'rcquicpay_com.dart';

///  関連tprxソース:rcic_dsp.c - IC_DspInfo
class ICDspInfo {
  // GtkWidget  *window;
  // GtkWidget  *wFixed;
  // GtkWidget  *TtlBar;
  // GtkWidget  *popup;
  // GtkWidget  *btn1;     /* Main Button (Confirmation or Cancel) */
  // GtkWidget  *btn2;     /* Sub1 Button (Retry)                  */
  // GtkWidget  *btn3;     /* Sub2 Button (Forced Balance)         */
  // GtkWidget  *pay_img1;
  // GtkWidget  *pay_img2;
  // GtkWidget  *pay_img3;
  // GtkWidget  *entry1;
  // GtkWidget  *entry2;
  // GtkWidget  *entry3;
  // GtkWidget  *hist_img1;
  // GtkWidget  *hist_img2;
  // GtkWidget  *hist_img3;
  // GtkWidget  *hist_img4;
  // GtkWidget  *hist_data1;
  // GtkWidget  *hist_data2;
  // GtkWidget  *hist_data3;
  // GtkWidget  *hist_data4;
  // GtkWidget  *hist_data5;
  // GtkWidget  *hist_data6;
  // GtkWidget  *rslt_msg;
}

class RcIcDsp {
  /// なんかする機能
  /// 戻値：なし
  /// 関連tprxソース:rcic_dsp.c - rcIC_Display()
  static Future<void> rcICDisplay(int funcCd, int payPrc) async {
    // String erlog;
    //
    // if(await RcSysChk.rcSGChkSelfGateSystem()) {
    //   erlog = "rcICDisplay : self system return !!\n";
    //   TprLog().logAdd(GetTid(), LogLevelDefine.error, erlog);
    //   return;
    // }
    if (await rcICModeCheck() != 0) {
      return;
    }
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "rcICDisplay : Start");
    await rcICStartDsp(funcCd, payPrc, LRcSpvt.POP_MSG_SPVT_START);
  }

  /// 戻値：成功:0 失敗:1
  /// 関連tprxソース:rcic_dsp.c - rcIC_ModeCheck()
  static Future<int> rcICModeCheck() async {
    int errNo = 1;
    if ((await RcFncChk.rcCheckEdyMode()) ||
        (await RcFncChk.rcCheckQPMode()) ||
        (await RcFncChk.rcCheckiDMode()) ||
        (await RcFncChk.rcCheckPiTaPaMode()) ||
        (await RcFncChk.rcCheckSuicaMode())) {
      errNo = 0;
    }
    return errNo;
  }

  /// かざす画面へ遷移する.
  /// 戻値：なし
  /// 関連tprxソース:rcic_dsp.c - rcIC_StartDsp()
  static Future<void> rcICStartDsp(int funcCd, int payPrc, String msg) async {
    if (funcCd == FuncKey.KY_CRDTVOID.keyId) {
      Get.to(() =>
          PaymentCardTouchScreen(
              title: 'レシート訂正',
              payPrc: payPrc,
              msg: 'カードをタッチしてください',
              onCancelPressed: () async {
                if (await RcFncChk.rcCheckQPMode()) {
                  await RcQuicPayCom.rcMultiQPCancelProc();
                } else if (await RcFncChk.rcCheckiDMode()) {
                  await RcidCom.rcMultiiDCancelProc();
                }
              }));
      return;
    }



    // RxMem
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcICStartDsp pCom faild.");
      return;
    }
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    String keyName = pCom.dbKfnc[cMem.stat.fncCode].fncName;

    Get.to(() =>
        PaymentCardTouchScreen(
            title: '$keyNameでお支払い',
            payPrc: payPrc,
            msg: msg,
            onCancelPressed: () async {
              if (await RcFncChk.rcCheckQPMode()) {
                await RcQuicPayCom.rcMultiQPCancelProc();
              } else if (await RcFncChk.rcCheckiDMode()) {
                await RcidCom.rcMultiiDCancelProc();
              }
            }));
  }

  /// 関連tprxソース:rcic_dsp.c - rcIC_ChgMsg()
  static Future<void> rcICChgMsg(Color color, String msg, {bool addMode=false}) async {
    if(await RcSysChk.rcSGChkSelfGateSystem()){
        return;
    }
    PaymentCardTouchController con =  Get.find();
    if (addMode) {
      con.msg2.value = msg;
    }
    else {
      con.msg.value = msg;
    }
    con.color.value = color;
   
    return;
  }

  /// 関連tprxソース:rcic_dsp.c - rcIC_Conf()
  static Future<void> rcICConf(int result) async {
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      return;
    }

    AtSingl atSingl = SystemFunc.readAtSingl();
    if (RcFncChk.rcQCCheckQPMode()) {
      if (result == Typ.OK) {
        atSingl.spvtData.tranEnd = 1;
        MsgDialog.show(
          MsgDialog.singleButtonMsg(
            type: MsgDialogType.info,
            message: LRcSpvt.MSG_ICTRAN_OK,
            btnTxt: RcEdy.KEY_EDY_FINAL,
            btnFnc: () async {
              await RcQuicPayCom.rcMultiQPEndProc();
            },
          ),
        );

      } else if (result == Typ.NG) {
        MsgDialog.show(
          MsgDialog.singleButtonMsg(
            type: MsgDialogType.error,
            message: LRcSpvt.MSG_ICTRAN_NG,
            btnTxt: RcEdy.KEY_EDY_FINAL,
            btnFnc: () async {
              await RcQuicPayCom.rcMultiQPEndProc();
            },
          ),
        );
      } else {
        MsgDialog.show(
          MsgDialog.singleButtonMsg(
            type: MsgDialogType.info,
            message: LRcSpvt.MSG_IC_UNKNOWN,
            btnTxt: LRcSpvt.BTN_IC_B_TRAN,
            btnFnc: () async {
              await RcQuicPayCom.rcMultiQPBeforeTran();
            },
          ),
        );

      }
    }
    if (await RcFncChk.rcQCCheckIDMode()) {
      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.info,
          message: LRcSpvt.MSG_IC_PIN_LIMITOVER,
          btnTxt: LRcSpvt.BTN_IC_STOP,
          btnFnc: () async {
            await RcidCom.rcMultiiDEndProc();
          },
        ),
      );
    }
    return;
  }

  /// 関連tprxソース:rcic_dsp.c - rcIC_MainBtn_Show()
  static void rcICMainBtnShow() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
  }

  /// 関連tprxソース:rcic_dsp.c - rcIC_MainBtn_Hide()
  static void rcICMainBtnHide() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
  }

  /// 支払い画面表示終了後に行う処理.
  /// 関連tprxソース:rcic_dsp.c - rcIC_DispEnd()
  static Future<void> rcICDispEnd() async {
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      return;
    }
    if (await rcICModeCheck() != 0) {
      return;
    }
    RcSet.rcReMovScrMode();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    if (await RcFncChk.rcCheckCrdtVoidSMode()) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        TprLog().logAdd(
            await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
        return;
      }
      RxTaskStatBuf tsBuf = xRet.object;
      if (tsBuf.multi.fclData.skind == FclService.FCL_NIMOCA) {
        cMem.stat.fncCode = atSing.spvtData.fncCode;
      } else {
        cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
      }
    } else if (await CmCksys.cmYunaitoHdSystem() != 0 &&
        ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true) ||
            (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true))) {
      cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
    } else {
      cMem.stat.fncCode = atSing.spvtData.fncCode;
    }

    // TODO:00012 平野 [暫定対応]　rcCheckItmMode()でfalseにならない件の調査中のため、コメントアウト
    // if(await RcFncChk.rcCheckItmMode()){
    //   // TODO:10121 QUICPay、iD 202404実装対象外
    //   // rcItem_Disp_FIP(fip_no);
    // }else {
    //   // TODO:10121 QUICPay、iD 202404実装対象外
    //   // rcStlFip(fip_no);

    // TODO:00012 平野 [暫定対応]　rcChkFselfSystem()でtrueにならない件の調査中のため、コメントアウト
    // if (CompileFlag.COLORFIP) {
    //   if(!(await CmCksys.cmYunaitoHdSystem() != 0
    //       && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
    //           || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true)))){
    if (!await RcFncChk.rcCheckCrdtVoidSMode()) {
      //       if(await RcSysChk.rcChkFselfSystem()){
      //         if(await RcSysChk.rcSysChkHappySmile()){
      //           // TODO:10121 QUICPay、iD 202404実装対象外
      //           // if (AT_SING->spvt_data.tran_end != 1)
      //           // {
      //           //   if (AT_SING->spvt_data.happy_smile_dsp_ctrl == 1)
      //           //   { // 取引の途中なので、客側表示は更新させない
      //           //     ;
      //           //   }
      //           //   else
      //           //   {
      //           //     rc_fself_subttl_redisp();
      //           //   }
      //           // }
      //         }else{
      if (atSing.spvtData.tranEnd != 1) {
        // 中止ボタンの時のみ、表示を戻したい為
        await Rc28StlInfo.rcFselfSubttlRedisp();
      }
      //         }
      //       }
    } else {
      if (atSing.spvtData.tranEnd != 1) {
        // キャンセル時、通番訂正は通番訂正画面まで戻す
        Get.until((route) => route.settings.name == '/receiptinputpage');
      }
    }
    //   }
    // }
    atSing.multiPfmOcxErrmsg = "";

    return;
//    }
  }

  /// 関連tprxソース:rcic_dsp.c - rcIC_Select_Act()
  static void rcICSelectAct() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
  }
}
