/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_collectkey.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

class RckyRegassist{
  /// 締め処理金額入力画面表示のチェック
  /// 関連tprxソース:rcky_regassist.c - rcCheck_RegAssist_Payment_Act(short err_code)
  /// 引数：なし
  /// 戻値：true:締め処理金額入力画面を表示する  false:締め処理金額入力画面を表示しない
  static Future<bool> rcCheckRegAssistPaymentAct(int errCode) async {
    KopttranBuff koptTran = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();
    int errNo;

    errNo = await rcCheckRegAssistCom();
    if(errNo != 0){
      return false;
    }

    if(errCode == DlgConfirmMsgKind.MSG_PAYMENT_PRICE_NEED.dlgId){
      await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
      if((koptTran.frcEntryFlg == 1) && (!(RcFncChk.rcChkTenOn()))){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  /// 関連tprxソース:rcky_regassist.c - rcCheck_RegAssist_Com()
  static Future<int> rcCheckRegAssistCom() async {
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if(!await RcSysChk.rcChkRegAssistSystem()){
      if(CmCksys.cmWeb2800System() != 0){
        errNo = DlgConfirmMsgKind.MSG_NOTUSE_WEB2800_CONF.dlgId;
      }else if(CmCksys.cmWeb2500System() != 0){
        errNo = DlgConfirmMsgKind.MSG_NOTUSE_WEB2500_CONF.dlgId;
      }else{
        errNo = DlgConfirmMsgKind.MSG_CANNOT_KEY_SET.dlgId;
      }
    }

    if(!(errNo != 0)){
      if((!await RcFncChk.rcCheckItmMode()) && (!await RcFncChk.rcCheckStlMode())){
        errNo = DlgConfirmMsgKind.MSG_REG_STL_KEY_USE.dlgId;
      }
    }

    if((await rcRegAssistZHQSaGCheck(1))
        && (cMem.ent.errNo == DlgConfirmMsgKind.MSG_PRICEZERO.dlgId)){
      errNo = 0;
    }
    return errNo;
  }

  /// 全日食様S&G精算機の条件チェック
  /// 関連tprxソース:rcky_regassist.c - rcRegAssist_ZHQ_SaG_Check(short modeChk)
  /// 引数：modeChk : アイテムリスト画面かをチェックするか
  /// 戻値：true:正 false:否
  static Future<bool> rcRegAssistZHQSaGCheck(int modeChk) async {

    if((await RcSysChk.rcChkZHQsystem()) // 全日食
        && (await RcSysChk.rcChkShopAndGoSystem())){ // S&G
      if(modeChk == 0){
        return true;
      }else{
        if(RcFncChk.rcQCCheckItemDspMode()){ // アイテムリスト画面
          return true;
        }
      }
    }
    return false;

  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 締め入力画面
  /// 関連tprxソース:rcky_regassist.c - rcRegAssist_Payment_Disp
  /// 引数：なし
  /// 戻値：なし
  static void rcRegAssistPaymentDisp(){
    return;
  }

  //windowの表示状態を確認
  /// 関連tprxソース:rcky_regassist.c - rcRegAssist_Rpr_Disp_DispStatus_Chk
  static Future<int> rcRegAssistRprDispDispStatusChk() async {
    int ret = 0;

    //windowの存在チェック
    ret = await rcRegAssistRprDispChk();
    if (ret == 0) {
      return WindowDispStatus.WINDOW_DISP_NON.value;
    }

    //showかhideか表示状態チェック
    ret = await rcRegAssistRprDispShowChk();
    if (ret == 0) {
      return WindowDispStatus.WINDOW_DISP_HIDE.value;
    } else {
      return WindowDispStatus.WINDOW_DISP_SHOW.value;
    }
  }

  //windowがあるか確認
  /// 関連tprxソース:rcky_regassist.c - rcRegAssist_Rpr_Disp_Chk
  static Future<int> rcRegAssistRprDispChk() async {
    int dispFlg = 0;

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
        if (await RcFncChk.rcCheckItmMode()) {
          // TODO:00013 三浦 必要？
          // dispFlg = rcRegAssist_Rpr_Disp_Chk_Proc(&Tran.Item_Subttl);
        } else if (await RcFncChk.rcCheckStlMode()) {
          // TODO:00013 三浦 必要？
          // dispFlg = rcRegAssist_Rpr_Disp_Chk_Proc(&Subttl);
        }

        if (dispFlg == 0 && FbInit.subinitMainSingleSpecialChk() == true) {
          // dispFlg = rcRegAssist_Rpr_Disp_Chk_Proc( &Dual_Subttl );
        }
        break;
      case RcRegs.KY_CHECKER:
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        if (await RcFncChk.rcCheckItmMode()) {
          // TODO:00013 三浦 必要？
          // dispFlg = rcRegAssist_Rpr_Disp_Chk_Proc(&Tran.Item_Subttl);
        } else if (await RcFncChk.rcCheckStlMode()) {
          // TODO:00013 三浦 必要？
          // dispFlg = rcRegAssist_Rpr_Disp_Chk_Proc(&Subttl);
        }
        break;
    }
    return dispFlg;
  }

  /// 関連tprxソース:rcky_regassist.c - rcRegAssist_Rpr_Disp_Chk_Proc
  // TODO:00013 三浦 必要？
  // static int rcRegAssistRprDispChkProc(Subttl_Info *pSubttl){
  // if(pSubttl->rcpt_rpr_dsp != NULL){}
  // return (rcCheck_DispStruct_Type(pSubttl)); //表示
  // }else{
  // return 0; //非表示
  // }
  // }

  //windowがありshowかhideか確認
  /// 関連tprxソース:rcky_regassist.c - rcRegAssist_Rpr_Disp_Show_Chk
  static Future<int> rcRegAssistRprDispShowChk() async {
    int showFlg = 0;

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
        if (await RcFncChk.rcCheckItmMode()) {
          // TODO:00013 三浦 必要？
          // showFlg = rcRegAssist_Rpr_Disp_Show_Chk_Proc(&Tran.Item_Subttl);
        } else {
          // TODO:00013 三浦 必要？
          // showFlg = rcRegAssist_Rpr_Disp_Show_Chk_Proc(&Subttl);
        }

        if (showFlg == 0 && FbInit.subinitMainSingleSpecialChk() == true) {
          // TODO:00013 三浦 必要？
          // showFlg = rcRegAssist_Rpr_Disp_Show_Chk_Proc( &Dual_Subttl );
        }
        break;
      case RcRegs.KY_CHECKER:
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        if (await RcFncChk.rcCheckItmMode()) {
          // TODO:00013 三浦 必要？
          // showFlg = rcRegAssist_Rpr_Disp_Show_Chk_Proc( &Tran.Item_Subttl );
        } else {
          // TODO:00013 三浦 必要？
          // showFlg = rcRegAssist_Rpr_Disp_Show_Chk_Proc( &Subttl );
        }
        break;
    }
    return showFlg;
  }

  /// 関連tprxソース:rcky_regassist.c - rcRegAssist_Rpr_Disp_Destroy
  static void rcRegAssistRprDispDestroy() {
    // TODO:10122 グラフィックス処理
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rcky_regassist.c - rcGtkTimerRemoveDispKeyAct
  static int rcGtkTimerRemoveDispKeyAct() {
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rcky_regassist.c - rcGtkTimerAddDispKeyAct
  static int rcGtkTimerAddDispKeyAct(int timer, void func, int data) {
    return 0;
  }
}